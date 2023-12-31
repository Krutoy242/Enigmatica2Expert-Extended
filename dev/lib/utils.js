/**
 * @file Helper script to prepare several files for fast acces
 * Lunch with NodeJS
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

// @ts-check

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
import replace_in_file from 'replace-in-file'

function relative(relPath = './') {
  return fileURLToPath(new URL(relPath, import.meta.url))
}

/* =============================================
=            Internal Helpers                 =
============================================= */

/**
 * A function that result would be hashed based on input string
 * @type {Map<(filePath: string) => any, {[filePath: string]: {mtime: number, result: any}}>} x is filename
 */
const hashMap = new Map()

/**
 * @template T
 * @param {(filePath: string) => T} fn
 * @returns {(filePath: string) => T} wrapped function
 */
function createHashedFunction(fn) {
  /**
   * @param {string} filename
   * @returns {T}
   */
  const inner = (filename) => {
    const hashFunction = hashMap.get(fn) ?? {}
    const oldResult = hashFunction[filename]
    const mtime = statSync(filename).mtime.getTime()
    if (oldResult && oldResult.mtime === mtime)
      return oldResult.result

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
 * @param {string} filePath Full or relative path to file
 *
 * @example subFileName('C:/main.js') // 'main'
 */
export function subFileName(filePath) {
  return basename(filePath).split('.').slice(0, -1).join('.')
}

/**
 * Load file from disk or from hash
 * @returns {string}
 */
export const loadText = createHashedFunction(filename =>
  readFileSync(filename, 'utf8')
)

/**
 * Load JSON file from disk or from hash
 * @param {string} filename
 */
export const loadJson = createHashedFunction(filename =>
  JSON.parse(loadText(filename))
)

/**
 * Load CSV file from disk or from hash
 * @param {string} filename
 */
export const getCSV = createHashedFunction(
  /** @return {Object<string, string>[]} */ filename =>
    csvParseSync(readFileSync(filename, 'utf8'), { columns: true })
)

/**
 * Load PDF file from disk or from hash
 * @param {string} filename
 */
export const getPDF = createHashedFunction(
  async filename => (await pdf(readFileSync(filename))).text
)

export const config = createHashedFunction((filename) => {
  const cfg = loadText(filename)
    .replace(/^ *#.*$/gm, '') // Remove comments
    .replace(/^~.*$/gm, '') // config version
    .replace(/^ *(\w+|"[^"]+") *{ *$/gm, '$1:{') // class name
    .replace(/^ *} *$/gm, '},') // end of block
    .replace(
      /^ *\w:(?:([\w.]+)|"([^"]+)") *= *(.*)$/gm,
      (match, p1, p2, p3) => {
        return (isNaN(p3) && !(p3 === 'true' || p3 === 'false')) || p3 === ''
          ? `"${p1 || p2}":"${p3.replace(/"/g, '\\"')}",`
          : `"${p1 || p2}":${p3.replace(/"/g, '\\"')},`
      }
    ) // simple values
    .replace(
      /^ *\w:(?:([\w.]+)|"([^"]+)") *< *[\s\S\n\r]*?> *$/gm,
      (match, p1, p2) => {
        const lines = match.split('\n')
        const content = lines.slice(1, lines.length - 1)
        return [
          `"${p1 || p2}": [`,
          ...content.map(l => `"${l.trim()}",`),
          '],',
        ].join('\n')
      }
    ) // Replace lists

  /**
   * @type {object}
   */
  let result
  try {
    result = eval(`({${cfg}})`)
  }
  catch (error) {
    console.log('Parsing config error. File: ', filename)
    console.error(error)
    writeFileSync(
      relative(`_error_${subFileName(filename)}.js`),
      `return{${cfg.replace(/\n\n+/gm, '\n')}}`
    )
  }

  return result
})

/**
 * Save Text but create folder if needed
 * @param {string} txt
 * @param {string} filename
 */
export function saveText(txt, filename) {
  mkdirSync(dirname(filename), { recursive: true })
  writeFileSync(filename, txt)
}

/**
 * Save object in file
 * @param {object} obj
 * @param {string} filename
 */
export function saveObjAsJson(obj, filename) {
  saveText(JSON.stringify(obj, null, 2), filename)
}

export function escapeRegex(string) {
  return string.replace(/[/\\^$*+?.()|[\]{}]/g, '\\$&')
}

export function matchBetween(str, begin, end, regex) {
  let sub = str
  if (begin)
    sub = str.substr(str.indexOf(begin) + begin.length)
  if (end)
    sub = sub.substr(0, sub.indexOf(end))
  return [...sub.matchAll(regex)]
}

export function transpose(a) {
  return Object.keys(a[0]).map((c) => {
    return a.map((r) => {
      return r[c]
    })
  })
}

/**
 * @param {string | string[]} filename
 * @param {string} keyStart
 * @param {string} keyFinish
 * @param {string} text
 */
export function injectInFile(filename, keyStart, keyFinish, text) {
  /** @type {import('replace-in-file').ReplaceResult[]} */
  let replaceResult
  try {
    const from = new RegExp(
        `${escapeRegex(keyStart)}[\\s\\S\n\r]*?${escapeRegex(keyFinish)}`,
        'm'
    )
    replaceResult = replace_in_file.sync({
      files       : filename,
      from,
      to          : keyStart + text + keyFinish,
      countMatches: true,
    })
  }
  catch (error) {
    console.error('Inject Error occurred:', error)
    return []
  }

  if (!replaceResult?.[0]?.numMatches) throw new Error(`Cant replace in file ${filename}`)
  return replaceResult
}

export function write(...args) {
  process.stdout.write(args.join('\t'))
}

export function end(...args) {
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

/**
 * @typedef {object} BlockDrop
 * @property {string} name
 * @property {number} meta
 * @property {number} length
 */

/**
 * @typedef {object} DropEntry
 * @property {string} stack
 * @property {number} [chance]
 * @property {[left:number, right:number][] | [left:number, right:number]} [luck]
 */

/**
 * Add new drop list
 * If second parameter is null - remove entry
 * @param {string} block_stack
 * @param {DropEntry[]} [dropList]
 * @param {boolean} [isSkipSaving]
 */
export function setBlockDrops(block_stack, dropList, isSkipSaving = false) {
  const [source, id, _block_meta] = block_stack.split(':')
  const block_meta = Number.parseInt(_block_meta || '0')
  const block_id = `${source}:${id}`

  let newObj

  if (dropList?.length) {
    newObj = {
      name  : block_id,
      meta  : block_meta,
      length: dropList.length,
    }

    dropList.forEach((o, i) => {
      const [drop_source, drop_id, drop_meta] = o.stack.split(':')
      newObj[`name${i}`] = `${drop_source}:${drop_id}`
      newObj[`meta${i}`] = Number.parseInt(drop_meta || '0')
      for (let j = 0; j < 4; j++) newObj[`${j}chance${i}`] = o.chance || 100.0
      for (let j = 0; j < 4; j++) {
        newObj[`${j}pair${i}`] = `{
  "left": ${o.luck?.[j]?.[0] ?? o.luck?.[0] ?? 1},
  "right": ${o.luck?.[j]?.[1] ?? o.luck?.[1] ?? 1}\n}`
      }
    })
  }

  /** @type {BlockDrop[]} */
  let arr
  try {
    arr = loadJson('config/BlockDrops/blockdrops.txt')
  }
  catch (error) {
    return []
  }
  const entryIndex = arr.findIndex(
    o => o.name === block_id && o.meta === block_meta
  )

  if (newObj) {
    if (entryIndex !== -1)
      Object.assign(arr[entryIndex], newObj)
    else arr.push(newObj)
  }
  else if (entryIndex !== -1) { arr.splice(entryIndex, 1) }

  if (!isSkipSaving)
    saveBlockDrops(arr)

  return arr
}

/**
 *
 * @param {{block_stack:string, dropList:DropEntry[] | undefined}[]} [blockDropList]
 */
export function setBlockDropsList(blockDropList) {
  let arr
  blockDropList?.forEach(
    o => (arr = setBlockDrops(o.block_stack, o.dropList, true))
  )
  return saveBlockDrops(arr)
}

/**
 * Round first 2 digits
 * @param {number} n
 * @returns {number}
 */
function smartRound(n) {
  const m = Math.round(Math.log10(n))
  const l = 10 ** (-m + 1)
  return ((n * l + 0.5) | 0) / l
}

/**
 * @param {BlockDrop[]} arr
 */
function saveBlockDrops(arr) {
  // Round values
  arr.forEach((a) => {
    let i = 0
    while (true) {
      for (let j = 0; j < 4; j++) {
        const k = `${j}chance${i}`
        if (!a[k]) return
        a[k] = smartRound(a[k])
      }
      i++
    }
  })
  saveText(
    JSON.stringify(
      arr.sort(({ name: a, meta: am }, { name: b, meta: bm }) =>
        naturalSort(a + am, b + bm)
      ),
      null,
      2
    ).replace(/^(\s+"\d+chance\d+": \d+)(,?)$/gm, '$1.0$2'),
    'config/BlockDrops/blockdrops.txt'
  )
  return arr
}

/**
 * Rename Key callback
 * @callback renameKeysCallback
 * @param {string} objKey
 * @param {*} objValue
 * @returns {string}
 */

/**
 * Rename each key in object by callback result
 *
 * @param {{}} obj
 * @param {renameKeysCallback} cb Rename Key callback
 * @return {{}}
 */
function renameKeys(obj, cb) {
  if (typeof cb !== 'function')
    return obj

  const keys = Object.keys(obj)
  const result = {}

  for (let i = 0; i < keys.length; i++) {
    let key = keys[i]
    if (key === '__')
      continue

    const val = obj[key]
    const str = cb(key, val)
    if (typeof str === 'string' && str !== '')
      key = str

    result[key] = val
  }

  return result
}

/**
 * Rename all object keys in object
 *
 * @param {*} obj
 * @param {renameKeysCallback} cb
 * @return {*}
 */
export function renameDeep(obj, cb) {
  const type = typeof obj

  if (type !== 'object' && !Array.isArray(obj))
    throw new Error('expected an object')

  if (type === 'object')
    obj = renameKeys(obj, cb)

  /** @type {{}|[]} */
  const res = Array.isArray(obj) ? [] : {}

  for (const key in obj) {
    if (key === '__')
      continue

    const val = obj[key]
    if (typeof val === 'object' || Array.isArray(val))
      res[key] = renameDeep(val, cb)

    else
      res[key] = val
  }
  return res
}

/**
 *
 * @param {string} a
 * @param {string} b
 */
export function naturalSort(a, b) {
  return a.localeCompare(b, undefined, { numeric: true, sensitivity: 'base' })
}

export function isPathHasChanged(pPath) {
  try {
    return !!execSync(`git diff HEAD ${pPath}`)
      .toString()
      .trim()
  }
  catch (error) {
    return true
  }
}

/**
 * @typedef {object} Helper
 * @property {(startItem: string, steps?: number)=>void} begin
 * @property {(itemDone?: any)=>void} done
 * @property {(s?: any)=>void} step
 * @property {(s?: any)=>void} result
 * @property {typeof console.log} warn
 * @property {typeof console.error} error
 * @property {boolean} [isUnfinishedTask]
 * @property {string} [taskResult]
 */

/**
 * @type {Helper}
 */
export const defaultHelper = {
  /** @this {Helper} */
  begin(s, steps) {
    this.done()
    if (steps) {
      // @ts-expect-error new fields
      this.steps = steps
      // @ts-expect-error new fields
      this.stepSize = steps / 30
    }
    process.stdout.write(`◽ ${s.trim()}${steps ? ` [${steps}] ` : ''}`)
    this.isUnfinishedTask = true
  },
  done(s = '') {
    if (!this.isUnfinishedTask)
      return
    process.stdout.write(` ${chalk.gray(`${s} ✔`)}\n`)
    this.isUnfinishedTask = false
  },
  step(s = '.') {
    // @ts-expect-error new fields
    if (this.steps <= 30 || this.steps-- % this.stepSize === 0)
      process.stdout.write(s)
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
 * @param {string} command
 */
export function execSyncInherit(command) {
  return execSync(command, { stdio: 'inherit' })
}

export function getModsJars() {
  return fast_glob.sync(['mods/*.jar', 'mods/*.disabled'], {
    ignore: ['mods/*-patched.jar', 'mods/*.jar.disabled'],
    dot   : true,
  })
}

/**
 * @param {number[]} numbers
 * @param {number} goal
 */
export function closest(numbers, goal) {
  return numbers.reduce((prev, curr) => Math.abs(curr - goal) < Math.abs(prev - goal) ? curr : prev)
}
