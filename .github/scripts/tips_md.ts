/**
 * @file Generate .md files from ready .lang files
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

import { mkdirSync, readFileSync, writeFileSync } from 'node:fs'
import { dirname, parse } from 'node:path'
import { getLangNameFromCode } from 'language-name-map'
import { globSync } from 'tinyglobby'

const filePathes = globSync('resources/tips/lang/*_*.lang')
const getLinesRegex = /^e2ee.tips.[^=]+=(.*)$/gm
const langCodeRegex = /_.*/
const obfuscatedRegex = /§[km](.*?)(?:§r|$)/im
const coloredRegex = /§[0-9a-f](.*?)(?:§r|$)/im
const boldUnderlinedRegex = /§[ln](.*?)(?:§r|$)/im
const italicRegex = /§o(.*?)(?:§r|$)/im
const removeRRegex = /§r/g

if (!filePathes.length) {
  process.stderr.write('No .lang files found in resources/tips/lang/\n')
  process.exit(1)
}

for (const [i, langFileText] of filePathes.map(f => readFileSync(f, 'utf8')).entries()) {
  const lines = Array.from(
    langFileText.matchAll(getLinesRegex),
    s => `- ${mcToMd(s[1])}`
  )

  const langCode = parse(filePathes[i]).name
  const langName = getLangNameFromCode(langCode.replace(langCodeRegex, ''))?.name ?? ''
  if (!langName) {
    process.stderr.write(`Unknown language code: ${langCode}\n`)
    continue
  }

  const outPath = `Enigmatica2Expert-Extended.wiki/Tips/${langName}.md`
  mkdirSync(dirname(outPath), { recursive: true })
  writeFileSync(outPath, `${lines.join('\n')}\n`)
}

process.stdout.write(`Generated ${filePathes.length} markdown files\n`)

function mcToMd(text: string): string {
  let result = text
  let fresh = ''
  while (true) {
    fresh = result
      .replace(obfuscatedRegex, '~~$1~~§r')
      .replace(coloredRegex, '**$1**§r')
      .replace(boldUnderlinedRegex, '`$1`§r')
      .replace(italicRegex, '_$1_§r')
    if (fresh === result) return result.replace(removeRRegex, '')
    result = fresh
  }
}
