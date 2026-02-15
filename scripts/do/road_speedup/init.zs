/*
  Speeds up player when walking on specific "road" blocks.
*/

#sideonly client
#reloadable
#priority 2000

import crafttweaker.block.IBlockDefinition;
import crafttweaker.block.IBlockState;
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math.floor;
import crafttweaker.world.IBlockPos;

zenClass Op {
  var speedupDefinitions as int[IBlockDefinition] = {};
  var speedupConditions  as [function(IBlockState)double] = [] as [function(IBlockState)double];
  zenConstructor() {}

  function addSpeedupBlock(item as IItemStack, multiplier as double) as void {
    return addSpeedupBlock(item, function (state as IBlockState) as double { return multiplier; });
  }
  function addSpeedupBlock(item as IItemStack, checkFn as function(IBlockState)double) as void {
    val blockDef = item.asBlock().definition;
    speedupDefinitions[blockDef] = speedupConditions.length;
    speedupConditions += checkFn;
  }
}
static op as Op = Op();

events.register(function (e as PlayerTickEvent) {
  // Only run on the client at the start of a tick
  if (e.phase != 'START' || e.side != 'CLIENT') return;

  val player = e.player;
  if (!player.onGround) return;
  if ((player.moveForward == 0 && player.moveStrafing == 0) || player.isInWater) return;

  // Get the block state directly under the player's feet
  val blockState = player.world.getBlockState(IBlockPos.create(floor(player.x), player.y - 0.06, floor(player.z)));
  if (isNull(blockState) || isNull(blockState.block) || isNull(blockState.block.definition)) return;

  val blockDef = blockState.block.definition;

  val checkFnIndex = op.speedupDefinitions[blockDef];
  if (isNull(checkFnIndex)) return;

  val checkFn = op.speedupConditions[checkFnIndex as int];
  val speedMultiplier = checkFn(blockState);
  if (speedMultiplier <= 0) return;

  // Apply speed boost
  player.motionX *= speedMultiplier;
  player.motionZ *= speedMultiplier;
});
