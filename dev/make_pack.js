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

// @ts-check
/* eslint-disable regexp/no-misleading-capturing-group */
/* eslint-disable regexp/no-super-linear-backtracking */

import { join, resolve } from 'node:path'

import chalk from 'chalk'
import * as del from 'del'
import fs_extra from 'fs-extra'
import git_describe from 'git-describe'
import ignore from 'ignore'
import open from 'open'
import { replaceInFileSync } from 'replace-in-file'
import { rimrafSync } from 'rimraf'
import simpleGit from 'simple-git'
import yargs from 'yargs'

import { doTask, enterString, getIgnoredFiles, pressEnterOrEsc, removeFiles } from './build/build_utils.ts'
import { manageSFTP } from './build/sftp.ts'
import {
  execSyncInherit,
  loadJson,
  saveObjAsJson,
  saveText,
  write,
} from './lib/utils.js'

const { gitDescribeSync } = git_describe
const { mkdirSync, existsSync, renameSync, readFileSync, writeFileSync }
  = fs_extra
const git = simpleGit()

const argv = yargs(process.argv.slice(2))
  .alias('h', 'help')
  .option('dryRun', {
    alias   : 'd',
    type    : 'boolean',
    describe: 'Not create .zip files',
  })
  .option('old', {
    alias   : 'o',
    type    : 'boolean',
    describe: 'Do not clear previous files in TMP folder, and not clone',
  })
  .parseSync()

const mcClientPath = process.cwd()
const sZPath = 'D:/Program Files/7-Zip/7z.exe'
const distrDir = 'E:/YandexDisk/dev/mc/e2e-e/dist/'
const serverRoot = resolve(mcClientPath, 'server/')
const tmpDir = 'D:/mc_tmp/'
const tmpOverrides = resolve(tmpDir, 'overrides/')

write(`${chalk.gray('-'.repeat(20))}\n`)

if (await pressEnterOrEsc(`Press ENTER to perform Automation. Press ESC to skip.`)) {
  doTask('🪓 Doing automation ...\n\n', () =>
    execSyncInherit('tsx mc-tools/packages/run/src/cli.ts "dev:(.*)"'))
}

/*
 ██████╗██╗  ██╗ █████╗ ███╗   ██╗ ██████╗ ███████╗██╗      ██████╗  ██████╗
██╔════╝██║  ██║██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║     ██╔═══██╗██╔════╝
██║     ███████║███████║██╔██╗ ██║██║  ███╗█████╗  ██║     ██║   ██║██║  ███╗
██║     ██╔══██║██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║     ██║   ██║██║   ██║
╚██████╗██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗╚██████╔╝╚██████╔╝
 ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝  ╚═════╝
*/

const oldVersion = gitDescribeSync().tag || undefined

const inputVersion = (
  await enterString(`Enter next version and press ENTER: `, {
    default: oldVersion,
  })
)?.trim()
const nextVersion = inputVersion || oldVersion || 'v???'
const zipBaseName = `E2E-Extended-${nextVersion}`
const serverSetupConfig = 'server/server-setup-config.yaml'

await pressEnterOrEsc(
    `Clear your working tree, rebase, and press ENTER. Press ESC to skip.`,
    async () => (await git.status()).isClean()
)

