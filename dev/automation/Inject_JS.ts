/**
 * @file Inject_JS
 *
 * @description Lookup for keyword "Inject_js" in all zs files
 * to evaluate block and inject its result
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

/*
 * ⚠️  EVAL CONTRACT ⚠️
 *
 * Code captured from `Inject_js(...)` / `Inject_js{...}` blocks is run via
 * `eval()` inside `evaluateBlock()`. The captured snippets rely on lexical
 * scope, so EVERY import and local helper below is effectively part of the
 * public API available to those blocks (e.g. `getByOreKind`, `Object.entries`,
 * `getUnchangedFurnaceRecipes`, `$`, `smelt`, ...).
 *
 * Do NOT remove an import/helper just because it looks unused in this file —
 * grep `scripts/**\/*.zs` for `Inject_js` first. The two eslint disables below
 * exist for exactly this reason.
 */

/* eslint-disable unused-imports/no-unused-vars */
/* eslint-disable unused-imports/no-unused-imports */

import type { Element } from 'xml-js'

import { consola } from 'consola'
import humanizeString from 'humanize-string'
import _ from 'lodash'
import { getBorderCharacters, table } from 'table'
import { globSync } from 'tinyglobby'
import { js2xml, xml2js } from 'xml-js'

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

/* =============================================
=            Eval-context helpers              =
= (used by injected blocks, see EVAL CONTRACT) =
============================================= */

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

/* =============================================
=               Output formatting              =
============================================= */

const rgxTableTrim = /[ \t]+$|\n$/gm

function flatTable(arr: any[][]): string | undefined {
  return arr.length <= 0
    ? undefined
    : table(arr, {
        border            : getBorderCharacters('void'),
        columnDefault     : { paddingLeft: 0, paddingRight: 0 },
        drawHorizontalLine: () => false,
      }).replace(rgxTableTrim, '')
}

/**
 * Turn whatever a block returned into a single string ready to be injected.
 * - `undefined`            → `undefined` (signals "skip")
 * - 2D array (`any[][]`)   → aligned table
 * - other array           → joined by newlines
 * - anything else         → `String(value)`
 */
function formatOutput(injectValue: unknown): string | undefined {
  if (injectValue === undefined) return undefined
  if (!Array.isArray(injectValue)) return String(injectValue)
  return injectValue.every(Array.isArray)
    ? flatTable(injectValue)
    : injectValue.join('\n')
}

/* =============================================
=             Block discovery                  =
============================================= */

const rgxInjectJS = /\/\*\s*Inject_js((?:\(|\{)[\s\S]*?(?:\)|\})\s*)\*\//g
const rgxEmptyParens = /^\(\s*\)$/m
const INJECT_TERMINATOR = '/**/'

interface Occurrence {
  filePath: string
  /** Raw captured snippet including its surrounding parens/braces. */
  capture : string
  /** Snippet wrapped so it can be `eval`-ed as an expression. */
  command : string
  /** 1-based line number of the block, for diagnostics. */
  line    : number
  /** Leading whitespace of the line, applied to injected output. */
  indent  : string
}

/**
 * Compute the 1-based line number of a given index in `content`.
 */
function lineNumberAt(content: string, index: number): number {
  let line = 1
  for (let i = 0; i < index && i < content.length; i++) {
    if (content[i] === '\n') line++
  }
  return line
}

/**
 * Extract the leading whitespace of the line containing `index`.
 */
function indentAt(content: string, index: number): string {
  const lineStart = content.lastIndexOf('\n', index) + 1
  return content.substring(lineStart, index).match(/^([ \t]*)/)?.[1] ?? ''
}

/**
 * Build an `eval`-able expression from a captured snippet.
 * - `{ ... }` blocks become an IIFE returning their body.
 * - `( ... )` blocks are used verbatim.
 */
function toCommand(whole: string): string {
  const trimmed = whole.trim()
  return trimmed.startsWith('{') && trimmed.endsWith('}')
    ? `(()=>${trimmed})()`
    : trimmed
}

/**
 * Scan all `scripts/**\/*.zs` files for `Inject_js` blocks.
 */
function collectOccurrences(): Occurrence[] {
  const occurrences: Occurrence[] = []

  for (const filePath of globSync('scripts/**/*.zs')) {
    const content = loadText(filePath)
    for (const match of content.matchAll(rgxInjectJS)) {
      const matchIndex = match.index ?? 0
      const [, whole] = match
      occurrences.push({
        filePath,
        capture: whole,
        command: toCommand(whole),
        line   : lineNumberAt(content, matchIndex),
        indent : indentAt(content, matchIndex),
      })
    }
  }

  return occurrences
}

/* =============================================
=                Evaluation                    =
============================================= */

/**
 * Evaluate a single block's command. Returns `'# Empty Injection'` for empty
 * `()` captures, or `undefined` when evaluation threw (after logging it).
 */
async function evaluateBlock(cmd: Occurrence): Promise<unknown> {
  if (rgxEmptyParens.test(cmd.capture)) return '# Empty Injection'

  try {
    // eslint-disable-next-line no-eval
    return await eval(`(async()=>{return ${cmd.command}})()`)
  }
  catch (error: any) {
    consola.error(
      `\nComment block Error.\nFile: ${cmd.filePath}:${cmd.line}`,
      '\nCapture:',
      cmd.capture,
      '\n\n',
      String(error)
    )
    return undefined
  }
}

/**
 * Indent every line of `text` with `indent`, unless the text already begins
 * with leading whitespace (then it is assumed to be pre-formatted).
 */
function applyIndent(text: string, indent: string): string {
  if (text.length === 0 || /^[ \t]/.test(text)) return text
  return text.split('\n').map(line => indent + line).join('\n')
}

/* =============================================
=                   Main                       =
============================================= */

export async function init() {
  consola.start('Searching Inject_js blocks in .zs files')
  const occurrences = collectOccurrences()

  consola.start(`Evaluating ${occurrences.length}`)
  let countBlocks = 0
  let countChanged = 0

  for (const cmd of occurrences) {
    const injectValue = await evaluateBlock(cmd)

    let injectString = formatOutput(injectValue)
    if (injectString === undefined) {
      consola.warn(`${cmd.filePath}:${cmd.line} Returned empty result!`)
      continue
    }

    // Trim trailing whitespace to avoid blank lines before terminator,
    // then re-indent to match the block's own indentation.
    injectString = applyIndent(injectString.trimEnd(), cmd.indent)

    try {
      const replaceResults = injectInFile(
        cmd.filePath,
        cmd.capture,
        INJECT_TERMINATOR,
        `*/\n${injectString}\n`
      )
      for (const o of replaceResults ?? []) {
        countBlocks += o.numMatches ?? 0
        countChanged += o.numReplacements ?? 0
      }
    }
    catch (error: any) {
      consola.error(`${cmd.filePath}:${cmd.line} Injection failed:`, String(error))
    }
  }

  consola.success(`Blocks: ${countBlocks}, Changed: ${countChanged}`)
}

if (import.meta.main) void init()
