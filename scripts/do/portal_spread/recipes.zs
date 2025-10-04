/**
 * @file Create and store recipes for do.zs/portal_spread
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#ignoreBracketErrors
#modloaded zenutils
#priority 2000
#reloadable

import crafttweaker.block.IBlockDefinition;
import crafttweaker.block.IBlockState;
import crafttweaker.oredict.IOreDictEntry;

import scripts.do.portal_spread.config.Config;
import scripts.do.portal_spread.message.log;

/*
██╗   ██╗ █████╗ ██████╗ ██╗ █████╗ ██████╗ ██╗     ███████╗███████╗
██║   ██║██╔══██╗██╔══██╗██║██╔══██╗██╔══██╗██║     ██╔════╝██╔════╝
██║   ██║███████║██████╔╝██║███████║██████╔╝██║     █████╗  ███████╗
╚██╗ ██╔╝██╔══██║██╔══██╗██║██╔══██║██╔══██╗██║     ██╔══╝  ╚════██║
 ╚████╔╝ ██║  ██║██║  ██║██║██║  ██║██████╔╝███████╗███████╗███████║
  ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝
*/

zenClass Spread {
	zenConstructor() {}

  // Recipes for exact inputState => outputState
  val stateRecipes as IBlockState[][IBlockState][int][int] = {} as IBlockState[][IBlockState][int][int]$orderly;

  // Block numerical IDs that can be converted (completely or only some of their states)
  val transformableBlockNumIds as bool[IBlockDefinition][int][int] = {};

  // Block numerical IDs that would be converted no matter of state
  val wildcardedNumIds as bool[IBlockDefinition][int][int] = {};

  // Dimensions that copy its recipes from other dimensions
  val dimFallbacks as int[int] = {};

  // Same as above but flipped - list of all dimensions that depends on this one
  val dimDependents as int[][int] = {};

  // Set of dimensions that have recipes
  val dimHasRecipes as bool[int] = {};

  // Blocks that can't be converted
  val blacklistedBlockNumIds as bool[IBlockDefinition][int][int] = {
    0: {
      -1: {
        <blockstate:minecraft:air>.block.definition: true,
        <blockstate:minecraft:obsidian>.block.definition: true,
        <blockstate:minecraft:portal>.block.definition: true 
      },
    },
  };

  var initialized as bool = false;

  // Get recipes and initialize if needed
  function getRecipes(dimFrom as int, dimTo as int) as IBlockState[][IBlockState] {
    if (!initialized) init();

    if (isNull(stateRecipes[dimFrom])) return null;
    return stateRecipes[dimFrom][dimTo];
  }

  // Get one of cached lists for faster lookup
  function getNumIds(listName as string, dimFrom as int, dimTo as int) as bool[IBlockDefinition] {
    if (!initialized) init();

    val list = listName == 'transformable'
      ? transformableBlockNumIds
      : listName == 'blacklisted'
        ? blacklistedBlockNumIds
        : listName == 'wildcarded'
          ? wildcardedNumIds
          : null;

    if (isNull(list)) logger.logWarning('§5[portal_spread]§8 trying to get unexisting block list: ' ~ listName);

    if (isNull(list[dimFrom])) return null;
    return list[dimFrom][dimTo];
  }

  function haveBlocks(blocksTo as IBlockState[]) as bool {
    if (isNull(blocksTo)) return false;
    for blockTo in blocksTo {
      if (!isNull(blockTo)) return true;
    }
    return false;
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
  * Copy recipes from one dim to another
  * For example:
  * ```
  * // All recipes in dim 0 would be available in dim 3
  * setDimensionFallback(3, 0);
  * ```
  */
  function setDimensionFallback(copyDim as int, baseDim as int) as void {
    dimFallbacks[copyDim] = baseDim;
    dimHasRecipes[copyDim] = dimHasRecipes[baseDim];
    if (isNull(dimDependents[baseDim])) dimDependents[baseDim] = [] as int[];
    dimDependents[baseDim] = dimDependents[baseDim] + copyDim;
  }

  ////////////////////////////////////////////////////////////
  // Helper functions
  ////////////////////////////////////////////////////////////

  // Remove all transformable blocks from blacklist
  function init() as void {
    initialized = true;
    for dimFromId, dimFrom in transformableBlockNumIds {
      if (isNull(blacklistedBlockNumIds[dimFromId])) continue;

      for dimToId, dimTo in dimFrom {
        if (isNull(blacklistedBlockNumIds[dimFromId][dimToId])) continue;

        blacklistedBlockNumIds[dimFromId][dimToId] = mapAExceptB(
          blacklistedBlockNumIds[dimFromId][dimToId], dimTo
        );
      }
    }
  }

  // Remove keys of B from A
  function mapAExceptB(a as bool[IBlockDefinition], b as bool[IBlockDefinition]) as bool[IBlockDefinition] {
    val newOne = {} as bool[IBlockDefinition];

    for idA, _ in a {
      var isOutputInInput = false;
      for idB, _ in b {
        if (idB.id == idA.id) {
          isOutputInInput = true;
          break;
        }
      }
      if (!isOutputInInput) newOne[idA] = true;
    }

    return newOne;
  }

  /*
  ██████╗ ██╗   ██╗██╗██╗     ██████╗ ███████╗██████╗
  ██╔══██╗██║   ██║██║██║     ██╔══██╗██╔════╝██╔══██╗
  ██████╔╝██║   ██║██║██║     ██║  ██║█████╗  ██████╔╝
  ██╔══██╗██║   ██║██║██║     ██║  ██║██╔══╝  ██╔══██╗
  ██████╔╝╚██████╔╝██║███████╗██████╔╝███████╗██║  ██║
  ╚═════╝  ╚═════╝ ╚═╝╚══════╝╚═════╝ ╚══════╝╚═╝  ╚═╝
  */

  /**
   * Set conversion of one any states of blocks to another ones
   */
  function setAllNether(                        blocksFrom as IBlockState[], blocksTo as IBlockState[], fallback as IBlockState[] = null) as Spread { return setAll(0, -1, blocksFrom, blocksTo, fallback); }
  function setAll(dimFrom as int, dimTo as int, blocksFrom as IBlockState[], blocksTo as IBlockState[], fallback as IBlockState[] = null) as Spread {
    log('Creating new WILDCARDED recipe for ' ~ blocksFrom.length ~ ' new block states inputs and ' ~ blocksTo.length ~ ' outputs.');
    for blockFrom in blocksFrom {
      if (isNull(blockFrom)) continue;
      if (isNull(wildcardedNumIds[dimFrom])) wildcardedNumIds[dimFrom] = {};
      if (isNull(wildcardedNumIds[dimFrom][dimTo])) wildcardedNumIds[dimFrom][dimTo] = {};
      wildcardedNumIds[dimFrom][dimTo][blockFrom.block.definition] = true;

      set(dimFrom, dimTo, blockFrom.block.definition.defaultState, blocksTo, fallback);
    }
    return this;
  }

  /**
   * Set conversion of one specific states to another ones
   */
  function setNether(                        blocksFrom as IBlockState[], blocksTo as IBlockState[], fallback as IBlockState[] = null) as Spread { return set(0, -1, blocksFrom, blocksTo, fallback); }
  function set(dimFrom as int, dimTo as int, blocksFrom as IBlockState[], blocksTo as IBlockState[], fallback as IBlockState[] = null) as Spread {
    log('Creating new recipe for ' ~ blocksFrom.length ~ ' new block states inputs, and ' ~ blocksTo.length ~ ' outputs.');
    for blockFrom in blocksFrom {
      set(dimFrom, dimTo, blockFrom, blocksTo, fallback);
    }
    return this;
  }

  /**
   * Set conversion of one any states of oredict to another ones
   */
  function setAllNether(                        oredict as IOreDictEntry, blocksTo as IBlockState[], fallback as IBlockState[] = null) as Spread { return setAll(0, -1, oredict, blocksTo, fallback); }
  function setAll(dimFrom as int, dimTo as int, oredict as IOreDictEntry, blocksTo as IBlockState[], fallback as IBlockState[] = null) as Spread {
    log('Creating new OREDICT recipe for ' ~ oredict.commandString ~ ' inputs and ' ~ blocksTo.length ~ ' outputs.');
    for item in oredict.items {
      setAll(dimFrom, dimTo, [item.asBlock().definition.defaultState], blocksTo, fallback);
    }
    return this;
  }

  /**
   * Set conversion of one specific state to another ones
   *
   * Use <blockstate:minecraft:air> in blocksTo to remove block
   *
   */
  function setNether(                        blockFrom as IBlockState, blocksTo as IBlockState[], fallback as IBlockState[] = null) as Spread { return set(0, -1, blockFrom, blocksTo, fallback); }
  function set(dimFrom as int, dimTo as int, blockFrom as IBlockState, blocksTo as IBlockState[], fallback as IBlockState[] = null) as Spread {
    // Input block state doesn't exist
    if (isNull(blockFrom)) return this;

    if (Config.debug) {
      val serialized = [] as [string];
      for state in blocksTo { serialized.add(state.commandString); }
      log('  Creating new recipe for ' ~ blockFrom.commandString
        ~ ' input and outputs: ' ~ mods.zenutils.StaticString.join(serialized as string[], ', '));
    }

    // Determine if we need to use fallback
    var blocksToActual = blocksTo;
    if (!haveBlocks(blocksTo)) {
      if (isNull(fallback) || fallback.length == 0) {
        logger.logWarning(
          '§5[portal_spread]§8 recipe from dim §3' ~ dimFrom
          ~ ' §8to dim §3' ~ dimTo ~ ' §8have input §2' ~ blockFrom.commandString
          ~ ' §8but doesn\'t have any output.'
          ~ ' §8This is probably recipe registering problem, try to add proper fallback outputs.'
        );
        return this;
      }
      blocksToActual = fallback;
    }

    // Update stateRecipes maps
    if (isNull(stateRecipes[dimFrom])) stateRecipes[dimFrom] = {};
    if (isNull(stateRecipes[dimFrom][dimTo])) stateRecipes[dimFrom][dimTo] = {};

    // Update fast lookup maps
    if (isNull(transformableBlockNumIds[dimFrom])) transformableBlockNumIds[dimFrom] = {};
    if (isNull(transformableBlockNumIds[dimFrom][dimTo])) transformableBlockNumIds[dimFrom][dimTo] = {};
    transformableBlockNumIds[dimFrom][dimTo][blockFrom.block.definition] = true;

    stateRecipes[dimFrom][dimTo][blockFrom] = blocksToActual;

    // Update this dim and all dependent dims
    dimHasRecipes[dimFrom] = true;
    if (!isNull(dimDependents[dimFrom])) {
      for i, dep in dimDependents[dimFrom] {
        dimHasRecipes[dep] = true;
      }
    }

    // Update untransformable blocks
    for blockTo in blocksToActual {
      if (isNull(blockTo)) continue;
      if (isNull(blacklistedBlockNumIds[dimFrom])) blacklistedBlockNumIds[dimFrom] = {};
      if (isNull(blacklistedBlockNumIds[dimFrom][dimTo])) blacklistedBlockNumIds[dimFrom][dimTo] = {};
      blacklistedBlockNumIds[dimFrom][dimTo][blockTo.block.definition] = true;
    }
    return this;
  }
}

static spread as Spread = Spread();

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

val TERRAIN = [
  <blockstate:minecraft:netherrack>,
  <blockstate:minecraft:netherrack>,
  <blockstate:minecraft:netherrack>,
  <blockstate:minecraft:quartz_ore>,
  <blockstate:netherendingores:block_nether_netherfish>,
] as IBlockState[];

spread
.setAllNether([
  <blockstate:minecraft:grass>,
  <blockstate:minecraft:dirt>,
  <blockstate:minecraft:farmland>,
  <blockstate:biomesoplenty:grass>,
  <blockstate:biomesoplenty:dirt>,
], TERRAIN)
.setNether([
  <blockstate:minecraft:stone:variant=stone>,
], TERRAIN)
.setNether([
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
])
.setAllNether([
  <blockstate:minecraft:tallgrass>,
  <blockstate:biomesoplenty:plant_0>,
  <blockstate:minecraft:vine>,
  <blockstate:minecraft:wooden_door>,
], [
  <blockstate:minecraft:air>,
])
.setAllNether([
  <blockstate:minecraft:yellow_flower>,
  <blockstate:minecraft:red_flower>,
  <blockstate:biomesoplenty:flower_0>,
  <blockstate:biomesoplenty:flower_1>,
  <blockstate:botania:flower>,
], [
  <blockstate:minecraft:fire>,
])
.setNether([
  <blockstate:minecraft:coal_ore>,
  <blockstate:thermalfoundation:ore:type=copper>,
  <blockstate:thermalfoundation:ore:type=tin>,
  <blockstate:thermalfoundation:ore:type=lead>,
  <blockstate:thermalfoundation:ore:type=aluminum>,
], [
  <blockstate:minecraft:quartz_ore>,
])
.setAllNether([
  <blockstate:minecraft:mossy_cobblestone>,
  <blockstate:biomesoplenty:hard_ice>,
], [<blockstate:minecraft:magma>])
.setAllNether([
  <blockstate:minecraft:stone_brick_stairs>,
  <blockstate:minecraft:oak_stairs>,
  <blockstate:minecraft:spruce_stairs>,
  <blockstate:minecraft:birch_stairs>,
  <blockstate:minecraft:jungle_stairs>,
  <blockstate:minecraft:acacia_stairs>,
  <blockstate:minecraft:dark_oak_stairs>,
], [<blockstate:minecraft:nether_brick_stairs>])
.setAllNether(<ore:sand>, [<blockstate:minecraft:soul_sand>])
.setNether([<blockstate:minecraft:sea_lantern>], [<blockstate:minecraft:glowstone>])
.setAllNether([<blockstate:minecraft:ice>], [<blockstate:minecraft:obsidian>])
.setAllNether([
  <blockstate:minecraft:brick_block>,
  <blockstate:minecraft:double_wooden_slab>,
], [<blockstate:minecraft:nether_brick>])
.setNether([<blockstate:minecraft:diamond_block>], [<blockstate:minecraft:gold_block>])
.setNether([<blockstate:minecraft:melon_block>], [<blockstate:minecraft:nether_wart_block>])
.setNether([
  <blockstate:minecraft:slime>,
], [
  <blockstate:minecraft:bone_block:axis=x>,
  <blockstate:minecraft:bone_block:axis=x>,
  <blockstate:minecraft:bone_block:axis=z>,
  <blockstate:minecraft:bone_block:axis=y>,
])
.setAllNether([<blockstate:minecraft:wooden_slab>], [<blockstate:minecraft:stone_slab:variant=nether_brick>])
.setNether([
  <blockstate:minecraft:stone_slab:half=bottom,variant=stone_brick>,
  <blockstate:minecraft:stone_slab:half=bottom,variant=stone>,
], [<blockstate:minecraft:stone_slab:half=bottom,variant=nether_brick>])
.setNether([
  <blockstate:minecraft:stone_slab:half=top,variant=stone_brick>,
  <blockstate:minecraft:stone_slab:half=top,variant=stone>,
], [
  <blockstate:minecraft:stone_slab:half=top,variant=nether_brick>
])
.setAllNether([<blockstate:minecraft:pumpkin>], [<blockstate:minecraft:lit_pumpkin>])
;

////////////////////////////////////////////////////////////
// Modded Recipes
////////////////////////////////////////////////////////////
val AIR       = [<blockstate:minecraft:air>] as IBlockState[];
val GLOWSTONE = [<blockstate:minecraft:glowstone>] as IBlockState[];
val QUARTZ    = [<blockstate:minecraft:quartz_ore>] as IBlockState[];
val CONCRETE  = [<blockstate:minecraft:concrete_powder:color=black>] as IBlockState[];
val BRICK     = [<blockstate:minecraft:nether_brick>] as IBlockState[];
val SOULSAND  = [<blockstate:minecraft:soul_sand>] as IBlockState[];
val STAIRS    = [<blockstate:minecraft:nether_brick_stairs>] as IBlockState[];

// --------------------------
// Vanilla input
// --------------------------
spread
.setAllNether([<blockstate:minecraft:cobblestone_wall>], [<blockstate:quark:fire_stone_wall>], [<blockstate:minecraft:nether_brick_fence>])
.setAllNether([<blockstate:minecraft:double_stone_slab>], [<blockstate:chisel:netherbrick:variation=7>], BRICK)
.setAllNether([<blockstate:minecraft:glass_pane>], [<blockstate:chisel:glasspane1:variation=0>], [<blockstate:minecraft:stained_glass_pane:color=black>])
.setAllNether([<blockstate:minecraft:hardened_clay>], [<blockstate:chisel:basalt2:variation=7>], CONCRETE)
.setAllNether([<blockstate:minecraft:hay_block>], [<blockstate:iceandfire:chared_gravel>], SOULSAND)
.setAllNether([<blockstate:minecraft:mycelium>], [<blockstate:extrautils2:cursedearth:decay=0>], SOULSAND)
.setAllNether([<blockstate:minecraft:planks>], [<blockstate:rustic:painted_wood_black>], CONCRETE)
.setAllNether([<blockstate:minecraft:prismarine>, <blockstate:minecraft:piston>, <blockstate:appliedenergistics2:sky_stone_block>], [<blockstate:biomesoplenty:hive:variant=hive>, <blockstate:biomesoplenty:hive:variant=honeycomb>, <blockstate:biomesoplenty:hive:variant=filled_honeycomb>], GLOWSTONE)
.setAllNether([<blockstate:minecraft:red_sandstone>], [<blockstate:iceandfire:chared_stone:revert=false>], [<blockstate:minecraft:red_nether_brick>])
.setAllNether([<blockstate:minecraft:sandstone_stairs>], [<blockstate:mysticalagriculture:soulstone_brick_stairs>], STAIRS)
.setAllNether([<blockstate:minecraft:snow_layer>, <blockstate:minecraft:snow>], [<blockstate:biomesoplenty:blue_fire>], AIR)
.setAllNether([<blockstate:minecraft:stained_hardened_clay>], [<blockstate:quark:sandstone_new:variant=soul_sandstone_smooth>], TERRAIN)
.setAllNether([<blockstate:minecraft:stone_stairs>], [<blockstate:quark:fire_stone_stairs>], STAIRS)
.setAllNether([<blockstate:minecraft:torch>], [<blockstate:tconstruct:stone_torch>], [null])
.setAllNether([<blockstate:minecraft:wool>], [<blockstate:darkutils:slime_dyed>], [<blockstate:minecraft:fire>])
.setNether([<blockstate:minecraft:cobblestone>, <blockstate:minecraft:monster_egg:variant=cobblestone>], [<blockstate:quark:biome_cobblestone:variant=fire_stone>], TERRAIN)
.setNether([<blockstate:minecraft:glass>], [<blockstate:quark:framed_glass>], [<blockstate:minecraft:stained_glass:color=black>])
.setNether([<blockstate:thermalfoundation:ore:type=nickel>], [<blockstate:netherendingores:ore_nether_vanilla:blocks=iron_ore>], QUARTZ)
.setNether([<blockstate:minecraft:grass_path>], [<blockstate:chisel:netherrack:variation=12>], TERRAIN)
.setNether([<blockstate:minecraft:gravel>], [<blockstate:exnihilocreatio:block_netherrack_crushed>], TERRAIN)
.setNether([<blockstate:minecraft:redstone_ore>], [<blockstate:netherendingores:ore_nether_vanilla:blocks=coal_ore>], QUARTZ)
.setNether([<blockstate:minecraft:iron_ore>], [<blockstate:netherendingores:ore_nether_modded_1:blocks=aluminum_ore>], QUARTZ)
.setNether([<blockstate:minecraft:lapis_ore>, <blockstate:minecraft:diamond_ore>, <blockstate:minecraft:emerald_ore>], [<blockstate:netherendingores:ore_nether_vanilla:blocks=redstone_ore>], QUARTZ)
.setNether([<blockstate:minecraft:sandstone:type=chiseled_sandstone>], [<blockstate:mysticalagriculture:soulstone:variant=smooth>], TERRAIN)
.setNether([<blockstate:minecraft:sandstone:type=sandstone>], [<blockstate:mysticalagriculture:soulstone:variant=cobbled>], TERRAIN)
.setNether([<blockstate:minecraft:sandstone:type=smooth_sandstone>], [<blockstate:mysticalagriculture:soulstone:variant=polished>], TERRAIN)
.setNether([<blockstate:minecraft:stone_slab:half=bottom,variant=cobblestone>], [<blockstate:quark:fire_stone_slab:half=bottom,prop=blarg>              ], [<blockstate:minecraft:stone_slab:half=bottom,variant=nether_brick>])
.setNether([<blockstate:minecraft:stone_slab:half=bottom,variant=sandstone>  ], [<blockstate:mysticalagriculture:soulstone_slab:half=bottom,lul=in_2017>], [<blockstate:minecraft:stone_slab:half=bottom,variant=nether_brick>])
.setNether([<blockstate:minecraft:stone_slab:half=top,variant=cobblestone>   ], [<blockstate:quark:fire_stone_slab:half=top,prop=blarg>                 ], [<blockstate:minecraft:stone_slab:half=top,variant=nether_brick>])
.setNether([<blockstate:minecraft:stone_slab:half=top,variant=sandstone>     ], [<blockstate:mysticalagriculture:soulstone_slab:half=top,lul=in_2017>   ], [<blockstate:minecraft:stone_slab:half=top,variant=nether_brick>])
.setNether([<blockstate:minecraft:stonebrick:variant=mossy_stonebrick>, <blockstate:minecraft:stonebrick:variant=chiseled_stonebrick>, <blockstate:minecraft:stonebrick:variant=cracked_stonebrick>, <blockstate:minecraft:stonebrick:variant=stonebrick>], [<blockstate:chisel:netherbrick:variation=7>], BRICK)
.setNether([<blockstate:minecraft:water>], [<blockstate:biomesoplenty:blood>], [null, null, <blockstate:minecraft:air>, <blockstate:minecraft:netherrack>])
.setAllNether(<ore:fenceWood>, [<blockstate:sonarcore:reinforcedstonefence>], [<blockstate:minecraft:nether_brick_fence>])
.setAllNether(<ore:logWood>, [<blockstate:advancedrocketry:charcoallog>], BRICK)
.setAllNether(<ore:treeLeaves>, [<blockstate:biomesoplenty:ash_block>], AIR)

// --------------------------
// Modded Input
// --------------------------
.setAllNether([<blockstate:astralsorcery:blockmarble>], [<blockstate:astralsorcery:blockblackmarble>])
.setAllNether([<blockstate:biomesoplenty:white_sandstone_stairs>], [<blockstate:quark:stone_jasper_stairs>], STAIRS)
.setAllNether([<blockstate:floralchemy:hedge>], [<blockstate:twilightforest:thorns>], AIR)
.setAllNether([<blockstate:quark:bark>], [<blockstate:advancedrocketry:charcoallog>], SOULSAND)
.setAllNether([<blockstate:quark:sandstone_wall>], [<blockstate:mysticalagriculture:soulstone_brick_wall>], TERRAIN)
.setAllNether([<blockstate:astralsorcery:blockcustomore>], [<blockstate:tconstruct:ore:type=ardite>], QUARTZ)
.setAllNether([<blockstate:appliedenergistics2:quartz_ore>, <blockstate:appliedenergistics2:charged_quartz_ore>], [<blockstate:netherendingores:ore_nether_vanilla:blocks=lapis_ore>], QUARTZ)
.setNether([<blockstate:astralsorcery:blockcustomsandore:oretype=aquamarine>], [<blockstate:excompressum:compressed_block:variant=soul_sand>], QUARTZ)
.setNether([<blockstate:biomesoplenty:white_sand>], [<blockstate:quark:jasper:variant=stone_jasper>], SOULSAND)
.setNether([<blockstate:biomesoplenty:white_sandstone:variant=chiseled>], [<blockstate:quark:world_stone_bricks:variant=stone_jasper_bricks>], BRICK)
.setNether([<blockstate:biomesoplenty:white_sandstone:variant=default>], [<blockstate:quark:jasper:variant=stone_jasper_smooth>], BRICK)
.setNether([<blockstate:biomesoplenty:white_sandstone:variant=smooth>], [<blockstate:quark:world_stone_carved:variant=stone_jasper_carved>], BRICK)
.setNether([<blockstate:forestry:resources:resource=apatite>], [<blockstate:netherendingores:ore_nether_modded_1:blocks=tin_ore>], QUARTZ)
.setNether([<blockstate:minecraft:gold_ore>, <blockstate:immersiveengineering:ore:type=uranium>, <blockstate:nuclearcraft:ore:type=thorium>, <blockstate:nuclearcraft:ore:type=boron>, <blockstate:nuclearcraft:ore:type=lithium>, <blockstate:nuclearcraft:ore:type=magnesium>], [<blockstate:netherendingores:ore_nether_modded_1:blocks=copper_ore>, <blockstate:netherendingores:ore_nether_modded_1:blocks=lead_ore>], QUARTZ)
.setNether([<blockstate:quark:sandstone_new:variant=sandstone_bricks>, <blockstate:quark:sandstone_new:variant=sandstone_smooth>], [<blockstate:mysticalagriculture:soulstone:variant=polished>], BRICK)
.setNether([<blockstate:rats:garbage_pile>], [<blockstate:tconstruct:soil:type=grout>], SOULSAND)
.setNether([<blockstate:thaumcraft:ore_amber>, <blockstate:actuallyadditions:block_misc:type=ore_black_quartz>], [<blockstate:netherendingores:ore_nether_modded_1:blocks=certus_quartz_ore>], QUARTZ)
.setNether([<blockstate:thaumcraft:ore_cinnabar>], [<blockstate:netherendingores:ore_nether_modded_1:blocks=charged_certus_quartz_ore>], QUARTZ)
.setNether([<blockstate:thaumcraft:stone_porous>], [<blockstate:forestry:ash_block_1>, <blockstate:forestry:ash_block_2>, <blockstate:forestry:ash_block_3>, <blockstate:additionalcompression:dustgunpowder_compressed:level=0>], [<blockstate:minecraft:coal_block>])
.setNether([<blockstate:thermalfoundation:ore:type=platinum>], [<blockstate:tconstruct:ore:type=cobalt>], QUARTZ)
;
