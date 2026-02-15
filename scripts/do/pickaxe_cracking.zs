/**
 * @file Adds a "cracking" mechanic for pickaxes.
 * Right-clicking certain blocks with a pickaxe will turn them into their cracked variants,
 * damage the tool, and create block-breaking particles.
 * This version supports property-preserving transformations for blocks like stairs and slabs.
 *
 * @author Krutoy242
 */

#reloadable
#ignoreBracketErrors
#modloaded zenutils

import crafttweaker.block.IBlockDefinition;
import crafttweaker.block.IBlockState;
import crafttweaker.event.PlayerInteractBlockEvent;
import crafttweaker.item.IItemStack;
import native.net.minecraft.util.EnumHand;

static statCrackedBlocks as mods.zenutils.PlayerStat = mods.zenutils.PlayerStat.getBasicStat('stat.cracked_blocks');

// A map of original itemstacks to their cracked variants.
// For blocks with different states (like stairs), use wildcard damage <...:*> to match any state of that block.
// For slabs and other blocks which "meta" does not represent block, use speciific blockstate ".meta" getter.
static crackedMap as IItemStack[IItemStack] = {
  <minecraft:stonebrick>: <minecraft:stonebrick:2>,
  <chisel:stonebrick:1>: <chisel:stonebrick:2>,
  <botania:livingrock:1>: <botania:livingrock:3>,
  <iceandfire:dread_stone_bricks>: <iceandfire:dread_stone_bricks_cracked>,
  <mysticalagriculture:soulstone:3>: <mysticalagriculture:soulstone:4>,
  <randomthings:biomestone:2>: <randomthings:biomestone:3>,
  <rats:marbled_cheese_brick>: <rats:marbled_cheese_brick_cracked>,
  <twilightforest:maze_stone:1>: <twilightforest:maze_stone:4>,
  <twilightforest:underbrick>: <twilightforest:underbrick:2>,
  <twilightforest:deadrock>: <twilightforest:deadrock:1>,
  <twilightforest:castle_brick>: <twilightforest:castle_brick:2>,
  <twilightforest:castle_stairs_brick:*>: <twilightforest:castle_stairs_cracked>,
  <tconstruct:seared:3>: <tconstruct:seared:4>,
  <tconstruct:seared_slab:3>: <tconstruct:seared_slab:4>,
  <tconstruct:seared_slab>.withDamage(<blockstate:tconstruct:seared_slab:half=top,type=brick>.meta): <tconstruct:seared_slab>.withDamage(<blockstate:tconstruct:seared_slab:half=top,type=brick_cracked>.meta),
  <tconstruct:seared_stairs_brick:*>: <tconstruct:seared_stairs_brick_cracked>,
  <tconstruct:brownstone:3>: <tconstruct:brownstone:4>,
  <tconstruct:brownstone_slab:3>: <tconstruct:brownstone_slab:4>,
  <tconstruct:brownstone_slab>.withDamage(<blockstate:tconstruct:brownstone_slab:half=top,type=brick>.meta): <tconstruct:brownstone_slab>.withDamage(<blockstate:tconstruct:brownstone_slab:half=top,type=brick_cracked>.meta),
  <tconstruct:brownstone_stairs_brick:*>: <tconstruct:brownstone_stairs_brick_cracked>,
  <tcomplement:scorched_block:3>: <tcomplement:scorched_block:4>,
  <tcomplement:scorched_slab:3>: <tcomplement:scorched_slab:4>,
  <tcomplement:scorched_slab>.withDamage(<blockstate:tcomplement:scorched_slab:half=top,type=brick>.meta): <tcomplement:scorched_slab>.withDamage(<blockstate:tcomplement:scorched_slab:half=top,type=brick_cracked>.meta),
  <tcomplement:scorched_stairs_brick:*>: <tcomplement:scorched_stairs_brick_cracked>,
  <quark:world_stone_bricks:2>: <chisel:andesite1:8>,
  <chisel:andesite1:8>: <chisel:andesite:1>,
  <chisel:andesite:1>: <chisel:andesite:2>,
  <thaumcraft:stone_arcane>: <chisel:arcane_stone>,
  <thaumcraft:stone_arcane_brick>: <chisel:arcane_stone1:12>,
  <chisel:arcane_stone:1>: <chisel:arcane_stone:2>,
  <quark:world_stone_bricks>: <chisel:granite1:8>,
  <chisel:granite1:8>: <chisel:granite:1>,
  <chisel:granite:1>: <chisel:granite:2>,
  <chisel:basalt2:7>: <chisel:basalt>,
  <chisel:basalt2>: <chisel:basalt:1>,
  <chisel:basalt:1>: <chisel:basalt:2>,
  <chisel:bricks2>: <chisel:bricks:1>,
  <chisel:bricks:1>: <chisel:bricks:2>,
  <minecraft:stone:3>: <chisel:diorite>,
  <chisel:diorite1:8>: <chisel:diorite:1>,
  <chisel:diorite:1>: <chisel:diorite:2>,
  <minecraft:hardened_clay>: <chisel:hardenedclay>,
  <chisel:hardenedclay2>: <chisel:hardenedclay:1>,
  <chisel:hardenedclay:1>: <chisel:hardenedclay:2>,
  <chisel:temple:2>: <chisel:temple:3>,
  <chisel:templemossy:2>: <chisel:templemossy:3>,
  <chisel:waterstone1:8>: <chisel:waterstone:1>,
  <chisel:waterstone:1>: <chisel:waterstone:2>,
  <chisel:lavastone1:8>: <chisel:lavastone:1>,
  <chisel:lavastone:1>: <chisel:lavastone:2>,
  <minecraft:end_stone>: <chisel:endstone>,
  <chisel:endstone2>: <chisel:endstone:1>,
  <chisel:endstone:1>: <chisel:endstone:2>,
  <minecraft:glowstone>: <chisel:glowstone>,
  <chisel:glowstone1:5>: <chisel:glowstone:1>,
  <chisel:glowstone:1>: <chisel:glowstone:2>,
  <minecraft:redstone_block>: <chisel:redstone>,
  <chisel:redstone1:5>: <chisel:redstone:1>,
  <chisel:redstone:1>: <chisel:redstone:2>,
  <appliedenergistics2:quartz_block>: <chisel:certus>,
  <chisel:certus1:8>: <chisel:certus:1>,
  <chisel:certus:1>: <chisel:certus:2>,
  <thermalfoundation:storage_resource>: <chisel:block_charcoal>,
  <chisel:block_charcoal1:8>: <chisel:block_charcoal:1>,
  <chisel:block_charcoal:1>: <chisel:block_charcoal:2>,
  <minecraft:cobblestone>: <chisel:cobblestone>,
  <chisel:cobblestone2>: <chisel:cobblestone:1>,
  <chisel:cobblestone:1>: <chisel:cobblestone:2>,
  <minecraft:coal_block>: <chisel:block_coal>,
  <chisel:block_coal1:8>: <chisel:block_coal:1>,
  <chisel:block_coal:1>: <chisel:block_coal:2>,
  <minecraft:ice>: <chisel:ice>,
  <chisel:ice1:8>: <chisel:ice:1>,
  <chisel:ice:1>: <chisel:ice:2>,
  <chisel:limestone2:7>: <chisel:limestone>,
  <chisel:limestone2>: <chisel:limestone:1>,
  <chisel:limestone:1>: <chisel:limestone:2>,
  <chisel:marble2:7>: <chisel:marble>,
  <chisel:marble2>: <chisel:marble:1>,
  <chisel:marble:1>: <chisel:marble:2>,
  <minecraft:prismarine>: <chisel:prismarine>,
  <chisel:prismarine2>: <chisel:prismarine:1>,
  <chisel:prismarine:1>: <chisel:prismarine:2>,
  <minecraft:mossy_cobblestone>: <chisel:cobblestonemossy>,
  <chisel:cobblestonemossy1:8>: <chisel:cobblestonemossy:1>,
  <chisel:cobblestonemossy:1>: <chisel:cobblestonemossy:2>,
  <minecraft:concrete:15>: <chisel:concrete_black>,
  <chisel:concrete_black1:8>: <chisel:concrete_black:1>,
  <chisel:concrete_black:1>: <chisel:concrete_black:2>,
  <minecraft:concrete:11>: <chisel:concrete_blue>,
  <chisel:concrete_blue1:8>: <chisel:concrete_blue:1>,
  <chisel:concrete_blue:1>: <chisel:concrete_blue:2>,
  <minecraft:concrete:12>: <chisel:concrete_brown>,
  <chisel:concrete_brown1:8>: <chisel:concrete_brown:1>,
  <chisel:concrete_brown:1>: <chisel:concrete_brown:2>,
  <minecraft:concrete:13>: <chisel:concrete_green>,
  <chisel:concrete_green1:8>: <chisel:concrete_green:1>,
  <chisel:concrete_green:1>: <chisel:concrete_green:2>,
  <minecraft:concrete:14>: <chisel:concrete_red>,
  <chisel:concrete_red1:8>: <chisel:concrete_red:1>,
  <chisel:concrete_red:1>: <chisel:concrete_red:2>,
  <minecraft:concrete:7>: <chisel:concrete_gray>,
  <chisel:concrete_gray1:8>: <chisel:concrete_gray:1>,
  <chisel:concrete_gray:1>: <chisel:concrete_gray:2>,
  <minecraft:concrete:8>: <chisel:concrete_lightgray>,
  <chisel:concrete_lightgray1:8>: <chisel:concrete_lightgray:1>,
  <chisel:concrete_lightgray:1>: <chisel:concrete_lightgray:2>,
  <minecraft:concrete:9>: <chisel:concrete_cyan>,
  <chisel:concrete_cyan1:8>: <chisel:concrete_cyan:1>,
  <chisel:concrete_cyan:1>: <chisel:concrete_cyan:2>,
  <minecraft:concrete:10>: <chisel:concrete_purple>,
  <chisel:concrete_purple1:8>: <chisel:concrete_purple:1>,
  <chisel:concrete_purple:1>: <chisel:concrete_purple:2>,
  <minecraft:concrete:3>: <chisel:concrete_lightblue>,
  <chisel:concrete_lightblue1:8>: <chisel:concrete_lightblue:1>,
  <chisel:concrete_lightblue:1>: <chisel:concrete_lightblue:2>,
  <minecraft:concrete:4>: <chisel:concrete_yellow>,
  <chisel:concrete_yellow1:8>: <chisel:concrete_yellow:1>,
  <chisel:concrete_yellow:1>: <chisel:concrete_yellow:2>,
  <minecraft:concrete:5>: <chisel:concrete_lime>,
  <chisel:concrete_lime1:8>: <chisel:concrete_lime:1>,
  <chisel:concrete_lime:1>: <chisel:concrete_lime:2>,
  <minecraft:concrete:6>: <chisel:concrete_pink>,
  <chisel:concrete_pink1:8>: <chisel:concrete_pink:1>,
  <chisel:concrete_pink:1>: <chisel:concrete_pink:2>,
  <minecraft:concrete:2>: <chisel:concrete_magenta>,
  <chisel:concrete_magenta1:8>: <chisel:concrete_magenta:1>,
  <chisel:concrete_magenta:1>: <chisel:concrete_magenta:2>,
  <minecraft:concrete:1>: <chisel:concrete_orange>,
  <chisel:concrete_orange1:8>: <chisel:concrete_orange:1>,
  <chisel:concrete_orange:1>: <chisel:concrete_orange:2>,
  <minecraft:concrete>: <chisel:concrete_white>,
  <chisel:concrete_white1:8>: <chisel:concrete_white:1>,
  <chisel:concrete_white:1>: <chisel:concrete_white:2>,
  <minecraft:sandstone>: <chisel:sandstoneyellow>,
  <chisel:sandstoneyellow2>: <chisel:sandstoneyellow:1>,
  <chisel:sandstoneyellow:1>: <chisel:sandstoneyellow:2>,
  <minecraft:red_sandstone>: <chisel:sandstonered>,
  <chisel:sandstonered2>: <chisel:sandstonered:1>,
  <chisel:sandstonered:1>: <chisel:sandstonered:2>,
  <chisel:block_coal_coke2:1>: <chisel:block_coal_coke>,
  <chisel:block_coal_coke1:8>: <chisel:block_coal_coke:1>,
  <chisel:block_coal_coke:1>: <chisel:block_coal_coke:2>,
} as IItemStack[IItemStack];

