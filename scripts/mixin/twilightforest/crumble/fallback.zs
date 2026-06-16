#modloaded twilightforest
#reloadable
#priority -10

import crafttweaker.util.Math;

// --- Native MC types ---
// Must match the function signature declared in shared.zs (the mixin calls this
// handler with native objects). `IBlockState` is aliased to avoid clashing with
// crafttweaker.block.IBlockState below.
import native.net.minecraft.world.World;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.block.state.IBlockState as NativeBlockState;
import native.net.minecraft.entity.EntityLivingBase;
import native.net.minecraft.item.ItemStack;

// --- native -> CraftTweaker wrappers ---
import native.crafttweaker.api.minecraft.CraftTweakerMC;

// --- CraftTweaker API types used by the handler logic ---
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.block.IBlockState;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.item.IItemStack;

// Fallback handler: breaks hand-minable blocks if no other handler matched.
// Low priority ensures this handler is registered last and acts as a catch-all.
scripts.mixin.twilightforest.crumble.shared.CrumbleOp.handlers += function(
  worldN as World,
  posN as BlockPos,
  stateN as NativeBlockState,
  livingN as EntityLivingBase,
  stackN as ItemStack
) as bool {
  // native to CraftTweaker
  val world as IWorld = CraftTweakerMC.getIWorld(worldN);
  val pos as IBlockPos = CraftTweakerMC.getIBlockPos(posN);
  val state as IBlockState = CraftTweakerMC.getBlockState(stateN);

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
