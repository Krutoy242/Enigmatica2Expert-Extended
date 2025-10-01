/**
 * @file Helper script to prepare several files for fast access
 * Run with NodeJS
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

/* =============================================
=                Variables                    =
============================================= */
import { execSync } from 'node:child_process'
import { mkdirSync, readFileSync, statSync, writeFileSync } from 'node:fs'
import { basename, dirname } from 'node:path'
import process from 'node:process'
import { fileURLToPath, URL } from 'node:url'

import chalk from 'chalk'
import { parse as csvParseSync } from 'csv-parse/sync'
import fast_glob from 'fast-glob'
import pdf from 'pdf-parse/lib/pdf-parse.js'

function relative(relPath = './'): string {
  return fileURLToPath(new URL(relPath, import.meta.url))
}

/* =============================================
=            Internal Helpers                 =
============================================= */
/**
 * A function that result would be hashed based on input string
 */
type HashFunction<T> = (filePath: string) => T
interface HashCache<T> { [filePath: string]: { mtime: number, result: T } }
const hashMap = new Map<HashFunction<any>, HashCache<any>>()

/**
 * @template T
 * @param fn Function to be wrapped with caching
 * @returns Wrapped function with caching
 */
function createHashedFunction<T>(fn: (filePath: string) => T): (filePath: string) => T {
  const inner = (filename: string): T => {
    const hashFunction = hashMap.get(fn) ?? {}
    const oldResult = hashFunction[filename]
    const mtime = statSync(filename).mtime.getTime()

    if (oldResult && oldResult.mtime === mtime) {
      return oldResult.result
    }

    const result = fn(filename)
    hashFunction[filename] = { result, mtime }
    hashMap.set(fn, hashFunction)
    return result
  }

  return inner
}

/* =============================================
=                   Helpers                   =
============================================= */
/**
 * Extract file name without extension
 * @param filePath Full or relative path to file
 * @example subFileName('C:/main.js') // 'main'
 */
export function subFileName(filePath: string): string {
  return basename(filePath).split('.').slice(0, -1).join('.')
}

/**
 * Load file from disk or from hash
 */
export const loadText = createHashedFunction((filename: string): string =>
  readFileSync(filename, 'utf8')
)

/**
 * Load JSON file from disk or from hash
 */
export const loadJson = createHashedFunction((filename: string): any =>
  JSON.parse(loadText(filename))
)

/**
 * Load CSV file from disk or from hash
 */
export const getCSV = createHashedFunction(
  (filename: string) =>
    csvParseSync(readFileSync(filename, 'utf8'), { columns: true }) as Record<string, string>[]
)

/**
 * Load PDF file from disk or from hash
 */
export const getPDF = createHashedFunction(
  async (filename: string): Promise<string> =>
    (await pdf(readFileSync(filename))).text
)

export const config = createHashedFunction((filename: string): Record<string, any> | undefined => {
  const cfg = loadText(filename)
    .replace(/^ *#.*$/gm, '') // Remove comments
    .replace(/^~.*$/gm, '') // config version
    .replace(/^ *(\w+|"[^"]+") *\{ *$/gm, '$1:{') // class name
    .replace(/^ *\} *$/gm, '},') // end of block
    // Encapsulate values with ""
    .replace(
      /^ *\w:(?:([\w.]+)|"([^"]+)") *= *(.*)$/gm,
      (match, key1, key2, val) => {
        return (isNaN(val) && !(val === 'true' || val === 'false')) || val === ''
          ? `"${key1 || key2}":"${val.replace(/"/g, '\\"')}",`
          : `"${key1 || key2}":${val.replace(/"/g, '\\"')},`
      }
    )
    // Replace lists
    .replace(
      /^ *\w:(?:([\w.]+)|"([^"]+)") *<[\s\S]*?> *$/gm,
      (match, p1, p2) => {
        const lines = match.split('\n')
        const content = lines.slice(1, lines.length - 1)
        return [
          `"${p1 || p2}": [`,
          ...content.map(l => `"${l.trim()}",`),
          '],',
        ].join('\n')
      }
    )
    .replace(/\s*\n\s*\n/g, '\n') // remove residue newlines after converting

  try {
    // eslint-disable-next-line no-eval
    return eval(`({${cfg}})`) as Record<string, any>
  }
  catch (error) {
    console.log('Parsing config error. File: ', filename)
    console.error(error)
    const errorFileName = relative(`_error_${subFileName(filename)}.js`)
    writeFileSync(errorFileName, `return{${cfg}}`)
    console.log('See ', errorFileName)
  }
})

/**
 * Save Text but create folder if needed
 */
export function saveText(txt: string, filename: string): void {
  mkdirSync(dirname(filename), { recursive: true })
  writeFileSync(filename, txt)
}

/**
 * Save object in file
 */
export function saveObjAsJson(obj: Record<string, any>, filename: string): void {
  saveText(JSON.stringify(obj, null, 2), filename)
}

export function escapeRegex(string: string): string {
  return string.replace(/[/\\^$*+?.()|[\]{}]/g, '\\$&')
}

export function matchBetween(
  str: string,
  begin: null | string,
  end: null | string,
  regex: RegExp
): RegExpMatchArray[] {
  let sub = str
  if (begin) {
    sub = str.substr(str.indexOf(begin) + begin.length)
  }
  if (end) {
    sub = sub.substr(0, sub.indexOf(end))
  }
  return [...sub.matchAll(regex)]
}

/**
 * @param filename File or array of files
 * @param keyStart Start key for injection
 * @param keyFinish End key for injection
 * @param text Text to inject
 */
