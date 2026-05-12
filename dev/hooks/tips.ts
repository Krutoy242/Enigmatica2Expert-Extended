/**
 * @file Sync tips files from `resources/tips/lang/en_us.lang` (source of truth).
 *
 * Triggered automatically by the `pre-commit` hook (see `.husky/pre-commit`)
 * whenever `resources/tips/lang/en_us.lang` is staged. Can also be run
 * manually via `pnpm tips:sync`.
 *
 * Behaviour:
 *  - `config/anothertips.cfg` "Tip Lang Keys" list is rebuilt from en_us
 *  - Other `*_*.lang` files are reordered to match en_us
 *  - Keys removed from en_us are removed from other locales
 *  - Keys added to en_us are inserted into other locales using the english
 *    text verbatim (translators must replace it later)
 *
 * Exits with non-zero code on unrecoverable errors (e.g. en_us.lang missing,
 * malformed line). Untranslated additions are *not* an error — they are
 * reported as warnings.
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

import { writeFileSync } from 'node:fs'
import { parse } from 'node:path'
import process from 'node:process'
import { consola } from 'consola'
import { globSync } from 'tinyglobby'

import {
  injectInFile,
  loadText,
} from '../lib/utils.js'

const LANG_GLOB = 'resources/tips/lang/*_*.lang'
const SOURCE_LANG = 'en_us'
const CFG_PATH = 'config/anothertips.cfg'

const getTipsRegex = /^(?<match>e2ee\.tips\.(?<id>[^=]+)=(?<text>.*))$/gm

// Patchouli tips generation constants (migrated from scripts/debug/patchouli/tips.zs)
const PATCHOULI_WIDTH = 28
const PATCHOULI_HEIGHT = 15
const PATCHOULI_DOT = 3
const PATCHOULI_ENTRY_PATH = 'patchouli_books/e2e_e/en_us/entries/world/tips.json'

interface LangGroups {
  match: string
  id   : string
  text : string
}

// Patchouli JSON type definitions
interface PatchouliPage {
  item : string
  type : string
  title: string
  text : string
}

interface PatchouliEntry {
  name    : string
  icon    : string
  category: string
  pages   : PatchouliPage[]
}

function getTips(lang: string, filePath: string): LangGroups[] {
  const tips = Array.from(
    lang.matchAll(getTipsRegex),
    m => m.groups as unknown as LangGroups
  )

  // Detect lines that look like tips but didn't match (malformed / typo)
  const suspicious = lang
    .split('\n')
    .map((line, i) => ({ line, n: i + 1 }))
    .filter(({ line }) => /^e2ee\.tips\./.test(line) && !/^e2ee\.tips\.[^=]+=.*/.test(line))

  if (suspicious.length) {
    for (const s of suspicious)
      consola.error(`${filePath}:${s.n}  malformed tip line: ${JSON.stringify(s.line)}`)
    throw new Error(`Malformed tip lines in ${filePath}`)
  }

  // Detect duplicate ids
  const seen = new Set<string>()
  for (const t of tips) {
    if (seen.has(t.id))
      throw new Error(`${filePath}: duplicate key "e2ee.tips.${t.id}"`)
    seen.add(t.id)
  }

  return tips
}

/**
 * Process tip text converting Minecraft formatting codes to Patchouli format,
 * replicating the original ZenScript logic from tips.zs
 */
function processTipText(text: string): string {
  return text
    .replace(/§e/g, '§6') // Yellow too bright for Patchouli background
    .replace(/§r/g, '$()') // Reset code → Patchouli reset
    .replace(/§(.)/g, '$$($1)') // Any §X → Patchouli $(X) ($$ is literal $ in replace)
    .replace(/\n/g, '') // Remove newlines
}

/**
 * Generate Patchouli tips entry from en_us tips, replicating the original
 * ZenScript page packing logic with textual lang keys
 */
