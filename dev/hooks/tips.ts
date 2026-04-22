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

interface LangGroups {
  match: string
  id   : string
  text : string
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
