/**
 * @file Create and store recipes for do.zs/portal_spread
 * 
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#priority 2000
#reloadable

import crafttweaker.block.IBlock;
import crafttweaker.block.IBlockState;
import crafttweaker.block.IBlockStateMatcher;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDictEntry;

/*
██╗   ██╗ █████╗ ██████╗ ██╗ █████╗ ██████╗ ██╗     ███████╗███████╗
██║   ██║██╔══██╗██╔══██╗██║██╔══██╗██╔══██╗██║     ██╔════╝██╔════╝
██║   ██║███████║██████╔╝██║███████║██████╔╝██║     █████╗  ███████╗
╚██╗ ██╔╝██╔══██║██╔══██╗██║██╔══██║██╔══██╗██║     ██╔══╝  ╚════██║
 ╚████╔╝ ██║  ██║██║  ██║██║██║  ██║██████╔╝███████╗███████╗███████║
  ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝
*/

// Recipes for exact inputState => outputState
static stateRecipes as IBlockState[][IBlockState][int][int]
               = {} as IBlockState[][IBlockState][int][int];

// Block numerical IDs that can be converted (completely or only some of their states)
static transformableBlockNumIds as bool[int][int][int]
                           = {} as bool[int][int][int];

// Block numerical IDs that would be converted no matter of state
static wildcardedNumIds as bool[int][int][int]
                   = {} as bool[int][int][int];

// Dimensions that copy its recipes from other dimensions
static dimFallbacks as int[int] = {} as int[int];

// Set of dimensions that have recipes
static dimHasRecipes as bool[int] = {} as bool[int];

static _air as int = <blockstate:minecraft:air>.block.definition.numericalId;
static _obs as int = <blockstate:minecraft:obsidian>.block.definition.numericalId;
static _prt as int = <blockstate:minecraft:portal>.block.definition.numericalId;

// Blocks that can't be converted
static blacklistedBlockNumIds as bool[int][int][int] = {
  0: {
    -1: { [_air]: true, [_obs]: true, [_prt]: true },
  },
} as bool[int][int][int];

static initialized as bool = false;

// Get recipes and initialize if needed
function getRecipes(dimFrom as int, dimTo as int) as IBlockState[][IBlockState] {
  if(!initialized) {
    initialized = true;
    init();
  }

  if (isNull(stateRecipes[dimFrom])) return null;
  return stateRecipes[dimFrom][dimTo];
}

/*
██████╗ ██╗   ██╗██████╗ ██╗     ██╗ ██████╗
██╔══██╗██║   ██║██╔══██╗██║     ██║██╔════╝
██████╔╝██║   ██║██████╔╝██║     ██║██║     
██╔═══╝ ██║   ██║██╔══██╗██║     ██║██║     
██║     ╚██████╔╝██████╔╝███████╗██║╚██████╗
╚═╝      ╚═════╝ ╚═════╝ ╚══════╝╚═╝ ╚═════╝

███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
█████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
*/

/**
 * Set conversion of one specific state to another ones
 * 
 * Use <blockstate:minecraft:air> in blocksTo to remove block
 * 
 */
function setState(dimFrom as int, dimTo as int, blockFrom as IBlockState, blocksTo as IBlockState[]) as void {
  if(isNull(blockFrom)) return;

  // Update stateRecipes maps
  if(isNull(stateRecipes[dimFrom])) stateRecipes[dimFrom] = {} as IBlockState[][IBlockState][int];
  if(isNull(stateRecipes[dimFrom][dimTo])) stateRecipes[dimFrom][dimTo] = {} as IBlockState[][IBlockState];

  // Update fast lookup maps
  if(isNull(transformableBlockNumIds[dimFrom])) transformableBlockNumIds[dimFrom] = {} as bool[int][int];
  if(isNull(transformableBlockNumIds[dimFrom][dimTo])) transformableBlockNumIds[dimFrom][dimTo] = {} as bool[int];
  transformableBlockNumIds[dimFrom][dimTo][blockFrom.block.definition.numericalId] = true;

  stateRecipes[dimFrom][dimTo][blockFrom] = blocksTo;
  dimHasRecipes[dimFrom] = true;

  // Update untransformable blocks
  for blockTo in blocksTo {
    if(isNull(blockTo)) continue;
    if(isNull(blacklistedBlockNumIds[dimFrom])) blacklistedBlockNumIds[dimFrom] = {} as bool[int][int];
    if(isNull(blacklistedBlockNumIds[dimFrom][dimTo])) blacklistedBlockNumIds[dimFrom][dimTo] = {} as bool[int];
    blacklistedBlockNumIds[dimFrom][dimTo][blockTo.block.definition.numericalId] = true;
  }
}

