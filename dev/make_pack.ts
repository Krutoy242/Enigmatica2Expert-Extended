/**
 * @file Make necessary preparations to turn dev version of pack
 * into distributable one.
 * Actually its:
 *  1. Clear temporary folders and files from previous script lunch
 *  2. Creating and replacing .zip files of latest tag
 *  3. Replacing files in dedicated server folder
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

/* eslint-disable antfu/no-top-level-await */

/* eslint-disable ts/promise-function-async */

/* eslint-disable regexp/no-super-linear-backtracking */

import type { Commit, ParserStreamOptions } from 'conventional-commits-parser'
import type { ProcessPromise } from 'zx'

import type { RemoveFilesResult } from './build/build_utils.js'

import process from 'node:process'

import * as p from '@clack/prompts'
import { ConventionalGitClient } from '@conventional-changelog/git-client'
import ignore from 'ignore'
import { resolve } from 'pathe'
import { replaceInFile } from 'replace-in-file'
import { $, fs, glob, retry } from 'zx'

import { commitAmend, confirm, formatError, formatRemoveResult, getIgnoredFiles, removeFiles, runAllLabeled, showStacks } from './build/build_utils.js'
import { manageSFTP } from './build/sftp.js'
import { generateChangelog } from './tools/changelog/changelog.js'
import { ICON_CLI, iconifyFile } from './tools/mc-icons.mjs'

const { existsSync, readFileSync } = fs

// stdin is `ignore`d: these commands never read from us, and a child holding the
// console input handle eats the keystrokes of the next prompt.
const $$ = $({ stdio: ['ignore', 'inherit', 'inherit'], verbose: true })

// For children that do need a real stdin — the mc-icons picker renders with
// Ink, which requires a raw-mode-capable input stream.
const $tty = $({ stdio: 'inherit', verbose: true })

// For children that must not touch the console at all. MSYS `git push` leaves
// the Windows console with ENABLE_PROCESSED_OUTPUT and VT processing cleared,
// which turns every later prompt into literal escape codes. Behind a pipe it
// never gets a console handle; zx still echoes its output (verbose).
const $pipe = $({ stdio: ['ignore', 'pipe', 'pipe'], verbose: true })

const PATHS = {
  tmpDir           : 'D:/mc_tmp/',
  dist             : 'dist',
  devonlyIgnore    : 'dev/.devonly.ignore',
  versionTxt       : 'dev/version.txt',
  changelogLatest  : 'CHANGELOG-latest.md',
  serverSetupConfig: 'server/server-setup-config.yaml',
  relauncher       : 'config/relauncher.json',
  mainMenu         : 'config/CustomMainMenu/mainmenu.json',
  manifest         : 'manifest.json',
  enderModpackCfg  : 'config/endermodpacktweaks/modpack.cfg',
  modlist          : 'config/crash_assistant/modlist.json',
  skipWorktree     : [
    'minecraftinstance.json',
    'config/crash_assistant/modlist.json',
  ],
} as const

const PARSER_OPTIONS: ParserStreamOptions = {
  headerPattern       : /^(\w*)(?:\((.*)\))?!?: (.*)$/,
  headerCorrespondence: ['type', 'scope', 'subject'],
  noteKeywords        : ['BREAKING CHANGE', 'BREAKING-CHANGE'],
}

/** Groups: optional `v` prefix, major, minor, patch. Prerelease / build are matched but dropped on bump. */
const SEMVER_RE = /^(v?)(\d+)\.(\d+)\.(\d+)(?:-[a-z0-9.-]+)?(?:\+[a-z0-9.-]+)?$/i

/** Canonical repo slug — also the fallback when `git remote` cannot be read. */
const REPO = 'Krutoy242/Enigmatica2Expert-Extended'
const CURSEFORGE_FILES_URL = 'https://legacy.curseforge.com/minecraft/modpacks/enigmatica-2-expert-extended/files'

/** Cleanroom tags its releases `<ver>` and names the assets `cleanroom-<ver>[-installer].jar`. */
const CLEANROOM_RELEASES = 'https://github.com/CleanroomMC/Cleanroom/releases/download'

