#modloaded twilightforest
#reloadable
#priority -10

import crafttweaker.util.Math;
import native.net.minecraft.world.World;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.entity.EntityLivingBase;
import native.net.minecraft.item.ItemStack;

// Fallback handler: breaks hand-minable blocks if no other handler matched.
// Low priority ensures this handler is registered last and acts as a catch-all.
scripts.mixin.twilightforest.crumble.shared.CrumbleOp.handlers += function (
  world as World,
  pos as BlockPos,
  state as IBlockState,
  living as EntityLivingBase,
  stack as ItemStack
) as bool {
  val block = state.block;
  val material = state.material;

  // Only break blocks that can be mined by hand
  if (material.isLiquid()) return false;
  if (!material.isToolNotRequired()) return false;
  if (block.getHarvestLevel(state) > 0) return false;

  val hardness = block.getBlockHardness(state, world, pos);
  if (hardness < 0) return false;

  // Toughness check: very hard hand-minable blocks should rarely break.
  // Some modded blocks have extreme hardness but harvest level 0,
  // making the horn too efficient without this check.
  val resistance = block.getExplosionResistance(null);
  val logHR = Math.log(hardness * resistance + 1.0);
  if (world.rand.nextFloat() * 10.0 < logHR) {
    return false; // Block is too tough — the horn fails to crumble it
  }

  // Break the block and drop items (same as mining by hand)
  world.destroyBlock(pos, true);
  return true;
};
