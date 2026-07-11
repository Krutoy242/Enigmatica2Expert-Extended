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

/* eslint-disable regexp/no-misleading-capturing-group */
/* eslint-disable regexp/no-super-linear-backtracking */

import type { Commit, ParserStreamOptions } from 'conventional-commits-parser'

import process from 'node:process'

import * as p from '@clack/prompts'
import { ConventionalGitClient } from '@conventional-changelog/git-client'
import ignore from 'ignore'
import { resolve } from 'pathe'
import { replaceInFile } from 'replace-in-file'
import { $, fs, glob, retry } from 'zx'

import { commitAmend, confirm, getIgnoredFiles, removeFiles } from './build/build_utils.js'
import { manageSFTP } from './build/sftp.js'
import { generateChangelog } from './tools/changelog/changelog.js'

const { existsSync, readFileSync } = fs
const $$ = $({ stdio: 'inherit', verbose: true })

const PATHS = {
  tmpDir           : 'D:/mc_tmp/',
  mcIcons          : 'E:/dev/mc-icons/src/cli.ts',
  dist             : 'dist',
  devonlyIgnore    : 'dev/.devonly.ignore',
  versionTxt       : 'dev/version.txt',
  changelogLatest  : 'CHANGELOG-latest.md',
  serverSetupConfig: 'server/server-setup-config.yaml',
  mainMenu         : 'config/CustomMainMenu/mainmenu.json',
  manifest         : 'manifest.json',
  enderModpackCfg  : 'config/endermodpacktweaks/modpack.cfg',
  modlist          : 'config/crash_assistant/modlist.json',
  skipWorktree     : [
    'minecraftinstance.json',
    'config/crash_assistant/modlist.json',
  ],
}

const PARSER_OPTIONS: ParserStreamOptions = {
  headerPattern       : /^(\w*)(?:\((.*)\))?!?: (.*)$/,
  headerCorrespondence: ['type', 'scope', 'subject'],
  noteKeywords        : ['BREAKING CHANGE', 'BREAKING-CHANGE'],
}

const devonlyIgnore = ignore().add(readFileSync(PATHS.devonlyIgnore, 'utf8'))

// ─────────────────────────────────────────────────────────────────────────────

p.intro('Let\'s cook a new release! 🍳')
await main()
process.exit(0)

// ─────────────────────────────────────────────────────────────────────────────

async function main() {
  await runAutomation()
  const { nextVersion, zipBaseName } = await resolveVersion()
  await runChangelog(nextVersion, zipBaseName)
  await createTag(nextVersion)
  await buildZips(nextVersion, zipBaseName)
  try {
    await manageSFTP(PATHS.serverSetupConfig)
  }
  catch (error) {
    p.log.error(`SFTP step crashed: ${error instanceof Error ? error.message : String(error)}`)
    if (!await confirm('Continue release despite SFTP failure?'))
      process.exit(1)
  }
  if (await confirm('Push tag?')) {
    await $$`git push --follow-tags`
    process.stdout.write('\n')
  }
  await publishRelease(nextVersion, zipBaseName)
}

async function runAutomation() {
  if (await confirm('🪓 Perform automation?')) {
    const { exitCode } = await $$`pnpm dev`.nothrow()
    if (exitCode !== 0)
      p.log.warn('Some dev automation tasks reported errors (see above) — continuing anyway.')
  }
}

async function resolveVersion(): Promise<{ nextVersion: string, zipBaseName: string }> {
  const oldVersion       = (await $`git describe --tags --abbrev=0`.text()).trim()
  const suggestedVersion = await suggestNextVersion(oldVersion)

  const input = await p.text({
    message     : 'Enter next version',
    initialValue: suggestedVersion,
    validate    : validateVersion,
  })

  if (p.isCancel(input)) {
    p.cancel('Operation cancelled.')
    process.exit(0)
  }

  const nextVersion = input?.trim() || oldVersion || 'v???'
  return { nextVersion, zipBaseName: `E2E-Extended-${nextVersion}` }
}

