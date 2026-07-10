/**
 * @file Execute Minecraft commands from Node via the ProbeZS RMI bridge.
 *
 * Round-trip:
 *   1. Encode `__cmd__:exec:<uuid>:<command>` into a ProbeZS-safe bracket token.
 *   2. Spawn a tiny Java RMI client that calls BracketHandler.getLocalizedName(token).
 *   3. The `reloadable.zs` mixin runs the command through a capturing command
 *      sender and replies with `OK:exec:<uuid>:<encodedOutput>` /
 *      `FAIL:exec:<uuid>:<encodedOutput>`, where `encodedOutput` is the command's
 *      own output (what it printed), newline-escaped via the %XX scheme.
 *   4. We take that reply from the RMI return value (fast path), or fall back to
 *      polling crafttweaker.log for it, then decode the output from the reply.
 */

import { Buffer } from 'node:buffer'
import { execFileSync } from 'node:child_process'
import { closeSync, existsSync, mkdirSync, openSync, readSync, statSync, writeFileSync } from 'node:fs'
import { delimiter, join } from 'node:path'
import process from 'node:process'
import fg from 'fast-glob'

// ── Config ──────────────────────────────────────────────────

const CWD = process.cwd()
const CRAFTTWEAKER_LOG = join(CWD, 'crafttweaker.log')
const DEBUG_LOG = join(CWD, 'logs', 'debug.log')
const CACHE_DIR = join(CWD, '~cache', 'probezs')
const RMI_HOST = 'localhost'
const RMI_PORT = 6489

/** Read a positive-integer env override, else the fallback. */
function envInt(name: string, fallback: number): number {
  const v = Number(process.env[name])
  return Number.isFinite(v) && v > 0 ? v : fallback
}

// The RMI java client blocks until the game returns from getLocalizedName, which
// for a synchronous command (e.g. `ct reload`) can be the whole command runtime.
// Keep this comfortably above the log-poll wait so the RMI call never dies first.
// Override with E2EE_RMI_TIMEOUT_MS.
const JAVA_EXEC_TIMEOUT_MS = envInt('E2EE_RMI_TIMEOUT_MS', 300_000)

// How long to wait for the reply to appear in crafttweaker.log. This is the
// binding timeout for slow commands like `ct reload` (well over the old 30s on
// this pack). Override per-run with E2EE_CMD_TIMEOUT_MS.
const DEFAULT_CMD_WAIT_MS = envInt('E2EE_CMD_TIMEOUT_MS', 180_000)

// Max time to wait for a headless auto-join to reach "joined the game".
// Override with E2EE_JOIN_TIMEOUT_MS.
const JOIN_WAIT_MS = envInt('E2EE_JOIN_TIMEOUT_MS', 120_000)

// ── Public types ────────────────────────────────────────────

export interface ExecOptions {
  /** Max time to wait for the reply via log polling, in ms (default 180000, or $E2EE_CMD_TIMEOUT_MS). */
  waitMs?        : number
  /** Log poll interval in ms (default 100). */
  pollIntervalMs?: number
  /** Emit diagnostics to stderr. */
  debug?         : boolean
}

export interface CmdResult {
  /** The command that ran, normalized with a leading `/`. */
  command: string
  /** Short id used to correlate the reply. */
  uuid   : string
  /** true on OK:exec, false on FAIL:exec. */
  ok     : boolean
  /** Full reply line, e.g. "OK:exec:a3f8:/say Hello". */
  reply  : string
  /** Captured command output text (from debug.log), stripped of log prefixes. */
  output : string
  /** Wall-clock duration in ms. */
  ms     : number
}

// ── Jar discovery (lazy: never throws at import time) ────────

let _jar: string | null = null
function probezsJar(): string {
  if (_jar) return _jar
  const [match] = fg.sync('mods/ProbeZS-*.jar', { cwd: CWD })
  if (!match) {
    throw new Error(`ProbeZS jar not found: no file matches "mods/ProbeZS-*.jar" under ${CWD}`)
  }
  _jar = join(CWD, match)
  return _jar
}

// ── Encoding ────────────────────────────────────────────────
// Single pass, char by char, so order never matters and `%` is handled safely.
// Mirror of decode() in reloadable.zs (which decodes %25 -> % LAST).