type BumpType = 'major' | 'minor' | 'patch'

/** Everything the steps after version selection need — resolved once, never recomputed. */
interface Release {
  version  : string
  baseName : string
  zip      : string
  serverZip: string
}

const devonlyIgnore = ignore().add(readDevonlyIgnore())

/** Label of the step running right now — an abort message names it instead of leaving a bare error. */
let currentStep = 'startup'

// ─────────────────────────────────────────────────────────────────────────────

p.intro('Let\'s cook a new release! 🍳')
try {
  await main()
}
catch (error) {
  p.log.error(`Step "${currentStep}" failed:\n${formatError(error)}`)
  if (!showStacks()) p.log.info('Re-run with DEBUG=1 to see stack traces.')
  p.cancel('Release aborted.')
  process.exit(1)
}
process.exit(0)

// ─────────────────────────────────────────────────────────────────────────────

async function main() {
  await step('automation', () => runAutomation())
  const release = await step('version', () => resolveVersion())
  await step('changelog', () => runChangelog(release))
  await step('tag', () => createTag(release))
  await step('build zips', () => buildZips(release))
  await step('sftp', () => runSFTP())

  if (!await step('push tag', () => pushTag())) {
    p.outro('Finished without release.')
    return
  }

  await step('publish release', () => publishRelease(release))
}

async function runAutomation() {
  if (!await confirm('🪓 Perform automation?')) return

  const { exitCode } = await $$`pnpm dev`.nothrow()
  if (exitCode !== 0)
    p.log.warn('Some dev automation tasks reported errors (see above) — continuing anyway.')
}

async function resolveVersion(): Promise<Release> {
  const described  = await $`git describe --tags --abbrev=0`.nothrow()
  const oldVersion = described.exitCode === 0 ? described.stdout.trim() : ''

  if (!oldVersion)
    p.log.warn('No tags found — cannot suggest a version based on history.')

  const version = await promptText('Enter next version', {
    initialValue: oldVersion ? await suggestNextVersion(oldVersion) : 'v1.0.0',
    validate    : validateVersion,
  })

  // Re-running a release for the same version is routine. Only ask when the tag
  // sits on another commit — there, re-tagging silently moves it off whatever was
  // released before.
  if (version === oldVersion) {
    const [tagged, head] = await Promise.all([revParse(version), revParse('HEAD')])
    if (tagged && tagged !== head && !await confirm(
      `${version} already points at ${tagged.slice(0, 7)}, HEAD is ${head.slice(0, 7)}. Move the tag to HEAD?`
    )) {
      p.cancel('Operation cancelled.')
      process.exit(0)
    }
  }

  return makeRelease(version)
}

