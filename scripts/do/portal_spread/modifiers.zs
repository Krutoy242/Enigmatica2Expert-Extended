/**
 * @file Portal modifier blocks and their configurations
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#priority 2100
#reloadable
#modloaded zenutils

import crafttweaker.block.IBlockState;
import crafttweaker.data.IData;
import crafttweaker.util.Position3f;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IFacing;
import crafttweaker.world.IWorld;

import scripts.do.portal_spread.config.Config;
import scripts.do.portal_spread.data.updatePortal;
import scripts.do.portal_spread.message.notifyPlayers;
import scripts.do.portal_spread.utils.radiusToIndex;

/////////////////////////////////////////////////////////////////////////////

static oldGroups as int[][string] = {};

/**
 * Using 4 block positions in world determine power of modifiers
 *
 * @return Array of power of each modifier [modif_1_value, modif_2_value, ..., modif_n_value]
 */
function getModifiers(
  world as IWorld,
  portalFullId as string,
  portalData as IData,
  targetDimIdStr as string = null,
  blockPos as IBlockPos = null,
  blockState as IBlockState = null,
  portalPos as Position3f = null
) as int[] {
  // Get corners
  var portalCorners = portalData;
  if (
    (isNull(portalCorners.asList()) || portalCorners.asList().length < 12)
    && !isNull(blockState) && !isNull(targetDimIdStr) && !isNull(blockPos)
  ) {
    val axisX = blockState.getPropertyValue('axis') == 'x';
    portalCorners = getCorners(world, blockPos, axisX);
    updatePortal(world, targetDimIdStr, blockPos, portalCorners);

    // Portal just created and asserted
    notifyPlayers(world, portalPos, 'created');
  }

  // Populate modifiers amounts
  val len = Config.modifiersList.length;
  val modifiers = intArrayOf(len, 0);
  val modGroupPower = intArrayOf(Config.modifierGroupCount, 0);
  for i in 0 .. 4 { // Iterate each corner
    val block = world.getBlock(portalCorners[i * 3 + 0], portalCorners[i * 3 + 1], portalCorners[i * 3 + 2]);
    if (isNull(block)) continue; // no block or Air

    val blockMetas = Config.modifBlocksKey[block.definition];
    if (isNull(blockMetas)) continue; // This block def not used

    val keys = blockMetas[block.meta];
    if (isNull(keys) || keys.length == 0) continue; // Block used but with other metas

    // Add to modifier group
    val groupIndex = Config.blockGroupMap[block.definition.id ~ ':' ~ block.meta] as int;
    modGroupPower[groupIndex] = modGroupPower[groupIndex] + 1;

    for key in keys {
      if (isNull(Config.MODIF[key])) {
        logger.logWarning('[Portal Spread]: cant find find modifier [' ~ key ~ '] for block ' ~ block.definition.id);
        continue;
      }
      val index = Config.MODIF[key] as int;
      modifiers[index] = modifiers[index] + 1;
    }
  }

  // Notify players if modifiers changed
  if (!isNull(portalPos)) {
    val old = oldGroups[portalFullId];
    if (!isNull(old)) {
      for i, value in modGroupPower {
        if (old[i] == value) continue;
        val postfix = old[i] > value ? 'red' : value != 4 ? 'add' : 'max';
        notifyPlayers(world, portalPos, i ~ '_' ~ postfix);
      }
    }
  }
  // Copy old values
  oldGroups[portalFullId] = modGroupPower;

  return modifiers;
}

function extractModif(modifiers as int[], key as string) as int {
  val _i = Config.MODIF[key];
  if (isNull(_i)) return 0;
  val i = _i as int;
  if (i < 0 || i >= modifiers.length) return 0;
  return modifiers[i];
}

function getTrueDelay(modifiers as int[]) as double {
  val value
    = pow(4.0, extractModif(modifiers, 'slow'))
    / pow(3.0, extractModif(modifiers, 'fast'));

  // Skip of maximum slow
  if (value >= 256) return 0.0;

  return Config.spreadDelay * value;
}

function getTrueLookup(modifiers as int[]) as double {
  val value = (Config.lookup as double)
  * pow(2, extractModif(modifiers, 'potent'))
  / pow(2, extractModif(modifiers, 'weak'));
  return value;
}

// "Index" is term used in portal_spread.utils functions
function getMaxSpreadIndex(modifiers as int[]) as int {
  val value = Config.defaultRadius
    + (Config.maxRadius - Config.defaultRadius) * pow(extractModif(modifiers, 'large'), 2) / 16
    - Config.defaultRadius * extractModif(modifiers, 'small') / 4;

  if (value < Config.defaultRadius / 4) return 0;
  if (value >= Config.maxRadius) return 2147483647;

  return radiusToIndex(value);
}

/**
 * Find corners of Nether portal
 *
 * @return Flatten array with length of 12 of coordinates
 *   [x0, y0, z0, x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4]
 */
function getCorners(world as IWorld, pos as IBlockPos, axisX as bool) as IData {
  var y1 = 0;
  var y2 = 0;
  for i in 1 .. 21 {
    if (!isPortalBlock(world, pos.getOffset(down, i))) { y1 = -i; break; }
  }
  for i in 1 .. 21 {
    if (!isPortalBlock(world, pos.getOffset(up, i))) { y2 = i; break; }
  }
  var u1 = 0;
  var u2 = 0;
  for i in 1 .. 21 {
    if (!isPortalBlock(world, pos.getOffset(axisX ? west : north, i))) { u1 = -i; break; }
  }
  for i in 1 .. 21 {
    if (!isPortalBlock(world, pos.getOffset(axisX ? east : south, i))) { u2 = i; break; }
  }
  return [
    pos.x + (axisX ? u1 : 0), pos.y + y1, pos.z + (!axisX ? u1 : 0),
    pos.x + (axisX ? u2 : 0), pos.y + y1, pos.z + (!axisX ? u2 : 0),
    pos.x + (axisX ? u1 : 0), pos.y + y2, pos.z + (!axisX ? u1 : 0),
    pos.x + (axisX ? u2 : 0), pos.y + y2, pos.z + (!axisX ? u2 : 0),
  ] as IData;
}

// Check if block on specific position is portal block
function isPortalBlock(world as IWorld, pos as IBlockPos) as bool {
  val block = world.getBlock(pos);
  return !isNull(block) && block.definition.id == 'minecraft:portal';
}
