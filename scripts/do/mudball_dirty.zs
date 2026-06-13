#modloaded biomesoplenty
#reloadable
#ignoreBracketErrors

import crafttweaker.block.IBlockDefinition;
import crafttweaker.block.IBlockState;
import crafttweaker.event.ProjectileImpactThrowableEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;

// ===== Manual explicit pairs =====
// These take precedence over dynamic detection
static manualPairs as IItemStack[IItemStack] = {
  // Natural terrain → dirty
  <minecraft:grass>: <minecraft:dirt>,
  <minecraft:grass_path>: <minecraft:dirt>,
  <minecraft:farmland>: <minecraft:dirt>,
  <minecraft:mycelium>: <minecraft:dirt>,
  <minecraft:dirt>: <biomesoplenty:mud>,
  <minecraft:sand>: <biomesoplenty:mud>,

  // Clear glass → brown stained
  <minecraft:glass>: <minecraft:stained_glass:12>,
  <minecraft:glass_pane>: <minecraft:stained_glass_pane:12>,
  <minecraft:white_glazed_terracotta>: <minecraft:brown_glazed_terracotta>,

  // BoP grass → dirt variants
  <biomesoplenty:grass:2>: <biomesoplenty:dirt>,
  <biomesoplenty:grass:3>: <biomesoplenty:dirt:1>,
  <biomesoplenty:grass:4>: <biomesoplenty:dirt:2>,
  <biomesoplenty:grass:7>: <biomesoplenty:dirt>,
  <biomesoplenty:dirt>: <biomesoplenty:mud>,
  <biomesoplenty:dirt:1>: <biomesoplenty:mud>,
  <biomesoplenty:dirt:2>: <biomesoplenty:mud>,
} as IItemStack[IItemStack];

// ===== Cache for manual pairs =====
static initialized as bool = false;
static muddyCache as IBlockState[IItemStack][IBlockDefinition] = {} as IBlockState[IItemStack][IBlockDefinition];

function addToCache(clean as IItemStack, dirty as IItemStack) as void {
  if (isNull(clean) || isNull(dirty)) return;
  val asBlock = clean.asBlock();
  if (isNull(asBlock)) return;
  val def = asBlock.definition;
  if (isNull(def)) return;
  if (isNull(muddyCache[def])) {
    muddyCache[def] = {} as IBlockState[IItemStack];
  }
  muddyCache[def][clean] = utils.getStateFromItem(dirty);
}

function init() as void {
  if (initialized) return;
  initialized = true;
  for cleanItem, dirtyItem in manualPairs {
    addToCache(cleanItem, dirtyItem);
  }
  print('mudball_dirty init: ' ~ manualPairs.length ~ ' manual pairs loaded, dynamic 16-color detection enabled');
}

// ===== Dynamic 16-color block detection =====

// ===== Standard Minecraft dye colors (lowercase) =====
static STANDARD_COLORS as string[] = [
  'white', 'orange', 'magenta', 'light_blue',
  'yellow', 'lime', 'pink', 'gray',
  'light_gray', 'cyan', 'purple', 'blue',
  'brown', 'green', 'red', 'black',
];

function strEndsWith(s as string, suffix as string) as bool {
  if (s.length() < suffix.length()) return false;
  return s.substring(s.length() - suffix.length()) == suffix;
}

function getNormalizedColor(v as string) as string {
  val lower = v.toLowerCase();
  for c in STANDARD_COLORS {
    if (lower == c) return c;
    if (strEndsWith(lower, '_' ~ c)) return c;
  }
  if (lower == 'silver' || strEndsWith(lower, '_silver')) return 'light_gray';
  return null;
}

function getBrownState(state as IBlockState) as IBlockState {
  if (isNull(state)) return null;
  val propNames = state.getPropertyNames();
  for propName in propNames {
    val values = state.getAllowedValuesForProperty(propName);
    if (values.length != 16) continue;
    var brownOriginal as string = null;
    var allColors as bool = true;
    for v in values {
      val normColor = getNormalizedColor(v);
      if (isNull(normColor)) { allColors = false; break; }
      if (normColor == 'brown') brownOriginal = v;
    }
    if (allColors && !isNull(brownOriginal)) {
      val currentValue = state.getPropertyValue(propName);
      if (currentValue == brownOriginal) return null;
      print('mudball_dirty: 16-color block detected, property=' ~ propName ~ ' brown=' ~ brownOriginal);
      return state.withProperty(propName, brownOriginal.toLowerCase());
    }
    if (!isNull(brownOriginal)) {
      print('mudball_dirty: skipped ' ~ state.block.definition.id ~ ' (already brown)');
    }
  }
  return null;
}