async function runChangelog(release: Release) {
  if (!await confirm('🧼 Working tree is clean and rebased?')) {
    p.cancel('Clean the working tree first — a release must not carry stray changes.')
    process.exit(0)
  }

  if (!await confirm('Generate Changelog?')) return

  p.note('Updating version in files', '📝')
  await runAllLabeled({
    [PATHS.versionTxt]: () => fs.writeFile(PATHS.versionTxt, release.version),

    [PATHS.mainMenu]: () => replaceInFile({
      files: PATHS.mainMenu,
      from : /("version_num"\s*:\s*\{\s*"text"\s*:\s*")[^"]+"/,
      to   : `$1${release.version}"`,
    }),

    [PATHS.manifest]: () => replaceInFile({
      files: PATHS.manifest,
      from : /(^ {2}"version"\s*:\s*")[^"]+("\s*,)/m,
      to   : `$1${release.version}$2`,
    }),

    [PATHS.enderModpackCfg]: () => replaceInFile({
      files: PATHS.enderModpackCfg,
      from : /^(\s*S\s*:\s*"\[\d+\] Modpack Version"\s*=\s*).*$/m,
      to   : `$1${release.version}`,
    }),

    [PATHS.serverSetupConfig]: () => updateServerSetupConfig(release),
    [PATHS.modlist]          : () => cleanupModlist(),
    [PATHS.changelogLatest]  : () => generateChangelog(PATHS.changelogLatest),
  })

  p.note('Iconify changelog and prepare files to git add', '📝')
  const { replaced, problems } = await iconifyFile(PATHS.changelogLatest)
  p.log.step(`Item names turned into icons: ${replaced}`)

  // Names that could mean several items are picked by hand, with image previews
  // — and that picker is interactive, so it lives in the mc-icons CLI. The
  // commit-msg hook nags about them as they are written, so this is rare.
  if (problems.length)
    await $tty`node ${ICON_CLI} ${PATHS.changelogLatest}`

  // These files are normally hidden from git; unhide them for exactly one commit
  // and always hide them again, even if the commit below fails.
  await gitRetry(() => $`git update-index --no-skip-worktree ${PATHS.skipWorktree}`)
  try {
    await commitVersionBump()
  }
  finally {
    await gitRetry(() => $`git update-index --skip-worktree ${PATHS.skipWorktree}`)
  }
}

async function commitVersionBump() {
  p.note('Now manually fix changelog and close file', '✍ ')
  await $$`code --wait ${PATHS.changelogLatest}`

  const filesToCommit = [
    PATHS.mainMenu,
    PATHS.versionTxt,
    PATHS.manifest,
    PATHS.enderModpackCfg,
    PATHS.serverSetupConfig,
    PATHS.changelogLatest,
    ...PATHS.skipWorktree,
  ]

  // -f: several of these are ignored in the dev tree.
  await gitRetry(() => $`git add -f ${filesToCommit}`)

  if ((await $`git diff --staged --quiet`.nothrow()).exitCode !== 0)
    await commitAmend('chore: 🧱 CHANGELOG update, version bump')
  else
    p.log.warn('Nothing staged — version files already match. Skipping commit.')
}

async function createTag(release: Release) {
  // The changelog step may have committed since the version was chosen, so this
  // is re-checked here rather than reused from `resolveVersion`.
  const [tagged, head] = await Promise.all([revParse(release.version), revParse('HEAD')])
  if (tagged && tagged === head) {
    p.log.info(`Tag ${release.version} is already on HEAD (${head.slice(0, 7)}) — nothing to tag.`)
    return
  }

  if (await confirm('Add tag?'))
    await $$`git tag -a -f -m "Next automated release" ${release.version}`
}

async function buildZips(release: Release) {
  const existing = [release.zip, release.serverZip].filter(f => existsSync(f))

  if (existing.length) {
    p.log.info(`Already built:\n${existing.join('\n')}`)
    if (!await confirm('Rewrite old .zip files?')) return

    await Promise.all([release.zip, release.serverZip].map(async f => fs.rm(f, { force: true })))
    p.note('Removed old zip files', '🪓 ')
  }

  p.note(`Clearing tmp folder ${PATHS.tmpDir} ...`, '🪓 ')
  try {
    await fs.rm(PATHS.tmpDir, { recursive: true, force: true })
  }
  catch (error) {
    throw new Error(`Cannot remove TMP folder ${PATHS.tmpDir}: ${errMessage(error)}\n`
      + '  Close anything holding files there (explorer, editor, MC instance) and retry.')
  }

  const tmpOverrides = resolve(PATHS.tmpDir, 'overrides/')
  await fs.mkdir(tmpOverrides, { recursive: true })

  p.note('Cloning latest tag to tmpOverrides...', '👬 ')
  const $tmp = $$({ cwd: tmpOverrides })
  await $tmp`git clone --depth 1 ${`file://${resolve(process.cwd())}`} .`
  await $tmp`git submodule init`
  await $tmp`git config submodule.mc-tools.update none`
  await $tmp`git submodule update -j8`

  const cleansed = await cleanseClone(tmpOverrides)
  p.note(cleansed.removed.length ? formatRemoveResult(cleansed) : 'Nothing to remove', '🧹 ')

  if (cleansed.failed.length) {
    const details = cleansed.failed.map(({ file, error }) => `${file}: ${error}`).join('\n')
    p.log.warn(`${cleansed.failed.length} dev-only file(s) could not be deleted and would ship inside the release:\n${details}`)
    if (!await confirm('Build the zip anyway?')) process.exit(1)
  }

  // 7z will not create the output directory for us.
  await fs.mkdir(resolve(PATHS.dist), { recursive: true })

  p.note('Create EN .zip', '🏴 ')
  await $$({ cwd: PATHS.tmpDir })`7z a -bso0 ${release.zip} .`

  p.note('Create server zip', '📥 ')
  await $$({ cwd: 'server' })`7z a -bso0 ${release.serverZip} .`
}

/** Strip dev-only files from the fresh clone and hoist `manifest.json` out of `overrides/`. */
async function cleanseClone(tmpOverrides: string): Promise<RemoveFilesResult> {
  const s = p.spinner()
  s.start('⬅️ Cleanse and move manifest.json...')
  try {
    const devonlyList = getIgnoredFiles(devonlyIgnore, { cwd: tmpOverrides })
      .map(f => resolve(tmpOverrides, f))

    // Delete first, so the passes below never touch a file that is on its way out.
    const removeResult = removeFiles(devonlyList)

    const tmpManifest = resolve(tmpOverrides, 'manifest.json')
    await Promise.all([
      replaceInFile({
        files: tmpManifest,
        from : /"___name"\s*:\s*"((?:[^"\\]|\\.)*)"\s*,?/g,
        to   : '',
      })
        .then(async () => fs.rename(tmpManifest, resolve(tmpOverrides, '../manifest.json'))),
      cleanupBo3Files(tmpOverrides),
    ])

    s.stop('⬅️ Cleanse and move manifest.json done')
    return removeResult
  }
  catch (error) {
    s.error('⬅️ Cleanse failed')
    throw error
  }
}