/**
 * Set conversion of one specific states to another ones
 */
function setStates(dimFrom as int, dimTo as int, blocksFrom as IBlockState[], blocksTo as IBlockState[]) as void {
  for blockFrom in blocksFrom {
    setState(dimFrom, dimTo, blockFrom, blocksTo);
  }
}

/**
 * Set conversion of one any states of blocks to another ones
 */
function setBlocks(dimFrom as int, dimTo as int, blocksFrom as IBlockState[], blocksTo as IBlockState[]) as void {
  for blockFrom in blocksFrom {
    if(isNull(wildcardedNumIds[dimFrom])) wildcardedNumIds[dimFrom] = {} as bool[int][int];
    if(isNull(wildcardedNumIds[dimFrom][dimTo])) wildcardedNumIds[dimFrom][dimTo] = {} as bool[int];
    wildcardedNumIds[dimFrom][dimTo][blockFrom.block.definition.numericalId] = true;

    setState(dimFrom, dimTo, blockFrom.block.definition.defaultState, blocksTo);
  }
}

/**
 * Set conversion of one any states of oredict to another ones
 */
function setOreBlocks(dimFrom as int, dimTo as int, oredict as IOreDictEntry, blocksTo as IBlockState[]) as void {
  for item in oredict.items {
    setBlocks(dimFrom, dimTo, [item.asBlock().definition.defaultState], blocksTo);
  }
}

/**
 * Copy recipes from one dim to another
 * For example:
 * ```
 * // All recipes in dim 0 would be available in dim 3
 * setDimensionFallback(3, 0);
 * ```
 */
function setDimensionFallback(copyDim as int, baseDim as int) as void {
  dimFallbacks[copyDim] = baseDim;
}

////////////////////////////////////////////////////////////
// Helper functions
////////////////////////////////////////////////////////////

// Remove all transformable blocks from blacklist
function init() as void {
  for dimFromId, dimFrom in transformableBlockNumIds {
    if(isNull(blacklistedBlockNumIds[dimFromId])) continue;

    for dimToId, dimTo in dimFrom {
      if(isNull(blacklistedBlockNumIds[dimFromId][dimToId])) continue;

      blacklistedBlockNumIds[dimFromId][dimToId] = mapAExceptB(
        blacklistedBlockNumIds[dimFromId][dimToId], dimTo
      );
    }
  }
}

// Remove keys of B from A
function mapAExceptB(a as bool[int], b as bool[int]) as bool[int] {
  val newOne = {} as bool[int];

  for idA, _ in a {
    var isOutputInInput = false;
    for idB, _ in b {
      if (idB == idA) {
        isOutputInInput = true;
        break;
      }
    }
    if (!isOutputInInput) newOne[idA] = true;
  }
  
  return newOne;
}

/*
██████╗ ███████╗███████╗ █████╗ ██╗   ██╗██╗  ████████╗
██╔══██╗██╔════╝██╔════╝██╔══██╗██║   ██║██║  ╚══██╔══╝
██║  ██║█████╗  █████╗  ███████║██║   ██║██║     ██║   
██║  ██║██╔══╝  ██╔══╝  ██╔══██║██║   ██║██║     ██║   
██████╔╝███████╗██║     ██║  ██║╚██████╔╝███████╗██║   
╚═════╝ ╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝   

██████╗ ███████╗ ██████╗██╗██████╗ ███████╗███████╗
██╔══██╗██╔════╝██╔════╝██║██╔══██╗██╔════╝██╔════╝
██████╔╝█████╗  ██║     ██║██████╔╝█████╗  ███████╗
██╔══██╗██╔══╝  ██║     ██║██╔═══╝ ██╔══╝  ╚════██║
██║  ██║███████╗╚██████╗██║██║     ███████╗███████║
╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝╚═╝     ╚══════╝╚══════╝
*/