const ENCODE: Record<string, string> = {
  '%' : '%25', // must be representable; the rest are forbidden by ZenTokener
  ' ' : '%20',
  '\t': '%09',
  '\r': '%0D',
  '\n': '%0A',
  '\\': '%5C',
  '@' : '%40',
  '#' : '%23',
  '$' : '%24',
  '§' : '%A7',
}

function encode(s: string): string {
  let out = ''
  for (const ch of s) out += ENCODE[ch] ?? ch
  return out
}

// Decode the captured command output carried back in the reply. Mirror of
// `encode()` in reloadable.zs: only newline chars are escaped on the way back,
// and `%25` is decoded LAST so an emitted `%` can't recombine into a spurious code.
function decodeOutput(s: string): string {
  return s
    .replace(/%0D/g, '\r')
    .replace(/%0A/g, '\n')
    .replace(/%25/g, '%') // LAST
}

// ── Server/world readiness check ───────────────────────────

/** Search for `pattern` reading from the end of the file (up to 10 MB). */
function searchFromEnd(filePath: string, pattern: RegExp): boolean {
  const CHUNK = 64 * 1024
  const MAX_READ = 10 * 1024 * 1024
  const size = fileSize(filePath)
  if (!size) return false
  let pos = size
  while (pos > 0) {
    const start = Math.max(0, pos - CHUNK)
    const slice = readSlice(filePath, start, pos)
    if (pattern.test(slice)) return true
    pos = Math.max(0, start - 512) // 512B overlap to avoid splitting match at boundary
    if (size - start >= MAX_READ) break
  }
  return false
}

// ── Log timestamp helpers ──────────────────────────────────

function firstLine(filePath: string): string {
  const size = fileSize(filePath)
  if (!size) return ''
  return readSlice(filePath, 0, Math.min(4096, size)).split('\n')[0] || ''
}
function lastLine(filePath: string): string {
  const CHUNK = 4096
  const size = fileSize(filePath)
  if (!size) return ''
  const slice = readSlice(filePath, Math.max(0, size - CHUNK), size)
  const lines = slice.trim().split('\n')
  for (let i = lines.length - 1; i >= 0; i--) if (lines[i]) return lines[i]
  return ''
}
function extractTimestamp(line: string): string | null {
  const m = line.match(/^\[(\d{2}:\d{2}:\d{2})\]/)
  return m ? m[1] : null
}
function formatDuration(totalSec: number): string {
  const m = Math.floor(totalSec / 60)
  const s = totalSec % 60
  return s ? `${m}m ${s.toString().padStart(2, '0')}s` : `${m}m`
}
function logBoundaryTimestamps(): { first: string | null; duration: string | null } {
  for (const lp of [join(CWD, 'logs', 'latest.log'), join(CWD, 'logs', 'debug.log')]) {
    if (!existsSync(lp)) continue
    const first = extractTimestamp(firstLine(lp))
    const last = extractTimestamp(lastLine(lp))
    if (first && last) {
      const [fh, fm, fs] = first.split(':').map(Number)
      const [lh, lm, ls] = last.split(':').map(Number)
      let diff = (lh * 3600 + lm * 60 + ls) - (fh * 3600 + fm * 60 + fs)
      if (diff < 0) diff += 86400
      return { first, duration: formatDuration(diff) }
    }
    if (first) return { first, duration: null }
  }
  return { first: null, duration: null }
}

const LOGS = () => [join(CWD, 'logs', 'latest.log'), join(CWD, 'logs', 'debug.log')]

/** True once a player has joined a world (integrated server ready for commands). */
function isWorldLoaded(): boolean {
  for (const lp of LOGS()) {
    if (existsSync(lp) && searchFromEnd(lp, /joined the game/)) return true
  }
  return false
}

/** True once FML finished loading mods (game at least at the main menu). */
function isFmlLoaded(): boolean {
  for (const lp of LOGS()) {
    if (existsSync(lp) && searchFromEnd(lp, /Forge Mod Loader has successfully loaded/)) return true
  }
  return false
}

