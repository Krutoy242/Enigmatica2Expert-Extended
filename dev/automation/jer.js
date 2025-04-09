// Template for automatic Just Enough Resources files automation

// Regex for removing useless information about block drops
// from: ("block": "([^"]+)",\n.+\n.+)\n.+\n.+\n\s+"itemStack": "\2",\n\s+"fortunes": \{\n(\s+"\d+": 1(\.0)?,?\n){4}\s+\}\n\s+\}\n\s+\],
// to: $1

// @ts-check

import {
  config,
  loadJson,
  loadText,
  saveObjAsJson,
} from '../lib/utils.js'

const worldgenJsonPath = 'config/jeresources/world-gen.json'
const worldGen = loadJson(worldgenJsonPath)

///////////////////////////////////////////////////////////////////////

worldGen.splice(0, worldGen.length, ...worldGen.filter(o => o.dim !== 'Block Drops'))

function addMeta(item) {
  return item.replace(/(:[a-z]+)$/i, '$1:0')
}

/**
 * @param {string} input
 * @param {string | string[]} outputs
 * @param {number[] | number[][]} [chances]
 */
function simple(input, outputs, chances) {
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

const harvestcraft = config('config/harvestcraft.cfg').drops

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
  .matchAll(/Modify drop; Block: (?<block>.+) Drop: (?<stack>.+) (?<luck>\[.*\])/g),
].forEach(({ groups: { block, stack, luck } }) =>
  simple(block, stack, eval(luck).slice(0, 4).map(([o]) => o)))

///////////////////////////////////////////////////////////////////////
saveObjAsJson(worldGen, worldgenJsonPath)
