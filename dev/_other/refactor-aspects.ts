/* eslint-disable no-cond-assign */
/* eslint-disable regexp/no-super-linear-backtracking */
import * as fs from 'node:fs'

import { consola } from 'consola'
import { replaceInFile } from 'replace-in-file'

const aspectToEmojiMap = new Map<string, string>()

function parseAspectEmojiMap() {
  const content = fs.readFileSync('scripts/mods/thaumcraft/aspect.zs', 'utf-8')
  const emojiMapContent = content.match(/static emojiMap as CTAspectStack\[string\] = \{([\s\S]*?)\};/)
  if (!emojiMapContent) {
    throw new Error('Could not find emojiMap in aspect.zs')
  }

  const regex = /'([^']+)': (?:<aspect:(\w+)>|Aspect\.(\w+))/g
  let match: null | RegExpExecArray
  while ((match = regex.exec(emojiMapContent[1])) !== null) {
    const emoji = match[1]
    const aspectName = match[2] || match[3]
    aspectToEmojiMap.set(aspectName.toLowerCase(), emoji)
  }
}

function aspectsToString(aspects: string): string {
  const aspectParts = aspects.split(',').map(s => s.trim()).filter(s => s)
  const emojiStrings = aspectParts.map((part) => {
    const match = part.match(/(?:<aspect:(\w+)>|Aspect\.(\w+))(?:\s*\*\s*(\d+))?/)
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
      from : /\[((?:\s*<?(?:aspect:|Aspect\.)\w+>?\s*(?:\*\s*\d+\s*)?,?)+)\]/gi,
      to   : (_m: string, aspects: string) => `Aspects('${aspectsToString(aspects)}')`,
    })

    const changedFiles = results
      .filter(result => result.hasChanged)
      .map(result => result.file)

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
