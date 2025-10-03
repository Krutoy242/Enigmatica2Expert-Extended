#modloaded nuclearcraft thermalexpansion
#reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;
import mods.fluidintetweaker.FITweaker;
import mods.fluidintetweaker.interaction.Condition;

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
  [<liquid:plasma>, <liquid:water>]                                         : [<mekanism:saltblock>, <additionalcompression:dustsugar_compressed:1>, <additionalcompression:dustgunpowder_compressed>],
  [<liquid:plasma>, <liquid:lava>]                                          : [<minecraft:magma>, <additionalcompression:flint_compressed:1>, <additionalcompression:coal_compressed:2>],
  //[<liquid:plasma>, <liquid:astralsorcery.liquidstarlight>]                 : [<quark:sugar_block>, <biomesoplenty:white_sand>, <astralsorcery:blockmarble>], // For some reason, Starlight+Water=Sand triggered faster than custom interaction
  [<liquid:plasma>, <liquid:cloud_seed_concentrated>]                       : [<enderio:block_fused_quartz>, <mysticalagriculture:storage:5>, <biomesoplenty:crystal>],
  [<liquid:plasma>, <liquid:lifeessence>]                                   : [<excompressum:compressed_block:6>, <minecraft:bone_block>, <iceandfire:dragon_bone_block>],
  [<liquid:ic2uu_matter>, <liquid:water>]                                   : [<quark:crystal:0>, <quark:crystal:6>, <actuallyadditions:block_crystal:2>],
  [<liquid:ic2uu_matter>, <liquid:lava>]                                    : [<advancedrocketry:basalt>, <draconicevolution:infused_obsidian>, <draconicevolution:draconium_block>],
  [<liquid:ic2uu_matter>, <liquid:astralsorcery.liquidstarlight>]           : [<quark:marble>, <minecraft:quartz_block>, <thermalfoundation:storage:7>],
  [<liquid:ic2uu_matter>, <liquid:cloud_seed_concentrated>]                 : [<randomthings:superlubricentice>, <nuclearcraft:supercold_ice>, <enderio:block_alloy:6>],
  [<liquid:ic2uu_matter>, <liquid:lifeessence>]                             : [<additionalcompression:meatbeef_compressed>, <minecraft:nether_wart_block>, <tconevo:metal_block:5>],
  [<liquid:ic2uu_matter>, <liquid:plasma>]                                  : [<enderio:block_infinity>, <minecraft:obsidian>, <tconevo:metal_block:7>],
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

static smelteryFuels as string[][double[string]] = utils.graph([
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
  'o': ['plasma', 'high_pressure_mercury', 'perfect_fuel'],
  'p': ['infinity_metal'],

  // Non-fuel Metals
  '1': [],
  '2': [],
  '3': ['osmium', 'obsidian', 'vibrant_alloy', 'pulsating_iron', 'end_steel'],
  '4': ['xu_demonic_metal', 'mirion', 'signalum', 'lumium', 'crystalline_alloy', 'melodic_alloy', 'crystalline_pink_slime'],
  '5': ['xu_enchanted_metal', 'xu_evil_metal', 'fierymetal', 'crystal_matrix'],
  '6': ['stellar_alloy', 'osgloglas', 'enderium', 'gelid_enderium', 'supremium', 'refinedglowstone', 'refinedobsidian'],
});

for pos, names in smelteryFuels {
  for name in names {
    val temp = pos.x as int;
    val time = pos.y as int;
    val liquid = game.getLiquid(name);
    if (isNull(liquid)) continue;

    liquid.definition.temperature = temp;

    if (time != 0) {
      mods.tconstruct.Fuel.registerFuel(liquid * 50, time);
    }
  }
}

// Custom special interactions
FITweaker.addRecipe(utils.getStateFromItem(<advancedrocketry:vitrifiedsand>),
  <liquid:pyrotheum>, false,
  utils.getStateFromItem(<extrautils2:decorativesolid:4>));

FITweaker.addRecipe(utils.getStateFromItem(<extrautils2:decorativesolid:4>),
  <liquid:enrichedlava>, false,
  utils.getStateFromItem(<minecraft:glass>));

// Restore default AS interactions
// This will allow compat with XU2 nodes
// Taken from modpack IsolatedCrystal3
// https://github.com/friendlyhj/IsolatedCrystal3/blob/e02e0901bb6df8f43a7b05ad22f2d761d69c7145/.minecraft/scripts/recipes/tier2/fluidinteractions.zs
FITweaker.addRecipe(
  <liquid:astralsorcery.liquidstarlight>,
  <liquid:lava>,
  FITweaker.outputBuilder()
    .addEvent(
      FITweaker.eventBuilder()
        .createSetBlockEvent(<blockstate:minecraft:sand>)
    )
    .addEvent(
      FITweaker.eventBuilder()
        .createSetBlockEvent(<blockstate:astralsorcery:blockcustomsandore>)
        .addCondition(Condition.byChance, [1.0f / 900.0f])
    )
);

FITweaker.addRecipe(
  <liquid:astralsorcery.liquidstarlight>,
  <liquid:water>,
  <blockstate:minecraft:ice>
);

FITweaker.addRecipe(
  <liquid:astralsorcery.liquidstarlight>,
  <liquid:petrotheum>,
  <blockstate:minecraft:gravel>
);

FITweaker.addRecipe(
  <liquid:astralsorcery.liquidstarlight>,
  <liquid:pyrotheum>,
  <blockstate:minecraft:glass>
);
