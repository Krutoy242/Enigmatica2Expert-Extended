/**
 * @file Misc automation of modpack
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

import { existsSync, readFileSync } from 'node:fs'
import { join, parse } from 'node:path'
import { consola } from 'consola'

import fast_glob from 'fast-glob'

import {
  loadJson,
  loadText,
  naturalSort,
  saveText as rawSaveText,
} from '../lib/utils.js'

// Shadow saveText/saveObjAsJson so every write keeps the destination's existing EOL — avoids flooding git diffs.
function saveText(content: string, filename: string): void {
  const eol = existsSync(filename) && readFileSync(filename, 'utf8').includes('\r\n') ? '\r\n' : '\n'
  rawSaveText(content.replace(/\r?\n/g, eol), filename)
}

function saveObjAsJson(obj: Record<string, any>, filename: string): void {
  saveText(JSON.stringify(obj, null, 2), filename)
}

const rgxOfQuality = /\r?\nof(?:AnimatedWater|AnimatedLava|AnimatedFire|AnimatedPortal|AnimatedRedstone|AnimatedExplosion|AnimatedFlame|AnimatedSmoke|VoidParticles|WaterParticles|PortalParticles|PotionParticles|FireworkParticles|DrippingWaterLava|AnimatedTerrain|AnimatedTextures|RainSplash):\w+/g
const rgxPlayerRanks = /\n\/\/ .*\n\[\w+\]\n(?:[\w.]+: .*\n)*/g
const rgxSplitColon = /:(.*)/s
const rgxCrafttweakerLog = /Save this into file "(?<file>[^"]+)"\r?\n(?<content>[\s\S]+?)(?=\r?\n(?:\[\w+\]){3} )/g