val terrainBlocks = [
  <blockstate:minecraft:netherrack>,
  <blockstate:minecraft:netherrack>,
  <blockstate:minecraft:netherrack>,
  <blockstate:minecraft:quartz_ore>,
  <blockstate:netherendingores:block_nether_netherfish>,
] as IBlockState[];

setBlocks(0, -1, [
  <blockstate:minecraft:grass>,
  <blockstate:minecraft:dirt>,
  <blockstate:minecraft:farmland>,
  <blockstate:biomesoplenty:grass>,
  <blockstate:biomesoplenty:dirt>,
], terrainBlocks);

setStates(0, -1, [
  <blockstate:minecraft:stone:variant=stone>,
], terrainBlocks);

setStates(0, -1, [
  <blockstate:minecraft:stone:variant=granite>,
  <blockstate:minecraft:stone:variant=smooth_granite>,
  <blockstate:minecraft:stone:variant=diorite>,
  <blockstate:minecraft:stone:variant=smooth_diorite>,
  <blockstate:minecraft:stone:variant=andesite>,
  <blockstate:minecraft:stone:variant=smooth_andesite>,
], [
  <blockstate:minecraft:netherrack>,
  <blockstate:minecraft:netherrack>,
  <blockstate:minecraft:netherrack>,
  <blockstate:minecraft:quartz_ore>,
  <blockstate:minecraft:quartz_ore>,
  <blockstate:minecraft:quartz_ore>,
  <blockstate:minecraft:lava>,
]);

setBlocks(0, -1, [
  <blockstate:minecraft:tallgrass>,
  <blockstate:biomesoplenty:plant_0>,
], [
  <blockstate:minecraft:air>,
]);

setBlocks(0, -1, [
  <blockstate:minecraft:yellow_flower>,
  <blockstate:minecraft:red_flower>,
  <blockstate:biomesoplenty:flower_0>,
  <blockstate:biomesoplenty:flower_1>,
  <blockstate:botania:flower>,
], [
  <blockstate:minecraft:fire>,
]);

setStates(0, -1, [
  <blockstate:minecraft:coal_ore>,
  <blockstate:thermalfoundation:ore:type=copper>,
  <blockstate:thermalfoundation:ore:type=tin>,
  <blockstate:thermalfoundation:ore:type=lead>,
  <blockstate:thermalfoundation:ore:type=aluminum>,
], [
  <blockstate:minecraft:quartz_ore>,
]);

setBlocks(0, -1, [
  <blockstate:minecraft:stone_brick_stairs>,
  <blockstate:minecraft:oak_stairs>,
  <blockstate:minecraft:spruce_stairs>,
  <blockstate:minecraft:birch_stairs>,
  <blockstate:minecraft:jungle_stairs>,
  <blockstate:minecraft:acacia_stairs>,
  <blockstate:minecraft:dark_oak_stairs>,
], [<blockstate:minecraft:nether_brick_stairs>]);
setOreBlocks(0, -1, <ore:sand>, [<blockstate:minecraft:soul_sand>]);
setStates(0, -1, [<blockstate:minecraft:sea_lantern>], [<blockstate:minecraft:glowstone>]);
setStates(0, -1, [<blockstate:minecraft:mossy_cobblestone>], [<blockstate:minecraft:magma>]);
setBlocks(0, -1, [<blockstate:minecraft:vine>], [<blockstate:minecraft:air>]);
setBlocks(0, -1, [<blockstate:minecraft:wooden_door>], [<blockstate:minecraft:air>]);
setBlocks(0, -1, [<blockstate:minecraft:ice>], [<blockstate:minecraft:obsidian>]);
setBlocks(0, -1, [
  <blockstate:minecraft:brick_block>,
  <blockstate:minecraft:double_wooden_slab>,
], [<blockstate:minecraft:nether_brick>]);
setStates(0, -1, [<blockstate:minecraft:diamond_block>], [<blockstate:minecraft:gold_block>]);
setStates(0, -1, [<blockstate:minecraft:melon_block>], [<blockstate:minecraft:nether_wart_block>]);
setStates(0, -1, [
  <blockstate:minecraft:slime>,
], [
  <blockstate:minecraft:bone_block:axis=x>,
  <blockstate:minecraft:bone_block:axis=x>,
  <blockstate:minecraft:bone_block:axis=z>,
  <blockstate:minecraft:bone_block:axis=y>,
]);

