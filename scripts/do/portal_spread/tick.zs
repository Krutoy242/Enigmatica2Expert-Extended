/**
 * @file Make portals spread their dimension blocks around
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#reloadable

import crafttweaker.block.IBlockDefinition;
import crafttweaker.block.IBlockState;
import crafttweaker.data.IData;
import crafttweaker.util.Math.cos;
import crafttweaker.util.Math.sin;
import crafttweaker.util.Position3f;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IFacing;
import crafttweaker.world.IWorld;

import scripts.do.portal_spread.data.getDimsMap;
import scripts.do.portal_spread.data.portalIdToPos;
import scripts.do.portal_spread.data.removePortal;
import scripts.do.portal_spread.data.updatePortal;
import scripts.do.portal_spread.message.notifyPlayers;
import scripts.do.portal_spread.modifiers.getCorners;
import scripts.do.portal_spread.utils.getNextPoint;

// Map of modifiers
static MODIF as int[string] = scripts.do.portal_spread.modifiers.MODIF;

static spreadDelay as double = scripts.do.portal_spread.config.spreadDelay;
static blockChecks as int = scripts.do.portal_spread.config.blockChecks;
static dimHasRecipes as bool[int] = scripts.do.portal_spread.recipes.dimHasRecipes;

////////////////////////////////////////////////////

// Save new portal coordinates
events.onPortalSpawn(function(e as crafttweaker.event.PortalSpawnEvent) {
  if(!e.valid || e.world.remote) return;

  // val blockPos = e.position.getOffset(crafttweaker.world.IFacing.up(), 1);
  // val blockState = e.world.getBlockState(blockPos);
  // server.commandManager.executeCommandSilent(server, '/say §8Spawned §6' ~ blockState.block.definition.id);
  updatePortal(e.world, -1, e.position);
});

// Convert blocks around portal
events.onWorldTick(function(e as crafttweaker.event.WorldTickEvent){
  if(e.world.remote || e.phase != "END") return;
  if(isNull(dimHasRecipes[e.world.dimension])) return;
  val fallback = scripts.do.portal_spread.recipes.dimFallbacks[e.world.dimension];
  val currDimNumId = !isNull(fallback) ? (fallback as int) : e.world.dimension;

  // Skip ticks
  val spreadDelayInt = spreadDelay as int;
  if(spreadDelayInt > 1 && e.world.time % spreadDelayInt != 0) return;

  for dimId, dimData in getDimsMap(e.world).asMap() {
    if(isNull(dimData) || isNull(dimData.asMap())) continue;

    // -------------------------------
    // Get userful maps from recipes
    val idInt = dimId as int;
    val spreadStateRecipes = scripts.do.portal_spread.recipes.getRecipes(currDimNumId, idInt);
    val _spreadWhitelist = scripts.do.portal_spread.recipes.transformableBlockNumIds[currDimNumId];
    val _spreadBlacklist = scripts.do.portal_spread.recipes.blacklistedBlockNumIds[currDimNumId];
    val _spreadWildcards = scripts.do.portal_spread.recipes.wildcardedNumIds[currDimNumId];

    if (
      isNull(spreadStateRecipes)
      || isNull(_spreadWhitelist[idInt])
      || isNull(_spreadBlacklist[idInt])
      || isNull(_spreadWildcards[idInt])
    ) continue;

    val spreadWhitelist = _spreadWhitelist[idInt];
    val spreadBlacklist = _spreadBlacklist[idInt];
    val spreadWildcards = _spreadWildcards[idInt];
    // -------------------------------

    for portalId, portalData in dimData.asMap() {
      val fullPortalId = e.world.dimension~':'~portalId;
      val portalPos = portalIdToPos(portalId);
      var blockPos = portalPos as IBlockPos;

      // Portal not loaded
      if (!e.world.isBlockLoaded(blockPos)) continue;

      val blockState = e.world.getBlockState(blockPos);

      // Portal is destroyed
      if (isNull(blockState) || blockState.block.definition.id != "minecraft:portal") {
        destroyPortal(e.world, dimId, portalId, fullPortalId);
        notifyPlayers(e.world, portalPos, 'broken');
        continue;
      }

      // Get modifiers
      var portalCorners = portalData;
      if (isNull(portalCorners.asList()) || portalCorners.asList().length < 12) {
        val axisX = blockState.getPropertyValue('axis') == 'x';
        portalCorners = getCorners(e.world, blockPos, axisX);
        updatePortal(e.world, dimId, blockPos, portalCorners);

        // Portal just created and asserted
        notifyPlayers(e.world, portalPos, 'created');
      }
      val modifiers = scripts.do.portal_spread.modifiers.getModifiers(e.world, fullPortalId, portalCorners, portalPos);

      // Skip generation on slow modifier
      val trueDelay = scripts.do.portal_spread.modifiers.getSlow(e.world, modifiers);
      if(trueDelay <= 0) continue;

      // Determine how many blocks could be transformed in one run
      val repeats = (1.0 / trueDelay) as int;

      // Show particles only if player nerbly
      var showParticles = isShowParticles(e.world, portalPos);

      // Repeat
      var somethingReplaced = false;
      for i in 0 .. repeats {
        for j in 0 .. blockChecks {
          if (spread(
            e.world,
            fullPortalId,
            portalPos,
            modifiers,
            showParticles,
            spreadStateRecipes,
            spreadWhitelist,
            spreadBlacklist,
            spreadWildcards
          )) {
            somethingReplaced = true;
            break;
          }
        }
      }
      if(somethingReplaced) portalIndexes[fullPortalId] = 1;
    }
  }
});

// Current iteration index for a portal
// Requre fullPortalID "dim:x:y:z"
static portalIndexes as int[string] = {} as int[string];

function getNexPortalPos(fullPortalId as string, offset as Position3f) as Position3f {
  var i = portalIndexes[fullPortalId];
  val tuple = getNextPoint(isNull(i) ? 1 : i as int);
  portalIndexes[fullPortalId] = tuple[0];
  return Position3f.create(tuple[1] + offset.x, tuple[2] + offset.y, tuple[3] + offset.z);
}

function destroyPortal(world as IWorld, dimId as string, portalId as string, fullPortalId as string) as void {
  portalIndexes[fullPortalId] = 1;
  removePortal(world, dimId, portalId);
}

// Find and convert one block
// Return true if block converted, false if skipped / not found
function spread(
  world as IWorld,
  fullPortalId as string,
  portalPos as Position3f,
  modifiers as int[],
  showParticles as bool,
  spreadStateRecipes as IBlockState[][IBlockState],
  spreadWhitelist as bool[int],
  spreadBlacklist as bool[int],
  spreadWildcards as bool[int]
) as bool {
  val spreadPos = getNexPortalPos(fullPortalId, portalPos);

  var inworldState = world.getBlockState(spreadPos);
  val inworldDefinition = inworldState.block.definition;
  val numId = inworldDefinition.numericalId;

  if(showParticles) particles(spreadPos.x, spreadPos.y, spreadPos.z);

  if (
    numId == 0 // Air
    || isNull(spreadWhitelist[numId])
    || !isNull(spreadBlacklist[numId])
  ) return false;

  // If block is wildcarded, lookup for its default state
  val isWildcarded = !isNull(spreadWildcards[numId]);
  val lookupState = isWildcarded ? inworldDefinition.defaultState : inworldState;

  // Determine result
  val blocksTo = spreadStateRecipes[lookupState];

  // No blocks to convert from this one
  if(isNull(blocksTo) || blocksTo.length == 0) return false;

  // Determine random block if needed
  // Each next block in list have x2 less chance to spawn
  var blockTo = blocksTo[0];
  if(blocksTo.length > 1) {
    val rndIndex = pow(world.random.nextInt(pow(blocksTo.length, 2)), 0.5) as int;
    blockTo = blocksTo[blocksTo.length - 1 - rndIndex];
  }

  if (
    numId == blockTo.block.definition.numericalId
    && inworldState == blockTo
  ) return false; // Already transformed

  // Copy parameters if wildcarded
  if(isWildcarded) {
    val copiablePropNames = blockTo.getPropertyNames();
    if(copiablePropNames.length > 0) {
      for propName in inworldState.getPropertyNames() {
        if(!(copiablePropNames has propName)) continue;
        val value = inworldState.getPropertyValue(propName);
        val allowedProps = blockTo.getAllowedValuesForProperty(propName);
        if(!(allowedProps has value)) continue;
        // Due to CraftTweaker bug, we must lower case prop values
        // because CT would warn if value have uppercase letters
        blockTo = blockTo.withProperty(propName, value.toLowerCase());
      }
    }
  }

  // Replace block
  setBlock(world, spreadPos, blockTo, showParticles);
  return true;
}

// Spawn particles
function particles(x as float,y as float,z as float) as void {
  server.commandManager.executeCommandSilent(server, "/particle witchMagic "~x~" "~y~" "~z~" 0 0 0 0 1");
}

// Replace block on position
function setBlock(world as IWorld, bpos as IBlockPos, state as IBlockState, fancy as bool) as void {
  if(fancy) world.destroyBlock(bpos, false);
  world.setBlockState(state, bpos);
}

// Check if we need to show particles
function isShowParticles(world as IWorld, portalPos as Position3f) as bool {
  val player = world.getClosestPlayer(portalPos.x, portalPos.y, portalPos.z, 60, false);
  if(!isNull(player)) {
    val item = player.getItemInSlot(
      crafttweaker.entity.IEntityEquipmentSlot.mainHand()
    );
    if(
      !isNull(item) &&
      item.definition.id == 'minecraft:flint_and_steel'
    ) return true;
  }
  return false;
}
