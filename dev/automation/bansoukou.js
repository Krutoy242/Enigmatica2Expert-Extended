/**
 * @file Create fixed advancement files for Bonsoukou
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

// @ts-check

import { execSync, spawnSync } from 'node:child_process'
import { existsSync, mkdirSync, renameSync, statSync, unlinkSync } from 'node:fs'
import { dirname, join, parse, relative as relativeTo, resolve } from 'node:path'
import process from 'node:process'
import { fileURLToPath, URL } from 'node:url'

import AdmZip from 'adm-zip'
import fast_glob from 'fast-glob'
import levenshtein from 'fast-levenshtein'
import _ from 'lodash'

import {
  defaultHelper,
  execSyncInherit,
  loadJson,
  saveObjAsJson,
  saveText,
} from '../lib/utils.js'

function relative(relPath = './') {
  return fileURLToPath(new URL(relPath, import.meta.url))
}

export async function init(h = defaultHelper) {
  const argv = process.argv.slice(2)
  if (argv[0] === 'extract' && argv[1])
    return await extractFromJar(h, argv[1])
  else if (argv[0] === 'diff' && argv[1])
    return await showDiff(argv[1])

  await h.begin('Fixing Bansoukou files')
  renameFoldersToActualMods()
  await showDiffs(h)

  return h.result('Done!')
}

/**
 * Get names of all folders inside ./bansoukou/
 */
function getBansFolders() {
  return fast_glob.sync('*', {
    dot      : true,
    onlyFiles: false,
    cwd      : 'bansoukou',
    ignore   : fast_glob.sync('*', { dot: true, cwd: 'bansoukou' }),
  })
}

/**
 *
 * @param {*} h
 * @param {string} classFullPath
 */
