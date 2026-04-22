/**
 * @file Inject_JS
 *
 * @description Lookup for keyword "Inject_js" in all zs files
 * to evaluate block and inject its result
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

/* eslint-disable unused-imports/no-unused-vars */
/* eslint-disable unused-imports/no-unused-imports */

import type { Element } from 'xml-js'

import { consola } from 'consola'
import humanizeString from 'humanize-string'
import _ from 'lodash'
import { getBorderCharacters, table } from 'table'
import { globSync } from 'tinyglobby'
import {  js2xml, xml2js } from 'xml-js'
import yargs from 'yargs'

import { getExtra } from '../lib/jaopca.js'
import {
  countBaseOutput,
  getByOreBase,
  getByOredict,
  getByOredict_first,
  getByOreKind,
  getCrtLogBlock,
  getFurnaceRecipes,
  getItemOredictSet,
  getOreBases_byKinds,
  getSomething,
  getSubMetas,
  getTableRecipes,
  getUnchangedFurnaceRecipes,
  getUnchangedTableRecipes,
  isFluidExist,
  isItemExist,
  isJEIBlacklisted,
  isODExist,
  isPurged,
  prefferedModSort,
  smelt,
  smeltOre,
} from '../lib/tellme.js'
import {
  closest,
  config,
  getCSV,
  injectInFile,
  loadJson,
  loadText,
  naturalSort,
  saveText,
} from '../lib/utils.js'

// const argv = yargs(process.argv.slice(2))
//   .alias('t', 'test')
//   .describe('t', 'Only test function').parseSync()

function saveObjAsJson(obj: any, filename: string) {
  saveText(JSON.stringify(obj, null, 2), filename)
}

function xml_to_js(xmlString: string): Element {
  return xml2js(xmlString, { compact: false }) as Element
}

function reverseStr(s: string) {
  return [...s].reverse().join('')
}
function reverseNaturalSort(a: string, b: string) {
  return naturalSort(reverseStr(a), reverseStr(b))
}

function itemize(id: string, meta: string) {
  return id + (meta && meta !== '0' ? `:${meta}` : '')
}
function $(source: string, id: string, meta: string, count: number | string, nbt: string, modifiers: string) {
  return `<${source}:${id}${meta && meta !== '0' ? `:${meta}` : ''}>${
    nbt ? `.withTag(${nbt})` : ''
  }${modifiers || ''}${Number(count) > 1 ? ` * ${Number(count) | 0}` : ''}`
}

const rgxTableTrim = /[ \t]+$|\n$/gm
function flatTable(arr: any[][]) {
  return arr.length <= 0
    ? undefined
    : table(arr, {
        border            : getBorderCharacters('void'),
        columnDefault     : { paddingLeft: 0, paddingRight: 0 },
        drawHorizontalLine: () => false,
      }).replace(rgxTableTrim, '')
}

function formatOutput(injectValue: any): string | undefined {
  return !Array.isArray(injectValue)
    ? String(injectValue)
    : injectValue.every(Array.isArray)
      ? flatTable(injectValue)
      : injectValue.join('\n')
}

// ----------------------------------

const rgxInjectJS = /\/\*\s*Inject_js((\(|\{)[\s\S]*?(\)|\})\s*)\*\//g
const rgxEmptyParens = /^\(\s*\)$/m

export async function init() {
  const occurences: Array<{
    filePath: string
    capture : string
    command : string
    line    : number
    below   : string
    block   : string
  }> = []

  consola.start('Searching Inject_js blocks in .zs files')
  globSync('scripts/**/*.zs').forEach((filePath) => {
    const zsfileContent = loadText(filePath)
    for (const match of zsfileContent.matchAll(rgxInjectJS)) {
      const lineNumber = zsfileContent
        .substring(0, match.index)
        .split('\n')
        .length
      const [, whole, p1, p2] = match
      const below = zsfileContent.substring((match.index ?? 0) + match[0].length + 1)
      occurences.push({
        filePath,
        capture: whole,
        command:
          p1 === '{' && p2 === '}'
            ? `(()=>${whole.trim()})()`
            : whole.trim(),
        line : lineNumber,
        below,
        block: below.substring(0, below.indexOf('/**/') - 1),
      })
    }
  })

  consola.start(`Evaluating ${occurences.length}`)
  let countBlocks = 0
  let countChanged = 0

  for (const cmd of occurences) {
    let injectValue: any = ''
    if (rgxEmptyParens.test(cmd.capture)) {
      injectValue = '# Empty Injection'
    }
    else {
      try {
        const evalStr = `(async()=>{return ${cmd.command}})()`
        // eslint-disable-next-line no-eval
        injectValue ||= await eval(evalStr)
      }
      catch (error: any) {
        consola.error(
          `\nComment block Error.\nFile: ${cmd.filePath}:${cmd.line}`,
          '\nCapture:',
          cmd.capture,
          '\n\n',
          String(error)
        )
        return
      }
    }

    const injectString = formatOutput(injectValue)

    // eslint-disable-next-line eqeqeq
    if (injectString == undefined) {
      consola.warn(`${cmd.filePath}:${cmd.line} Returned empty result!`)
    }
    else {
      const replaceResults = injectInFile(
        cmd.filePath,
        cmd.capture,
        '/**/',
        `*/\n${injectString}\n`
      )
      replaceResults?.forEach(o => countBlocks += o.numMatches ?? 0)
      replaceResults?.forEach(o => countChanged += o.numReplacements ?? 0)
    }
  }

  consola.success(`Blocks: ${countBlocks}, Changed: ${countChanged}`)
}

if (import.meta.main) void init()
