/**
 * @file Make portals spread their dimension blocks around
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#reloadable
#modloaded zenutils

import crafttweaker.block.IBlockDefinition;
import crafttweaker.block.IBlockState;
import crafttweaker.data.IData;
import crafttweaker.util.Position3f;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;

import scripts.do.portal_spread.config.Config;
import scripts.do.portal_spread.data.getDimsMap;
import scripts.do.portal_spread.data.portalIdToPos;
import scripts.do.portal_spread.data.removePortal;
import scripts.do.portal_spread.data.updatePortal;
import scripts.do.portal_spread.message.log;
import scripts.do.portal_spread.message.notifyPlayers;
import scripts.do.portal_spread.modifiers.getModifiers;
import scripts.do.portal_spread.recipes.spread;
import scripts.do.portal_spread.utils.getNextPoint;
import native.net.minecraft.util.EnumParticleTypes;

////////////////////////////////////////////////////

// Save new portal coordinates
events.onPortalSpawn(function (e as crafttweaker.event.PortalSpawnEvent) {
  log('onPortalSpawn event thrown in world §7' ~ e.world.dimension ~ ' §8at pos: §7' ~ e.position.x ~ '§8:§7' ~ e.position.y ~ '§8:§7' ~ e.position.z, e.world);
  if (!e.valid) return log('portal not valid', e.world);
  if (e.world.remote) return log('event is client sided', e.world);
  for dim, _ in spread.dimHasRecipes {
    log('dim with recipe: ' ~ dim);
  }
  if (isNull(spread.dimHasRecipes[e.world.dimension])) return log("this dimension doesn't have recipes", e.world);

  updatePortal(e.world, -1, e.position);
});

// Convert blocks around portal
events.onWorldTick(function (e as crafttweaker.event.WorldTickEvent) {
  if (e.world.remote || e.phase != 'END') return;
  if (isNull(spread.dimHasRecipes[e.world.dimension])) return;
  val fallback = spread.dimFallbacks[e.world.dimension];
  val recipeDimId = !isNull(fallback) ? (fallback as int) : e.world.dimension;

  // Skip ticks for every portal
  val spreadDelayInt = Config.spreadDelay as int;
  if (spreadDelayInt > 1 && e.world.time % spreadDelayInt != 0) return;

  for targetDimIdStr, dimData in getDimsMap(e.world).asMap() {
    if (isNull(dimData) || isNull(dimData.asMap())) continue;
    tickPortalsToWorld(e.world, targetDimIdStr, dimData, recipeDimId);
  }
});

// Cache userful maps from recipes
// of specified [Portal origin] => [portal towards] directions
zenClass DirectionMapCache {
  var spreadStateRecipes as IBlockState[][IBlockState];
  var spreadWhitelist as bool[IBlockDefinition];
  var spreadBlacklist as bool[IBlockDefinition];
  var spreadWildcards as bool[IBlockDefinition];

  zenConstructor() {}
  function update(recipeDimId as int, targetDimIdStr as string) as bool {
    spreadStateRecipes = spread.getRecipes(recipeDimId, targetDimIdStr); if (isNull(spreadStateRecipes)) return false;
    spreadWhitelist = spread.getNumIds('transformable', recipeDimId, targetDimIdStr); if (isNull(spreadWhitelist)) return false;
    spreadBlacklist = spread.getNumIds('blacklisted', recipeDimId, targetDimIdStr); if (isNull(spreadBlacklist)) return false;
    spreadWildcards = spread.getNumIds('wildcarded', recipeDimId, targetDimIdStr); if (isNull(spreadWildcards)) return false;
    return true;
  }
}
static currentDirection as DirectionMapCache = DirectionMapCache();

function tickPortalsToWorld(world as IWorld, targetDimIdStr as string, dimData as IData, recipeDimId as int) as void {
  if (!currentDirection.update(recipeDimId, targetDimIdStr)) return;
  /*
      ████
    ██▒▒▒▒██
    ██▒▒▒▒██
    ██▒▒▒▒██
  ░░░░████░░░░
  */
  for portalId, portalData in dimData.asMap() {
    val portalPos = portalIdToPos(portalId);
    val blockPos = portalPos as IBlockPos;

    // Portal not loaded
    if (!world.isBlockLoaded(blockPos)) continue;

    val blockState = world.getBlockState(blockPos);

    // Portal is destroyed
    val fullPortalId = world.dimension ~ ':' ~ portalId;
    if (isNull(blockState) || blockState.block.definition.id != 'minecraft:portal') {
      destroyPortal(world, targetDimIdStr, portalId, fullPortalId);
      notifyPlayers(world, portalPos, 'broken');
      continue;
    }

    // Get modifiers
    val modifiers = getModifiers(world, fullPortalId, portalData, targetDimIdStr, blockPos, blockState, portalPos);

    // Skip if portal shrinked to zero size
    val maxSpreadIndex = scripts.do.portal_spread.modifiers.getMaxSpreadIndex(modifiers);
    if (maxSpreadIndex <= 0) continue;

    // Skip generation on slow modifier
    val trueDelay = scripts.do.portal_spread.modifiers.getTrueDelay(modifiers);
    if (trueDelay <= 0) continue;

    // Skip generation on slow modifier
    if (trueDelay >= 1.0 && (world.time % (trueDelay as int)) != 0) continue;

    // Determine how many blocks could be transformed in one run
    val repeats = (1.0 / trueDelay) as int;

    // Show particles only if player nerbly
    val showParticles = isShowParticles(world, portalPos);

    val trueLookup = scripts.do.portal_spread.modifiers.getTrueLookup(modifiers);
    if (trueLookup <= 0) continue;

    // Repeat
    var somethingReplaced = false;
    for i in 0 .. max(repeats, 1) {
      for j in 0 .. trueLookup {
        val spreadPos = getNexPortalPos(fullPortalId, portalPos, maxSpreadIndex);
        if (spreadBlock(
          world,
          spreadPos,
          showParticles
        )) {
          somethingReplaced = true;
          break;
        }
      }
    }

    // Reset lookup radius to allow automation closest block near portal
    if (somethingReplaced && !Config.debug) portalIndexes[fullPortalId] = 1;
  }
}

