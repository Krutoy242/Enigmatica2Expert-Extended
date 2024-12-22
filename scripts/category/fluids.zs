#modloaded nuclearcraft thermalexpansion
#reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;
import mods.fluidintetweaker.FBTweaker;
import mods.fluidintetweaker.FITweaker;

// Chalice interactions
val chaliceGrid = {
  // First                      , Second                                                             , ⏩ + ⏩                                , ⏩ + 🔷                             , 🔷 + ⏩                      ,
  [<liquid:cloud_seed_concentrated>, <liquid:water>]                        : [<additionalcompression:feather_compressed>, <twilightforest:wispy_cloud>, <minecraft:clay>],
  [<liquid:cloud_seed_concentrated>, <liquid:lava>]                         : [<exnihilocreatio:block_endstone_crushed>, <minecraft:end_stone>, <excompressum:compressed_block:7>],
  [<liquid:cloud_seed_concentrated>, <liquid:astralsorcery.liquidstarlight>]: [<exnihilocreatio:block_dust>, <exnihilocreatio:block_andesite_crushed>, <excompressum:compressed_block>],
  [<liquid:lifeessence>, <liquid:water>]                                    : [<additionalcompression:cropapple_compressed>, <thaumcraft:flesh_block>, <additionalcompression:spidereye_compressed>],
  [<liquid:lifeessence>, <liquid:lava>]                                     : [<tconstruct:slime:3>, <thaumcraft:flesh_block>, <minecraft:nether_wart_block>],
  [<liquid:lifeessence>, <liquid:astralsorcery.liquidstarlight>]            : [<harvestcraft:honey>, <harvestcraft:honeycomb>, <biomesoplenty:honey_block>],
  [<liquid:lifeessence>, <liquid:cloud_seed_concentrated>]                  : [<thermalfoundation:rockwool:7>, <minecraft:wool>, <minecraft:wool:2>],
  [<liquid:hot_mercury>, <liquid:water>]                                    : [<mekanism:saltblock>, <additionalcompression:dustsugar_compressed:1>, <additionalcompression:dustgunpowder_compressed>],
  [<liquid:hot_mercury>, <liquid:lava>]                                     : [<minecraft:magma>, <additionalcompression:flint_compressed:1>, <additionalcompression:coal_compressed:2>],
  [<liquid:hot_mercury>, <liquid:astralsorcery.liquidstarlight>]            : [<quark:sugar_block>, <biomesoplenty:white_sand>, <astralsorcery:blockmarble>],
  [<liquid:hot_mercury>, <liquid:cloud_seed_concentrated>]                  : [<enderio:block_fused_quartz>, <mysticalagriculture:storage:5>, <biomesoplenty:crystal>],
  [<liquid:hot_mercury>, <liquid:lifeessence>]                              : [<excompressum:compressed_block:6>, <minecraft:bone_block>, <iceandfire:dragon_bone_block>],
  [<liquid:ic2uu_matter>, <liquid:water>]                                   : [<quark:crystal:0>, <quark:crystal:6>, <actuallyadditions:block_crystal:2>],
  [<liquid:ic2uu_matter>, <liquid:lava>]                                    : [<advancedrocketry:basalt>, <draconicevolution:infused_obsidian>, <draconicevolution:draconium_block>],
  [<liquid:ic2uu_matter>, <liquid:astralsorcery.liquidstarlight>]           : [<quark:marble>, <minecraft:quartz_block>, <thermalfoundation:storage:7>],
  [<liquid:ic2uu_matter>, <liquid:cloud_seed_concentrated>]                 : [<randomthings:superlubricentice>, <nuclearcraft:supercold_ice>, <enderio:block_alloy:6>],
  [<liquid:ic2uu_matter>, <liquid:lifeessence>]                             : [<additionalcompression:meatbeef_compressed>, <minecraft:nether_wart_block>, <tconevo:metal_block:5>],
  [<liquid:ic2uu_matter>, <liquid:hot_mercury>]                             : [<enderio:block_infinity>, <minecraft:obsidian>, <tconevo:metal_block:7>],
} as IItemStack[][ILiquidStack[]]$orderly;

// ### Honorable mentions: ####
// liquid_sunshine
// cloud_seed_concentrated
// vibrant_alloy
// deuterium
// hydrofluoric_acid
// milk_chocolate
// honey
// blockfluiddirt
// mutagen
// dist_water
// if.pink_slime
// menrilresin
// liquidchorus
// witchwater
// xpjuice

// Defauls weights:
// 1200: lava + starlight = sand
//   70: lava + starlight = Aquamarine

// Weights by interaction type
val weights = [64, 8, 1] as int[];

