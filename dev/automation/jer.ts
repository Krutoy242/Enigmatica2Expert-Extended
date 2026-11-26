// Template for automatic Just Enough Resources files automation

// Regex for removing useless information about block drops
// from: ("block": "([^"]+)",\n.+\n.+)\n.+\n.+\n\s+"itemStack": "\2",\n\s+"fortunes": \{\n(\s+"\d+": 1(\.0)?,?\n){4}\s+\}\n\s+\}\n\s+\],
// to: $1

import { existsSync } from 'node:fs'

import { defineCommand, runMain } from 'citty'
import { consola } from 'consola'
import picomatch from 'picomatch'
import simplify from 'simplify-js'
import { globSync } from 'tinyglobby'

import {
  config,
  escapeRegex,
  loadJson,
  loadText,
  saveText,
} from '../lib/utils.js'

const HAS_NO_META_RE = /^[^:]+:[^:]+$/
const MODIFY_DROP_RE = /Modify drop; Block: (?<block>.+) Drop: \[(?<stack>.+)\] (?<luck>\[.*\])/
const PARSE_2D_ARRAY_RE_1 = /^\[|\]$/g
const PARSE_2D_ARRAY_RE_2 = /\],\s*\[/g
const PARSE_2D_ARRAY_RE_3 = /,\s*\]/g
const PARSE_2D_ARRAY_RE_4 = /\[,/g
const PARSE_2D_ARRAY_RE_5 = /\[(.*?)\]/
const DIM_MATCH_RE = /^Dim (-?\d+): (.+)$/
const CT_ERROR_RE = /^(?:\[[^\]]+\])*\[(?:ERROR|FATAL)\]/m
const CT_INIT_RE = /^\[INITIALIZATION\]/m
const CT_COMPLETE_RE = /^\[(?:AVAILABLE|SERVER_STARTING|SERVER_STARTED)\]/m
const HARVESTCRAFT_GARDENS = [
  'aridGarden',
  'frostGarden',
  'shadedGarden',
  'soggyGarden',
  'tropicalGarden',
  'windyGarden',
] as const

