// Template for automatic Just Enough Resources files automation

// Regex for removing useless information about block drops
// from: ("block": "([^"]+)",\n.+\n.+)\n.+\n.+\n\s+"itemStack": "\2",\n\s+"fortunes": \{\n(\s+"\d+": 1(\.0)?,?\n){4}\s+\}\n\s+\}\n\s+\],
// to: $1

import { defineCommand, runMain } from 'citty'
import { consola } from 'consola'
import picomatch from 'picomatch'
import simplify from 'simplify-js'

import {
  config,
  loadJson,
  loadText,
  saveText,
} from '../lib/utils.js'

const ADD_META_RE = /(:[a-z]+)$/i
const MODIFY_DROP_RE = /Modify drop; Block: (?<block>.+) Drop: \[(?<stack>.+)\] (?<luck>\[.*\])/g
const PARSE_2D_ARRAY_RE_1 = /^\[|\]$/g
const PARSE_2D_ARRAY_RE_2 = /\],\s*\[/g
const PARSE_2D_ARRAY_RE_3 = /,\s*\]/g
const PARSE_2D_ARRAY_RE_4 = /\[,/g
const PARSE_2D_ARRAY_RE_5 = /\[(.*?)\]/
const SHORTEN_VALUE_RE_1 = /\.0+$/
const SHORTEN_VALUE_RE_2 = /([1-9])0+$/
const DIM_MATCH_RE = /^Dim (-?\d+): (.+)$/
const DISTRIB_RE = /;$/
const GET_ID_RE = /^[^:]+:[^:]+(?::\d+)?/
const FORTUNES_RE = /"fortunes": \{(\n[^}]+)\}/g
const SPACES_RE = /\s+/g

interface WorldGenEntry {
  block     : string
  dim       : string
  distrib   : string
  dropsList?: Drop[]
  silktouch?: boolean
}

interface Drop {
  fortunes : { 0?: number, 1?: number, 2?: number, 3?: number }
  itemStack: string
}

interface Args {
  removeif?: string
}

