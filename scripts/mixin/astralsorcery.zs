#loader mixin
#modloaded astralsorcery

import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;

#mixin {targets: "hellfirepvp.astralsorcery.common.block.fluid.FluidBlockLiquidStarlight"}
zenClass MixinFluidBlockLiquidStarlight {
    #mixin Overwrite
    function interactWithAdjacent(world as World, pos as BlockPos) as void {
        // NO-OP: interactions would be handled by FluidInteractionTweaker
    }
}