async function runSFTP() {
  try {
    await manageSFTP(PATHS.serverSetupConfig)
  }
  catch (error) {
    p.log.error(`SFTP step crashed: ${errMessage(error)}`)
    if (!await confirm('Continue release despite SFTP failure?'))
      process.exit(1)
  }
}

/** @returns whether the tag is now on the remote — i.e. whether publishing is safe. */
async function pushTag(): Promise<boolean> {
  if (!await confirm('Push tag?')) {
    p.log.warn('Tag stays local. `gh release create` would tag the remote default branch instead — skipping publish.')
    return false
  }

  if (!await runUntilSuccess('git push', () => $pipe`git push --follow-tags`)) {
    p.log.warn('Tag is not on the remote — GitHub release would point to nothing. Skipping publish.')
    return false
  }

  process.stdout.write('\n')
  return true
}

async function publishRelease(release: Release) {
  const missing = [release.zip, release.serverZip].filter(f => !existsSync(f))
  if (missing.length) {
    p.log.error(`Cannot publish — these build artifacts are missing:\n${missing.join('\n')}`)
    p.outro('Finished without release.')
    return
  }

  const inputTitle = await promptText('Enter release title')
  if (!inputTitle) {
    p.cancel('No title provided — skipping GitHub release.')
    return
  }

  p.note('Releasing on Github ...', '🌍 ')
  const repo  = await getGitHubRepo()
  const title = `${release.version} ${inputTitle.replace(/"/g, '\'')}`.trim()

  const published = await runUntilSuccess('gh release create', () =>
    $pipe`gh release create ${release.version} --title=${title} --repo=${repo} --notes-file=${PATHS.changelogLatest} ${release.zip} ${release.serverZip}`)

  if (!published) {
    p.log.warn('Release not published. Everything else is done — publish it later without rebuilding the pack.')
    p.outro('Finished without release.')
    return
  }

  p.note('Manually mark additional file as server pack', '🚀 ')

  // A browser that refuses to open must not turn an already-published release
  // into a failed run — this is the last step, everything is done by now.
  if ((await $$`start ${CURSEFORGE_FILES_URL}`.nothrow()).exitCode !== 0)
    p.log.warn(`Could not open the browser — do it manually:\n${CURSEFORGE_FILES_URL}`)

  p.outro('Finished!')
}

// ─────────────────────────────────────────────────────────────────────────────

/** Remember what is running, so a throw from anywhere can be reported against a named step. */
async function step<T>(label: string, run: () => Promise<T>): Promise<T> {
  currentStep = label
  return run()
}

