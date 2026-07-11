/* eslint-disable antfu/no-top-level-await */
import process from 'node:process'

import { consola } from 'consola'
import logUpdate from 'log-update'
import { join, parse, posix } from 'pathe'
import { replaceInFileSync } from 'replace-in-file'
import Client from 'ssh2-sftp-client'
import { $, fs, glob } from 'zx'

import { confirm, getBoxForLabel } from './build_utils.js'

const { readFileSync, writeFileSync, unlinkSync, existsSync, statSync } = fs

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

  const currentVersion = (await $`git describe --tags --abbrev=0`.text()).trim()

  // Build the temp server-setup-config.yaml that points overrides/ -> .
  const serverConfigTmp = '~tmp-server-setup-config.yaml'
  const confSource = readFileSync(serverSetupConfig, 'utf8')
  const confText = confSource.replace(
    /(localFiles:\s*)\n +\S.*\n +\S.*$/m,
    `$1
    - from: overrides/
      to: .`
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

  if (config.port !== undefined && Number.isNaN(Number(config.port)))
    problems.push(`"port" is not a number: ${JSON.stringify(config.port)}`)

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

/**
 * Turn a raw connection/transfer error into an explanation a human can act on.
 */
function describeSftpError(error: unknown, config: SftpConfig): string {
  const err = error as NodeJS.ErrnoException & { level?: string }
  const host = config.host ?? '<unknown host>'
  const port = config.port ?? 22
  const target = `${host}:${port}`

  switch (String(err.code)) {
    case 'ENOTFOUND':
      return `Host "${host}" could not be resolved (DNS lookup failed). `
        + 'Check the "host" value for typos and your internet/VPN connection.'
    case 'ECONNREFUSED':
      return `Connection refused by ${target}. `
        + 'The SFTP/SSH server is not accepting connections there — check it is running and the "port" is correct.'
    case 'ETIMEDOUT':
    case 'ERR_SOCKET_CONNECTION_TIMEOUT':
      return `Connection to ${target} timed out. `
        + 'The server is unreachable, a firewall is blocking it, or the host/port is wrong.'
    case 'ECONNRESET':
      return `Connection to ${host} was reset. The server closed the link unexpectedly (restart, idle timeout, or fail2ban?).`
    case 'EHOSTUNREACH':
      return `Host ${host} is unreachable. Check the network route / VPN.`
    case 'ENETUNREACH':
      return `Network unreachable while connecting to ${host}. Check your internet connection.`
    case 'EPIPE':
      return `Connection to ${host} broke mid-transfer (broken pipe). Retry — the server may have dropped the session.`
    case 'ENOSPC':
      return `Remote server ${host} is out of disk space (ENOSPC).`
    case 'EACCES':
    case 'EPERM':
      return `Permission denied on ${host}. The user "${config.username}" lacks rights for that path.`
    case 'ENOENT':
      return `A path does not exist. Check "mc_root" (${config.mc_root ?? 'not set'}) on ${host} and local file paths.`
    default:
      break
  }

  const msg = err.message || String(error)

  if (
    err.level === 'client-authentication'
    || /authentication|all configured authentication methods failed|permission denied/i.test(msg)
  ) {
    return `Authentication failed for user "${config.username}" on ${host}. `
      + 'Check "username", "password"/"privateKey"'
      + `${config.privateKey ? ' and "passphrase"' : ''}.`
  }

  if (/handshake/i.test(msg)) {
    return `SSH handshake with ${host} failed. `
      + 'The server may require key algorithms this client does not offer, or it is not an SSH/SFTP server.'
  }

  if (/time?d? ?out/i.test(msg))
    return `Operation timed out talking to ${host}. ${msg}`

  return `${msg}${err.code ? ` (code: ${err.code})` : ''}`
}

async function uploadToServer(
  conf: LoadedConfig,
  ctx: { serverConfigTmp: string, confText: string, currentVersion: string }
) {
  const { serverConfigTmp, confText, currentVersion } = ctx

  if (!await confirm(`Upload SFTP ${conf.label}?`)) return

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
  }
  catch (error) {
    logUpdate.done()
    consola.error(`Cannot connect to SFTP "${conf.label}": ${describeSftpError(error, conf.config)}`)
    return
  }

  try {
    if (conf.config.offline)
      await uploadOffline(sftp, conf, { serverConfigTmp, confText, updateBox, basePath })
    else
      await uploadOnline(sftp, conf, { serverConfigTmp, currentVersion, updateBox, basePath })
  }
  catch (error) {
    logUpdate.done()
    consola.error(`Upload to SFTP "${conf.label}" failed: ${describeSftpError(error, conf.config)}`)
  }
  finally {
    if (connected) {
      try {
        await sftp.end()
      }
      catch {
        // Closing an already-dead connection is not worth surfacing.
      }
    }
  }
}

async function uploadOffline(
  sftp: Client,
  conf: LoadedConfig,
  { serverConfigTmp, confText, updateBox, basePath }:
  { serverConfigTmp: string, confText: string, updateBox: (...a: any[]) => void, basePath: string }
) {
  const offlineConfigTmp = `~${serverConfigTmp}`
  const zipRgx = `https:\/\/github.com\/Krutoy242\/Enigmatica2Expert-Extended\/releases\/download\/[^/]+\/`
  const zipName = confText.match(new RegExp(`${zipRgx}(.+)`))?.[1]
  const zipPath = join('dist', zipName || '')

  if (!zipName) {
    logUpdate.done()
    consola.warn(`Offline upload for "${conf.label}" skipped: could not find modpack zip URL in the config.`)
    return
  }
  if (!existsSync(zipPath)) {
    logUpdate.done()
    consola.warn(`Offline upload for "${conf.label}" skipped: modpack zip not built at "${zipPath}".\n  `
      + 'Run the "Create EN .zip" build step first.')
    return
  }

  writeFileSync(offlineConfigTmp, confText.replace(new RegExp(zipRgx), 'file://'))
  updateBox(`[Upload Offline mode]`, `\n${offlineConfigTmp}\n${zipPath}`)
  try {
    // Small config first, then the big zip with a live progress indicator.
    await sftp.fastPut(offlineConfigTmp, posix.join(basePath, 'server-setup-config.yaml'))
    await fastPutWithProgress(sftp, zipPath, posix.join(basePath, zipName), zipName, updateBox)
  }
  finally {
    if (existsSync(offlineConfigTmp)) unlinkSync(offlineConfigTmp)
  }
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
  updateBox: (...a: any[]) => void
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

function formatBytes(n: number): string {
  if (!Number.isFinite(n) || n < 0) return '?'
  const units = ['B', 'KB', 'MB', 'GB', 'TB']
  let i = 0
  while (n >= 1024 && i < units.length - 1) {
    n /= 1024
    i++
  }
  return `${n.toFixed(i === 0 || n >= 100 ? 0 : 1)} ${units[i]}`
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

async function uploadOnline(
  sftp: Client,
  conf: LoadedConfig,
  { serverConfigTmp, currentVersion, updateBox, basePath }:
  { serverConfigTmp: string, currentVersion: string, updateBox: (...a: any[]) => void, basePath: string }
) {
  updateBox(`Copy ${serverConfigTmp}`)
  await sftp.fastPut(serverConfigTmp, posix.join(basePath, 'server-setup-config.yaml'))

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

  if (!replaceResult.length || !replaceResult[0].hasChanged) {
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
