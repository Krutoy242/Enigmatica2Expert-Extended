import type { Stats } from 'node:fs'

import { join, parse, relative as relativeTo, resolve } from 'node:path/posix'

import { execSyncInherit } from '../lib/utils'

export function decompile(unpatchedFilePath: string, patchedFilePath: string): { newF: string, oldF: string } {
  if (parse(patchedFilePath).ext !== '.class')
    return { oldF: unpatchedFilePath, newF: patchedFilePath }

  return Object.fromEntries(
    [
      ['oldF', unpatchedFilePath],
      ['newF', patchedFilePath],
    ].map(([key, fPath]) => {
      const actualFile = replaceExt(fPath, '.java')
      decompileFile(fPath, actualFile)
      return [key, actualFile]
    })
  ) as { newF: string, oldF: string }
}

function replaceExt(fileName: string, newExt: string): string {
  const { dir, name } = parse(fileName)
  return join(dir, name) + newExt
}

function decompileFile(source: string, target: string): void {
  execSyncInherit(
    '"D:/Program Files/Java/zulu-24/bin/java.exe"'
    + ' -jar'
    + ' cfr-0.152.jar'
    + ` "${source}"`
    + ` > "${target}"`
  )
}

export function statToString(stat: Stats): string {
  return `${stat.mtime.toUTCString()} - ${stat.size}`
}

async function showDiff(diffPath: string): Promise<void> {
  const modClass = relativeTo('dev/automation/data/bansoukou_diffs', diffPath).replace(/.class.diff$/, '')
  decompileFile(resolve('~bansoukou_unpatched', `${modClass}.class`), `~A.java`)
  decompileFile(resolve('bansoukou', `${modClass}.class`), `~B.java`)
  execSyncInherit('code --diff ~A.java ~B.java')
}

// eslint-disable-next-line antfu/no-top-level-await
if (import.meta.url === (await import('node:url')).pathToFileURL(process.argv[1]).href) void showDiff(process.argv[2])