/**
 * Run a command that talks to the network, showing why it failed and offering
 * another attempt. A dropped proxy or a flaky connection should not throw away
 * an already-built pack.
 */
async function runUntilSuccess(label: string, run: () => ProcessPromise): Promise<boolean> {
  while (true) {
    const result = await run().nothrow()
    if (result.exitCode === 0)
      return true

    const reason = `${result.stderr}\n${result.stdout}`
      .split('\n')
      .map(line => line.trim())
      .filter(Boolean)
      .pop() ?? `exit code ${result.exitCode}`

    p.log.error(`${label} failed:\n${reason}`)
    if (!await confirm(`Retry ${label}?`))
      return false
  }
}

/**
 * Commit a ref resolves to, or `''` when there is no such ref.
 *
 * `rev-list` rather than `rev-parse`: an annotated tag resolves to its own tag
 * object, which never equals the commit HEAD points at.
 */
async function revParse(ref: string): Promise<string> {
  const result = await $`git rev-list -n 1 ${ref}`.nothrow()
  return result.exitCode === 0 ? result.stdout.trim() : ''
}

/** Index writes race with editors and file watchers on Windows; one short retry clears it. */
function gitRetry(run: () => ProcessPromise) {
  return retry(2, '1s', run)
}

async function promptText(
  message: string,
  options: { initialValue?: string, validate?: (value: string | undefined) => string | undefined } = {}
): Promise<string> {
  const input = await p.text({ message, ...options })

  if (p.isCancel(input)) {
    p.cancel('Operation cancelled.')
    process.exit(0)
  }

  return input?.trim() ?? ''
}

function makeRelease(version: string): Release {
  const baseName = `E2E-Extended-${version}`
  const base     = resolve(PATHS.dist, baseName)
  return { version, baseName, zip: `${base}.zip`, serverZip: `${base}-server.zip` }
}

async function suggestNextVersion(oldTag: string): Promise<string> {
  try {
    const client = new ConventionalGitClient(process.cwd())
    const commits: Commit[] = []
    for await (const commit of client.getCommits({ from: oldTag }, PARSER_OPTIONS))
      commits.push(commit)

    const hasBreaking = commits.some(c => c.notes.some(n => n.title.toUpperCase().includes('BREAKING')))
    const hasFeat     = commits.some(c => c.type === 'feat')
    const bumpType: BumpType = hasBreaking ? 'major' : hasFeat ? 'minor' : 'patch'

    return bumpVersion(oldTag, bumpType)
  }
  catch {
    return oldTag
  }
}

function bumpVersion(version: string, bump: BumpType): string {
  const match = SEMVER_RE.exec(version)
  if (!match) return version

  const [, prefix]            = match
  const [major, minor, patch] = match.slice(2, 5).map(Number)

  switch (bump) {
    case 'major': return `${prefix}${major + 1}.0.0`
    case 'minor': return `${prefix}${major}.${minor + 1}.0`
    case 'patch': return `${prefix}${major}.${minor}.${patch + 1}`
  }
}

function validateVersion(value: string | undefined): string | undefined {
  if (!SEMVER_RE.test(value?.trim() ?? ''))
    return 'Version must follow SemVer (e.g. v1.2.3)'
}

async function getGitHubRepo(): Promise<string> {
  const remote = await $`git remote get-url origin`.nothrow()
  if (remote.exitCode === 0) {
    const match = remote.stdout.trim().match(/[:/]([^/]+\/[^/.]+)(?:\.git)?$/)
    if (match?.[1]) return match[1]
  }
  return REPO
}

/** Matches one `key: value` line of a YAML mapping. Groups: the `key:` prefix, the value, an optional CR. */
function yamlScalar(key: string): RegExp {
  return new RegExp(String.raw`^([ \t]*${key}[ \t]*:[ \t]*)([^\r\n]*)(\r?)$`, 'm')
}

/**
 * Rewrite everything version-dependent in the dedicated-server setup config.
 *
 * One read-modify-write for the whole file: two `replaceInFile` calls on the same
 * path run concurrently here and would lose one of the two edits.
 */