events.onProjectileImpactThrowable(function (e as ProjectileImpactThrowableEvent) {
  if (isNull(e.entity) || isNull(e.entity.world) || e.entity.world.remote) return;

  val entityDef = e.entity.definition;
  if (isNull(entityDef) || entityDef.id != 'biomesoplenty:mudball') return;

  val rayTrace = e.rayTrace;
  if (isNull(rayTrace) || !rayTrace.isBlock) return;

  init();

  val pos = rayTrace.blockPos;
  val world = e.entity.world;
  val blockState = world.getBlockState(pos);
  if (isNull(blockState) || isNull(blockState.block) || isNull(blockState.block.definition)) return;

  val blockDef = blockState.block.definition;
  val blockId = blockDef.id;

  print('mudball_dirty: hit ' ~ blockId ~ ' meta=' ~ blockState.meta);

  // Step 1: Check manualPairs cache (terrain, glass, etc.)
  val recipesForDef = muddyCache[blockDef];
  if (!isNull(recipesForDef)) {
    for cleanItem, dirtyState in recipesForDef {
      val meta = blockState.meta;
      val wildcarded = cleanItem.damage == 32767;
      if (!wildcarded && meta != cleanItem.damage) continue;
      print('mudball_dirty: manual cache match → dirty');
      if (!world.remote) {
        world.destroyBlock(pos, false);
        world.setBlockState(dirtyState, pos);
      }
      return;
    }
  }

  // Step 2: Dynamic 16-color detection
  val brownState = getBrownState(blockState);
  if (!isNull(brownState)) {
    print('mudball_dirty: dynamic 16-color match → brown');
    if (!world.remote) {
      world.destroyBlock(pos, false);
      world.setBlockState(brownState, pos);
    }
    return;
  }

  print('mudball_dirty: no match for ' ~ blockId);
});

// ===== Debug: place all color variants of 16-color blocks in world =====
function debugPlaceAllColors(world as IWorld, pos as IBlockPos) as void {
  var placed = 0;
  val seenIds = {} as bool[string];
  for item in game.items {
    if (
      item.id.startsWith('avaritiafurnace:')
      || item.id.startsWith('bithop:screwhop')
      || item.id.startsWith('bibliocraft:')
    ) {
      continue;
    }
    var lastMeta = -1 as int;
    for sub in item.subItems {
      if (lastMeta == sub.damage) continue;
      lastMeta = sub.damage;
      val state = utils.getStateFromItem(sub);
      if (isNull(state)) continue;
      val defId = state.block.definition.id;
      if (!isNull(seenIds[defId])) continue;

      // Find a 16-color property
      val propNames = state.getPropertyNames();
      var colorProp as string = null;
      for propName in propNames {
        val values = state.getAllowedValuesForProperty(propName);
        if (values.length != 16) continue;
        var allColors = true;
        for v in values {
          if (isNull(getNormalizedColor(v))) { allColors = false; break; }
        }
        if (allColors) { colorProp = propName; break; }
      }
      if (isNull(colorProp)) continue;

      seenIds[defId] = true;

      // Place all 16 color variants
      val values = state.getAllowedValuesForProperty(colorProp);
      for v in values {
        val coloredState = state.withProperty(colorProp, v.toLowerCase());
        val newPos = pos.east(placed % 9).north(placed / 9);
        world.setBlockState(coloredState, newPos);
        placed += 1;
      }
    }
  }
}

events.onPlayerLeftClickBlock(function (e as crafttweaker.event.PlayerLeftClickBlockEvent) {
  if (e.player.world.remote) return;
  if (isNull(e.player.currentItem)) return;
  if (!utils.DEBUG) return;
  if (!e.player.creative) return;
  if (!(<biomesoplenty:mudball> has e.player.currentItem)) return;

  debugPlaceAllColors(e.world, e.position.up(1));
  e.cancel();
});
