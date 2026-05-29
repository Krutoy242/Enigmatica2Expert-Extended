#modloaded twilightforest
#reloadable
#priority -10

import crafttweaker.util.Math;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.block.IBlockState;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.item.IItemStack;

// Fallback handler: breaks hand-minable blocks if no other handler matched.
// Low priority ensures this handler is registered last and acts as a catch-all.
scripts.mixin.twilightforest.crumble.shared.CrumbleOp.handlers += function(
  world as IWorld,
  pos as IBlockPos,
  state as IBlockState,
  living as IEntityLivingBase,
  stack as IItemStack
) as bool {
  val block = state.block;
  val def = block.definition;
  
  // Only break blocks that can be mined by hand
  if (state.material.liquid) return false;
  if (!state.material.toolNotRequired) return false;
  if (def.getHarvestLevel(state) > 0) return false;
  
  val hardness = state.getBlockHardness(world, pos);
  if (hardness < 0) return false;
  
  // Toughness check: very hard hand-minable blocks should rarely break.
  // Some modded blocks have extreme hardness but harvest level 0,
  // making the horn too efficient without this check.
  val logHR = Math.log(hardness * def.resistance + 1.0);
  if (world.random.nextFloat() * 10.0 < logHR) {
    return false; // Block is too tough — the horn fails to crumble it
  }
  
  // Break the block and drop items (same as mining by hand)
  world.destroyBlock(pos, true);
  return true;
};