export async function init() {
  // ###############################################################################
  // ###############################################################################
  // ###############################################################################

  /*

    Save default options

  */
  consola.start('Saving default options')
  const moreDefOptsPath = 'config/MoreDefaultOptions/'

  interface MDOptions {
    sourceFilePath     : string
    destinationFilePath: string
    clientSide         : boolean
    serverSide         : boolean
  }

  const mdoJson = loadJson('config/MoreDefaultOptions.json') as MDOptions[]
  mdoJson.forEach((o) => {
    const dest = join(moreDefOptsPath, o.sourceFilePath)

    const fileContent = loadText(o.destinationFilePath)
    const optionsTransformers: Record<string, () => void> = {
      'default': () => saveText(fileContent, dest),

      // Remove config lines
      'optionsof.txt': () => {
        saveText(fileContent
          .replace(rgxOfQuality, ''), dest)
      },

      // Remove current player ranks
      'ranks.txt': () => {
        saveText(fileContent
          .replace(rgxPlayerRanks, ''), dest)
      },

      'options.txt': () => {
        // Merge keys — normalize CRLF so values don't carry stray '\r'
        const normalize = (t: string) => t.replace(/\r\n/g, '\n')
        const entriesArray = normalize(fileContent).split('\n').map(l => l.split(rgxSplitColon) as [string, string])
        let entries: Record<string, string> = Object.fromEntries(entriesArray)

        const oldDestEntries: Record<string, string> = Object.fromEntries(normalize(loadText(dest)).split('\n').map(l => l.split(rgxSplitColon) as [string, string]))

        // Filter out dark mode resource pack
        if (entries.resourcePacks) {
          const resourcePacks = JSON.parse(entries.resourcePacks) as string[]
          entries.resourcePacks = JSON.stringify(resourcePacks.filter(p => !p.startsWith('Dark Mode-')))
        }

        entries = {
          ...oldDestEntries,
          ...entries,
        }

        const finalEntries = Object.entries(entries).filter(([k]) => ![
          'difficulty',
          'lastServer',
          'renderClouds',
          'renderDistance',
        ].includes(k))

        // Sort keys
        finalEntries
          .sort(([a], [b]) => [a, b].every(l => l.startsWith('key_')) ? naturalSort(a, b) : 0)

        saveText(finalEntries.map(([k, v]) => k ? `${k}:${v}` : '').join('\n'), dest)
      },
    }
    ;(optionsTransformers[o.sourceFilePath] ?? optionsTransformers.default)()
  })

  // ###############################################################################
  // ###############################################################################
  // ###############################################################################

  /*

    Heavy Sieve automatically recipes

  */
  consola.start('Heavy Sieve automatically recipes')
  const blocksToCopy = [
    ['biomesoplenty:dried_sand', 'contenttweaker:compressed_dried_sand'],
    ['quark:gravisand', 'contenttweaker:compressed_gravisand'],
    ['minecraft:sand:1', 'contenttweaker:compressed_red_sand'],
    ['biomesoplenty:white_sand', 'contenttweaker:compressed_white_sand'],
    ['exnihilocreatio:block_skystone_crushed', 'contenttweaker:compressed_crushed_skystone'],
    ['rats:garbage_pile', 'contenttweaker:compressed_garbage_pile'],
    ['enderio:block_infinity', 'enderio:block_infinity:1'],
  ]
  interface SieveReward {
    drop     : { nbt?: unknown, name: string, meta: number }
    meshLevel: number
    chance   : number
  }
  interface HeavySieveEntry {
    name    : string
    metadata: number
    type    : string
    rewards : any[]
  }
  const sieveRegistry = loadJson('config/exnihilocreatio/SieveRegistry.json') as Record<string, SieveReward[]>
  const heavySievePath = 'config/ExCompressum/HeavySieve.json'
  const heavySieve = loadJson(heavySievePath) as { custom: { entries: HeavySieveEntry[] } }
  for (const [normal, compressed] of blocksToCopy) {
    if (!normal || !compressed) continue
    const normEntry = sieveRegistry[normal] ?? sieveRegistry[`${normal}:0`]
    if (!normEntry) {
      consola.warn(`Cant add Heavy Sieve recipe: Cant find normal entry: ${normal}\n`)
      continue
    }
    const entries = heavySieve.custom.entries
    const [source, id, _meta] = compressed.split(':')
    const shortand = `${source}:${id}`
    const meta = Number(_meta || '0')
    const index = entries.findIndex(
      o => o.name === shortand && o.metadata === meta
    )
    const found = entries[index] as HeavySieveEntry | undefined

    const entry: HeavySieveEntry = {
      ...found ?? { name: shortand, metadata: meta, type: 'list', rewards: [] },
      ...{
        name    : shortand,
        metadata: meta,
        type    : 'list',
        rewards : normEntry
          .filter(o => !o.drop.nbt)
          .map(o => ({
            meshLevel: o.meshLevel,
            name     : o.drop.name,
            metadata : o.drop.meta,
            tag      : o.drop.nbt,
            count    : 1,
            luck     : 0.0,
            chance   : o.chance,
            rolls    : 1,
          })),
      },
    }

    if (index !== -1) entries[index] = entry
    else entries.push(entry)
  }
  saveObjAsJson(heavySieve, heavySievePath)

  // ###############################################################################
  // ###############################################################################
  // ###############################################################################

  /*

    Save files from crafttweaker.log

  */

  const saveMap: Record<string, string> = {}
  for (const match of loadText('crafttweaker.log').matchAll(rgxCrafttweakerLog)) {
    if (match.groups) {
      const { file, content } = match.groups
      if (file && content) {
        saveMap[file] = content
      }
    }
  }
  Object.keys(saveMap).forEach(f => saveText(saveMap[f], f))

  // ###############################################################################
  // ###############################################################################
  // ###############################################################################

  /*

    Add all screenshots in folder to config

  */

  const menuFile = 'config/CustomMainMenu/mainmenu.json'
  interface MenuJson {
    other: { background: { slideshow: { images: string[] } } }
  }
  const menuJson = loadJson(menuFile) as MenuJson
  menuJson.other.background.slideshow.images = [
    ...fast_glob.sync(
      'resources/enigmatica/textures/slideshow/*.jpg',
      { dot: true }
    ).map(f => `enigmatica:textures/slideshow/${parse(f).base}`),
    ...menuJson.other.background.slideshow.images.filter(img => img.startsWith('web:')),
  ]
  saveText(`${JSON.stringify(menuJson, null, 2)}\n`, menuFile)

  // ###############################################################################
  // ###############################################################################
  // ###############################################################################
  consola.success('Misc automation complete')
}

if (import.meta.main) void init()
