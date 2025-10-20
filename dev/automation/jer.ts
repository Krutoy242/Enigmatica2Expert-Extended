/* eslint-disable style/no-multi-spaces */
// Template for automatic Just Enough Resources files automation

// Regex for removing useless information about block drops
// from: ("block": "([^"]+)",\n.+\n.+)\n.+\n.+\n\s+"itemStack": "\2",\n\s+"fortunes": \{\n(\s+"\d+": 1(\.0)?,?\n){4}\s+\}\n\s+\}\n\s+\],
// to: $1

import simplify from 'simplify-js'

import {
  config,
  loadJson,
  loadText,
  saveText,
} from '../lib/utils.js'

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

const worldgenJsonPath = 'config/jeresources/world-gen.json'
const worldGen: WorldGenEntry[] = loadJson(worldgenJsonPath)

///////////////////////////////////////////////////////////////////////
// Populate manual entries
///////////////////////////////////////////////////////////////////////

worldGen.splice(0, worldGen.length, ...worldGen.filter(o => o.dim !== 'Block Drops'))

function addMeta(item: string) {
  return item.replace(/(:[a-z]+)$/i, '$1:0')
}

function simple(input: string, outputs: string | string[], chances?: any[]) {
  /** @type {number[][]} */
  const chance = !chances
    ? [[]]
    : Array.isArray(chances[0]) ? chances : [chances ?? []]
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

for (let i = -1; i < 16; i++) {
  simple(
    `minecraft:${i === -1 ? '' : 'stained_'}glass:${Math.max(0, i)}`,
    `quark:glass_shards:${i + 1}`,
    [2, 3, 4, 4]
  )
}

const harvestcraft = config('config/harvestcraft.cfg')!.drops as Record<string, string>

for (const garden of [
  'aridGarden',
  'frostGarden',
  'shadedGarden',
  'soggyGarden',
  'tropicalGarden',
  'windyGarden',
]) {
  const list = harvestcraft[garden]
  simple(`harvestcraft:${garden.toLowerCase()}`, list, [1, 1, 1, 1].fill(2.0 / list.length))
}

;[...loadText('crafttweaker.log')
  .matchAll(/Modify drop; Block: (?<block>.+) Drop: \[(?<stack>.+)\] (?<luck>\[.*\])/g)].forEach(({ groups: { block, stack, luck } }) =>
  simple(block, stack.split(', '), parse2DArray(luck).slice(0, 4).map(([o]) => o)))

function parse2DArray(input: string): number[][] {
  // Normalize the input string
  const normalized = input
    .trim()
    .replace(/^\[|\]$/g, '') // remove leading/trailing brackets
    .replace(/\],\s*\[/g, '];[') // normalize separators
    .replace(/,\s*\]/g, ']') // remove trailing commas before closing bracket
    .replace(/\[,/g, '[') // fix empty entries like "[,2,2]" => "[2,2]"

  // Split the string into subarrays
  const arrayStrings = normalized
    .split(';')
    .map(str => str.trim())
    .filter(str => str.length > 0)

  // Parse each subarray
  const result: number[][] = arrayStrings.map((sub) => {
    const match = sub.match(/\[(.*?)\]/)
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
    v.toPrecision(2).replace(/\.0+$/, '').replace(/([1-9])0+$/, '$1'),
    v.toExponential(1),
  ].sort((a, b) => a.length - b.length)
  return list[0]
}

worldGen.forEach((wg) => {
  const dimMatch = wg.dim.match(/^Dim (-?\d+): (.+)$/)
  if (dimMatch) {
    const [, dimNum, dimName] = dimMatch
    wg.dim = `${dimName.trim()} (${dimNum})`
  }

  // Remove default silk touch value
  if (wg.silktouch === false) delete wg.silktouch

  // Descrease the precision
  const levels = wg.distrib
    .replace(/;$/, '')
    .split(';')
    .map(s => s.split(',').map(Number) as [number, number])
    // .map(([l, v]) => [l, shortenValue(v)])

  wg.distrib = clenDistrib(clenDistrib(clenDistrib(simplifyDistrib(levels))))
    .map(l => l.join(','))
    .join(';')

  wg.dropsList?.forEach((d) => {
    // Descrease precision of fortunes
    [0, 1, 2, 3].filter(n => d.fortunes[n]).forEach(n =>
      d.fortunes[n] = Number(d.fortunes[n].toPrecision(2))
    )

    if (Object.entries(d.fortunes).every((v, _, arr) => v[1] === arr[0][1])) {
      d.fortunes = Object.fromEntries([Object.entries(d.fortunes)[0]])
    }

    if (!Object.values(d.fortunes).length)
      delete d.fortunes
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
        groups[id] = [{...d.shift(), itemStack: id}]
      }
    })
    wg.dropsList = Object.entries(groups).map(([_, d]) => d).flat()

    // if (wg.dropsList.length > 8) console.log('Too big dropsList: ', wg.dropsList.length, wg.block)

    if (!wg.dropsList.length) delete wg.dropsList
  }
})

function getID(itemStack:string) {
  const m = itemStack.match(/^[^:]+:[^:]+(?::\d+)?/)
  if (!m) throw new Error(`No ID for item: ${itemStack}`)
  return m[0]
}

function fortuneSame(fortunes: Drop['fortunes']) {
  return  [0, 1, 2, 3].map(n => fortunes[n]).every((v, _, arr) => v === arr[0])
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

  result.push(arr[arr.length - 1])
  return result
}

function simplifyDistrib(distrib: [number, number | string][]) {
  const maxV = Math.max(...distrib.map(([,v]) => Number(v)))
  const mult = 80 / maxV // Size of graph is 128:40

  const simplified = simplify(
    distrib.map(([l, v]) => ({x: l, y: Number(v) * mult})),
    0.9,
    true
  )

  return simplified.map(o => [o.x, shortenValue(o.y / mult)] as [number, string])
}

const stringified = `${JSON.stringify(worldGen, null, 2).trimEnd()}\n`
  .replace(/"fortunes": \{(\n[^}]+)\}/g, (m, r) => `"fortunes": {${r.replace(/\s+/g, ' ')}}`)

///////////////////////////////////////////////////////////////////////
saveText(stringified, worldgenJsonPath)
