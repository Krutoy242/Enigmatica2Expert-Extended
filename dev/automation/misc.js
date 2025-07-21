/**
 * @file Misc automation of modpack
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

// @ts-check

import { join, parse } from 'node:path'
import process from 'node:process'

import * as del from 'del'
import fast_glob from 'fast-glob'
import yargs from 'yargs'

import {
  defaultHelper,
  injectInFile,
  loadJson,
  loadText,
  naturalSort,
  saveObjAsJson,
  saveText,
} from '../lib/utils.js'

const argv = yargs(process.argv.slice(2))
  .alias('k', 'keep-cache')
  .describe('k', 'Not delete cached files')
  .argv

export async function init(h = defaultHelper, options = argv) {
  // ###############################################################################
  // ###############################################################################
  // ###############################################################################

  // Fake iron automatic recipes
  // Inspecting all recipes to automatically change some of them
  // Required command before running
  // /ct recipes

  const globMatch = loadText('crafttweaker.log').match(/^Recipes:$.*/ms)

  // Add already exist remakes
  const fakeIron_zs = loadText('scripts/mods/enderio_fakeIron.zs')
  let remakes

  if (!globMatch) {
    h.warn('No /ct recipes found in crafttweaker.log')
  }
  else {
    remakes = fakeIron_zs.match(/^(?:#|\/\/) Start of automatically generated recipes:$.*/ms)?.[0]
    if (!remakes)
      h.warn('Can not find automatically generated recipes for Fake Iron')
  }

  const resultArr = []
  if (globMatch && remakes) {
    const recipes = globMatch[0]
    const whitelist = [
      '<extrautils2:opinium>',
      '<extrautils2:opinium:1>',
      '<immersiveengineering:drillhead:1>',
      '<excompressum:auto_compressor>',
      '<integrateddynamics:squeezer>',
      '<ic2:crafting:18>',
      '<extrautils2:spike_iron>',
      '<environmentaltech:lightning_rod>',
      '<environmentaltech:lightning_cont_6>',
      '<environmentaltech:lightning_cont_5>',
      '<environmentaltech:lightning_cont_4>',
      '<environmentaltech:lightning_cont_3>',
      '<environmentaltech:lightning_cont_2>',
      '<environmentaltech:lightning_cont_1>',
      '<extendedcrafting:table_basic>',
      '<rustic:condenser_advanced>',
      '<draconicevolution:crafting_injector>',
      '<cyclicmagic:fluid_drain>',
    ]

    for (const match of remakes.matchAll(
      /^remakeShape.{1,4}\(["'][^"']+["'], (?<output><[^>]+>).*$/gm
    )) {
      if (match.groups && whitelist.includes(match.groups.output))
        resultArr.push(match[0])
    }

    // Add new
    for (const match of recipes.matchAll(
      /^(?<function>recipes\.addShape(?<postfix>d|less))\((?<name>".*?") *, *(?<output>[^, ]*)(?<count> \* \d+)?, (?<grid>.*)\);$/gm
    )) {
      const g = match.groups

      const regex = /<(minecraft:iron_|ore:)(ingot|block|nugget)(?:Iron)?>/gi
      if (
        !g
        || !whitelist.includes(g.output)
        || !g.grid.match(new RegExp(`.*${regex.source}.*`))
      ) {
        continue
      }

      const replacedGrid = g.grid.replace(regex, (...args) =>
        args[2].substring(0, 1).toUpperCase())
      const line = `remakeShape${g.postfix}(${g.name}, ${g.output}${
        g.count ?? ''
      }, ${replacedGrid});`
      resultArr.push(line)
    }

    injectInFile(
      'scripts/mods/enderio_fakeIron.zs',
      '// Start of automatically generated recipes:\n',
      '\n// End of automatically generated recipes',
      resultArr.sort().join('\n')
    )
  }

  // ###############################################################################
  // ###############################################################################
  // ###############################################################################

  let countCachedRemoved
  if (!options['keep-cache']) {
    await h.begin('Removing cached files')
    countCachedRemoved = del.deleteSync(
      ['config/thaumicjei_itemstack_aspects.json'],
      { dryRun: false }
    ).length
  }

  // ###############################################################################
  // ###############################################################################
  // ###############################################################################

  /*

    Save default options

  */
  await h.begin('Saving default options')
  const moreDefOptsPath = 'config/MoreDefaultOptions/'

  /**
   * @typedef MDOptions
   * @property {string} sourceFilePath "menu.json"
   * @property {string} destinationFilePath "minemenu/menu.json"
   * @property {boolean} clientSide true
   * @property {boolean} serverSide false
   */

  /** @type {MDOptions[]} */
  const mdoJson = loadJson('config/MoreDefaultOptions.json')
  mdoJson.forEach((o) => {
    const dest = join(moreDefOptsPath, o.sourceFilePath)

    const fileContent = loadText(o.destinationFilePath)
    const optionsTransformers = {
      'default': () => saveText(fileContent, dest),

      // Remove config lines
      'optionsof.txt': () => {
        saveText(fileContent
          .replace(/\nofAnimatedTerrain:false/g, '\nofAnimatedTerrain:true'), dest)
      },

      // Remove current player ranks
      'ranks.txt': () => {
        saveText(fileContent
          .replace(/\n\/\/ .*\n\[\w+\]\n([\w.]+: .*\n)*/g, ''), dest)
      },

      'options.txt': () => {
        // Merge keys
        let entries = Object.entries({
          ...Object.fromEntries(loadText(dest).split('\n').map(l => l.split(/:(.*)/s))),
          ...Object.fromEntries(fileContent.split('\n').map(l => l.split(/:(.*)/s))),
        })

        entries = entries.filter(([k]) => ![
          'difficulty',
          'renderDistance',
        ].includes(k))

        // Sort keys
        entries
          .sort(([a], [b]) => [a, b].every(l => l.startsWith('key_')) ? naturalSort(a, b) : 0)

        saveText(entries.map(([k, v]) => k ? `${k}:${v}` : '').join('\n'), dest)
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
  await h.begin('Heavy Sieve automatically recipes')
  const blocksToCopy = [
    ['biomesoplenty:dried_sand', 'contenttweaker:compressed_dried_sand'],
    ['quark:gravisand', 'contenttweaker:compressed_gravisand'],
    ['minecraft:sand:1', 'contenttweaker:compressed_red_sand'],
    ['biomesoplenty:white_sand', 'contenttweaker:compressed_white_sand'],
    ['exnihilocreatio:block_skystone_crushed', 'contenttweaker:compressed_crushed_skystone'],
    ['rats:garbage_pile', 'contenttweaker:compressed_garbage_pile'],
    ['enderio:block_infinity', 'enderio:block_infinity:1'],
  ]
  const sieveRegistry = loadJson('config/exnihilocreatio/SieveRegistry.json')
  const heavySievePath = 'config/ExCompressum/HeavySieve.json'
  const heavySieve = loadJson(heavySievePath)
  blocksToCopy.forEach(([normal, compressed]) => {
    const normEntry = sieveRegistry[normal] ?? sieveRegistry[`${normal}:0`]
    if (!normEntry) {
      h.warn(`Cant add Heavy Sieve recipe: Cant find normal entry: ${normal}\n`)
      return
    }
    const entries = heavySieve.custom.entries
    const [source, id, _meta] = compressed.split(':')
    const shortand = `${source}:${id}`
    const meta = Number(_meta || '0')
    const index = entries.findIndex(
      o => o.name === shortand && o.metadata === meta
    )
    const found = entries[index]

    const entry = {
      ...found ?? {},
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
  })
  saveObjAsJson(heavySieve, heavySievePath)

  // ###############################################################################
  // ###############################################################################
  // ###############################################################################

  /*

    Save files from crafttweaker.log

  */

  const saveMap = {}
  for (const match of loadText('crafttweaker.log').matchAll(/Save this into file "(?<file>[^"]+)"\r?\n(?<content>[\s\S]+?)(?=\r?\n(?:\[\w+\]){3} )/g)) {
    // @ts-ignore
    const {file, content} = match.groups
    saveMap[file] = content
  }
  Object.keys(saveMap).forEach(f => saveText(saveMap[f], f))

  // ###############################################################################
  // ###############################################################################
  // ###############################################################################

  /*

    Add all screenshots in folder to config

  */

  const menuFile = 'config/CustomMainMenu/mainmenu.json'
  const menuJson = loadJson(menuFile)
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
  h.result(
    `Saved fakeIron recipes: ${resultArr.length}${
      countCachedRemoved ? `, Removed cached: ${countCachedRemoved}` : ''}`
  )
}

if (
  import.meta.url === (await import('node:url')).pathToFileURL(process.argv[1]).href
)
  init()