async function runChangelog(nextVersion: string, zipBaseName: string) {
  await confirm('🧼 Clear your working tree and rebase')

  if (!await confirm('Generate Changelog?')) return

  p.note('Updating version in files', '📝')
  await Promise.all([
    fs.writeFile(PATHS.versionTxt, nextVersion),
    replaceInFile({
      files: PATHS.mainMenu,
      from : /("version_num"\s*:\s*\{\s*"text"\s*:\s*")[^"]+"/,
      to   : `$1${nextVersion}"`,
    }),
    replaceInFile({
      files: PATHS.manifest,
      from : /(^ {2}"version"\s*:\s*")[^"]+("\s*,)/m,
      to   : `$1${nextVersion}$2`,
    }),
    replaceInFile({
      files: PATHS.enderModpackCfg,
      from : /^(\s*S\s*:\s*"\[\d+\] Modpack Version"\s*=\s*).*$/m,
      to   : `$1${nextVersion}`,
    }),
    replaceInFile({
      files: PATHS.serverSetupConfig,
      from : /^( {2}modpackUrl\s*:\s*)(.+)$/m,
      to   : `$1https://github.com/Krutoy242/Enigmatica2Expert-Extended/releases/download/${nextVersion}/${zipBaseName}.zip`,
    }),
    cleanupModlist(),
    generateChangelog(PATHS.changelogLatest),
  ])

  p.note('Iconify changelog and prepare files to git add', '📝')

  await $$`tsx ${PATHS.mcIcons} ${PATHS.changelogLatest} --no-short --modpack=e2ee --treshold=2`
  await retry(2, '1s', async () => $`git update-index --no-skip-worktree ${PATHS.skipWorktree}`)

  const filesToCommit = [
    PATHS.mainMenu,
    PATHS.versionTxt,
    PATHS.manifest,
    PATHS.enderModpackCfg,
    PATHS.serverSetupConfig,
    PATHS.changelogLatest,
    ...PATHS.skipWorktree,
  ]

  p.note('Now manually fix changelog and close file', '✍ ')

  await Promise.all([
    retry(2, '1s', async () => $`git add -f ${filesToCommit}`),
    $$`code --wait ${PATHS.changelogLatest}`,
  ])

  await retry(2, '1s', async () => $`git add ${PATHS.changelogLatest}`)

  if ((await $`git diff --staged --quiet`.nothrow()).exitCode !== 0)
    await commitAmend('chore: 🧱 CHANGELOG update, version bump')

  await retry(2, '1s', async () => $`git update-index --skip-worktree ${PATHS.skipWorktree}`)
}

async function createTag(nextVersion: string) {
  if (await confirm('Add tag?'))
    await $$`git tag -a -f -m "Next automated release" ${nextVersion}`
}

async function buildZips(nextVersion: string, zipBaseName: string) {
  const zipPathBase   = resolve(PATHS.dist, zipBaseName)
  const zipPath       = `${zipPathBase}.zip`
  const zipPathServer = `${zipPathBase}-server.zip`

  const isZipsExist = [zipPath, zipPathServer].some(f => existsSync(f))

  if (isZipsExist) {
    if (!await confirm('Rewrite old .zip files?')) return

    const s = p.spinner()
    s.start('🪓 Removing old zip files')
    try {
      await Promise.all([
        fs.rm(zipPath, { force: true }),
        fs.rm(zipPathServer, { force: true }),
      ])
    }
    finally {
      s.stop('🪓 Removed old zip files')
    }
  }

  p.note(`Clearing tmp folder ${PATHS.tmpDir} ...`, '🪓 ')
  try {
    await fs.rm(PATHS.tmpDir, { recursive: true, force: true })
  }
  catch (err) {
    p.cancel(`Cannot remove TMP folder ${PATHS.tmpDir} ${String(err)}`)
    process.exit(1)
  }

  const tmpOverrides = resolve(PATHS.tmpDir, 'overrides/')
  await fs.mkdir(tmpOverrides, { recursive: true })

  p.note('Cloning latest tag to tmpOverrides...', '👬 ')
  const $tmp = $$({ cwd: tmpOverrides })
  await $tmp`git clone --depth 1 ${`file://${resolve(process.cwd())}`} .`
  await $tmp`git submodule init`
  await $tmp`git config submodule.mc-tools.update none`
  await $tmp`git submodule update -j8`

  const s = p.spinner()
  s.start('⬅️ Cleanse and move manifest.json...')
  try {
    const devonlyList     = getIgnoredFiles(devonlyIgnore, { cwd: tmpOverrides })
      .map(f => resolve(tmpOverrides, f))
    const tmpManifestPath = resolve(tmpOverrides, 'manifest.json')

    const [removedFiles] = await Promise.all([
      (async () => removeFiles(devonlyList))(),
      replaceInFile({
        files: tmpManifestPath,
        from : /"___name"\s*:\s*"((?:[^"\\]|\\.)*)"\s*,?/g,
        to   : '',
      })
        .then(async () => fs.rename(tmpManifestPath, resolve(tmpOverrides, '../manifest.json'))),
      cleanupBo3Files(tmpOverrides),
    ])

    p.note(removedFiles.length > 0 ? `🧹 Removed non-release files and folders:\n${removedFiles}` : 'Nothing to remove')
  }
  finally {
    s.stop('⬅️ Cleanse and move manifest.json done')
  }

  p.note('Create EN .zip', '🏴 ')
  await $$({ cwd: PATHS.tmpDir })`7z a -bso0 ${zipPath} .`

  p.note('Create server zip', '📥 ')
  await $$({ cwd: 'server' })`7z a -bso0 ${zipPathServer} .`
}