// Current iteration index for a portal
// Requre fullPortalID "dim:x:y:z"
static portalIndexes as int[string] = {} as int[string];

function getNexPortalPos(fullPortalId as string, offset as Position3f, maxSpreadIndex as int) as Position3f {
  val _i = portalIndexes[fullPortalId];
  val i = (isNull(_i) || _i >= maxSpreadIndex) ? 1 : _i as int;
  val tuple = getNextPoint(i);
  portalIndexes[fullPortalId] = tuple[0];
  return Position3f.create(tuple[1] + offset.x, tuple[2] + offset.y, tuple[3] + offset.z);
}

function destroyPortal(world as IWorld, dimId as string, portalId as string, fullPortalId as string) as void {
  portalIndexes[fullPortalId] = 1;
  removePortal(world, dimId, portalId);
}

// Find and convert one block
// Return true if block converted, false if skipped / not found
function spreadBlock(
  world as IWorld,
  spreadPos as Position3f,
  showParticles as bool
) as bool {
  val inworldState = world.getBlockState(spreadPos);
  val inworldDefinition = inworldState.block.definition;
  val numId = inworldDefinition.numericalId;

  if (showParticles) {
    (world.native as native.net.minecraft.world.WorldServer).spawnParticle(
      EnumParticleTypes.SPELL_WITCH,
      spreadPos.x as double, spreadPos.y as double, spreadPos.z as double, 1, 0.0, 0.0, 0.0, 0.0, 0);
  }

  if (numId == 0) return false; // Air

  if(isNull(currentDirection.spreadWhitelist[inworldDefinition]) || !isNull(currentDirection.spreadBlacklist[inworldDefinition]))
    return false;

  // If block is wildcarded, lookup for its default state
  val isWildcarded = !isNull(currentDirection.spreadWildcards[inworldDefinition]);
  val lookupState = isWildcarded ? inworldDefinition.defaultState : inworldState;

  // Determine result
  val blocksTo = currentDirection.spreadStateRecipes[lookupState];

  // No blocks to convert from this one
  if (isNull(blocksTo) || blocksTo.length == 0) return false;

  // Determine random block if needed
  // Each next block in list have x2 less chance to spawn
  var blockTo = blocksTo[0];
  if (blocksTo.length > 1) {
    val rndIndex = pow(world.random.nextInt(pow(blocksTo.length, 2)), 0.5) as int;
    blockTo = blocksTo[blocksTo.length - 1 - rndIndex];
  }

  if (isNull(blockTo)) return false;
  val blockToNumId = blockTo.block.definition.numericalId;

  if (
    numId == blockToNumId
    && inworldState == blockTo
  ) return false; // Already transformed

  // Copy parameters if wildcarded
  if (isWildcarded) {
    val copiablePropNames = blockTo.getPropertyNames();
    if (copiablePropNames.length > 0) {
      for propName in inworldState.getPropertyNames() {
        if (!(copiablePropNames has propName)) continue;
        val value = inworldState.getPropertyValue(propName);
        val allowedProps = blockTo.getAllowedValuesForProperty(propName);
        if (!(allowedProps has value)) continue;
        // Due to CraftTweaker bug, we must lower case prop values
        // because CT would warn if value have uppercase letters
        blockTo = blockTo.withProperty(propName, value.toLowerCase());
      }
    }
  }

  // Replace block
  setBlock(world, spreadPos, blockTo, showParticles);

  // Return false if transformed block was air to prevent stopping on those blocks
  return blockToNumId != 0;
}

// Replace block on position
function setBlock(world as IWorld, bpos as IBlockPos, state as IBlockState, fancy as bool) as void {
  if (fancy) world.destroyBlock(bpos, false);
  world.setBlockState(state, bpos);
}

// Check if we need to show particles
function isShowParticles(world as IWorld, portalPos as Position3f) as bool {
  val player = world.getClosestPlayer(portalPos.x, portalPos.y, portalPos.z, 60, false);
  if (!isNull(player)) {
    val item = player.getItemInSlot(mainHand);
    if (
      !isNull(item)
      && item.definition.id == 'minecraft:flint_and_steel'
    ) return true;
  }
  return false;
}