function buildDroptSkippedRe(): RegExp | null {
  const relScripts = globSync('scripts/**/*.zs')
    .map(p => p.replace(/\\/g, '/'))
    .filter(p => p === 'scripts/lib/dropt.zs' || loadText(p).includes('dropt.addDrop'))
    .map(p => escapeRegex(p.replace(/^scripts\//, '')).replace(/\\\//g, '[/\\\\]'))
  if (!relScripts.length) return null
  return new RegExp(`Ignoring script \\{[^}]*:\\s*(?:${relScripts.join('|')})\\}`)
}
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
                                 pnpm tsx dev/automation/jer.ts --removeif="block=botania:mushroom* && dim=!(*[(]{0,-1,1}[)])"
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

    function addMeta(item: string) {
      return HAS_NO_META_RE.test(item) ? `${item}:0` : item
    }

    function simple(input: string, outputs: string | string[], chances?: number[] | number[][]) {
      const outputList = [outputs].flat()
      let chanceRows: number[][]
      if (!chances) {
        chanceRows = [[]]
      }
      else if (Array.isArray(chances[0])) {
        const matrix = chances as number[][]
        if (matrix.length !== outputList.length) {
          throw new Error(
            `JER simple("${input}"): outputs (${outputList.length}) and chances (${matrix.length}) length mismatch`
          )
        }
        chanceRows = matrix
      }
      else {
        chanceRows = [chances as number[]]
      }

      worldGen.push({
        block    : addMeta(input),
        distrib  : '0,1.0;255,1.0;',
        silktouch: false,
        dropsList: outputList.map((output, i) => {
          const row = chanceRows.length === 1 ? chanceRows[0] : chanceRows[i]
          if (row.length > 0 && row.length !== 4) {
            throw new Error(
              `JER simple("${input}"): chance row for "${output}" has length ${row.length}, expected 4`
            )
          }
          return {
            itemStack: addMeta(output),
            fortunes : {
              0: row[0] ?? 1,
              1: row[1] ?? 1,
              2: row[2] ?? 1,
              3: row[3] ?? 1,
            },
          }
        }),
        dim: 'Block Drops',
      })
    }

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

    function droptExpectedDrops(ranges: number[][], itemCount: number): number[] {
      const count = Math.max(1, itemCount)
      const expected: number[] = []
      let weightedSum = 0
      let totalWeight = 0
      for (let fortune = 0; fortune < 4; fortune++) {
        const [minDrop, maxDrop = minDrop] = ranges[fortune]
        const weight = 10 ** fortune
        weightedSum += weight * ((minDrop + maxDrop) / 2)
        totalWeight += weight
        expected.push(weightedSum / totalWeight / count)
      }
      return expected
    }

    function readHealthyDroptLog(logPath: string):
      | { ok: true, entries: Map<string, { drops: string[], ranges: number[][] }> }
      | { ok: false, reason: string } {
      if (!existsSync(logPath))
        return { ok: false, reason: `${logPath} does not exist` }

      const logText = loadText(logPath)
      if (!logText.trim())
        return { ok: false, reason: `${logPath} is empty` }

      if (CT_ERROR_RE.test(logText))
        return { ok: false, reason: `${logPath} contains CraftTweaker [ERROR]/[FATAL] entries` }

      if (!CT_INIT_RE.test(logText) || !CT_COMPLETE_RE.test(logText))
        return { ok: false, reason: `${logPath} did not finish initialization` }

      const skippedRe = buildDroptSkippedRe()
      if (skippedRe?.test(logText))
        return { ok: false, reason: `${logPath} skipped one or more dropt scripts (partial modpack boot)` }

      const entries = new Map<string, { drops: string[], ranges: number[][] }>()
      for (const line of logText.split(/\r?\n/)) {
        if (!line.includes('Modify drop;')) continue
        const m = MODIFY_DROP_RE.exec(line)
        if (!m?.groups)
          return { ok: false, reason: `Malformed Modify drop line: "${line.slice(0, 120)}"` }
        const { block, stack, luck } = m.groups
        if (!block.trim() || !stack.trim() || !luck.trim())
          return { ok: false, reason: `Malformed Modify drop line: "${line.slice(0, 120)}"` }
        const drops = stack.split(', ').map(s => s.trim()).filter(Boolean)
        let ranges: number[][]
        try {
          ranges = parse2DArray(luck)
        }
        catch {
          return { ok: false, reason: `Malformed Modify drop luck array for block "${block.trim()}"` }
        }
        if (!drops.length || ranges.length < 4 || ranges.some(r => r.length !== 2 || r.some(n => !Number.isFinite(n))))
          return { ok: false, reason: `Malformed Modify drop line for block "${block.trim()}"` }
        entries.set(addMeta(block.trim()), { drops, ranges })
      }

      if (entries.size === 0)
        return { ok: false, reason: `${logPath} has no "Modify drop;" entries (utils.DEBUG may be false)` }

      return { ok: true, entries }
    }

    const droptHealth = readHealthyDroptLog('crafttweaker.log')
    const harvestcraftPath = 'config/harvestcraft.cfg'
    const harvestcraftCfg = existsSync(harvestcraftPath) ? config(harvestcraftPath) : undefined
    const harvestcraftData = harvestcraftCfg?.drops as Record<string, string[]> | undefined
    const hasAllGardens = Boolean(
      harvestcraftData
      && HARVESTCRAFT_GARDENS.every(g => Array.isArray(harvestcraftData[g]) && harvestcraftData[g].length > 0)
    )

    if (!droptHealth.ok) {
      consola.warn(`Skipping Block Drops rebuild: ${droptHealth.reason}. Keeping existing Block Drops entries.`)
    }
    else if (!hasAllGardens || !harvestcraftData) {
      consola.warn('Skipping Block Drops rebuild: failed to parse config/harvestcraft.cfg garden drops. Keeping existing Block Drops entries.')
    }
    else {
      worldGen.splice(0, worldGen.length, ...worldGen.filter(o => o.dim !== 'Block Drops'))

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
      // ------------------------------------------------------------------
      // Custom gem ore drops for JER.
      // When a new gem ore block is added in scripts/cot/init.zs, insert
      // a matching `simple()` line here so that `pnpm dev:jer` regenerates
      // config/jeresources/world-gen.json correctly.
      // Block → gem item; fortune multipliers are identical for all gems.
      // ------------------------------------------------------------------
      simple('contenttweaker:ore_anglesite', 'contenttweaker:anglesite', [1, 1.5, 2.0, 2.5])
      simple('contenttweaker:ore_benitoite', 'contenttweaker:benitoite', [1, 1.5, 2.0, 2.5])
      simple('contenttweaker:ore_bixbite', 'contenttweaker:bixbite', [1, 1.5, 2.0, 2.5])
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
        [0.083, 0.083, 0.083, 0.083],
        [0.083, 0.083, 0.083, 0.083],
        [0.083, 0.083, 0.083, 0.083],
        [0.083, 0.083, 0.083, 0.083],
        [0.083, 0.083, 0.083, 0.083],
        [0.083, 0.083, 0.083, 0.083],
        [1, 1, 1, 1],
        [14, 14, 14, 14],
        [9.5, 9.5, 9.5, 9.5],
        [1, 1, 1, 1],
        [6, 6, 6, 6],
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
        'thaumcraft:cluster:1',
        'minecraft:clay_ball',
        'minecraft:quartz',
        'minecraft:redstone',
        'minecraft:emerald',
        'minecraft:prismarine_shard',
        'minecraft:prismarine_crystals',
        'minecraft:diamond',
      ], [
        [0.80, 0.60, 0.40, 0.20],
        [0.05, 0.10, 0.15, 0.20],
        [0.05, 0.11, 0.16, 0.22],
        [0.04, 0.08, 0.12, 0.16],
        [0.04, 0.08, 0.12, 0.16],
        [0.03, 0.06, 0.09, 0.12],
        [0.03, 0.06, 0.09, 0.12],
        [0.03, 0.05, 0.08, 0.11],
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

      const harvestcraftGardens = harvestcraftCfg?.gardens as Record<string, unknown> | undefined
      const rawDropAmount = harvestcraftGardens?.gardendropAmount
      const gardenDropAmount = typeof rawDropAmount === 'number' && Number.isFinite(rawDropAmount) && rawDropAmount >= 0 ? rawDropAmount : 3
      for (const garden of HARVESTCRAFT_GARDENS) {
        const list = harvestcraftData[garden]
        const chance = Math.min(gardenDropAmount, list.length) / list.length
        simple(`harvestcraft:${garden.toLowerCase()}`, list, [chance, chance, chance, chance])
      }

      for (const [block, { drops, ranges }] of droptHealth.entries) {
        simple(block, drops, droptExpectedDrops(ranges, drops.length))
      }
    }

    ///////////////////////////////////////////////////////////////////////
    // Cleanup
    ///////////////////////////////////////////////////////////////////////

    function shortenValue(v: number) {
      if (!v) return '0'
      const fixed = String(Number(v.toPrecision(2)))
      const exp = v.toExponential(1)
      return fixed.length <= exp.length ? fixed : exp
    }

    worldGen.forEach((wg) => {
      const dimMatch = wg.dim.match(DIM_MATCH_RE)
      if (dimMatch) {
        const [, dimNum, dimName] = dimMatch
        wg.dim = `${dimName.trim()} (${dimNum})`
      }

      wg.block = addMeta(wg.block)

      // Remove default silk touch value
      if (wg.silktouch === false) delete wg.silktouch

      // Decrease the precision
      const levels = wg.distrib
        .replace(DISTRIB_RE, '')
        .split(';')
        .map(s => s.split(',').map(Number) as [number, number])

      wg.distrib = clenDistrib(clenDistrib(clenDistrib(simplifyDistrib(levels))))
        .map(l => l.join(','))
        .join(';')

      wg.dropsList?.forEach((d) => {
        d.itemStack = addMeta(d.itemStack)
        if (!d.fortunes) return
        // Decrease precision of fortunes
        for (const n of [0, 1, 2, 3] as const) {
          const v = d.fortunes[n]
          if (v !== undefined) d.fortunes[n] = Number(v.toPrecision(2))
        }

        const entries = Object.entries(d.fortunes)
        if (entries.length > 1 && entries.every(([, val]) => val === entries[0][1])) {
          d.fortunes = Object.fromEntries([entries[0]])
        }
      })

      // Clean Remove Drop List
      if (wg.dropsList?.length) {
        wg.dropsList = wg.dropsList.filter((d) => {
          if (d.itemStack === 'minecraft:air:0') return false
          const fortuneKeys = d.fortunes ? Object.keys(d.fortunes) : []
          return fortuneKeys.length > 0
        })

        if (
          wg.dropsList.length === 1
          && wg.dropsList[0].itemStack === wg.block
          && Object.keys(wg.dropsList[0].fortunes).length === 1
          && wg.dropsList[0].fortunes['0'] === 1
        ) {
          wg.dropsList = []
        }

        // Remove same item with different NBT tags flooding drops
        const groups: { [id: string]: Drop[] } = {}
        wg.dropsList.forEach(d => (groups[getID(d.itemStack)] ??= []).push(d))
        Object.entries(groups).forEach(([id, d]) => {
          if (d.length > 1 && wg.dropsList!.length > 8) {
            groups[id] = [{ ...d[0], itemStack: id }]
          }
        })
        wg.dropsList = Object.entries(groups).map(([_, d]) => d).flat()

        if (!wg.dropsList.length) delete wg.dropsList
      }
    })

    function getID(itemStack: string) {
      const m = itemStack.match(GET_ID_RE)
      if (!m) throw new Error(`No ID for item: ${itemStack}`)
      return m[0]
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
        if (sameLevel && bv !== 0 && Math.abs((targetv - bv) / bv) <= 0.02) continue

        result.push(arr[i])
      }

      const last = arr.at(-1)
      if (last) result.push(last)
      return result
    }

    function simplifyDistrib(distrib: [number, number | string][]) {
      const maxV = Math.max(...distrib.map(([, v]) => Number(v)))
      if (!Number.isFinite(maxV) || maxV <= 0)
        return distrib.map(([l, v]) => [l, shortenValue(Number(v))] as [number, string])

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
