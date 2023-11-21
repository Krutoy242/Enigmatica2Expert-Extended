/**
 * @file Portal modifier blocks and their configurations
 * 
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#priority 2100
#reloadable

import crafttweaker.data.IData;
import crafttweaker.util.Position3f;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IFacing;
import crafttweaker.world.IWorld;

import scripts.do.portal_spread.message.notifyPlayers;

// List of ID names of modifiers
static modifiersList as string[] = [
  'slow',
];

// Enum of modifiers
static MODIF as int[string]$orderly = {};

// Fill Enum list
for i, k in modifiersList { MODIF[k] = i; }

// Default list of blocks and their modifiers
static modifBlocksKey as string[string] = {
  'minecraft:coal_block': 'slow',
};
static modifKeyBlock as string[string] = {};
for i, k in modifBlocksKey { modifKeyBlock[k] = i; }

/////////////////////////////////////////////////////////////////////////////
static spreadDelay as double = scripts.do.portal_spread.config.config.spreadDelay;

// List of old values of previous portal check
static oldModifiers as int[][string] = {};

/** 
 * Using 4 block positions in world determine power of modifiers
 * 
 * @return Array of power of each modifier [modif_1_value, modif_2_value, ..., modif_n_value]
 */
function getModifiers(world as IWorld, portalFullId as string, portalCorners as IData, portalPos as Position3f = null) as int[] {
  val len = modifiersList.length;
  var result = intArrayOf(len, 0);
  for i in 0 .. 4 {
    val block = world.getBlock(portalCorners[i*3+0], portalCorners[i*3+1], portalCorners[i*3+2]);
    if(isNull(block)) continue;
    val modifierKey = modifBlocksKey[block.definition.id];
    if(isNull(modifierKey)) continue;
    if(isNull(MODIF[modifierKey])) {
      logger.logWarning('Portal Spread cant find find modifier ['~ modifierKey ~'] for block '~block.definition.id);
      continue;
    }
    val index = MODIF[modifierKey] as int;
    result[index] = result[index] + 1;
  }

  // Copy old values
  val old = oldModifiers[portalFullId];
  for i in 0 .. len {
    // result[i+len] = old[i];
    if(!isNull(portalPos) && !isNull(old)) {
          if(old[i] > result[i]) notifyPlayers(world, portalPos, modifiersList[i]~'_red');
      else if(old[i] < result[i])
        if(result[i] != 4) notifyPlayers(world, portalPos, modifiersList[i]~'_add');
        else notifyPlayers(world, portalPos, modifiersList[i]~'_max');
    }
  }
  oldModifiers[portalFullId] = result;

  return result;
}

function getSlow(world as IWorld, currModifiers as int[]) as double {
  // Skip generation on slow modifier
  val slowVal = pow(4, currModifiers[MODIF.slow]);
  val trueDelay = spreadDelay < 1.0 ? spreadDelay * slowVal : spreadDelay;
  if (slowVal >= 256 || (
    slowVal > 0 && trueDelay >= 1.0 &&
    ((world.time / trueDelay) % slowVal) != 0
  )) return 0.0;
  return trueDelay;
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
    if(!isPortalBlock(world, pos.getOffset(IFacing.down(), i)))
      { y1 = -i; break; }
  }
  for i in 1 .. 21 {
    if(!isPortalBlock(world, pos.getOffset(IFacing.up(), i)))
      { y2 = i; break; }
  }
  var u1 = 0;
  var u2 = 0;
  for i in 1 .. 21 {
    if(!isPortalBlock(world, pos.getOffset(axisX ? IFacing.west() : IFacing.north(), i)))
      { u1 = -i; break; }
  }
  for i in 1 .. 21 {
    if(!isPortalBlock(world, pos.getOffset(axisX ? IFacing.east() : IFacing.south(), i)))
      { u2 = i; break; }
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