setBlocks(0, -1, [<blockstate:floralchemy:hedge>], [<blockstate:twilightforest:thorns>]);
setBlocks(0, -1, [<blockstate:minecraft:wooden_slab>], [<blockstate:minecraft:stone_slab:variant=nether_brick>]);
setStates(0, -1, [
  <blockstate:minecraft:stone_slab:half=bottom,variant=stone_brick>,
  <blockstate:minecraft:stone_slab:half=bottom,variant=stone>,
], [<blockstate:minecraft:stone_slab:half=bottom,variant=nether_brick>]);
setStates(0, -1, [
  <blockstate:minecraft:stone_slab:half=top,variant=stone_brick>,
  <blockstate:minecraft:stone_slab:half=top,variant=stone>
], [<blockstate:minecraft:stone_slab:half=top,variant=nether_brick>]);
setStates(0, -1, [], [<blockstate:minecraft:stone_slab:half=bottom,variant=nether_brick>]);

////////////////////////////////////////////////////////////
// Modded Recipes
////////////////////////////////////////////////////////////
if(!isNull(loadedMods['biomesoplenty'])) {
  setBlocks(0, -1, [<blockstate:minecraft:water>], [<blockstate:biomesoplenty:blood>]);

  for item in <ore:treeLeaves>.items {
    setBlocks(0, -1, [item.asBlock().definition.defaultState], [<blockstate:biomesoplenty:ash_block>]);
  }
  setBlocks(0, -1, [
    <blockstate:appliedenergistics2:sky_stone_block>,
    <blockstate:minecraft:prismarine>,
    <blockstate:minecraft:piston>,
  ], [
    <blockstate:biomesoplenty:hive:variant=hive>,
    <blockstate:biomesoplenty:hive:variant=honeycomb>,
    <blockstate:biomesoplenty:hive:variant=filled_honeycomb>,
  ]);
  setBlocks(0, -1, [<blockstate:minecraft:snow_layer>], [<blockstate:biomesoplenty:blue_fire>]);
} else {

}

if(!isNull(loadedMods['netherendingores'])) {
  setStates(0, -1, [
    <blockstate:minecraft:iron_ore>,
    <blockstate:minecraft:redstone_ore>,
  ], [
    <blockstate:netherendingores:ore_nether_vanilla:blocks=coal_ore>,
  ]);
  setStates(0, -1, [<blockstate:minecraft:lapis_ore>], [<blockstate:netherendingores:ore_nether_vanilla:blocks=redstone_ore>]);

  setStates(0, -1, [
    <blockstate:minecraft:gold_ore>,
    <blockstate:thermalfoundation:ore:type=nickel>,
  ], [
    <blockstate:netherendingores:ore_nether_vanilla:blocks=iron_ore>,
  ]);
  setStates(0, -1, [<blockstate:minecraft:iron_ore>], [<blockstate:netherendingores:ore_nether_modded_1:blocks=aluminum_ore>]);

  setStates(0, -1, [<blockstate:forestry:resources:resource=apatite>], [<blockstate:netherendingores:ore_nether_modded_1:blocks=tin_ore>]);
  setStates(0, -1, [<blockstate:immersiveengineering:ore:type=uranium>], [<blockstate:netherendingores:ore_nether_modded_1:blocks=copper_ore>]);
  setStates(0, -1, [<blockstate:thaumcraft:ore_amber>], [<blockstate:netherendingores:ore_nether_modded_1:blocks=certus_quartz_ore>]);
  setStates(0, -1, [<blockstate:thaumcraft:ore_cinnabar>], [<blockstate:netherendingores:ore_nether_modded_1:blocks=charged_certus_quartz_ore>]);
  setStates(0, -1, [<blockstate:thermalfoundation:ore:type=platinum>], [<blockstate:netherendingores:ore_nether_modded_1:blocks=lead_ore>]);
} else {

}

if(!isNull(loadedMods['rustic'])) {
  setBlocks(0, -1, [<blockstate:minecraft:planks>], [<blockstate:rustic:painted_wood_black>]);
} else {

}