const main = defineCommand({
  meta: {
    name       : 'jer-automation',
    description: 'Automate Just Enough Resources world-gen.json',
  },
  args: {
    removeif: {
      type       : 'string',
      alias      : 'r',
      description: `
Filter entries matching key=glob (multiple rules separated by &&)
                               Example:
                                 npx tsx dev/automation/jer.ts --removeif="block=botania:mushroom* && dim=!(*[(]{0,-1,1}[)])"
`.trim(),
    },
  },
  run({ args: _args }) {
    const args = _args as unknown as Args
    const worldgenJsonPath = 'config/jeresources/world-gen.json'
    let worldGen = loadJson(worldgenJsonPath) as WorldGenEntry[]

    ///////////////////////////////////////////////////////////////////////
    // Populate manual entries
    ///////////////////////////////////////////////////////////////////////

    worldGen.splice(0, worldGen.length, ...worldGen.filter(o => o.dim !== 'Block Drops'))

    function addMeta(item: string) {
      return item.replace(ADD_META_RE, '$1:0')
    }

    function simple(input: string, outputs: string | string[], chances?: (number | number[])[]) {
      const chance = !chances
        ? [[]] as number[][]
        : (Array.isArray(chances[0]) ? chances : [chances]) as number[][]
      worldGen.push({
        block    : addMeta(input),
        distrib  : '0,1.0;255,1.0;',
        silktouch: false,
        dropsList: [outputs].flat().map((output, i) => ({
          itemStack: addMeta(output),
          fortunes : {
            0: chance[i % chance.length]?.[0] ?? 1,
            1: chance[i % chance.length]?.[1] ?? 1,
            2: chance[i % chance.length]?.[2] ?? 1,
            3: chance[i % chance.length]?.[3] ?? 1,
          },
        })),
        dim: 'Block Drops',
      })
    }

    simple('astralsorcery:blockgemcrystals:1', 'astralsorcery:itemperkgem:2')
    simple('astralsorcery:blockgemcrystals:2', 'astralsorcery:itemperkgem:0')
    simple('astralsorcery:blockgemcrystals:3', 'astralsorcery:itemperkgem:1')
    simple('biomesoplenty:grass', 'minecraft:end_stone')
    simple('botania:enchanter', 'minecraft:lapis_block')
    simple('buildinggadgets:constructionblock_dense:0', 'buildinggadgets:constructionpaste:0', [9, 9, 9, 9])
    simple('buildinggadgets:constructionblock:0', 'buildinggadgets:constructionpaste:0', [6, 6, 6, 6])
    simple('extrautils2:ironwood_leaves:1', ['minecraft:blaze_powder', 'extrautils2:ironwood_sapling:1'], [0.2, 0.4, 0.8, 0.9])
    simple('extrautils2:ironwood_leaves', 'extrautils2:ironwood_sapling')
    simple('extrautils2:ironwood_log', 'extrautils2:ironwood_planks')
    simple('forestry:bog_earth:3', 'forestry:peat')
    simple('ic2:sheet', 'ic2:misc_resource:4')
    simple('iceandfire:chared_grass_path', 'iceandfire:chared_dirt')
    simple('iceandfire:frozen_grass_path', 'iceandfire:frozen_dirt')
    simple('iceandfire:jar_pixie', 'iceandfire:jar_empty')
    simple('lootr:lootr_trapped_chest', 'minecraft:trapped_chest')
    simple('mekanism:saltblock', 'mekanism:salt', [4, 4, 4, 4])
    simple('minecraft:vine', 'rustic:grape_stem')
    simple('mysticalagriculture:end_inferium_ore', 'mysticalagriculture:crafting:0')
    simple('mysticalagriculture:end_prosperity_ore', 'mysticalagriculture:crafting:5')
    simple('mysticalagriculture:inferium_ore', 'mysticalagriculture:crafting:0')
    simple('mysticalagriculture:nether_inferium_ore', 'mysticalagriculture:crafting:0')
    simple('mysticalagriculture:nether_prosperity_ore', 'mysticalagriculture:crafting:5')
    simple('mysticalagriculture:prosperity_ore', 'mysticalagriculture:crafting:5')
    simple('mysticalagriculture:soulstone', 'mysticalagriculture:soulstone:1')
    simple('rustic:leaves_apple', 'rustic:sapling_apple')
    simple('scalinghealth:crystalore', 'scalinghealth:crystalshard')
    simple('tconstruct:slime_leaves', 'tconstruct:slime_sapling')
    simple('twilightforest:magic_log_core:0', 'twilightforest:magic_log:0')
    simple('twilightforest:magic_log_core:1', 'twilightforest:magic_log:1')
    simple('twilightforest:magic_log_core:2', 'twilightforest:magic_log:2')
    simple('twilightforest:magic_log_core:3', 'twilightforest:magic_log:3')
    simple('minecraft:mob_spawner', ['enderio:item_broken_spawner', 'actuallyadditions:item_misc:20'])
    simple('endreborn:crop_ender_flower', 'minecraft:ender_pearl')
    simple('bloodmagic:demon_crystal', 'bloodmagic:item_demon_crystal')
    simple('exnihilocreatio:block_infested_leaves', 'minecraft:string', [2, 2, 2, 2])
    simple('contenttweaker:ore_anglesite', 'contenttweaker:anglesite', [1, 1.5, 2.0, 2.5])
    simple('contenttweaker:ore_benitoite', 'contenttweaker:benitoite', [1, 1.5, 2.0, 2.5])
    simple('randomthings:spectreleaf', ['randomthings:spectresapling', 'randomthings:ingredient:2'])
    simple('randomthings:beanpod', [
      'biomesoplenty:gem:1',
      'biomesoplenty:gem:2',
      'biomesoplenty:gem:3',
      'biomesoplenty:gem:4',
      'biomesoplenty:gem:5',
      'biomesoplenty:gem:6',
      'randomthings:ingredient:11',
      'minecraft:iron_ingot',
      'minecraft:gold_ingot',
      'minecraft:emerald',
      'randomthings:beans',
    ], [
      [0.5, 0.5, 0.5, 0.5],
      [0.5, 0.5, 0.5, 0.5],
      [0.5, 0.5, 0.5, 0.5],
      [0.5, 0.5, 0.5, 0.5],
      [0.5, 0.5, 0.5, 0.5],
      [0.5, 0.5, 0.5, 0.5],
      [8, 12, 16, 20],
      [4, 7, 11, 15],
      [0.5, 1, 1.5, 2],
      [4, 5, 7, 8],
    ])

    simple('thaumcraft:stone_porous', [
      'minecraft:gravel',
      'thaumcraft:amber',
      'thaumcraft:cluster',
      'thaumcraft:cluster:2',
      'thaumcraft:cluster:3',
      'thaumcraft:cluster:5',
      'thaumcraft:cluster:6',
      'thaumcraft:cluster:4',
    ], [
      [0.80, 0.60, 0.40, 0.20],
      [0.05, 0.10, 0.15, 0.20],
      [0.05, 0.11, 0.16, 0.22],
      [0.04, 0.08, 0.12, 0.16],
      [0.04, 0.08, 0.12, 0.16],
      [0.03, 0.06, 0.09, 0.12],
      [0.03, 0.06, 0.09, 0.12],
      [0.03, 0.05, 0.08, 0.11],
    ])

    simple('thaumcraft:stone_porous', [
      'thaumcraft:cluster:1',
      'minecraft:clay_ball',
      'minecraft:quartz',
      'minecraft:redstone',
      'minecraft:emerald',
      'minecraft:prismarine_shard',
      'minecraft:prismarine_crystals',
      'minecraft:diamond',
    ], [
      [0.022, 0.044, 0.066, 0.088],
      [0.064, 0.128, 0.192, 0.256],
      [0.037, 0.074, 0.111, 0.148],
      [0.033, 0.066, 0.099, 0.132],
      [0.009, 0.018, 0.027, 0.036],
      [0.008, 0.016, 0.024, 0.032],
      [0.007, 0.014, 0.021, 0.028],
      [0.003, 0.006, 0.009, 0.012],
    ])

    for (let i = -1; i < 16; i++) {
      simple(
        `minecraft:${i === -1 ? '' : 'stained_'}glass:${Math.max(0, i)}`,
        `quark:glass_shards:${i + 1}`,
        [2, 3, 4, 4]
      )
    }

    const harvestcraftData = config('config/harvestcraft.cfg')!.drops as Record<string, string>

    for (const garden of [
      'aridGarden',
      'frostGarden',
      'shadedGarden',
      'soggyGarden',
      'tropicalGarden',
      'windyGarden',
    ]) {
      const list = harvestcraftData[garden]
      simple(`harvestcraft:${garden.toLowerCase()}`, list, [1, 1, 1, 1].fill(2.0 / list.length))
    }

    ;[...loadText('crafttweaker.log').matchAll(MODIFY_DROP_RE)].forEach((m) => {
      const { block, stack, luck } = m.groups ?? {}
      if (block && stack && luck)
        simple(block, stack.split(', '), parse2DArray(luck).slice(0, 4).map(([o]) => o))
    })

    function parse2DArray(input: string): number[][] {
      // Normalize the input string
      const normalized = input
        .trim()
        .replace(PARSE_2D_ARRAY_RE_1, '') // remove leading/trailing brackets
        .replace(PARSE_2D_ARRAY_RE_2, '];[') // normalize separators
        .replace(PARSE_2D_ARRAY_RE_3, ']') // remove trailing commas before closing bracket
        .replace(PARSE_2D_ARRAY_RE_4, '[') // fix empty entries like "[,2,2]" => "[2,2]"

      // Split the string into subarrays
      const arrayStrings = normalized
        .split(';')
        .map(str => str.trim())
        .filter(str => str.length > 0)

      // Parse each subarray
      const result: number[][] = arrayStrings.map((sub) => {
        const match = sub.match(PARSE_2D_ARRAY_RE_5)
        if (!match) throw new Error(`Invalid format in segment: ${sub} for input: ${input}`)
        const elements = match[1]
          .split(',')
          .map(el => el.trim())
          .filter(el => el !== '')
          .map(el => Number(el))
        return elements
      })

      return result
    }

    ///////////////////////////////////////////////////////////////////////
    // Cleanup
    ///////////////////////////////////////////////////////////////////////

    function shortenValue(v:number) {
      if (!v) return String(v)
      const list = [
        v.toPrecision(2).replace(SHORTEN_VALUE_RE_1, '').replace(SHORTEN_VALUE_RE_2, '$1'),
        v.toExponential(1),
      ].sort((a, b) => a.length - b.length)
      return list[0]
    }

    worldGen.forEach((wg) => {
      const dimMatch = wg.dim.match(DIM_MATCH_RE)
      if (dimMatch) {
        const [, dimNum, dimName] = dimMatch
        wg.dim = `${dimName.trim()} (${dimNum})`
      }

      // Remove default silk touch value
      if (wg.silktouch === false) delete wg.silktouch

      // Descrease the precision
      const levels = wg.distrib
        .replace(DISTRIB_RE, '')
        .split(';')
        .map(s => s.split(',').map(Number) as [number, number])
        // .map(([l, v]) => [l, shortenValue(v)])

      wg.distrib = clenDistrib(clenDistrib(clenDistrib(simplifyDistrib(levels))))
        .map(l => l.join(','))
        .join(';')

      wg.dropsList?.forEach((d) => {
        // Descrease precision of fortunes
        ([0, 1, 2, 3] as const).filter(n => d.fortunes[n]).forEach((n) => {
          const v = d.fortunes[n]
          if (v !== undefined) d.fortunes[n] = Number(v.toPrecision(2))
        })

        if (Object.entries(d.fortunes).every((v, _, arr) => v[1] === arr[0][1])) {
          d.fortunes = Object.fromEntries([Object.entries(d.fortunes)[0]])
        }

        if (!Object.values(d.fortunes).length)
          delete (d as Partial<Drop>).fortunes
      })

      // Clean Remove Drop List
      if (wg.dropsList?.length) {
        wg.dropsList = wg.dropsList.filter((d, _, arr) => !(
          // Remove air
          d.itemStack === 'minecraft:air:0'

          // Remove same block
          || (
            d.itemStack === wg.block && (
              fortuneSame(d.fortunes)
              || (
                arr.length === 1
                && d.fortunes
                && Object.keys(d.fortunes).length === 1
                && d.fortunes['0'] === 1)
            )
          )
        ))

        // Remove same item with different NBT tags flooding drops
        const groups:{ [id: string]: Drop[] } = {}
        wg.dropsList.forEach(d => (groups[getID(d.itemStack)] ??= []).push(d))
        Object.entries(groups).forEach(([id, d]) => {
          if (d.length > 1 && wg.dropsList!.length > 8) {
            groups[id] = [{ ...d[0], itemStack: id }]
          }
        })
        wg.dropsList = Object.entries(groups).map(([_, d]) => d).flat()

        // if (wg.dropsList.length > 8) console.log('Too big dropsList: ', wg.dropsList.length, wg.block)

        if (!wg.dropsList.length) delete wg.dropsList
      }
    })

    function getID(itemStack:string) {
      const m = itemStack.match(GET_ID_RE)
      if (!m) throw new Error(`No ID for item: ${itemStack}`)
      return m[0]
    }

    function fortuneSame(fortunes: Drop['fortunes']) {
      return  ([0, 1, 2, 3] as const).map(n => fortunes[n]).every((v, _, arr) => v === arr[0])
    }

    function clenDistrib(arr: [number, string][]) {
      if (arr.length < 3) return arr // nothing to remove

      const result = [arr[0]]

      for (let i = 1; i < arr.length - 1; i++) {
        const [al, av] = arr[i - 1].map(Number)
        const [bl, bv] = arr[i].map(Number)
        const [cl, cv] = arr[i + 1].map(Number)

        // Point in the middle of surroundings
        const sameLevel = (al + cl) / 2 === bl
        const targetv = (av + cv) / 2
        if (sameLevel && targetv === bv) continue

        // Skip if difference less than 2%
        if (sameLevel && Math.abs((targetv - bv) / bv) <= 0.02) continue

        result.push(arr[i])
      }

      const last = arr.at(-1)
      if (last) result.push(last)
      return result
    }

    function simplifyDistrib(distrib: [number, number | string][]) {
      const maxV = Math.max(...distrib.map(([,v]) => Number(v)))
      const mult = 80 / maxV // Size of graph is 128:40

      const simplified = simplify(
        distrib.map(([l, v]) => ({ x: l, y: Number(v) * mult })),
        0.9,
        true
      )

      return simplified.map(o => [o.x, shortenValue(o.y / mult)] as [number, string])
    }

    ///////////////////////////////////////////////////////////////////////
    // CLI Filtering
    ///////////////////////////////////////////////////////////////////////
    if (args.removeif) {
      const filters = args.removeif.split('&&').map((f) => {
        const [key, ...patternParts] = f.trim().split('=')
        const pattern = patternParts.join('=')
        return { key, isMatch: picomatch(pattern) }
      })

      const initialCount = worldGen.length
      worldGen = worldGen.filter((entry) => {
        const matchesAll = filters.every((f) => {
          const val = (entry as unknown as Record<string, unknown>)[f.key]
          return f.isMatch(String(val ?? ''))
        })
        if (matchesAll) {
          consola.info(`Filtering out entry: ${entry.block} in ${entry.dim}`)
          return false
        }
        return true
      })
      const removedCount = initialCount - worldGen.length
      if (removedCount > 0)
        consola.success(`Removed ${removedCount} entries based on filters.`)
      else
        consola.warn('No entries matched the provided filters.')
    }

    const stringified = `${JSON.stringify(worldGen, null, 2).trimEnd()}\n`
      .replace(FORTUNES_RE, (m, r: string) => `"fortunes": {${r.replace(SPACES_RE, ' ')}}`)

    ///////////////////////////////////////////////////////////////////////
    saveText(stringified, worldgenJsonPath)
    consola.success('world-gen.json updated successfully.')
  },
})

void runMain(main)