export function injectInFile(
  filename: string | string[],
  keyStart: string,
  keyFinish: string,
  text: string
): { file: string, hasChanged: boolean, numMatches: number, numReplacements: number }[] {
  return Array.isArray(filename)
    ? filename.map(f => injectInSingleFile(f, keyStart, keyFinish, text))
    : [injectInSingleFile(filename, keyStart, keyFinish, text)]
}

/**
 * @param filename File to inject into
 * @param keyStart Start key for injection
 * @param keyFinish End key for injection
 * @param text Text to inject
 */
function injectInSingleFile(
  filename: string,
  keyStart: string,
  keyFinish: string,
  text: string
): { file: string, hasChanged: boolean, numMatches: number, numReplacements: number } {
  const oldText = loadText(filename)
  const result = {
    file           : filename,
    hasChanged     : true,
    numMatches     : 0,
    numReplacements: 0,
  }

  const newText = oldText
    .replace(/\r\n/g, '\n')
    .replace(
      new RegExp(`${escapeRegex(keyStart)}[\\s\\S\r\n]*?${escapeRegex(keyFinish)}`, 'm'),
      () => {
        result.numMatches++
        result.numReplacements++
        return keyStart + text + keyFinish
      }
    )

  if (!result.numMatches) throw new Error(`Can't replace in file ${filename}`)

  saveText(newText, filename)
  return result
}

export function write(...args: any[]): void {
  process.stdout.write(args.join('\t'))
}

export function end(...args: any[]): void {
  process.stdout.write(args.length === 0 ? ' done' : args.join('\t'))
  process.stdout.write('\n')
}

export const begin = write
export const done = end

// # ######################################################################
// #
// # Utils
// #
// # ######################################################################

type RenameKeysCallback = (objKey: string, objValue: any) => string

/**
 * Rename each key in object by callback result
 */
function renameKeys<T>(
  obj: Record<string, T>,
  cb: RenameKeysCallback
): Record<string, T> {
  if (typeof cb !== 'function') {
    return obj
  }

  const keys = Object.keys(obj)
  const result: Record<string, any> = {}

  for (let i = 0; i < keys.length; i++) {
    let key = keys[i]
    if (key === '__') {
      continue
    }

    const val = obj[key]
    const str = cb(key, val)

    if (typeof str === 'string' && str !== '') {
      key = str
    }

    result[key] = val
  }

  return result
}

/**
 * Rename all object keys in object
 */
export function renameDeep<T extends Record<string, unknown>>(
  obj: T,
  cb: RenameKeysCallback
): T {
  const type = typeof obj

  if (type !== 'object' && !Array.isArray(obj)) {
    throw new Error('expected an object')
  }

  if (type === 'object') {
    obj = renameKeys(obj, cb)
  }

  const res: any[] | Record<string, any> = Array.isArray(obj) ? [] : {}

  for (const key in obj) {
    if (key === '__') {
      continue
    }

    const val = obj[key]

    if (typeof val === 'object' || Array.isArray(val)) {
      res[key] = renameDeep(val, cb)
    }
    else {
      res[key] = val
    }
  }

  return res
}

/**
 * Natural sort comparison function
 */
export function naturalSort(a: string, b: string): number {
  return a.localeCompare(b, undefined, { numeric: true, sensitivity: 'base' })
}

export function isPathHasChanged(pPath: string): boolean {
  try {
    return !!execSync(`git diff HEAD ${pPath}`).toString().trim()
  }
  catch (error) {
    return true
  }
}

interface Helper {
  begin            : (s: string, steps?: number) => Promise<void> | void
  done             : (s?: unknown) => Promise<void> | void
  error            : (...data: any[]) => Promise<void> | void
  isUnfinishedTask?: boolean
  result           : (s?: unknown) => Promise<void> | void
  step             : (s?: unknown) => Promise<void> | void
  taskResult?      : string
  warn             : (...data: any[]) => Promise<void> | void
}

export const defaultHelper: Helper = {
  begin(s, steps) {
    this.done()

    if (steps) {
      this.steps = steps
      this.stepSize = steps / 30
    }

    process.stdout.write(`◽ ${s.trim()}${steps ? ` [${steps}] ` : ''}`)
    this.isUnfinishedTask = true
  },

  done(s = '') {
    if (!this.isUnfinishedTask) {
      return
    }

    process.stdout.write(` ${chalk.gray(`${s} ✔`)}\n`)
    this.isUnfinishedTask = false
  },

  step(s = '.') {
    const helper = this
    if (helper.steps <= 30 || helper.steps-- % helper.stepSize === 0) {
      process.stdout.write(s)
    }
  },

  result(s = '') {
    this.done()
    process.stdout.write(`${chalk.green('✓')} ${chalk.dim.green(`${s}`)}\n`)
  },

  warn(...s) {
    process.stderr.write(`⚠️ ${chalk.dim.yellow(`${s.join('\t')}`)}`)
  },

  error(...s) {
    process.stderr.write(`🛑 ${chalk.dim.red(`${s.join('\t')}`)}`)
  },

  isUnfinishedTask: false,
  taskResult      : '',
}

/**
 * Execute command with inherited stdio
 */
export function execSyncInherit(command: string) {
  return execSync(command, { stdio: 'inherit' })
}

export function getModsJars(): string[] {
  return fast_glob.sync(['mods/*.jar', 'mods/*.disabled'], {
    ignore: ['mods/*-patched.jar', 'mods/*.jar.disabled'],
    dot   : true,
  })
}

/**
 * Find the number closest to the goal
 */
export function closest(numbers: number[], goal: number): number {
  return numbers.reduce((prev, curr) =>
    Math.abs(curr - goal) < Math.abs(prev - goal) ? curr : prev
  )
}