if(!isNull(loadedMods['chisel'])) {
  setBlocks(0, -1, [<blockstate:minecraft:hardened_clay>], [<blockstate:chisel:basalt2:variation=7>]);

  setStates(0, -1, [
    <blockstate:minecraft:stonebrick:variant=mossy_stonebrick>,
    <blockstate:minecraft:stonebrick:variant=chiseled_stonebrick>,
    <blockstate:minecraft:stonebrick:variant=cracked_stonebrick>,
    <blockstate:minecraft:stonebrick:variant=stonebrick>,
  ], [
    <blockstate:chisel:netherbrick:variation=7>,
  ]);
  setBlocks(0, -1, [<blockstate:minecraft:glass_pane>], [<blockstate:chisel:glasspane1:variation=0>]);
  setBlocks(0, -1, [<blockstate:minecraft:double_stone_slab>], [<blockstate:chisel:netherbrick:variation=7>]);
  setStates(0, -1, [<blockstate:minecraft:grass_path>], [<blockstate:chisel:netherrack:variation=12>]);
} else {

}

if(!isNull(loadedMods['exnihilocreatio'])) {
  setStates(0, -1, [<blockstate:minecraft:gravel>], [<blockstate:exnihilocreatio:block_netherrack_crushed>]);
} else {

}

if(!isNull(loadedMods['exnihilocreatio'])) {
  setStates(0, -1, [<blockstate:minecraft:sandstone:type=sandstone>], [<blockstate:mysticalagriculture:soulstone:variant=cobbled>]);
  setStates(0, -1, [<blockstate:minecraft:sandstone:type=chiseled_sandstone>], [<blockstate:mysticalagriculture:soulstone:variant=smooth>]);
  setStates(0, -1, [<blockstate:minecraft:sandstone:type=smooth_sandstone>], [<blockstate:mysticalagriculture:soulstone:variant=polished>]);
  setStates(0, -1, [<blockstate:minecraft:stone_slab:half=bottom,variant=sandstone>], [<blockstate:mysticalagriculture:soulstone_slab:half=bottom,lul=in_2017>]);
  setStates(0, -1, [<blockstate:minecraft:stone_slab:half=top,variant=sandstone>], [<blockstate:mysticalagriculture:soulstone_slab:half=top,lul=in_2017>]);
  setBlocks(0, -1, [<blockstate:minecraft:sandstone_stairs>], [<blockstate:mysticalagriculture:soulstone_brick_stairs>]);
  setStates(0, -1, [
    <blockstate:quark:sandstone_new:variant=sandstone_bricks>,
    <blockstate:quark:sandstone_new:variant=sandstone_smooth>,
  ], [
    <blockstate:mysticalagriculture:soulstone:variant=polished>,
  ]);
} else {

}

if(!isNull(loadedMods['advancedrocketry'])) {
  setOreBlocks(0, -1, <ore:logWood>, [
    <blockstate:advancedrocketry:charcoallog>,
  ]);
  setBlocks(0, -1, [<blockstate:quark:bark>], [<blockstate:advancedrocketry:charcoallog>]);
} else {

}

