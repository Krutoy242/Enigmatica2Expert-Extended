#loader contenttweaker
#modloaded fluidlogged_api

import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import native.git.jbredwards.fluidlogged_api.api.util.FluidloggedUtils;

// Override the default no-op hook to also clear fluidlogged fluids.
scripts.cot.trait.vaporizer.VaporizerHook.tryClearFluidlogged = function (world as IWorld, pos as IBlockPos) as bool {
  val fluidState = FluidloggedUtils.getFluidState(world.native, pos.native);
  if (!fluidState.isEmpty()) {
    FluidloggedUtils.setFluidToAir(world, pos, null, 2);
    return true;
  }
  return false;
};