async function extractFromJar(h = defaultHelper, classFullPath) {
  await h.begin(`Extracting ${classFullPath}`)

  const [jarFilePath, classPath] = classFullPath.split(/.jar\//)
  const jarPath = `${jarFilePath}.jar`
  const realJarPath = existsSync(jarPath) ? jarPath : jarPath.replace('.jar', '-patched.jar')
  if (!existsSync(realJarPath)) return await h.error(`.jar file does not exist: ${realJarPath}`)
  const modName = jarFilePath.split(/\\|\//).pop()
  const className = classPath.split(/\\|\//).pop()
  const bansFolder = `bansoukou/${modName}`
  try {
    mkdirSync(bansFolder, { recursive: true })
  }
  catch (error) {
    return h.error(`Cannot create folder: ${bansFolder}`)
  }

  const zip = new AdmZip(realJarPath)
  const extractPath = `${classPath}.class`
  const insertPath = `${bansFolder}/${className}.class`

  try {
    h.begin(`from ${extractPath} to ${bansFolder}`)
    zip.extractEntryTo(extractPath, bansFolder, true, true)
  }
  catch (error) {
    return h.error(`Cannot extract file from: ${extractPath} to: ${insertPath}.\n${error}`)
  }
  await h.done()
}

async function showDiff(diffPath) {
  const modClass = relativeTo('dev/automation/data/bansoukou_diffs', diffPath).replace(/.class.diff$/, '')
  decompileFile(resolve('~bansoukou_unpatched', `${modClass}.class`), `~A.java`)
  decompileFile(resolve('bansoukou', `${modClass}.class`), `~B.java`)
  execSyncInherit('code --diff ~A.java ~B.java')
}

function renameFoldersToActualMods() {
  const bansFolders = getBansFolders()

  const allMods = fast_glob
    .sync('*.jar', { dot: true, cwd: 'mods' })
    .map(mod => mod.replace(/(-patched)?\.jar/, ''))

  bansFolders.forEach((modName) => {
    if (allMods.includes(modName)) return

    const levArr = _(allMods)
      .map(m => ({ lev: levenshtein.get(m, modName), mod: m }))
      .sortBy('lev')
      .value()

    if (levArr[1].lev - levArr[0].lev < 3) {
      console.error(`\nBansoukou mod search function cant find mod ${modName}`)
      return
    }

    const currFolder = levArr[0].mod
    renameSync(join('bansoukou', modName), join('bansoukou', currFolder))
  })
}

/**
 * Replace extension
 * @param {string} fileName
 * @param {string} newExt
 * @returns string
 */
function replaceExt(fileName, newExt) {
  const { dir, name } = parse(fileName)
  return join(dir, name) + newExt
}

async function showDiffs(/** @type {typeof defaultHelper} */ h) {
  const cachePath = relative('~bansoukou_cached.json')
  /**
   * File path and its change time + size
   * @type {{[file:string]:string}}
   */
  const caches = existsSync(cachePath) ? loadJson(cachePath) : {}

  const bansFolders = getBansFolders()

  await h.begin('Generating Diffs', bansFolders.length)
  const diffStore = 'dev/automation/data/bansoukou_diffs'
  for (const folder of bansFolders) {
    const jarPath = existsSync(`mods/${folder}.disabled`)
      ? `mods/${folder}.disabled`
      : `mods/${folder}.jar`
    if (!existsSync(jarPath)) continue
    const jarStat = statToString(statSync(jarPath))
    const isJarCached = caches[jarPath] === jarStat
    caches[jarPath] = jarStat
    const unpatchedModPath = join('~bansoukou_unpatched/', folder)

    /** @type {AdmZip |  undefined} */
    let zip

    // List of files that should be changed by Bansoukou
    const changedFiles = fast_glob.sync('**/*', {
      dot: true,
      cwd: `bansoukou/${folder}`,
    })

    // Generate Diffs
    changedFiles.forEach((changedFile) => {
      const patchedFilePath = join('bansoukou', folder, changedFile)
      const diffOut = `${join(diffStore, folder, changedFile)}.diff`
      const diffExist = existsSync(diffOut)
      const stat = statSync(patchedFilePath)

      // If file just supposed to be removed no diffs will be generated
      if (!stat.size) return

      // Skip if both files unchanged
      // Never skip if diff file not exist
      const fileStat = statToString(stat)
      if (diffExist && isJarCached && caches[patchedFilePath] === fileStat) return

      // Extract unpatched file
      try {
        (zip ??= new AdmZip(jarPath))
          .extractEntryTo(changedFile, unpatchedModPath, true, true)
      }
      catch (error) {
        return
      }

      const unpatchedFilePath = join(unpatchedModPath, changedFile)
      const { oldF, newF } = decompile(unpatchedFilePath, patchedFilePath)

      mkdirSync(dirname(diffOut), { recursive: true })

      const gitDiffCommand = 'git diff --no-index'
        + ` "${oldF}"`
        + ` "${newF}"`
      // process.stdout.write(`> ${chalk.cyan(gitDiffCommand)}\n`)

      /** @type {string|undefined} */
      let diffResult
      try {
        diffResult = execSync(gitDiffCommand).toString().trim()
      }
      catch (error) {
        // Diff will end with error each time
        diffResult = error?.stdout.toString().trim()
      }

      // Remove diff technical info
      if (diffResult) {
        diffResult = diffResult.replace(/^diff --git .+\nindex .+\n(--- .+\n\+\+\+ .+|Binary files .+)\n/m, '')
        saveText(diffResult, diffOut)
      }

      try {
        spawnSync(
          'code --diff'
          + ` "${oldF}"`
          + ` "${newF}"`
          , { stdio: 'inherit' }
        )
      }
      catch (error) {}

      // Remove tempFiles
      if (unpatchedFilePath !== oldF) unlinkSync(oldF)
      if (patchedFilePath !== newF) unlinkSync(newF)

      // Save cache
      caches[patchedFilePath] = fileStat
    })

    h.step()
    await new Promise(resolve => setTimeout(resolve, 1))
  }

  saveObjAsJson(caches, cachePath)
}

/**
 * @param {string} unpatchedFilePath
 * @param {string} patchedFilePath
 * @returns {{oldF: string, newF: string}}
 */
function decompile(unpatchedFilePath, patchedFilePath) {
  if (parse(patchedFilePath).ext !== '.class')
    return { oldF: unpatchedFilePath, newF: patchedFilePath }

  // @ts-expect-error type
  return Object.fromEntries(
    [
      ['oldF', unpatchedFilePath],
      ['newF', patchedFilePath],
    ].map(([key, fPath]) => {
      const actualFile = replaceExt(fPath, '.java')
      decompileFile(fPath, actualFile)
      return [key, actualFile]
    })
  )
}

function decompileFile(source, target) {
  execSyncInherit(
    '"C:/Program Files/Java/jdk-13.0.2/bin/java.exe"'
    + ' -jar'
    + ' cfr-0.152.jar'
    + ` "${source}"`
    + ` > "${target}"`
  )
}

/**
 * @returns {string}
 * @param {import("fs").Stats} stat
 */
function statToString(stat) {
  return `${stat.mtime.toUTCString()} - ${stat.size}`
}

if (
  import.meta.url === (await import('node:url')).pathToFileURL(process.argv[1]).href
)
  init()