if(!isNull(loadedMods['quark'])) {
  setStates(0, -1, [<blockstate:minecraft:glass>], [<blockstate:quark:framed_glass>]);
  setStates(0, -1, [<blockstate:minecraft:stone_slab:half=bottom,variant=cobblestone>], [<blockstate:quark:fire_stone_slab:half=bottom,prop=blarg>]);
  setStates(0, -1, [<blockstate:minecraft:stone_slab:half=top,variant=cobblestone>], [<blockstate:quark:fire_stone_slab:half=top,prop=blarg>]);
  setBlocks(0, -1, [<blockstate:minecraft:stone_stairs>], [<blockstate:quark:fire_stone_stairs>]);
  setBlocks(0, -1, [<blockstate:minecraft:cobblestone_wall>], [<blockstate:quark:fire_stone_wall>]);
  setStates(0, -1, [
    <blockstate:minecraft:cobblestone>,
    <blockstate:minecraft:monster_egg:variant=cobblestone>,
  ], [
    <blockstate:quark:biome_cobblestone:variant=fire_stone>,
  ]);
  setStates(0, -1, [<blockstate:biomesoplenty:white_sand>], [<blockstate:quark:jasper:variant=stone_jasper>]);
  setStates(0, -1, [<blockstate:biomesoplenty:white_sandstone:variant=default>], [<blockstate:quark:jasper:variant=stone_jasper_smooth>]);
  setStates(0, -1, [<blockstate:biomesoplenty:white_sandstone:variant=chiseled>], [<blockstate:quark:world_stone_bricks:variant=stone_jasper_bricks>]);
  setStates(0, -1, [<blockstate:biomesoplenty:white_sandstone:variant=smooth>], [<blockstate:quark:world_stone_carved:variant=stone_jasper_carved>]);
  setBlocks(0, -1, [<blockstate:biomesoplenty:white_sandstone_stairs>], [<blockstate:quark:stone_jasper_stairs>]);
  setBlocks(0, -1, [<blockstate:minecraft:stained_hardened_clay>], [<blockstate:quark:sandstone_new:variant=soul_sandstone_smooth>]);
  setBlocks(0, -1, [<blockstate:quark:sandstone_wall>], [<blockstate:mysticalagriculture:soulstone_brick_wall>]);
} else {

}

if(!isNull(loadedMods['darkutils'])) {
  setBlocks(0, -1, [<blockstate:minecraft:wool>], [<blockstate:darkutils:slime_dyed>]);
} else {

}

if(!isNull(loadedMods['tconstruct'])) {
  setBlocks(0, -1, [<blockstate:minecraft:torch>], [<blockstate:tconstruct:stone_torch>]);
  setStates(0, -1, [
    <blockstate:actuallyadditions:block_misc:type=ore_black_quartz>,
    <blockstate:nuclearcraft:ore:type=thorium>,
    <blockstate:nuclearcraft:ore:type=boron>,
    <blockstate:nuclearcraft:ore:type=lithium>,
    <blockstate:nuclearcraft:ore:type=magnesium>,
  ], [
    <blockstate:tconstruct:ore:type=ardite>,
  ]);
  setBlocks(0, -1, [
    <blockstate:minecraft:diamond_ore>,
    <blockstate:minecraft:emerald_ore>,
    <blockstate:appliedenergistics2:quartz_ore>,
    <blockstate:appliedenergistics2:charged_quartz_ore>,
  ], [
    <blockstate:tconstruct:ore:type=cobalt>,
  ]);
} else {

}

if(!isNull(loadedMods['sonarcore'])) {
  setOreBlocks(0, -1, <ore:fenceWood>, [<blockstate:sonarcore:reinforcedstonefence>]);
} else {

}

if(!isNull(loadedMods['excompressum'])) {
  setStates(0, -1, [<blockstate:astralsorcery:blockcustomsandore:oretype=aquamarine>], [<blockstate:excompressum:compressed_block:variant=soul_sand>]);
} else {

}

if(!isNull(loadedMods['actuallyadditions'])) {
  setBlocks(0, -1, [<blockstate:astralsorcery:blockmarble>], [<blockstate:astralsorcery:blockblackmarble>]);
} else {

}

if(!isNull(loadedMods['iceandfire'])) {
  setBlocks(0, -1, [<blockstate:minecraft:hay_block>], [<blockstate:iceandfire:chared_gravel>]);
  setBlocks(0, -1, [<blockstate:minecraft:red_sandstone>], [<blockstate:iceandfire:chared_stone:revert=false>]);
} else {

}

if(!isNull(loadedMods['extrautils2'])) {
  setBlocks(0, -1, [<blockstate:minecraft:mycelium>], [<blockstate:extrautils2:cursedearth:decay=0>]);
} else {

}

if(!isNull(loadedMods['thaumcraft'])) {
  setStates(0, -1, [
    <blockstate:thaumcraft:stone_porous>,
  ], [
    <blockstate:forestry:ash_block_1>,
    <blockstate:forestry:ash_block_2>,
    <blockstate:forestry:ash_block_3>,
    <blockstate:additionalcompression:dustgunpowder_compressed:level=0>,
  ]);
} else {

}

if(!isNull(loadedMods['rats'])) {
  setStates(0, -1, [<blockstate:rats:garbage_pile>], [<blockstate:tconstruct:soil:type=grout>]);
} else {

}