async function updateServerSetupConfig(release: Release) {
  const cleanroom = readCleanroomVersion()
  const source    = await fs.readFile(PATHS.serverSetupConfig, 'utf8')

  /** `expect`: leave the value alone unless it already is the kind of value we are about to write. */
  const patches: { key: string, value: string, expect?: string }[] = [
    {
      key  : 'modpackUrl',
      value: `https://github.com/${REPO}/releases/download/${release.version}/${release.baseName}.zip`,
    },
    {
      key   : 'installerUrl',
      value : `'${CLEANROOM_RELEASES}/${cleanroom}/cleanroom-${cleanroom}-installer.jar'`,
      expect: 'cleanroom',
    },
    {
      // The jar the installer above produces — a stale name here starts nothing.
      key   : 'startFile',
      value : `cleanroom-${cleanroom}.jar`,
      expect: 'cleanroom',
    },
  ]

  let patched = source
  for (const { key, value, expect } of patches) {
    const re    = yamlScalar(key)
    const match = re.exec(patched)

    if (!match) {
      p.log.warn(`"${key}:" not found in ${PATHS.serverSetupConfig} — left untouched.`)
      continue
    }
    if (expect && !match[2].toLowerCase().includes(expect)) {
      p.log.warn(`"${key}: ${match[2].trim()}" in ${PATHS.serverSetupConfig} is not a ${expect} value — left untouched.`)
      continue
    }

    patched = patched.replace(re, (_full, prefix: string, _old: string, cr: string) => `${prefix}${value}${cr}`)
  }

  if (patched !== source) await fs.writeFile(PATHS.serverSetupConfig, patched)
}

/**
 * Cleanroom build the client launches with.
 *
 * `config/relauncher.json` is the single source of truth: if the server installs
 * a different build, everyone joins a server running another loader version.
 */
function readCleanroomVersion(): string {
  let relauncher: { selectedVersion?: unknown }
  try {
    relauncher = JSON.parse(readFileSync(PATHS.relauncher, 'utf8')) as { selectedVersion?: unknown }
  }
  catch (error) {
    throw new Error(`Cannot read the Cleanroom version from "${PATHS.relauncher}": ${errMessage(error)}`)
  }

  const version = relauncher.selectedVersion
  if (typeof version !== 'string' || !version.trim()) {
    throw new Error(`"selectedVersion" is missing or not a string in ${PATHS.relauncher}.\n`
      + '  The server setup config takes its Cleanroom version from there.')
  }
  return version.trim()
}

function readDevonlyIgnore(): string {
  try {
    return readFileSync(PATHS.devonlyIgnore, 'utf8')
  }
  catch (error) {
    throw new Error(`Cannot read the dev-only ignore list "${PATHS.devonlyIgnore}": ${errMessage(error)}`)
  }
}

/** Drop dev-only mods from the crash-assistant modlist so it matches the shipped `mods/`. */
async function cleanupModlist() {
  const modlist  = JSON.parse(await fs.readFile(PATHS.modlist, 'utf8')) as Record<string, unknown>
  const filtered = Object.fromEntries(
    Object.entries(modlist).filter(([key]) => !devonlyIgnore.ignores(`mods/${key}`))
  )
  await fs.writeFile(PATHS.modlist, JSON.stringify(filtered, null, 2))
}

/** OTG `.bo3` files are huge; comments and blank lines are pure download weight. */
async function cleanupBo3Files(baseDir: string) {
  const files = await glob(`${baseDir}/mods/OpenTerrainGenerator/worlds/**/*.bo3`)
  await Promise.all(files.map(async (file) => {
    const content = await fs.readFile(file, 'utf8')
    const cleaned = content
      .split('\n')
      // Trim first: these files are CRLF, so a "blank" line is `\r`, not ``.
      .filter((line) => {
        const trimmed = line.trim()
        return trimmed !== '' && !trimmed.startsWith('#')
      })
      .join('\n')
    await fs.writeFile(file, cleaned, 'utf8')
  }))
}

function errMessage(error: unknown): string {
  return formatError(error)
}