/**
 * Ensure a world is loaded and the server is ready for commands. If the game is
 * at the main menu (FML loaded, no world), trigger a headless auto-join over the
 * RMI bridge and block until the world is up — see scripts/mixin/probezs's
 * `__cmd__:join:` handler / Op.requestAutoJoin. Throws if still loading, or if
 * the auto-join does not complete in time.
 */
async function ensureWorldLoaded(options: ExecOptions = {}): Promise<void> {
  if (isWorldLoaded()) return

  if (!isFmlLoaded()) {
    const { first, duration } = logBoundaryTimestamps()
    throw new Error(
      `Minecraft is still loading — with ${first ? `${first}` : '??'} and already ${duration ? `${duration}` : '??'}`
    )
  }

  // At the main menu with no world — auto-join the launch-time marker world.
  await ensureAutoJoined(options)
}

/** Fire a headless auto-join and wait for "joined the game". */
async function ensureAutoJoined(options: ExecOptions = {}): Promise<void> {
  const { debug = false } = options
  const uuid = shortUuid()
  const expr = encode(`__cmd__:join:${uuid}`)
  try {
    const reply = rmiLookup(expr)
    if (debug) console.error(`[probezs] join -> ${reply || '(empty)'}`)
  }
  catch (e) {
    // Bridge not reachable yet — surface as a normal "still loading" style error.
    throw new Error(`Auto-join request failed (RMI not ready?): ${(e as Error).message}`)
  }

  const deadline = Date.now() + JOIN_WAIT_MS
  while (Date.now() < deadline) {
    if (isWorldLoaded()) return
    await sleep(500)
  }
  throw new Error(`Auto-join did not reach a loaded world within ${JOIN_WAIT_MS}ms (check logs/debug.log for a missing-registry confirmation screen)`)
}

// ── Process check ───────────────────────────────────────────

function isMinecraftRunning(): boolean {
  try {
    if (process.platform === 'win32') {
      const out = execFileSync('wmic', ['process', 'where', 'name="java.exe" or name="javaw.exe"', 'get', 'commandline'], { encoding: 'utf8', stdio: 'pipe' })
      const l = out.toLowerCase()
      return l.includes('minecraft') || l.includes('forge') || l.includes('launchwrapper')
    }
    else {
      const out = execFileSync('ps', ['-ef'], { encoding: 'utf8', stdio: 'pipe' })
      const l = out.toLowerCase()
      return l.includes('java') && (l.includes('minecraft') || l.includes('forge') || l.includes('launchwrapper'))
    }
  }
  catch {
    return true // Assume running if check fails to avoid false positive blocking
  }
}

// ── Java / RMI ──────────────────────────────────────────────

const JAVA_SOURCE = `
import java.rmi.registry.LocateRegistry;
import youyihj.probezs.api.BracketHandlerService;
public class R {
  public static void main(String[] a) throws Exception {
    BracketHandlerService s = (BracketHandlerService)
      LocateRegistry.getRegistry("${RMI_HOST}", ${RMI_PORT}).lookup("BracketHandler");
    for (String e : a) System.out.println(s.getLocalizedName(e));
  }
}
`

let _compiled = false
function ensureCompiled(): void {
  if (_compiled) return
  const jar = probezsJar()
  const classFile = join(CACHE_DIR, 'R.class')
  if (!existsSync(classFile)) {
    mkdirSync(CACHE_DIR, { recursive: true })
    const javaFile = join(CACHE_DIR, 'R.java')
    writeFileSync(javaFile, JAVA_SOURCE)
    try {
      execFileSync('javac', ['-cp', jar, '-d', CACHE_DIR, javaFile], { stdio: 'pipe' })
    }
    catch (e) {
      throw wrapExecError('javac', e)
    }
  }
  _compiled = true
}

/** Triggers the bracket handler; returns whatever ZS sent back (one trimmed line). */
function rmiLookup(expr: string): string {
  ensureCompiled()
  const classpath = [CACHE_DIR, probezsJar()].join(delimiter)
  try {
    return execFileSync('java', ['-cp', classpath, 'R', expr], {
      stdio  : 'pipe',
      timeout: JAVA_EXEC_TIMEOUT_MS,
    }).toString().trim()
  }
  catch (e) {
    throw wrapExecError('java RMI lookup', e)
  }
}