if (await pressEnterOrEsc(`Generate Changelog? ENTER / ESC.`)) {
  const latestPath = 'CHANGELOG-latest.md'

  // Update version in files
  execSyncInherit(`npx json -I -f config/CustomMainMenu/mainmenu.json -e "this.labels.version_num.text='${nextVersion}'"`)
  await git.add('config/CustomMainMenu/mainmenu.json')

  writeFileSync('dev/version.txt', nextVersion)
  await git.add('dev/version.txt')

  replaceInFileSync({
    files: 'manifest.json',
    from : /(^ {2}"version"\s*:\s*")[^"]+("\s*,)/m,
    to   : `$1${nextVersion}$2`,
  })
  await git.add('manifest.json')

  replaceInFileSync({
    files: serverSetupConfig,
    from : /^( {2}modpackUrl\s*:\s*)(.+)$/m,
    to   : `$1https://github.com/Krutoy242/Enigmatica2Expert-Extended/releases/download/${nextVersion}/${zipBaseName}.zip`,
  })
  await git.add(serverSetupConfig)

  // Generate changelog
  execSyncInherit(`npx conventional-changelog-cli --config dev/tools/changelog/config.cjs -o ${latestPath}`)

  // Iconize
  try {
    execSyncInherit(`tsx E:/dev/mc-icons/src/cli.ts "${latestPath}" --silent --no-short --modpack=e2ee --treshold=2`)
    await git.add(latestPath)
  }
  catch (error) {
    write(`ERROR: ${error}`)
  }

  await open(latestPath, { wait: true })

  await git.commit('chore: 🧱 CHANGELOG update, version bump')
}

if (await pressEnterOrEsc(`Add tag? ENTER / ESC.`))
  execSyncInherit(`git tag -a -f -m "Next automated release" ${nextVersion}`)

/*
██████╗ ██████╗ ███████╗██████╗ ███████╗██████╗  █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
██████╔╝██████╔╝█████╗  ██████╔╝█████╗  ██████╔╝███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
██╔═══╝ ██╔══██╗██╔══╝  ██╔═══╝ ██╔══╝  ██╔══██╗██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
██║     ██║  ██║███████╗██║     ███████╗██║  ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
*/

const zipPath_base = join(distrDir, zipBaseName)
const zipPath_EN = `${zipPath_base}.zip`
const zipPath_server = `${zipPath_base}-server.zip`

const isZipsExist = !argv.dryRun && [zipPath_EN, zipPath_server].some(f => existsSync(f))

let rewriteOldZipFiles = false
if (isZipsExist && (await pressEnterOrEsc(`Rewrite old .zip files? ENTER / ESC`))) {
  rewriteOldZipFiles = true
  doTask(
    '🪓 Removing old zip files ... ',
    () => del.deleteSync([zipPath_EN, zipPath_server], { force: true }).length
  )
}
const makeZips = !isZipsExist || rewriteOldZipFiles

const devonlyIgnore = ignore().add(readFileSync('dev/.devonly.ignore', 'utf8'))

if (!argv.old && makeZips) {
  doTask(`🪓 Clearing tmp folder ${tmpDir} ... `, () => {
    try {
      rimrafSync(tmpDir)
    }
    catch (err) {
      process.stdout.write(`\n${chalk.red(`Cannot remove TMP folder ${tmpDir}`)}\n${String(err)}\n`)
    }
    mkdirSync(tmpOverrides, { recursive: true })
  })

  doTask(`👬 Cloning latest tag to ${tmpOverrides} ... \n`, () => {
    execSyncInherit(`git clone --recurse-submodules -j8 --depth 1 "file://${mcClientPath}" .`)
  }, tmpOverrides)

  doTask(
    '⬅️ Move manifest.json ... ',
    () => {
      const manifest = loadJson('manifest.json')
      manifest.files.forEach(o => delete o.___name)
      saveObjAsJson(manifest, 'manifest.json')
      renameSync('manifest.json', '../manifest.json')
    },
    tmpOverrides
  )

  doTask(
    '🧹 Removing non-release files and folders ... ',
    () => removeFiles(getIgnoredFiles(devonlyIgnore)),
    tmpOverrides
  )
}

/*
███████╗██╗██████╗
╚══███╔╝██║██╔══██╗
  ███╔╝ ██║██████╔╝
 ███╔╝  ██║██╔═══╝
███████╗██║██║
╚══════╝╚═╝╚═╝
*/

/**
 * Returns handler for working with Zip file of specified path
 * @param {string} zipPath path to file working with
 */
function withZip(zipPath) {
  /**
   * Handler to work with zip file
   * @param {string | string[]} params Globs for files add or remove from Zip
   * @param {string} [command] Optional 7Zip command. Default 'a' - Add
   */
  const zipHandler = (params, command = 'a') => {
    if (argv.dryRun) {
      return write(
          `\n${command === 'd' ? '➖' : '➕'} ${
            `${chalk.bgRgb(10, 10, 10).rgb(30, 30, 30)(zipPath)
            } ${
            chalk.gray(params)}`
          }`
      )
    }

    const exec7z = p =>
      execSyncInherit(`"${sZPath}" ${command} -bso0 "${zipPath}" ${p}`)

    if (!Array.isArray(params)) return exec7z(params)

    const tmpPath = '_tmp_7zip.txt'
    saveText(params.join('\n'), tmpPath)
    exec7z(`@${tmpPath}`)
    del.deleteSync(tmpPath)
  }
  return zipHandler
}

makeZips && doTask('🏴󠁧󠁢󠁥󠁮󠁧󠁿 Create EN .zip ... \n', () => withZip(zipPath_EN)('.'), tmpDir)
makeZips && doTask('📥 Create server zip ... \n', () => withZip(zipPath_server)('.'), serverRoot)

/*
  ███████╗███████╗████████╗██████╗
  ██╔════╝██╔════╝╚══██╔══╝██╔══██╗
  ███████╗█████╗     ██║   ██████╔╝
  ╚════██║██╔══╝     ██║   ██╔═══╝
  ███████║██║        ██║   ██║
  ╚══════╝╚═╝        ╚═╝   ╚═╝
  */

await manageSFTP(serverSetupConfig)

/*
  ██████╗ ███████╗██╗     ███████╗ █████╗ ███████╗███████╗
  ██╔══██╗██╔════╝██║     ██╔════╝██╔══██╗██╔════╝██╔════╝
  ██████╔╝█████╗  ██║     █████╗  ███████║███████╗█████╗
  ██╔══██╗██╔══╝  ██║     ██╔══╝  ██╔══██║╚════██║██╔══╝
  ██║  ██║███████╗███████╗███████╗██║  ██║███████║███████╗
  ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝
  */

if (await pressEnterOrEsc(`Push tag? ENTER / ESC`))
  execSyncInherit('git push --follow-tags')

const inputTitle = await enterString(
    `Enter release title and press ENTER. Press ESC to skip release: `
)

if (inputTitle !== undefined) {
  doTask('🌍 Releasing on Github ... \n', () =>
    execSyncInherit(
      'gh release create'
      + ` ${nextVersion}`
      + ` --title="${(`${nextVersion} ${inputTitle.replace(/"/g, '\'')}`).trim()}"`
      + ' --repo=Krutoy242/Enigmatica2Expert-Extended'
      + ' --notes-file=CHANGELOG-latest.md'
      + ` "${zipPath_EN}"`
      + ` "${zipPath_server}"`
    ))
}

process.exit(0)
