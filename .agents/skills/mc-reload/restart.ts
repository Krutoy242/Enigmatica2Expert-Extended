/// <reference types="node" />

import process from 'node:process'
import { spawn } from 'node:child_process'
import fs from 'node:fs/promises'
import { constants as fsConstants } from 'node:fs'
import { StringDecoder } from 'node:string_decoder'
import { isAbsolute, join, normalize, resolve } from 'pathe'

import consola from 'consola'
import chalk from 'chalk'
import { execa } from 'execa'
import find from 'find-process'
import kill from 'tree-kill'
import { defineCommand, runMain } from 'citty'
import envPaths from 'env-paths'

const IS_WIN = process.platform === 'win32'
const CWD = normalize(process.cwd())

// Timing knobs (ms)
const TICK_MS = 1000 // log read / pattern check cadence
const HEALTH_MS = 3000 // process-liveness + stall check cadence
const STALL_MS = 30_000 // debug.log silence that counts as "loaded"
const MONITOR_MS = 300_000 // overall ceiling
const DOT_MS = 5000 // dot-print interval (progress indicator)
const LAUNCH_MS = 120_000 // give up if MC never starts

const sleep = (ms: number) => new Promise(resolve => setTimeout(resolve, ms))

// ---------- Path helpers ----------
/** Canonical, comparable form of a path (case-insensitive on Windows). */
function pathKey(p: string): string {
  let s = normalize(p)
    .replace(/\\/g, '/')
    .replace(/^\/\/\?\//, '') // strip Windows \\?\ extended-length prefix
    .replace(/\/+$/, '') // strip trailing slashes
  if (IS_WIN) s = s.toLowerCase()
  return s
}

function samePath(a: string, b: string): boolean {
  return pathKey(a) === pathKey(b)
}

// ---------- PrismLauncher / Instance helpers ----------
async function getPrismDataDir(): Promise<string> {
  if (process.env.PRISMLAUNCHER_DATA_DIR) {
    return normalize(process.env.PRISMLAUNCHER_DATA_DIR)
  }
  const programFiles = [
    'D:\\Program Files\\PrismLauncher',
    'C:\\Program Files\\PrismLauncher',
    'C:\\Program Files (x86)\\PrismLauncher',
  ]
  for (const c of programFiles) {
    try {
      await fs.access(join(c, 'portable.txt'), fsConstants.R_OK)
      return normalize(c)
    } catch {
      // not portable
    }
  }
  const appData = envPaths('prismlauncher', { suffix: '' }).data
  try {
    await fs.access(appData, fsConstants.R_OK)
    return normalize(appData)
  } catch {
    throw new Error(
      'Cannot find PrismLauncher data dir. Set PRISMLAUNCHER_DATA_DIR or install PrismLauncher.',
    )
  }
}

async function getInstanceDirs(dataDir: string): Promise<string[]> {
  const dirs: string[] = []
  const cfgPath = join(dataDir, 'prismlauncher.cfg')
  try {
    const cfg = await fs.readFile(cfgPath, 'utf-8')
    const match = cfg.match(/^InstanceDir=(.+)$/m)
    if (match) {
      let dir = match[1].trim()
      if (!isAbsolute(dir)) dir = join(dataDir, dir)
      dirs.push(normalize(dir))
    }
  } catch {
    // ignore
  }
  dirs.push(join(dataDir, 'instances'))
  return dirs
}

/** Returns the instance folder name whose `.minecraft` resolves to CWD, or null. */
async function findInstanceInDir(rootDir: string): Promise<string | null> {
  let entries
  try {
    entries = await fs.readdir(rootDir, { withFileTypes: true })
  } catch {
    return null
  }
  for (const entry of entries) {
    if (!entry.isDirectory() && !entry.isSymbolicLink()) continue
    const instancePath = join(rootDir, entry.name)
    const mcLinkPath = join(instancePath, '.minecraft')
    let realPath: string | null = null
    try {
      const stats = await fs.lstat(mcLinkPath)
      if (stats.isSymbolicLink()) {
        // Junctions and symlinks both surface here on Windows.
        const target = await fs.readlink(mcLinkPath)
        realPath = isAbsolute(target) ? target : resolve(instancePath, target)
      } else if (stats.isDirectory()) {
        realPath = mcLinkPath
      }
    } catch {
      continue
    }
    if (realPath && samePath(realPath, CWD)) return entry.name
  }
  return null
}

async function detectInstance(dataDir: string): Promise<string | null> {
  for (const rootDir of await getInstanceDirs(dataDir)) {
    const id = await findInstanceInDir(rootDir)
    if (id) return id
  }
  return null
}

// ---------- Process helpers ----------
/** PID of the Minecraft (game) javaw process for this instance, preferring a CWD match. */
async function getMcPid(): Promise<number | null> {
  try {
    const list = await find('name', 'javaw.exe')
    const needle = pathKey(CWD)
    let fallback: number | null = null
    for (const proc of list) {
      if (!proc.cmd || !proc.cmd.includes('EntryPoint')) continue
      if (fallback === null) fallback = proc.pid
      // Prefer the javaw whose command line points at this instance dir.
      if (pathKey(proc.cmd).includes(needle)) return proc.pid
    }
    return fallback
  } catch {
    return null
  }
}

/** Cheap liveness probe — no child process spawned. */
function running(pid: number): boolean {
  try {
    process.kill(pid, 0)
    return true
  } catch (err: any) {
    return err?.code === 'EPERM' // exists but not signalable
  }
}

function forceKillTree(pid: number): Promise<void> {
  return new Promise(resolve => kill(pid, 'SIGKILL', () => resolve()))
}

async function killProcess(pid: number): Promise<void> {
  // 1. Ask nicely: close the main window (graceful in-game shutdown).
  try {
    await execa(
      'powershell',
      [
        '-NoProfile',
        '-Command',
        `$p = Get-Process -Id ${pid} -ErrorAction SilentlyContinue; if ($p) { [void]$p.CloseMainWindow() }`,
      ],
      { timeout: 15_000 },
    )
  } catch {
    // ignore — fall through to force kill
  }
  for (let waited = 0; waited < 10_000 && running(pid); waited += 500) {
    await sleep(500)
  }
  if (!running(pid)) return

  // 2. Force: kill the whole tree.
  await forceKillTree(pid)
  for (let waited = 0; waited < 5_000 && running(pid); waited += 250) {
    await sleep(250)
  }
}

/**
 * Kill the game JVM and any sidecar `crash_assistant` watchdog it spawned. The
 * watchdog is a separate JVM (child of the launcher, not the game) that monitors
 * the game by PID and does NOT exit when the game is killed — so killing only the
 * game leaks a ~512 MB JVM on every restart. Its classpath references the game's
 * PID (`…/crash_assistant/<gamePid>_<ts>_app.jar`), which lets us find it.
 */
async function killMc(gamePid: number): Promise<void> {
  const helpers: number[] = []
  try {
    const list = await find('name', 'javaw.exe')
    const jarRef = new RegExp(`crash_assistant[\\\\/]${gamePid}_`, 'i')
    for (const proc of list) {
      if (proc.pid !== gamePid && proc.cmd && jarRef.test(proc.cmd)) helpers.push(proc.pid)
    }
  } catch {
    // ignore — fall back to killing just the game
  }
  await killProcess(gamePid)
  for (const helper of helpers) {
    if (running(helper)) await forceKillTree(helper)
  }
}

// ---------- Log tailing ----------
function dbgLogPath(): string {
  return join(CWD, 'logs', 'debug.log')
}

function ctLogPath(): string {
  return join(CWD, 'crafttweaker.log')
}

interface LogTail {
  pos: number // bytes consumed
  pending: string // partial (unterminated) trailing line
  lineNo: number // 1-based number of the last completed line
  decoder: StringDecoder // handles multibyte chars split across reads
}

function createTail(startPos = 0): LogTail {
  return { pos: startPos, pending: '', lineNo: 0, decoder: new StringDecoder('utf8') }
}

/** Reads newly appended, newline-terminated lines. Handles truncation/rotation. */
async function readNewLines(filePath: string, tail: LogTail): Promise<string[]> {
  let size: number
  try {
    size = (await fs.stat(filePath)).size
  } catch {
    return []
  }
  if (size < tail.pos) {
    // File was truncated/rotated (new MC session) — start over.
    tail.pos = 0
    tail.pending = ''
    tail.decoder = new StringDecoder('utf8')
  }
  if (size <= tail.pos) return []

  const len = size - tail.pos
  const buffer = Buffer.alloc(len)
  let bytesRead = 0
  const fd = await fs.open(filePath, 'r')
  try {
    ;({ bytesRead } = await fd.read(buffer, 0, len, tail.pos))
  } finally {
    await fd.close()
  }
  tail.pos += bytesRead

  const text = tail.pending + tail.decoder.write(buffer.subarray(0, bytesRead))
  const parts = text.split('\n')
  tail.pending = parts.pop() ?? '' // keep the unterminated remainder for next read
  return parts.map(l => (l.endsWith('\r') ? l.slice(0, -1) : l))
}

async function readErrorsFromLog(): Promise<{ lines: string[], count: number }> {
  try {
    const content = await fs.readFile(ctLogPath(), 'utf-8')
    const lines = content
      .split('\n')
      .filter(line => /\b(?:ERROR|FATAL)\b/.test(line))
      .map(line => line.trim())
      .filter(Boolean)
    return { lines, count: lines.length }
  } catch {
    return { lines: [], count: 0 }
  }
}

// ---------- Crash helpers ----------
async function findNewestCrashReport(afterTs: number): Promise<string | null> {
  const crashDir = join(CWD, 'crash-reports')
  try {
    const entries = await fs.readdir(crashDir, { withFileTypes: true })
    const files = await Promise.all(
      entries
        .filter(e => e.isFile() && e.name.endsWith('.txt'))
        .map(async (e) => {
          const path = join(crashDir, e.name)
          const stat = await fs.stat(path)
          return { path, mtime: stat.mtimeMs }
        }),
    )
    const recent = files
      .filter(f => f.mtime >= afterTs)
      .sort((a, b) => b.mtime - a.mtime)
    return recent[0]?.path ?? null
  } catch {
    return null
  }
}

async function readCrashSummary(crashPath: string): Promise<string> {
  const content = await fs.readFile(crashPath, 'utf-8')
  const lines = content.split('\n')
  const title = lines.find(l => l.startsWith('// ')) ?? ''
  const desc = lines.find(l => l.startsWith('Description:')) ?? ''
  const causeStart = lines.findIndex(l => /^[\w.]+(?:Exception|Error)/.test(l))
  const cause = causeStart >= 0 ? lines.slice(causeStart, causeStart + 6).join('\n') : ''
  return [title, desc, cause].filter(Boolean).join('\n')
}

/** Most recent world by `level.dat` mtime (dir mtime is unreliable on Windows). */
async function detectLatestWorld(): Promise<string | null> {
  let entries
  try {
    entries = await fs.readdir(join(CWD, 'saves'), { withFileTypes: true })
  } catch {
    return null
  }
  let latest: string | null = null
  let latestMtime = 0
  for (const d of entries) {
    if (!d.isDirectory()) continue
    let mtime = 0
    for (const marker of ['level.dat', 'level.dat_old']) {
      try {
        mtime = Math.max(mtime, (await fs.stat(join(CWD, 'saves', d.name, marker))).mtimeMs)
      } catch {
        // marker missing
      }
    }
    if (mtime === 0) {
      try {
        mtime = (await fs.stat(join(CWD, 'saves', d.name))).mtimeMs
      } catch {
        continue
      }
    }
    if (mtime > latestMtime) {
      latestMtime = mtime
      latest = d.name
    }
  }
  return latest
}

// ---------- Launch ----------
async function launchInstance(instanceId: string, world: string | null): Promise<void> {
  const isSsh = process.env.SSH_CLIENT || process.env.SSH_CONNECTION || process.env.SSH_TTY
  if (isSsh) {
    // No interactive desktop over SSH — bounce through a one-shot scheduled task.
    consola.info(chalk.magenta('SSH session detected — launching via schtasks in the desktop session…'))
    const taskName = `PrismLaunch_${Date.now()}`
    const worldArg = world ? ` --world "${world}"` : ''
    try {
      await execa('schtasks', [
        '/create', '/tn', taskName,
        '/tr', `cmd.exe /c "prismlauncher --launch ${instanceId}${worldArg} --alive"`,
        '/sc', 'once', '/st', '00:00', '/it', '/f',
      ])
      await execa('schtasks', ['/run', '/tn', taskName])
      await execa('schtasks', ['/delete', '/tn', taskName, '/f'])
    } catch (err: any) {
      consola.error('Failed to launch via schtasks. Make sure you are logged in locally.', err?.message)
      process.exit(1)
    }
    return
  }

  const args = ['--launch', instanceId]
  if (world) args.push('--world', world)
  args.push('--alive')
  spawn('prismlauncher', args, { detached: true, stdio: 'ignore' }).unref()
}

// ---------- Main command ----------
const mainCommand = defineCommand({
  meta: {
    name: 'mc-reload',
    description: 'Restart Minecraft instance and monitor logs',
  },
  args: {
    dry: {
      type: 'boolean',
      description: 'Dry run: no kill, no launch, only report crafttweaker.log errors',
      default: false,
    },
    until_ctlog: {
      type: 'string',
      description: 'Stop when regex matches a new line in crafttweaker.log',
    },
    until_debuglog: {
      type: 'string',
      description: 'Stop when regex matches a new line in logs/debug.log',
    },
    stop: {
      type: 'boolean',
      description: 'Kill MC once an --until* pattern matches (or on timeout). Requires an --until* flag.',
      default: false,
    },
  },
  async run({ args }) {
    const untilCt = args.until_ctlog ? new RegExp(args.until_ctlog) : null
    const untilDebug = args.until_debuglog ? new RegExp(args.until_debuglog) : null
    const hasPattern = Boolean(untilCt || untilDebug)

    if (args.stop && !hasPattern) {
      consola.error('--stop requires --until_ctlog or --until_debuglog')
      process.exit(1)
    }

    const dbgLog = dbgLogPath()
    const ctLog = ctLogPath()

    // ----- Dry run: report only -----
    if (args.dry) {
      consola.info(chalk.yellow('─── DRY RUN ─── reporting crafttweaker.log ERROR/FATAL, no kill/launch'))
      const { lines, count } = await readErrorsFromLog()
      if (count > 0) {
        consola.warn(`${count} ERROR/FATAL lines in crafttweaker.log:`)
        process.stderr.write(`${lines.map(l => `  ${l}`).join('\n')}\n`)
      } else {
        consola.success('No ERROR/FATAL in crafttweaker.log')
      }
      return
    }

    // ----- Resolve instance -----
    const dataDir = await getPrismDataDir()
    const instanceId = await detectInstance(dataDir)
    if (!instanceId) {
      consola.error('No instance found — run this from inside the modpack directory (the .minecraft folder)')
      process.exit(1)
    }

    const world = await detectLatestWorld()
    const existingPid = await getMcPid()
    consola.info(
      `cwd=${chalk.cyan(CWD)} `
      + `instance=${chalk.green(instanceId)} `
      + `mc=${existingPid ? chalk.yellow(`PID ${existingPid}`) : chalk.gray('stopped')} `
      + `world=${world ? chalk.cyan(world) : chalk.gray('none')}`,
    )

    // Capture sizes BEFORE relaunch so the new (truncated) session is tailed from its start.
    const sizeOf = async (p: string) => {
      try {
        return (await fs.stat(p)).size
      } catch {
        return 0
      }
    }
    const initialDbgSize = await sizeOf(dbgLog)
    const initialCtSize = await sizeOf(ctLog)

    // ----- Kill existing -----
    if (existingPid) {
      await killMc(existingPid)
      if (running(existingPid)) consola.warn(`MC PID ${existingPid} did not stop, continuing anyway`)
      else consola.success(`Killed MC PID ${existingPid}`)
    }

    // Give the OS a moment to release file handles / locks before the next
    // launch, so a freshly spawned PrismLauncher doesn't conflict with the
    // previous session's cleanup.
    await sleep(3000)

    // ----- Launch -----
    await launchInstance(instanceId, world)
    const launchTs = Date.now()
    consola.info(`Launched ${chalk.green(instanceId)} · watching debug.log (stall ${STALL_MS / 1000}s, max ${MONITOR_MS / 1000}s)`)

    // ----- Monitor -----
    const debugTail = createTail(initialDbgSize)
    const ctTail = createTail(initialCtSize)

    let pid: number | null = null
    let lastChange = launchTs
    let lastHealth = launchTs
    let reportedStall = false
    let ticking = false
    let shuttingDown = false
    let lastDot = 0
    let tickTimer: ReturnType<typeof setInterval> | null = null
    let timeoutTimer: ReturnType<typeof setTimeout> | null = null

    const shutdown = (code: number): never => {
      if (!shuttingDown) {
        shuttingDown = true
        if (tickTimer) clearInterval(tickTimer)
        if (timeoutTimer) clearTimeout(timeoutTimer)
      }
      process.exit(code)
    }

    const printMatch = (label: string, lineNo: number, line: string, next?: string) => {
      process.stdout.write(`\n${chalk.green(`Found match in ${label}:${lineNo}:`)}\n`)
      process.stdout.write(`  ${line}\n`)
      if (next !== undefined) process.stdout.write(`  ${next}\n`)
    }

    const stopMc = async () => {
      const target = pid ?? (await getMcPid())
      if (!target) return
      consola.info(chalk.yellow('Stopping MC (--stop)…'))
      await killMc(target)
    }

    const printCrashIfAny = async () => {
      const crash = await findNewestCrashReport(launchTs)
      if (!crash) return false
      consola.error(chalk.redBright(`Crash report: ${crash}`))
      process.stderr.write(`${await readCrashSummary(crash)}\n`)
      return true
    }

    /** Print the crafttweaker.log error summary, then exit (errors ⇒ non-zero). */
    const reportAndExit = async (code: number): Promise<never> => {
      const { lines, count } = await readErrorsFromLog()
      if (count > 0) {
        process.stdout.write(`${chalk.yellow(`${count} ERROR/FATAL lines in crafttweaker.log:`)}\n`)
        const shown = lines.slice(0, 50)
        for (const l of shown) process.stdout.write(`  ${chalk.red(l)}\n`)
        if (lines.length > shown.length) process.stdout.write(chalk.gray(`  …and ${lines.length - shown.length} more\n`))
        return shutdown(code === 0 ? 1 : code)
      }
      process.stdout.write(`${chalk.green('No ERROR/FATAL in crafttweaker.log')}\n`)
      return shutdown(code)
    }

    const onMatch = async (label: string, lineNo: number, line: string, next?: string): Promise<never> => {
      printMatch(label, lineNo, line, next)
      if (args.stop) await stopMc()
      return shutdown(0)
    }

    const renderStatus = () => {
      process.stdout.write('.')
    }

    const checkHealth = async () => {
      if (!pid) return
      if (!running(pid)) {
        consola.error(chalk.red(`MC process (PID ${pid}) exited`))
        await printCrashIfAny()
        return shutdown(1)
      }
      const idle = Date.now() - lastChange
      if (idle >= STALL_MS && !reportedStall) {
        reportedStall = true
        if (await printCrashIfAny()) return shutdown(1)
        // Alive, no crash → scripts loaded and the game went idle.
        consola.info(chalk.gray(`debug.log idle for ${Math.round(idle / 1000)}s — MC appears loaded`))
        if (!hasPattern && !args.stop) await reportAndExit(0)
      } else if (reportedStall && idle < STALL_MS) {
        reportedStall = false
      }
    }

    const tick = async () => {
      if (ticking || shuttingDown) return
      ticking = true
      try {
        if (!pid) {
          const found = await getMcPid()
          if (found) {
            pid = found
            consola.success(chalk.green(`MC process started (PID ${pid})`))
          }
        }

        const debugLines = await readNewLines(dbgLog, debugTail)
        if (debugLines.length) {
          lastChange = Date.now()
          if (untilDebug) {
            for (let i = 0; i < debugLines.length; i++) {
              debugTail.lineNo++
              if (untilDebug.test(debugLines[i])) return await onMatch('logs/debug.log', debugTail.lineNo, debugLines[i], debugLines[i + 1])
            }
          } else {
            debugTail.lineNo += debugLines.length
          }
        }

        if (untilCt) {
          const ctLines = await readNewLines(ctLog, ctTail)
          for (let i = 0; i < ctLines.length; i++) {
            ctTail.lineNo++
            if (untilCt.test(ctLines[i])) return await onMatch('crafttweaker.log', ctTail.lineNo, ctLines[i], ctLines[i + 1])
          }
        }

        const now = Date.now()
        if (now - lastHealth >= HEALTH_MS) {
          lastHealth = now
          await checkHealth()
          if (shuttingDown) return
        }

        if (!pid && now - launchTs >= LAUNCH_MS) {
          consola.error(chalk.red(`MC did not start within ${LAUNCH_MS / 1000}s`))
          return shutdown(1)
        }

        if (now - lastDot >= DOT_MS) {
          lastDot = now
          renderStatus()
        }
      } finally {
        ticking = false
      }
    }

    timeoutTimer = setTimeout(async () => {
      if (hasPattern) {
        consola.warn(chalk.yellow(`Timeout (${MONITOR_MS / 1000}s): pattern not matched`))
        if (args.stop) await stopMc()
        shutdown(1)
      } else {
        consola.warn(chalk.yellow(`Timeout (${MONITOR_MS / 1000}s) reached`))
        await reportAndExit(0)
      }
    }, MONITOR_MS)

    tickTimer = setInterval(tick, TICK_MS)

    process.on('SIGINT', () => shutdown(130))
    process.on('SIGTERM', () => shutdown(143))
  },
})

runMain(mainCommand)