// --- Caching for performance ---
static initialized as bool = false;
static crackableDefs as IBlockState[IItemStack][IBlockDefinition] = {} as IBlockState[IItemStack][IBlockDefinition];

function init() as void {
  if (initialized) return;
  initialized = true;

  for originalItem, crackedItem in crackedMap {
    if (isNull(originalItem) || isNull(crackedItem)) continue;

    val originalDef = originalItem.asBlock().definition;
    if (isNull(originalDef)) continue;

    if (isNull(crackableDefs[originalDef])) {
      crackableDefs[originalDef] = {} as IBlockState[IItemStack];
    }
    crackableDefs[originalDef][originalItem] = utils.getStateFromItem(crackedItem);
  }
}

events.register(function (e as PlayerInteractBlockEvent) {
  if (e.hand != 'MAIN_HAND' || e.player.isSneaking) return;

  val item = e.item;
  if (isNull(item) || !(item.toolClasses has 'pickaxe')) return;

  init();
  val blockState = e.blockState;
  val recipesForDef = crackableDefs[blockState.block.definition];
  if (isNull(recipesForDef)) return;

  if (!item.canHarvestBlock(blockState)) return;

  for originalItem, crackedStateDef in recipesForDef {
    // If the original item has a specific meta, check if the block state matches that meta.
    val wildcarded = originalItem.damage == 32767;
    if (!wildcarded && blockState.meta != originalItem.damage) continue;

    // Match found, now perform the transformation.
    var crackedState = crackedStateDef;
    if (wildcarded) {
      for propName in blockState.getPropertyNames() {
        if (crackedState.getPropertyNames() has propName) {
          val propValue = blockState.getPropertyValue(propName);
          if (crackedState.getAllowedValuesForProperty(propName) has propValue) {
            crackedState = crackedState.withProperty(propName, propValue.toLowerCase());
          }
        }
      }
    }

    if (e.world.remote) {
      e.player.native.swingArm(EnumHand.MAIN_HAND);
    } else {
      // Replace the block and create particles.
      e.world.destroyBlock(e.position, false);
      e.world.setBlockState(crackedState, e.position);

      // Damage the tool if not in creative mode.
      if (!e.player.creative) {
        item.mutable().damageItem(1, e.player);
      }

      e.player.addStat(statCrackedBlocks, 1);
    }

    e.cancel();
    return; // Exit after processing the first valid match.
  }
});