function wrapExecError(what: string, e: unknown): Error {
  const err = e as { stderr?: Buffer | string, message?: string } | null
  let detail = err?.stderr?.toString().trim() || err?.message || String(e)
  if (detail.includes('Connection refused')) {
    detail = `ProbeZS RMI server is not listening on ${RMI_HOST}:${RMI_PORT}.\n`
             + `Diagnosis: ${diagnoseRmiFailure()}\n\n${
               detail}`
  }
  return new Error(`${what} failed: ${detail}`)
}

function diagnoseRmiFailure(): string {
  const logPath = join(CWD, 'logs', 'debug.log')
  const size = fileSize(logPath)
  if (size === 0) return 'logs/debug.log is empty or missing.'

  const start = Math.max(0, size - 100_000)
  const logContent = readSlice(logPath, start, size)

  const crashIdx = logContent.lastIndexOf('---- Minecraft Crash Report ----')
  if (crashIdx !== -1) {
    const lines = logContent.slice(crashIdx).split('\n').map(l => l.trim())
    const descIdx = lines.findIndex(l => l.startsWith('Description:'))
    const desc = descIdx !== -1 ? lines[descIdx] : 'Description: Unknown'

    let ex = ''
    let causedBy = ''
    if (descIdx !== -1) {
      for (let i = descIdx + 1; i < lines.length; i++) {
        if (!ex && lines[i] && (lines[i].includes('Exception') || lines[i].includes('Error'))) {
          ex = lines[i]
        }
        if (lines[i].startsWith('Caused by:')) {
          causedBy = lines[i]
          break
        }
      }
    }

    let msg = `Minecraft crashed!\n  ${desc}`
    if (ex) msg += `\n  ${ex}`
    if (causedBy) msg += `\n  ${causedBy}`
    return msg
  }

  const rmiIdx = logContent.lastIndexOf('java.rmi.server.ExportException')
  if (rmiIdx !== -1) {
    const rmiLine = logContent.slice(rmiIdx).split('\n')[0].trim()
    return `ProbeZS RMI failed to start: ${rmiLine}`
  }

  return 'No clear crash or bind error found in the last 100KB of logs/debug.log.'
}

// ── Log helpers ─────────────────────────────────────────────

function fileSize(p: string): number {
  try {
    return statSync(p).size
  }
  catch {
    return 0
  }
}

/** Read bytes [start, end) as UTF-8. Returns '' on any error or empty range. */
function readSlice(path: string, start: number, end: number): string {
  if (end <= start) return ''
  let fd: number | undefined
  try {
    fd = openSync(path, 'r')
    const len = end - start
    const buf = Buffer.alloc(len)
    const n = readSync(fd, buf, 0, len, start)
    return buf.toString('utf8', 0, n)
  }
  catch {
    return ''
  }
  finally {
    if (fd !== undefined) closeSync(fd)
  }
}

function findReply(text: string, uuid: string): { ok: boolean, reply: string, output: string } | null {
  for (const [ok, tag] of [[true, `OK:exec:${uuid}:`], [false, `FAIL:exec:${uuid}:`]] as const) {
    const idx = text.indexOf(tag)
    if (idx < 0) continue
    const reply = lineAt(text, idx)
    return { ok, reply, output: decodeOutput(reply.slice(tag.length)) }
  }
  return null
}

function lineAt(text: string, idx: number): string {
  const nl = text.indexOf('\n', idx)
  return (nl >= 0 ? text.slice(idx, nl) : text.slice(idx)).trim()
}

/** Poll only the bytes appended after `since`, growing the read window each tick. */
async function waitForLogResult(
  uuid: string,
  since: number,
  timeoutMs: number,
  pollIntervalMs: number
): Promise<{ ok: boolean, reply: string, output: string }> {
  const deadline = Date.now() + timeoutMs
  let from = since
  let acc = ''
  while (Date.now() < deadline) {
    const size = fileSize(CRAFTTWEAKER_LOG)
    if (size < from) {
      // Log was rotated/truncated; rescan from the top.
      from = 0
      acc = ''
    }
    if (size > from) {
      acc += readSlice(CRAFTTWEAKER_LOG, from, size)
      from = size
      const hit = findReply(acc, uuid)
      if (hit) return hit
    }
    await sleep(pollIntervalMs)
  }
  throw new Error(`Command timed out after ${timeoutMs}ms (uuid=${uuid})`)
}

