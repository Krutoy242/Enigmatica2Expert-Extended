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
import { join, relative, resolve } from 'node:path'

import chalk from 'chalk'
import * as del from 'del'
import fast_glob from 'fast-glob'
import fs_extra from 'fs-extra'
import git_describe from 'git-describe'
import simpleGit from 'simple-git'
import terminal_kit from 'terminal-kit'
import yargs from 'yargs'
import ignore from 'ignore'
import open from 'open'

import replace_in_file from 'replace-in-file'
import {
  end,
  execSyncInherit,
  loadJson,
  loadText,
  saveObjAsJson,
  saveText,
  write,
} from './lib/utils.js'

const { gitDescribeSync } = git_describe
const { terminal: term } = terminal_kit
const { rmSync, mkdirSync, existsSync, renameSync, copySync, readFileSync, writeFileSync }
  = fs_extra
const git = simpleGit()

const { sync: _globs } = fast_glob

/**
 * Globs with default options `dot: true, onlyFiles: false`
 * @param {string | string[]} source
 * @param {import('../node_modules/fast-glob/out/settings').Options} [options]
 */
function globs(source, options) {
  return _globs(source, { dot: true, onlyFiles: false, ...options })
}

/**
 * @param {any} ignored
 */
function getIgnoredFiles(ignored) {
  return globs(
    ignored._rules.filter(r => !r.negative).map(r => r.pattern),
    { ignore: ignored._rules.filter(r => r.negative).map(r => r.pattern) }
  )
}

/**
 * @param {string | readonly string[]} files list of globs of files to remove
 */
function removeFiles(files) {
  const removed = del.deleteSync(files, { dryRun: false })
  return `removed: ${removed.length}\n${
    removed.map(s => chalk.gray(relative(process.cwd(), s))).join('\n')
  }`
}

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

const style = {
  trace : chalk.hex('#7b4618'),
  info  : chalk.hex('#915c27'),
  log   : chalk.hex('#ad8042'),
  label : chalk.hex('#bfab67'),
  string: chalk.hex('#bfc882'),
  number: chalk.hex('#a4b75c'),
  status: chalk.hex('#647332'),
  chose : chalk.hex('#3e4c22'),
  end   : chalk.hex('#2e401c'),
}

