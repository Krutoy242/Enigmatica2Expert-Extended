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

import process from 'node:process'

import * as p from '@clack/prompts'
import ignore from 'ignore'
import { resolve } from 'pathe'
import { replaceInFile } from 'replace-in-file'
import { $, fs, retry } from 'zx'

import { commitAmend, getIgnoredFiles, removeFiles } from './build/build_utils'
import { manageSFTP } from './build/sftp'
import { generateChangelog } from './tools/changelog/changelog'

const { existsSync, readFileSync } = fs
const $$ = $({ stdio: 'inherit', verbose: true })

p.intro('Let\'s cook a new release! 🍳')

const tmpDir = 'D:/mc_tmp/'
if (await p.confirm({ message: '🪓 Perform automation?' }) === true)
  await $$`pnpm dev`

const devonlyIgnore = ignore().add(readFileSync('dev/.devonly.ignore', 'utf8'))

/*
 ██████╗██╗  ██╗ █████╗ ███╗   ██╗ ██████╗ ███████╗██╗      ██████╗  ██████╗
██╔════╝██║  ██║██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║     ██╔═══██╗██╔════╝
██║     ███████║███████║██╔██╗ ██║██║  ███╗█████╗  ██║     ██║   ██║██║  ███╗
██║     ██╔══██║██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║     ██║   ██║██║   ██║
╚██████╗██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗╚██████╔╝╚██████╔╝
 ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝  ╚═════╝
*/

const oldVersion = await $`git describe --tags --abbrev=0`.text()

const inputVersion = await p.text({
  message     : 'Enter next version',
  initialValue: oldVersion,
})

if (p.isCancel(inputVersion)) {
  p.cancel('Operation cancelled.')
  process.exit(0)
}

const nextVersion = inputVersion?.trim() || oldVersion || 'v???'
const zipBaseName = `E2E-Extended-${nextVersion}`
const serverSetupConfig = 'server/server-setup-config.yaml'

const s = p.spinner()

await p.confirm({ message: '🧼 Clear your working tree and rebase' })