// ── RMI availability ─────────────────────────────────────────
// World auto-join now happens at boot via a launch-time marker file read by
// a GUI-init mixin (see mc-tools/packages/reducer/src/launcher/prism.ts's
// writeAutoJoinMarker and scripts/mixin/probezs/shared.zs's
// Op.tryAutoJoinWorld) — no RMI round-trip needed for that anymore.
// waitForRmi remains a generic "is the bridge up yet" helper.

export interface WaitForRmiOptions {
  /** Max time to wait for RMI to become reachable, in ms (default 120_000). */
  rmiWaitMs?     : number
  /** Poll interval in ms (default 250). */
  pollIntervalMs?: number
  /** Emit diagnostics to stderr. */
  debug?         : boolean
}

/**
 * Wait until the ProbeZS RMI bridge is reachable (Minecraft loaded, at main
 * menu — NOT waiting for a world to be loaded). Throws on timeout.
 */
export async function waitForRmi(options: WaitForRmiOptions = {}): Promise<void> {
  if (!isMinecraftRunning()) {
    throw new Error(`Minecraft instance is not running. Start the game first.\nDiagnosis: ${diagnoseRmiFailure()}`)
  }
  const { rmiWaitMs = 120_000, pollIntervalMs = 250, debug = false } = options
  const deadline = Date.now() + rmiWaitMs
  while (Date.now() < deadline) {
    try {
      // Any bracket expression that doesn't NPE will do — we just test connectivity.
      rmiLookup('<__probe__:ping>')
      if (debug) console.error('[probezs] RMI reachable')
      return
    } catch {
      if (debug) console.error('[probezs] waiting for RMI...')
      await sleep(pollIntervalMs)
    }
  }
  throw new Error(`RMI bridge did not become reachable within ${rmiWaitMs}ms`)
}

// ── Public API ──────────────────────────────────────────────

/** Run a single Minecraft command and resolve with its result. */
export async function execCmd(cmd: string, options: ExecOptions = {}): Promise<CmdResult> {
  if (!isMinecraftRunning()) {
    throw new Error(`Minecraft instance is not running. Start the game first.\nDiagnosis: ${diagnoseRmiFailure()}`)
  }

  await ensureWorldLoaded(options)

  const command = cmd.startsWith('/') ? cmd : `/${cmd}`
  if (command.trim() === '/') throw new Error('Empty command')

  const uuid = shortUuid()
  const expr = encode(`__cmd__:exec:${uuid}:${command}`)
  const { waitMs = DEFAULT_CMD_WAIT_MS, pollIntervalMs = 100, debug = false } = options

  const since = fileSize(CRAFTTWEAKER_LOG)
  const t0 = performance.now()

  const rmiReply = rmiLookup(expr)
  if (debug) console.error(`[probezs] rmi -> ${rmiReply || '(empty)'}`)

  // Fast path: the RMI call returned the reply directly.
  const fast = findReply(rmiReply, uuid)
  if (debug && !fast) console.error('[probezs] no reply over RMI, falling back to log polling')

  // The reply carries the captured command output (sender-side capture).
  const hit = fast ?? await waitForLogResult(uuid, since, waitMs, pollIntervalMs)

  return { command, uuid, ok: hit.ok, reply: hit.reply, output: hit.output, ms: performance.now() - t0 }
}

/** Run commands in order, stopping at the first failure. Returns results so far. */
export async function execCmds(cmds: string[], options: ExecOptions = {}): Promise<CmdResult[]> {
  const results: CmdResult[] = []
  for (const cmd of cmds) {
    const result = await execCmd(cmd, options)
    results.push(result)
    if (!result.ok) break
  }
  return results
}

// ── Misc ────────────────────────────────────────────────────

function shortUuid(): string {
  return Math.random().toString(16).slice(2, 8)
}

async function sleep(ms: number): Promise<void> {
  return new Promise(r => setTimeout(r, ms))
}
