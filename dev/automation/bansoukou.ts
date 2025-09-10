/**
 * @file Create fixed advancement files for Bonsoukou
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */
import { dirname } from 'node:path/posix'
import process from 'node:process'
import { fileURLToPath, URL } from 'node:url'

import AdmZip from 'adm-zip'
import {consola} from 'consola'
import fast_glob from 'fast-glob'
import levenshtein from 'fast-levenshtein'
import { join } from 'pathe'
import { $, fs } from 'zx'

import { decompile, statToString } from '../tools/showBansoukouDiff.js'

const {existsSync, mkdirSync, renameSync, statSync, unlinkSync} = fs

export function relative(relPath: string = './'): string {
  return fileURLToPath(new URL(relPath, import.meta.url))
}

export async function init(): Promise<any> {
  consola.start('Fixing Bansoukou files')
  renameFoldersToActualMods()
  await showDiffs()
  return consola.success('Done!')
}

/**
 * Get names of all folders inside ./bansoukou/
 */
export function getBansFolders(): string[] {
  return fast_glob.sync('*', {
    dot      : true,
    onlyFiles: false,
    cwd      : 'bansoukou',
    ignore   : fast_glob.sync('*', { dot: true, cwd: 'bansoukou' }),
  })
}

function renameFoldersToActualMods(): void {
  const bansFolders = getBansFolders()

  const allMods = fast_glob
    .sync('*.jar', { dot: true, cwd: 'mods' })
    .map(mod => mod.replace(/(?:-patched)?\.jar/, ''))

  bansFolders.forEach((modName) => {
    if (allMods.includes(modName)) return

    const levArr = allMods
      .map(m => ({ lev: levenshtein.get(m, modName), mod: m }))
      .sort((a, b) => a.lev - b.lev)

    if (levArr.length < 2 || levArr[1].lev - levArr[0].lev < 3) {
      console.error(`\nBansoukou mod search function cant find mod ${modName}`)
      return
    }

    const currFolder = levArr[0].mod
    renameSync(join('bansoukou', modName), join('bansoukou', currFolder))
  })
}

async function showDiffs(): Promise<void> {
  const cachePath = relative('~bansoukou_cached.json')
  const caches: { [file: string]: string } = existsSync(cachePath) ? fs.readJsonSync(cachePath) : {}

  const bansFolders = getBansFolders()

  consola.start('Generating Diffs', bansFolders.length)
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

    let zip: AdmZip | undefined

    // List of files that should be changed by Bansoukou
    const changedFiles = fast_glob.sync('**/*', {
      dot: true,
      cwd: `bansoukou/${folder}`,
    })

    // Generate Diffs
    for (const changedFile of changedFiles) {
      const patchedFilePath = join('bansoukou', folder, changedFile)
      const diffOut = `${join(diffStore, folder, changedFile)}.diff`
      const diffExist = existsSync(diffOut)
      const stat = statSync(patchedFilePath)

      // If file just supposed to be removed no diffs will be generated
      if (!stat.size) continue

      // Skip if both files unchanged
      // Never skip if diff file not exist
      const fileStat = statToString(stat)
      if (diffExist && isJarCached && caches[patchedFilePath] === fileStat) continue

      // Skip inner classes
      if (/\$.+\.(?:java|class)$/.test(patchedFilePath)) continue

      // Extract unpatched file
      try {
        (zip ??= new AdmZip(jarPath))
          .extractEntryTo(changedFile, unpatchedModPath, true, true)
      }
      catch (error) {
        consola.error(`Cannot extract file from: ${changedFile} to: ${unpatchedModPath}.\n${error}`)
        continue
      }

      const unpatchedFilePath = join(unpatchedModPath, changedFile)
      const { oldF, newF } = decompile(unpatchedFilePath, patchedFilePath)

      mkdirSync(dirname(diffOut), { recursive: true })

      let diffResult = String(await $({nothrow: true})`git diff --no-index ${oldF} ${newF}`)

      // Remove diff technical info
      if (diffResult) {
        diffResult = diffResult.replace(/^diff --git .+\nindex .+\n(?:--- .+\n\+\+\+ .+|Binary files .+)\n/m, '')
        fs.writeFileSync(diffOut, diffResult)
      }

      await $`code --diff ${oldF} ${newF}`

      // Remove tempFiles
      if (unpatchedFilePath !== oldF) unlinkSync(oldF)
      if (patchedFilePath !== newF) unlinkSync(newF)

      // Save cache
      caches[patchedFilePath] = fileStat
    }

    consola.trace('.')
    await new Promise(resolve => setTimeout(resolve, 1))
  }

  fs.writeJsonSync(cachePath, caches, { spaces: 2 })
}

// eslint-disable-next-line antfu/no-top-level-await
if (import.meta.url === (await import('node:url')).pathToFileURL(process.argv[1]).href) void init()