if (await p.confirm({ message: `Generate Changelog?` }) === true) {
  const changelogPath = 'CHANGELOG-latest.md'

  p.note('Updating version in files', '📝')
  // Update version in files
  await Promise.all([
    fs.writeFile('dev/version.txt', nextVersion),
    replaceInFile({
      files: 'config/CustomMainMenu/mainmenu.json',
      from : /("version_num"\s*:\s*\{\s*"text"\s*:\s*")[^"]+"/,
      to   : `$1${nextVersion}"`,
    }),
    replaceInFile({
      files: 'manifest.json',
      from : /(^ {2}"version"\s*:\s*")[^"]+("\s*,)/m,
      to   : `$1${nextVersion}$2`,
    }),
    replaceInFile({
      files: 'config/endermodpacktweaks/modpack.cfg',
      from : /^(\s*S\s*:\s*"\[\d+\] Modpack Version"\s*=\s*).*$/m,
      to   : `$1${nextVersion}`,
    }),
    replaceInFile({
      files: serverSetupConfig,
      from : /^( {2}modpackUrl\s*:\s*)(.+)$/m,
      to   : `$1https://github.com/Krutoy242/Enigmatica2Expert-Extended/releases/download/${nextVersion}/${zipBaseName}.zip`,
    }),
    cleanupModlist(),
    generateChangelog(changelogPath),
  ])

  // Some files need to be assumed unchanged
  // to prevent them always clutter git
  const skipWorktreeList = [
    'minecraftinstance.json',
    'config/crash_assistant/modlist.json',
  ]

  const filesToCommit = [
    'config/CustomMainMenu/mainmenu.json',
    'dev/version.txt',
    'manifest.json',
    'config/endermodpacktweaks/modpack.cfg',
    serverSetupConfig,
    changelogPath,
  ].concat(skipWorktreeList)

  p.note('Iconify changelog and prepare files to git add', '📝')

  await Promise.all([
    $$`tsx E:/dev/mc-icons/src/cli.ts ${changelogPath} --silent --no-short --modpack=e2ee --treshold=2`,
    retry(2, '1s', async () => $$`git update-index --no-skip-worktree ${skipWorktreeList}`),
  ])

  p.note('Now manually fix changelog and close file', '✍ ')

  await Promise.all([
    retry(2, '1s', async () => $$`git add -f ${filesToCommit}`),
    $$`code --wait ${changelogPath}`,
  ])

  await retry(2, '1s', async () => $$`git add ${changelogPath}`)

  if (await hasStaged())
    await commitAmend('chore: 🧱 CHANGELOG update, version bump')

  await retry(2, '1s', async () => $$`git update-index --skip-worktree ${skipWorktreeList}`)
}

if (await p.confirm({ message: `Add tag?` }) === true)
  await $$`git tag -a -f -m "Next automated release" ${nextVersion}`

/*
██████╗ ██████╗ ███████╗██████╗ ███████╗██████╗  █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
██████╔╝██████╔╝█████╗  ██████╔╝█████╗  ██████╔╝███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
██╔═══╝ ██╔══██╗██╔══╝  ██╔═══╝ ██╔══╝  ██╔══██╗██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
██║     ██║  ██║███████╗██║     ███████╗██║  ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
*/

const zipPath_base = resolve('dist', zipBaseName)
const zipPath = `${zipPath_base}.zip`
const zipPath_server = `${zipPath_base}-server.zip`

const isZipsExist = [zipPath, zipPath_server].some(f => existsSync(f))

let rewriteOldZipFiles = false
if (isZipsExist && await p.confirm({ message: `Rewrite old .zip files?` }) === true) {
  rewriteOldZipFiles = true
  s.start(`🪓 Removing old zip files:\n${zipPath}\n${zipPath_server}`)
  await Promise.all([
    fs.rm(zipPath, { force: true }),
    fs.rm(zipPath_server, { force: true }),
  ])
  s.stop(`🪓 Removing old zip files:\n${zipPath}\n${zipPath_server}`)
}

/*
  ██████╗ ███████╗██╗     ███████╗ █████╗ ███████╗███████╗
  ██╔══██╗██╔════╝██║     ██╔════╝██╔══██╗██╔════╝██╔════╝
  ██████╔╝█████╗  ██║     █████╗  ███████║███████╗█████╗
  ██╔══██╗██╔══╝  ██║     ██╔══╝  ██╔══██║╚════██║██╔══╝
  ██║  ██║███████╗███████╗███████╗██║  ██║███████║███████╗
  ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝
  */
const makeZips = !isZipsExist || rewriteOldZipFiles
if (makeZips) {
  p.note(`Clearing tmp folder ${tmpDir} ...`, '🪓 ')
  try {
    await fs.rm(tmpDir, { recursive: true, force: true })
  }
  catch (err) {
    p.cancel(`Cannot remove TMP folder ${tmpDir} ${err}`)
  }

  const tmpOverrides = resolve(tmpDir, 'overrides/')
  await fs.mkdir(tmpOverrides, { recursive: true })

  p.note('Cloning latest tag to tmpOverrides...', '👬 ')
  const $tmp = $$({ cwd: tmpOverrides, sync: true })
  $tmp`git clone --depth 1 ${`file://${resolve(process.cwd())}`} .`
  $tmp`git submodule init`
  $tmp`git config submodule.mc-tools.update none`
  $tmp`git submodule update -j8`

  s.start('⬅️ Cleanse and move manifest.json...')
  const devonlyList = getIgnoredFiles(devonlyIgnore, { cwd: tmpOverrides })
    .map(f => resolve(tmpOverrides, f))
  const tmpManifestPath = resolve(tmpOverrides, 'manifest.json')
  const [removedFiles] = await Promise.all([
    removeFiles(devonlyList),
    replaceInFile({
      files: tmpManifestPath,
      from : /"___name"\s*:\s*"((?:[^"\\]|\\.)*)"\s*,?/g,
      to   : '',
    })
      .then(async () => fs.rename(tmpManifestPath, resolve(tmpOverrides, '../manifest.json'))),
    $$({ cwd: tmpOverrides })`find mods/OpenTerrainGenerator/worlds -type f -name "*.bo3" -exec sed -i '/^$/d; /^#/d' {} +`,
  ])
  s.stop('⬅️ Cleanse and move manifest.json...')

  p.note(removeFiles.length > 0 ? `🧹 Removed non-release files and folders:\n${removedFiles}` : 'Nothing to remove')

  p.note('Create EN .zip', '🏴 ')
  await $$({ cwd: tmpDir })`7z a -bso0 ${zipPath} .`

  p.note('Create server zip', '📥 ')
  await $$({ cwd: 'server' })`7z a -bso0 ${zipPath_server} .`
}

await manageSFTP(serverSetupConfig)

if (await p.confirm({ message: `Push tag?` }) === true)
  await $$`git push --follow-tags`

const inputTitle = await p.text({ message: 'Enter release title' })

if (p.isCancel(inputTitle)) {
  p.cancel('Operation cancelled.')
  process.exit(0)
}

if (inputTitle) {
  p.note('Releasing on Github ...', '🌍 ')
  const title = `${nextVersion} ${inputTitle.replace(/"/g, '\'')}`.trim()
  await $$`gh release create ${nextVersion} --title=${title} --repo=Krutoy242/Enigmatica2Expert-Extended --notes-file=CHANGELOG-latest.md ${zipPath} ${zipPath_server}`

  p.note('Manually mark additional file as server pack', '🚀 ')
  await $$`start https://legacy.curseforge.com/minecraft/modpacks/enigmatica-2-expert-extended/files`

  p.outro('Finished!')
}

process.exit(0)

async function cleanupModlist() {
  const modlistPath = 'config/crash_assistant/modlist.json'
  const modlist = JSON.parse(readFileSync(modlistPath, 'utf8')) as { [key: string]: unknown }

  // Filter out ignored fields
  const filteredModlist = Object.fromEntries(
    Object.entries(modlist).filter(([key]) => !devonlyIgnore.ignores(`mods/${key}`))
  )

  // Save the modified modlist.json back
  await fs.writeFile(modlistPath, JSON.stringify(filteredModlist, null, 2))
}

async function hasStaged() {
  const result = await $`git diff --staged --quiet`.nothrow()
  return result.exitCode !== 0
}