async function publishRelease(nextVersion: string, zipBaseName: string) {
  const zipPathBase   = resolve(PATHS.dist, zipBaseName)
  const zipPath       = `${zipPathBase}.zip`
  const zipPathServer = `${zipPathBase}-server.zip`

  const inputTitle = await p.text({ message: 'Enter release title' })

  if (p.isCancel(inputTitle)) {
    p.cancel('Operation cancelled.')
    process.exit(0)
  }

  if (!inputTitle) {
    p.cancel('No title provided — skipping GitHub release.')
    return
  }

  p.note('Releasing on Github ...', '🌍 ')
  const repo  = await getGitHubRepo()
  const title = `${nextVersion} ${inputTitle.replace(/"/g, '\'')}`.trim()
  await $$`gh release create ${nextVersion} --title=${title} --repo=${repo} --notes-file=${PATHS.changelogLatest} ${zipPath} ${zipPathServer}`

  p.note('Manually mark additional file as server pack', '🚀 ')
  await $$`start https://legacy.curseforge.com/minecraft/modpacks/enigmatica-2-expert-extended/files`

  p.outro('Finished!')
}

// ─────────────────────────────────────────────────────────────────────────────

async function suggestNextVersion(oldTag: string): Promise<string> {
  try {
    const client  = new ConventionalGitClient(process.cwd())
    const commits: Commit[] = []
    for await (const commit of client.getCommits({ from: oldTag }, PARSER_OPTIONS))
      commits.push(commit)

    const hasBreaking = commits.some(c => c.notes.some(n => n.title.toUpperCase().includes('BREAKING')))
    const hasFeat     = commits.some(c => c.type === 'feat')
    const bumpType    = hasBreaking ? 'major' : hasFeat ? 'minor' : 'patch'

    return bumpVersion(oldTag, bumpType)
  }
  catch {
    return oldTag
  }
}

function bumpVersion(version: string, bump: 'major' | 'minor' | 'patch'): string {
  const match = version.match(/^(v?)(\d+)\.(\d+)\.(\d+)/)
  if (!match) return version
  const [, prefix, maj, min, pat] = match
  const [major, minor, patch]     = [Number(maj), Number(min), Number(pat)]
  switch (bump) {
    case 'major': return `${prefix}${major + 1}.0.0`
    case 'minor': return `${prefix}${major}.${minor + 1}.0`
    case 'patch': return `${prefix}${major}.${minor}.${patch + 1}`
  }
}

function validateVersion(value: string | undefined): string | undefined {
  if (!value || !/^v?\d+\.\d+\.\d+(?:-[a-zA-Z0-9.]+)?(?:\+[a-zA-Z0-9.]+)?$/.test(value))
    return 'Version must follow SemVer (e.g. v1.2.3)'
}

async function getGitHubRepo(): Promise<string> {
  try {
    const remote = (await $`git remote get-url origin`.text()).trim()
    const match  = remote.match(/[:/]([^/]+\/[^/.]+)(?:\.git)?$/)
    if (match?.[1]) return match[1]
  }
  catch {}
  return 'Krutoy242/Enigmatica2Expert-Extended'
}

async function cleanupModlist() {
  const modlist = JSON.parse(await fs.readFile(PATHS.modlist, 'utf8')) as Record<string, unknown>
  const filtered = Object.fromEntries(
    Object.entries(modlist).filter(([key]) => !devonlyIgnore.ignores(`mods/${key}`))
  )
  await fs.writeFile(PATHS.modlist, JSON.stringify(filtered, null, 2))
}

async function cleanupBo3Files(baseDir: string) {
  const files = await glob(`${baseDir}/mods/OpenTerrainGenerator/worlds/**/*.bo3`)
  await Promise.all(files.map(async (file) => {
    const content = await fs.readFile(file, 'utf8')
    const cleaned = content
      .split('\n')
      .filter(line => line !== '' && !line.startsWith('#'))
      .join('\n')
    await fs.writeFile(file, cleaned, 'utf8')
  }))
}
