/* eslint-disable antfu/no-top-level-await */
import type { UpdateBox } from './build_utils.js'

import process from 'node:process'

import { consola } from 'consola'
import logUpdate from 'log-update'
import { join, parse, posix } from 'pathe'
import { replaceInFileSync } from 'replace-in-file'
import Client from 'ssh2-sftp-client'
import { $, fs, glob } from 'zx'

import { confirm, formatError, getBoxForLabel } from './build_utils.js'

const { readFileSync, writeFileSync, unlinkSync, existsSync, statSync } = fs

/** `  modpackUrl: https://…/E2E-Extended-v1.2.3.zip` — groups: the `key:` prefix, the URL. */
const MODPACK_URL_RE = /^([ \t]*modpackUrl[ \t]*:[ \t]*)(\S+)[ \t]*$/m

/**
 * The `localFiles:` key plus every entry/comment line indented under it.
 * Each repetition starts at a literal newline, so lines cannot be split apart.
 */
const LOCAL_FILES_RE = /^([ \t]*)localFiles:[ \t]*$(?:\n[ \t]*[#-][^\n]*)*\n?/m

interface SftpConfig {
  host?        : string
  port?        : string | number
  username?    : string
  password?    : string
  privateKey?  : string
  passphrase?  : string
  mc_root?     : string
  offline?     : boolean
  [key: string]: unknown
}

interface LoadedConfig {
  dir   : string
  label : string
  config: SftpConfig
}

export async function manageSFTP(serverSetupConfig: string = 'server/server-setup-config.yaml') {
  if (!existsSync(serverSetupConfig)) {
    consola.error(`Server setup config not found: ${serverSetupConfig}\n`
      + '  Nothing to upload — check the path passed to manageSFTP().')
    return
  }

  const sftpList = await glob('~secrets/sftp_servers/*/sftp.json')
  if (!sftpList.length) {
    consola.warn('No SFTP servers found under ~secrets/sftp_servers/*/sftp.json — skipping upload.')
    return
  }

  const sftpConfigs = loadSftpConfigs(sftpList)
  if (!sftpConfigs.length) {
    consola.warn('No usable SFTP configs — skipping upload.')
    return
  }

  // `.stdout`, not `.text()`: the latter also carries stderr into the version string.
  const described = await $`git describe --tags --abbrev=0`.nothrow()
  const currentVersion = described.exitCode === 0 ? described.stdout.trim() : ''
  if (!currentVersion)
    consola.warn('No git tag found — the server version banner will be left blank.')

  // Build the temp server-setup-config.yaml that points overrides/ -> .
  const serverConfigTmp = '~tmp-server-setup-config.yaml'
  const confSource = readFileSync(serverSetupConfig, 'utf8')
  const confText = confSource.replace(
    LOCAL_FILES_RE,
    (_full, indent: string) => `${indent}localFiles:\n${indent}  - from: overrides/\n${indent}    to: .\n`
  )
  if (confText === confSource) {
    consola.warn(`Could not patch "localFiles:" block in ${serverSetupConfig} — `
      + 'the regex did not match. Uploaded config may be missing the "overrides/ -> ." mapping.')
  }
  writeFileSync(serverConfigTmp, confText)

  try {
    for (const conf of sftpConfigs)
      await uploadToServer(conf, { serverConfigTmp, confText, currentVersion })
  }
  finally {
    // Always clean the shared temp file, even if a server threw.
    if (existsSync(serverConfigTmp)) unlinkSync(serverConfigTmp)
  }
}

/**
 * Read and validate every sftp.json. Invalid configs are reported and skipped
 * instead of crashing the whole release.
 */
function loadSftpConfigs(sftpList: string[]): LoadedConfig[] {
  const result: LoadedConfig[] = []
  for (const filename of sftpList) {
    const dir = parse(filename).dir
    const label = dir.split('/').pop() || filename

    let config: SftpConfig
    try {
      config = JSON.parse(readFileSync(filename, 'utf8')) as SftpConfig
    }
    catch (error) {
      consola.error(`Cannot read/parse SFTP config "${label}" (${filename}):\n  `
        + `${error instanceof Error ? error.message : String(error)}\n  `
        + 'Make sure the file exists and contains valid JSON.')
      continue
    }

    const problems = validateSftpConfig(config)
    if (problems.length) {
      consola.error(`SFTP config "${label}" (${filename}) is invalid:\n  - ${problems.join('\n  - ')}`)
      continue
    }

    result.push({ dir, label, config })
  }
  return result
}

/**
 * Return a list of human-readable problems with a config, or [] if it looks ok.
 */
function validateSftpConfig(config: SftpConfig): string[] {
  const problems: string[] = []

  if (!config.host)
    problems.push('missing "host"')
  if (!config.username)
    problems.push('missing "username"')
  if (!config.password && !config.privateKey)
    problems.push('missing credentials: provide either "password" or "privateKey"')

  if (config.port !== undefined && !isValidPort(config.port))
    problems.push(`"port" is not a valid port number (1-65535): ${JSON.stringify(config.port)}`)

  // privateKey in ssh2 must be the key *contents*, not a path. Catch the common
  // mistake of passing a file path that doesn't even exist on disk.
  if (
    typeof config.privateKey === 'string'
    && !config.privateKey.includes('PRIVATE KEY')
    && !existsSync(config.privateKey)
  ) {
    problems.push(`"privateKey" looks like a path but no such file exists: ${config.privateKey}\n    `
      + '(ssh2 expects the key contents, or a path to an existing key file)')
  }

  return problems
}

/** `Number('')` and `Number(' ')` are `0`, so an empty port must be rejected explicitly. */
function isValidPort(port: string | number): boolean {
  const parsed = typeof port === 'string' ? Number(port.trim() || Number.NaN) : port
  return Number.isInteger(parsed) && parsed > 0 && parsed <= 65535
}

/**
 * Report an SFTP failure as it actually happened.
 *
 * Deliberately never guesses at a cause: a previous version pattern-matched the
 * message and reported a remote "Permission denied" (SFTP status 3, thrown by
 * `fastPut` long after login) as an authentication failure, which sent everyone
 * looking at credentials that were fine. Print the real error plus the facts
 * from the config needed to locate it, and nothing else.
 */
function describeSftpError(error: unknown, config: SftpConfig): string {
  const target = `${config.username ?? '<no username>'}@${config.host ?? '<no host>'}:${config.port ?? 22}`
  return `${formatError(error)}\n  target: ${target}  mc_root: ${config.mc_root ?? '<not set>'}`
}

/**
 * Upload to one server, offering another attempt after every failure.
 *
 * Most things that break here — a dropped VPN, a wrong `mc_root`, a server-side
 * permission — are fixed in another window in under a minute, and skipping would
 * throw away a whole upload for that.
 */
async function uploadToServer(
  conf: LoadedConfig,
  ctx: { serverConfigTmp: string, confText: string, currentVersion: string }
) {
  if (!await confirm(`Upload SFTP ${conf.label}?`)) return

  while (!await attemptUpload(conf, ctx)) {
    if (!await confirm(`Retry upload to SFTP ${conf.label}?`)) {
      consola.warn(`SFTP "${conf.label}" skipped — the server still holds the previous version.`)
      return
    }
  }
}

/** One connect-and-upload round trip. @returns whether it went through. */
async function attemptUpload(
  conf: LoadedConfig,
  ctx: { serverConfigTmp: string, confText: string, currentVersion: string }
): Promise<boolean> {
  const { serverConfigTmp, confText, currentVersion } = ctx

  const sftp = new Client()
  const updateBox = getBoxForLabel(conf.label || '')
  const basePath = conf.config.mc_root ?? ''

  updateBox('Establishing connection')
  let connected = false
  try {
    // readyTimeout so an unreachable host fails fast instead of hanging.
    const { port, ...rest } = conf.config
    await sftp.connect({
      readyTimeout: 20_000,
      ...rest,
      ...port !== undefined ? { port: Number(port) } : {},
    })
    connected = true

    const uploaded = conf.config.offline
      ? await uploadOffline(sftp, conf, { serverConfigTmp, confText, updateBox, basePath })
      : await uploadOnline(sftp, conf, { serverConfigTmp, updateBox, basePath })

    // Both modes need this: the version banner and the server-only overrides are
    // not part of the modpack zip, and `localFiles: overrides/ -> .` re-copies
    // whatever sits in the remote `overrides/` on every install — a stale file
    // there silently overwrites the fresh config of every later release.
    if (uploaded)
      await uploadOverrides(sftp, conf, { currentVersion, updateBox, basePath })

    return true
  }
  catch (error) {
    logUpdate.done()
    const stage = connected ? 'Upload to' : 'Connection to'
    consola.error(`${stage} SFTP "${conf.label}" failed: ${describeSftpError(error, conf.config)}`)
    return false
  }
  finally {
    if (connected) {
      try {
        await sftp.end()
      }
      catch (error) {
        // Closing an already-dead connection is expected after a failed upload,
        // so this is not an error — but it is never hidden either.
        consola.debug(`Closing SFTP "${conf.label}" failed: ${formatError(error)}`)
      }
    }
  }
}

/** @returns whether the pack was actually uploaded — `false` when there was nothing to send. */
async function uploadOffline(
  sftp: Client,
  conf: LoadedConfig,
  { serverConfigTmp, confText, updateBox, basePath }:
  { serverConfigTmp: string, confText: string, updateBox: UpdateBox, basePath: string }
): Promise<boolean> {
  // Derived from the config instead of a hardcoded repo URL, so renaming the
  // repo or hosting the zip elsewhere cannot silently break offline uploads.
  const zipName = confText.match(MODPACK_URL_RE)?.[2].split('/').pop()
  if (!zipName) {
    logUpdate.done()
    consola.warn(`Offline upload for "${conf.label}" skipped: no "modpackUrl:" found in the server setup config.`)
    return false
  }

  const zipPath = join('dist', zipName)
  if (!existsSync(zipPath)) {
    logUpdate.done()
    consola.warn(`Offline upload for "${conf.label}" skipped: modpack zip not built at "${zipPath}".\n  `
      + 'Run the "Create EN .zip" build step first.')
    return false
  }

  // The server downloads the pack from its own folder rather than from GitHub.
  const offlineConfigTmp = `~${serverConfigTmp}`
  // Function form: a `$` in the file name must not be read as a replacement pattern.
  writeFileSync(offlineConfigTmp, confText.replace(MODPACK_URL_RE, (_full, prefix: string) => `${prefix}file://${zipName}`))
  updateBox(`[Upload Offline mode]`, `\n${offlineConfigTmp}\n${zipPath}`)
  try {
    // Small config first, then the big zip with a live progress indicator.
    await sftp.fastPut(offlineConfigTmp, posix.join(basePath, 'server-setup-config.yaml'))
    await fastPutWithProgress(sftp, zipPath, posix.join(basePath, zipName), zipName, updateBox)
  }
  finally {
    if (existsSync(offlineConfigTmp)) unlinkSync(offlineConfigTmp)
  }

  return true
}

/**
 * `sftp.fastPut` with a live box: progress bar, %, transferred/total, speed, ETA.
 * A 1s ticker keeps the box updating even when no bytes flow, so a slow or
 * stalled connection is visibly different from a frozen script.
 */
async function fastPutWithProgress(
  sftp: Client,
  local: string,
  remote: string,
  label: string,
  updateBox: UpdateBox
) {
  const total = statSync(local).size
  const startTime = Date.now()
  let transferred = 0
  let lastStepTime = startTime
  let lastRender = 0

  const render = () => {
    const now = Date.now()
    const elapsed = (now - startTime) / 1000
    const idle = (now - lastStepTime) / 1000
    const speed = elapsed > 0 ? transferred / elapsed : 0
    const ratio = total > 0 ? Math.min(transferred / total, 1) : 0
    const eta = speed > 0 && total > transferred ? (total - transferred) / speed : 0
    updateBox(
      label,
      `\n${progressBar(ratio)} ${Math.floor(ratio * 100)}%`,
      `\n${formatBytes(transferred)} / ${formatBytes(total)}`,
      `${formatBytes(speed)}/s`,
      idle > 3
        ? `STALLED ${Math.floor(idle)}s`
        : eta > 0 ? `ETA ${formatDuration(eta)}` : formatDuration(elapsed)
    )
  }

  render()
  const ticker = setInterval(render, 1000)
  try {
    await sftp.fastPut(local, remote, {
      step: (totalTransferred: number) => {
        transferred = totalTransferred
        lastStepTime = Date.now()
        if (lastStepTime - lastRender >= 150) {
          lastRender = lastStepTime
          render()
        }
      },
    })
    transferred = total
    render()
  }
  finally {
    clearInterval(ticker)
    logUpdate.done()
  }
}

function progressBar(ratio: number, width = 24): string {
  const filled = Math.round(Math.min(Math.max(ratio, 0), 1) * width)
  return `${'█'.repeat(filled)}${'░'.repeat(width - filled)}`
}

function formatBytes(bytes: number): string {
  if (!Number.isFinite(bytes) || bytes < 0) return '?'
  const units = ['B', 'KB', 'MB', 'GB', 'TB']
  let value = bytes
  let i = 0
  while (value >= 1024 && i < units.length - 1) {
    value /= 1024
    i++
  }
  return `${value.toFixed(i === 0 || value >= 100 ? 0 : 1)} ${units[i]}`
}

function formatDuration(sec: number): string {
  if (!Number.isFinite(sec) || sec <= 0) return '--'
  const s = Math.round(sec)
  const h = Math.floor(s / 3600)
  const m = Math.floor((s % 3600) / 60)
  const ss = s % 60
  if (h) return `${h}h ${m}m`
  if (m) return `${m}m ${ss}s`
  return `${ss}s`
}

/** The server downloads the pack itself, so only the setup config goes up here. */
async function uploadOnline(
  sftp: Client,
  conf: LoadedConfig,
  { serverConfigTmp, updateBox, basePath }:
  { serverConfigTmp: string, updateBox: UpdateBox, basePath: string }
): Promise<boolean> {
  updateBox(`Copy ${serverConfigTmp}`)
  await sftp.fastPut(serverConfigTmp, posix.join(basePath, 'server-setup-config.yaml'))
  return true
}

/** Stamp the release into the Discord start banner and push the server-only overrides. */
async function uploadOverrides(
  sftp: Client,
  conf: LoadedConfig,
  { currentVersion, updateBox, basePath }:
  { currentVersion: string, updateBox: UpdateBox, basePath: string }
) {
  updateBox('Change and copy server overrides')
  const mc2discordPath = join(conf.dir, 'overrides/config/mc2discord.toml')
  if (!existsSync(mc2discordPath)) {
    throw new Error(`Expected override file is missing: ${mc2discordPath}\n  `
      + 'The server overrides folder looks incomplete — cannot stamp the version banner.')
  }

  const title = `+ Server Started! +`
  const spaces = ' '.repeat(Math.max(1, (title.length - currentVersion.length) / 2) | 0)
  const replaceResult = replaceInFileSync({
    files       : mc2discordPath,
    from        : /(start\s*=\s*")[^"]+"/,
    to          : `$1\`\`\`diff\\n${title}\\n${spaces}${currentVersion}\\n\`\`\`"`,
    countMatches: true,
    disableGlobs: true,
  })

  // `numMatches`, not `hasChanged`: re-releasing the same version writes the banner
  // it already holds, and an unchanged file is success, not a broken regex.
  if (!replaceResult.length || !replaceResult[0].numMatches) {
    throw new Error(`Nothing replaced in ${mc2discordPath} — the "start = ..." line was not found. `
      + 'The override template may have changed; fix the regex before re-uploading.')
  }

  updateBox('Remove', 'serverstarter.lock')
  await sftp.delete(posix.join(basePath, 'serverstarter.lock'), true)

  let fileCounter = 0
  sftp.on('upload', () => updateBox('Copy overrides', ++fileCounter))
  await sftp.uploadDir(join(conf.dir, 'overrides'), posix.join(basePath, 'overrides/'))
}

// Launch file
if (import.meta.url === (await import('node:url')).pathToFileURL(process.argv[1]).href) {
  await manageSFTP()
  process.exit(0)
}