function generatePatchouliTips(enUsTips: LangGroups[]) {
  const pages: PatchouliEntry['pages'] = []
  let currentPageText = ''
  let currentHeight = 0
  let tipCounter = 0

  const WIDTH = PATCHOULI_WIDTH
  const HEIGHT = PATCHOULI_HEIGHT
  const DOT = PATCHOULI_DOT

  for (const tip of enUsTips) {
    const processedText = processTipText(tip.text)
    const tipStr = `$(li)${processedText}`
    const tipTextLength = processedText.length

    // Replicate original tip height calculation from ZenScript
    const addedLength = currentHeight === 0 ? DOT : 0
    const tipHeight = Math.floor((tipTextLength + addedLength) / WIDTH) + 1 + (tipCounter === 0 ? 1 : 0)

    // Check if we need to start a new page (same logic as original)
    if (currentHeight !== 0 && currentHeight + tipHeight > HEIGHT) {
      // Finalize current page
      pages.push({
        item : 'thaumicaugmentation:research_notes',
        type : 'text',
        title: 'Tips',
        text : currentPageText,
      })
      // Reset for new page
      currentPageText = ''
      currentHeight = 0
    }

    // Add tip to current page
    currentPageText += tipStr
    currentHeight += tipHeight
    tipCounter++
  }

  // Finalize last page
  if (currentPageText || pages.length === 0) {
    pages.push({
      item : 'thaumicaugmentation:research_notes',
      type : 'text',
      title: 'Tips',
      text : currentPageText,
    })
  }

  // Build and write Patchouli entry
  const entry: PatchouliEntry = {
    name    : 'Tips',
    icon    : 'thaumicaugmentation:research_notes',
    category: 'World',
    pages,
  }

  writeFileSync(PATCHOULI_ENTRY_PATH, `${JSON.stringify(entry, null, 2)}\n`)
  consola.info(`Generated Patchouli tips entry: ${PATCHOULI_ENTRY_PATH}`)
}

export async function init() {
  const filePathes = globSync(LANG_GLOB)
  if (!filePathes.length)
    throw new Error(`No lang files found by glob ${LANG_GLOB}`)

  const rawLandCodes = filePathes.map(f => parse(f).name)
  const en_us_index = rawLandCodes.indexOf(SOURCE_LANG)
  if (en_us_index < 0)
    throw new Error(`Source of truth "${SOURCE_LANG}.lang" not found among ${filePathes.join(', ')}`)

  consola.start(`Syncing tips from ${filePathes[en_us_index]}`)

  const rawFiles = filePathes.map(loadText)
  const rawTips = rawFiles.map((text, i) => getTips(text, filePathes[i]))
  const en_us_Tips = rawTips[en_us_index]

  // ---- config/anothertips.cfg ----
  injectInFile(
    CFG_PATH,
    '    S:"Tip Lang Keys" <\n',
    '\n     >',
    en_us_Tips.map(tip => `        e2ee.tips.${tip.id}`).join('\n')
  )

  // ---- en_us itself (rewrite to normalize formatting / line endings) ----
  replaceTips(en_us_index, en_us_Tips)

  // ---- other languages ----
  let totalAdded = 0
  let totalRemoved = 0

  rawTips.forEach((tips, i) => {
    if (i === en_us_index) return
    const lang = rawLandCodes[i]
    const existing = new Map(tips.map(t => [t.id, t]))
    const filtered: LangGroups[] = []
    const added: string[] = []

    for (const en of en_us_Tips) {
      const found = existing.get(en.id)
      if (found) {
        filtered.push(found)
      }
      else {
        filtered.push(en)
        added.push(en.id)
      }
    }

    const removed = tips.filter(t => !en_us_Tips.some(en => en.id === t.id)).map(t => t.id)

    totalAdded += added.length
    totalRemoved += removed.length

    if (added.length)
      consola.warn(`[${lang}] +${added.length} new key(s) need translation: ${added.join(', ')}`)
    if (removed.length)
      consola.info(`[${lang}] -${removed.length} removed: ${removed.join(', ')}`)

    replaceTips(i, filtered)
  })

  function replaceTips(fileIndex: number, newGroups: LangGroups[]) {
    writeFileSync(
      filePathes[fileIndex],
      `${newGroups.map(({ id, text }) => `e2ee.tips.${id}=${text}`).join('\n')}\n`
    )
  }

  // Generate Patchouli tips entry from synced en_us tips
  generatePatchouliTips(en_us_Tips)

  consola.success(
    `Tips synced: ${en_us_Tips.length} total${
      totalAdded ? `, +${totalAdded} added` : ''
    }${totalRemoved ? `, -${totalRemoved} removed` : ''}`
  )
}

if (import.meta.main) {
  try {
    // eslint-disable-next-line antfu/no-top-level-await
    await init()
  }
  catch (err) {
    consola.error(err instanceof Error ? err.message : err)
    process.exit(1)
  }
}
