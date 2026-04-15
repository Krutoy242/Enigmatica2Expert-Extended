/*
  Search for aspect lists in all .zs files
  and replace them with Emoji lists as defined in globals.zs
*/

/* eslint-disable no-cond-assign */
/* eslint-disable regexp/no-super-linear-backtracking */
import * as fs from 'node:fs'

import { consola } from 'consola'
import { replaceInFile } from 'replace-in-file'

const ASPECT_EMOJI_MAP_REGEX = /static emojiMap as CTAspectStack\[string\] = \{([\s\S]*?)\};/
const ASPECT_ENTRY_REGEX = /'([^']+)': (?:<aspect:(\w+)>|Aspect\.(\w+))/g
const ASPECT_REF_REGEX = /(?:<aspect:(\w+)>|Aspect\.(\w+))(?:\s*\*\s*(\d+))?/
const ASPECT_BRACKET_REGEX = /\[((?:\s*<?(?:aspect:|Aspect\.)\w+>?\s*(?:\*\s*\d+\s*)?,?)+)\]/gi

const aspectToEmojiMap = new Map<string, string>()

function parseAspectEmojiMap() {
  const content = fs.readFileSync('scripts/mods/thaumcraft/aspect/emoji.zs', 'utf-8')
  const emojiMapContent = content.match(ASPECT_EMOJI_MAP_REGEX)
  if (!emojiMapContent) {
    throw new Error('Could not find emojiMap in thaumcraft/aspect/emoji.zs')
  }

  let match: null | RegExpExecArray
  while ((match = ASPECT_ENTRY_REGEX.exec(emojiMapContent[1])) !== null) {
    const emoji = match[1]
    const aspectName = match[2] || match[3]
    aspectToEmojiMap.set(aspectName.toLowerCase(), emoji)
  }
}

function aspectsToString(aspects: string): string {
  const aspectParts = aspects.split(',').map(s => s.trim()).filter(s => s)
  const emojiStrings = aspectParts.map((part) => {
    const match = part.match(ASPECT_REF_REGEX)
    if (match) {
      const aspectName = (match[1] || match[2]).toLowerCase()
      const amount = match[3] ? Number.parseInt(match[3], 10) : 1
      const emoji = aspectToEmojiMap.get(aspectName)

      if (!emoji) {
        consola.warn(`Emoji not found for aspect: ${aspectName}`)
        return ''
      }
      return amount === 1 ? emoji : `${amount}${emoji}`
    }
    return ''
  })

  return emojiStrings.filter(s => s).join(' ')
}

async function run() {
  try {
    parseAspectEmojiMap()

    const results = await replaceInFile({
      files: 'scripts/**/*.zs',
      from : ASPECT_BRACKET_REGEX,
      to   : (_m: string, aspects: string) => `Aspects('${aspectsToString(aspects)}')`,
    })

    const changedFiles = results
      .filter(result => result.hasChanged)
      .map(result => result.file)

    consola.info(`Scanned ${results.length} files`)

    if (changedFiles.length > 0) {
      consola.success(`Successfully refactored ${changedFiles.length} files:\n- ${changedFiles.join('\n- ')}`)
    }
    else {
      consola.info('No files needed refactoring.')
    }
  }
  catch (error) {
    consola.error('An error occurred:', error)
  }
}

void run()