;(async () => {
  const mcClientPath = process.cwd()
  const sZPath = 'D:/Program Files/7-Zip/7z.exe'
  const distrDir = 'E:/YandexDisk/dev/mc/e2e-e/dist/'
  const serverRoot = resolve(mcClientPath, 'server/')
  const tmpDir = 'D:/mc_tmp/'
  const tmpOverrides = resolve(tmpDir, 'overrides/')

  /**
   * Write task in log and execute it
   * @param {string} s Name of the tast would be printed in Log
   * @param {()=>void} fn Function of task
   * @param {string} [cwd] Optional working path where task is executed
   */
  const doTask = (s, fn, cwd) => {
    const oldCwd = process.cwd()
    if (cwd) process.chdir(cwd)
    write(style.label(s))
    end(fn())
    if (cwd) process.chdir(oldCwd)
  }

  /*
 █████╗ ██╗   ██╗████████╗ ██████╗ ███╗   ███╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗████╗ ████║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
███████║██║   ██║   ██║   ██║   ██║██╔████╔██║███████║   ██║   ██║██║   ██║██╔██╗ ██║
██╔══██║██║   ██║   ██║   ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
██║  ██║╚██████╔╝   ██║   ╚██████╔╝██║ ╚═╝ ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
*/
  write(`${chalk.gray('-'.repeat(20))}\n`)

  /**
   * Prompt user to write something and press ENTER or ESC
   * @param {string} message message to show
   * @param {terminal_kit.Terminal.InputFieldOptions} [options] message to show
   * @returns {Promise<string|undefined>} inputted string or undefined
   */
  async function enterString(message, options) {
    term(style.trace(message.replace(/(ENTER|ESC)/g, style.info('$1'))))
    const result = await term.inputField({
      cancelable: true,
      ...(options ?? {}),
    }).promise
    term('\n')
    return result
  }

  /**
   * Prompt user to press ENTER or ESC
   * @param {string} message message to show
   * @param {()=>Promise<boolean>} [condition] repeat until true
   * @returns {Promise<boolean>} `true` if ENTER pressed, `false` otherwise
   */
  const pressEnterOrEsc = async (message, condition) => {
    let oneTime = 0
    while (condition ? !(await condition()) : !oneTime++)
      if ((await enterString(message)) === undefined) return false

    return true
  }

  let STEP = 1

  if (
    await pressEnterOrEsc(
      `[${STEP++}] Press ENTER to perform Automation. Press ESC to skip.`
    )
  ) {
    doTask('🪓 Doing automation ...\n\n', () =>
      execSyncInherit('esno mc-tools/packages/run/src/cli.ts dev/tools/mct-run.json')
    )
  }

  /*
 ██████╗██╗  ██╗ █████╗ ███╗   ██╗ ██████╗ ███████╗██╗      ██████╗  ██████╗
██╔════╝██║  ██║██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║     ██╔═══██╗██╔════╝
██║     ███████║███████║██╔██╗ ██║██║  ███╗█████╗  ██║     ██║   ██║██║  ███╗
██║     ██╔══██║██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║     ██║   ██║██║   ██║
╚██████╗██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗╚██████╔╝╚██████╔╝
 ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝  ╚═════╝
*/

  const oldVersion = gitDescribeSync().tag

  const inputVersion = (
    await enterString(`[${STEP++}] Enter next version and press ENTER: `, {
      default: oldVersion || undefined,
    })
  )?.trim()
  const nextVersion = inputVersion || oldVersion || 'v???'

  if (await pressEnterOrEsc(`[${STEP++}] Generate Changelog? ENTER / ESC.`)) {
    const latestPath = 'changelogs/LATEST.md'

    // Update version in files
    execSyncInherit(`npx json -I -f config/CustomMainMenu/mainmenu.json -e "this.labels.version_num.text='${nextVersion}'"`)
    writeFileSync('dev/version.txt', nextVersion)
    replace_in_file.sync({
      files: 'manifest.json',
      from : /("version"[\s\n]*:[\s\n]*")[^"]+("[\s\n]*,)/m,
      to   : `$1${nextVersion}$2`,
    })

    // Generate changelog
    execSyncInherit(`npx conventional-changelog-cli --config ./dev/tools/changelog/config.cjs -o ${latestPath}`)

    // Iconize
    execSyncInherit(`esno E:/dev/mc-icons/src/cli.ts "${latestPath}" --silent --no-short --modpack=e2ee --treshold=2`)

    await open(latestPath, { wait: true })
  }

  await pressEnterOrEsc(
    `[${STEP++}] Clear your working tree, rebase, and press ENTER. Press ESC to skip.`,
    async () => (await git.status()).isClean()
  )

  if (await pressEnterOrEsc(`[${STEP++}] Add tag? ENTER / ESC.`))
    execSyncInherit(`git tag -a -f -m "Next automating release" ${nextVersion}`)

  /*
██████╗ ██████╗ ███████╗██████╗ ███████╗██████╗  █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
██████╔╝██████╔╝█████╗  ██████╔╝█████╗  ██████╔╝███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
██╔═══╝ ██╔══██╗██╔══╝  ██╔═══╝ ██╔══╝  ██╔══██╗██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
██║     ██║  ██║███████╗██║     ███████╗██║  ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
*/

  const zipPath_base = join(distrDir, `E2E-Extended-${nextVersion}`)
  const zipPath_EN = `${zipPath_base}.zip`
  const zipPath_server = `${zipPath_base}-server.zip`

  const isZipsExist = !argv.dryRun && [zipPath_EN, zipPath_server].some(f => existsSync(f))

  let rewriteOldZipFiles = false
  if (isZipsExist && (await pressEnterOrEsc(`[${STEP++}] Rewrite old .zip files? ENTER / ESC`))) {
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
        rmSync(tmpDir, { recursive: true })
      }
      catch (err) {}
      mkdirSync(tmpOverrides, { recursive: true })
    })

    doTask(`👬 Cloning latest tag to ${tmpOverrides} ... \n`, () => {
      execSyncInherit(`git clone --recurse-submodules -j8 --depth 1 "file://${mcClientPath}" .`)
    },
    tmpOverrides
    )

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
      () => removeFiles(getIgnoredFiles(devonlyIgnore)), tmpOverrides
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

  /********************************************************

███████╗███╗   ██╗
██╔════╝████╗  ██║
█████╗  ██╔██╗ ██║
██╔══╝  ██║╚██╗██║
███████╗██║ ╚████║
╚══════╝╚═╝  ╚═══╝

********************************************************/
  makeZips && doTask('🏴󠁧󠁢󠁥󠁮󠁧󠁿 Create EN .zip ... \n', () => withZip(zipPath_EN)('.'), tmpDir)

  /********************************************************

███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗
██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗
███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝
╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗
███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║
╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝

********************************************************/

  /**
   * Patterns of files that should be removed from server
  */
  const serveronlyIgnore = ignore().add(loadText('dev/.serveronly.ignore'))

  /** List of all server-side mod JARs, except bansoukou and devonly */
  const serverModsList = globs(['mods/*.jar', 'mods/*/*.jar'])
    .filter(serveronlyIgnore.createFilter()) // Ignore clientside files
    .filter(devonlyIgnore.createFilter()) // Ignore devonly files
    .filter(f => !f.endsWith('-patched.jar')) // Bansoukou-patched files should be handled separately

  // List of mods, patched with Bansoukou, but without extension
  // mods/betteranimalsplus-1.12.2-9.0.1
  // mods/NuclearCraft-2.18zz-1.12.2
  const unpatchedList = globs('mods/*-patched.jar').map(f =>
    f.replace('-patched.jar', '')
  )

  doTask(
    '🪑 Removing client-only files and folders ... ',
    () => removeFiles(getIgnoredFiles(serveronlyIgnore)),
    tmpOverrides
  )
  doTask('🪑 Add server root files ... ', () => {
    const files = globs('*', { cwd: serverRoot })
    files.forEach(f => copySync(join(serverRoot, f), join(tmpOverrides, f)))
    return `added: ${files.length}`
  })

  makeZips && doTask('📥 Create server zip ... \n', () => {
    // Add everything in overrides dir
    const zip = withZip(zipPath_server)
    zip('.')

    // Add mods
    write('\n Add server mods\n')
    process.chdir(mcClientPath)
    zip(serverModsList)

    // Add Unpatched by Bansoukou mods
    write('\n Add & Rename Bansoukou-unpatched mods\n')
    const disabledList = unpatchedList.map(f => `${f}.disabled`)
    const renameList = unpatchedList.flatMap(f => [
      `${f}.disabled`,
      `${f}.jar`,
    ])
    process.chdir(mcClientPath)
    zip(disabledList)
    zip(renameList, 'rn')
  },
  tmpOverrides
  )

  /*
███████╗███████╗████████╗██████╗
██╔════╝██╔════╝╚══██╔══╝██╔══██╗
███████╗█████╗     ██║   ██████╔╝
╚════██║██╔══╝     ██║   ██╔═══╝
███████║██║        ██║   ██║
╚══════╝╚═╝        ╚═╝   ╚═╝
  */

  // /**
  //  * @type {{ dir:string, label:string, config: {[key:string]:string} }[]}
  //  */
  // const sftpConfigs = globs('secrets/sftp_servers/*/sftp.json').map(
  //   (filename) => {
  //     const dir = parse(filename).dir
  //     return {
  //       dir,
  //       label : /** @type {string} */ (dir.split('/').pop()),
  //       config: loadJson(filename),
  //     }
  //   }
  // )

  // // Relative to overrides
  // const serverAllOverrides = globs('./*', { cwd: tmpOverrides })

  // // Relative paths of dirs like
  // // - bansoukou
  // // - config
  // const serverRemoveDirs = serverAllOverrides
  //   .filter(f => lstatSync(join(tmpOverrides, f)).isDirectory())
  //   .concat('mods')

  // /** @type {import('boxen').Options} */
  // const defBoxStyle = {
  //   borderStyle: 'round',
  //   borderColor: '#22577a',
  //   width      : 50,
  //   // @ts-expect-error types
  //   padding    : { left: 1, right: 1 },
  // }

  // for (const conf of sftpConfigs) {
  //   logUpdate.done()

  //   if (
  //     !(await pressEnterOrEsc(
  //       `[${STEP++}] To upload SFTP ${style.string(
  //         conf.label
  //       )} press ENTER. Press ESC to skip.`
  //     ))
  //   )
  //     continue

  //   const sftp = new Client()

  //   const updateBox = (/** @type {any[]} */ ...args) =>
  //     logUpdate(
  //       boxen(
  //         args.map((v, i) => Object.values(style)[i](String(v))).join(' '),
  //         {
  //           ...defBoxStyle,
  //           title: style.info(conf.label),
  //         }
  //       )
  //     )

  //   updateBox('Establishing connection')
  //   await sftp.connect(conf.config)

  //   updateBox('Removing folders')
  //   await Promise.all(
  //     serverRemoveDirs.map(async (dir) => {
  //       try {
  //         if (!(await sftp.stat(dir)).isDirectory) return
  //         await sftp.rmdir(dir, true)
  //         updateBox('Removed folder:', dir)
  //       }
  //       catch (error) {}
  //     })
  //   )

  //   const zipName = parse(zipPath_server).base
  //   updateBox('Copy server pack')
  //   const bytes = (/** @type {number} */ v) => numeral(v).format('0.0b')
  //   let step = 0
  //   await sftp.fastPut(zipPath_server, zipName, {
  //     step: (total_transferred, chunk, total) => {
  //       if (step++ % 10 !== 0) return
  //       updateBox(
  //         'Copy server pack',
  //         bytes(total_transferred),
  //         '/',
  //         bytes(total)
  //       )
  //     },
  //   })

  //   await pressEnterOrEsc(
  //     `Go to SFTP server, Unpack ${style.log(
  //       zipName
  //     )} and press ENTER to override`
  //   )

  //   updateBox('Change and copy server overrides')
  //   const jsonPath = join(
  //     conf.dir,
  //     'overrides/config/Chikachi/discordintegration.json'
  //   )

  //   saveText(
  //     loadText(jsonPath).replace(
  //       /("serverStart":\s*")[^"]+"/,
  //       `$1\`\`\`diff\\n+ Server Started! +\\n     ${nextVersion}\\n\`\`\`"`
  //     ),
  //     jsonPath
  //   )

  //   let fileCounter = 0
  //   sftp.on('upload', () => updateBox('Copy overrides', ++fileCounter))
  //   const allOverridesDir = join(conf.dir, 'overrides')
  //   await sftp.uploadDir(allOverridesDir, './')

  //   await sftp.end()
  // }

  /*
  ██████╗ ███████╗██╗     ███████╗ █████╗ ███████╗███████╗
  ██╔══██╗██╔════╝██║     ██╔════╝██╔══██╗██╔════╝██╔════╝
  ██████╔╝█████╗  ██║     █████╗  ███████║███████╗█████╗
  ██╔══██╗██╔══╝  ██║     ██╔══╝  ██╔══██║╚════██║██╔══╝
  ██║  ██║███████╗███████╗███████╗██║  ██║███████║███████╗
  ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝
  */

  if (await pressEnterOrEsc(`[${STEP++}] Push tag? ENTER / ESC`))
    execSyncInherit('git push --follow-tags')

  const inputTitle = await enterString(
    `[${STEP++}] Enter release title and press ENTER. Press ESC to skip release: `
  )

  if (inputTitle !== undefined) {
    doTask('🌍 Releasing on Github ... \n', () =>
      execSyncInherit(
        'gh release create'
          + ` ${nextVersion}`
          + ` --title="${(`${nextVersion} ${inputTitle}`).trim()}"`
          + ' --repo=Krutoy242/Enigmatica2Expert-Extended'
          + ' --notes-file=changelogs/LATEST.md'
          + ` "${zipPath_EN}"`
          + ` "${zipPath_server}"`
      )
    )
  }

  process.exit(0)
})()