for lList, itList in chaliceGrid {
  for i, it in itList {
    mods.astralsorcery.LiquidInteraction.addInteraction(lList[0] * 10, 0.2 * i, lList[1] * 100, 0.2 * i, weights[i], it);
  }
  scripts.jei.mod.astralsorcery.add_everflow_chalice(lList[0] * 10, lList[1] * 100, [itList[0] * weights[0], itList[1] * weights[1], itList[2] * weights[2]]);

  FITweaker.addRecipe(lList[0], lList[1], utils.getStateFromItem(itList[0]));
}

// *======= Fuels =======*

/* Patchouli_js("Liquids/Smeltery Fuels", {
  item: "tconstruct:smeltery_controller",
  _text: `
    $(l)Smeltery/$ melting temperatures was tweaked. Some metals $(l)require/$ better fuels than $(#d31)lava/$.
    All fuels consume $(l)50/$mb.
    $(l)Temperature/$ of fuel affect melting speed.
    $(l)Time/$ is number of ticks fuel will burn.`});

Patchouli_js("Liquids/Smeltery Fuels",
  paged({
    item: "tconstruct:smeltery_controller",
    type: "item_list"
  }, 7,
  from_crafttweaker_log(/Register Smeltery fuel. Temp: (?<temp>\d+), Burn time: (?<time>\d+), Name: (?<name>.*)/gm)
  .map(o=>o.groups)

  // Default fuels
  .concat([{temp:1300, time:80, name:"lava"}])

  .sort((a,b)=>b.temp*b.time - a.temp*a.time)
  .map(o=>[wrap_bucket(o.name), `${o.temp}°К, ${o.time} ticks`])
)) */

for pos, names in utils.graph([
// ↑ Duration
  '                                                          l           o        p',
  '       a              f  g                      k                               ',
  '                                           n           m                        ',
  '                                                                                ',
  '                   e         h   i                                              ',
  '         b c    d                                                               ',
  '                                                                                ',
  '*  r q                               j                                          ',
  '1 2      3            4                     5                         6         ',
// ┣━━━━─━━━━┷━━━━─━━━━┻━━━━─━━━━┷━━━━─━━━━╋╋━━━━─━━━━┷━━━━─━━━━┻━━━━─━━━━┷━━━━─━━━━┫
// |500     2300      4100      5900      7800      9600      11400     13200  15000| Temp --->
], {
  x: { min: 500, max: 15000, step: 100 },
  y: { min: 0, max: 1200, step: 100 },
}, {
  // Fuels
  '*': ['steam'],
  'r': ['canolaoil'],
  'q': ['creosote', 'ic2creosote'],
  'a': ['ic2pahoehoe_lava'],
  'b': ['biodiesel', 'biofuel'],
  'c': ['diesel', 'ic2biogas', 'refinedcanolaoil'],
  'd': ['gasoline', 'crystaloil'],
  'e': ['boric_acid', 'napalm', 'refined_biofuel'],
  'f': ['hydrofluoric_acid'],
  'g': ['sulfuricacid'],
  'h': ['bio.ethanol', 'rocket_fuel'],
  'i': ['refined_fuel'],
  'j': ['pyrotheum'],
  'm': ['rocketfuel'],
  'k': ['ic2uu_matter', 'enrichedlava'],
  'l': [],
  'n': ['empoweredoil'],
  'o': ['plasma', 'hot_mercury', 'perfect_fuel'],
  'p': ['infinity_metal'],

  // Non-fuel Metals
  '1': [],
  '2': [],
  '3': ['osmium', 'obsidian', 'vibrant_alloy', 'pulsating_iron', 'end_steel'],
  '4': ['xu_demonic_metal', 'mirion', 'signalum', 'lumium', 'crystalline_alloy', 'melodic_alloy', 'crystalline_pink_slime'],
  '5': ['xu_enchanted_metal', 'xu_evil_metal', 'fierymetal', 'crystal_matrix'],
  '6': ['stellar_alloy', 'osgloglas', 'enderium', 'gelid_enderium', 'supremium', 'refinedglowstone', 'refinedobsidian'],
}) {
  for name in names {
    val temp = pos.x as int;
    val time = pos.y as int;
    val liquid = game.getLiquid(name);
    if (isNull(liquid)) continue;

    liquid.definition.temperature = temp;

    if (time != 0) {
      utils.log('Register Smeltery fuel. Temp: ' ~ temp ~ ', Burn time: ' ~ time ~ ', Name: ' ~ name);
      mods.tconstruct.Fuel.registerFuel(liquid * 50, time);
    }
  }
}
