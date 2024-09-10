#loader mixin

import native.net.minecraft.world.World;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.block.Block;

#mixin Mixin
#{targets: "zmaster587.libVulpes.tile.energy.TilePlugBase"}
zenClass MixinTilePlugBase {
    #mixin ModifyConstant
    #{
    #    method: "getMaxEnergy",
    #    constant: {intValue: 10000}
    #}
    function modifyMaxEnergyModifier(value as int) as int {
        return 20000000;
    }

    #mixin ModifyConstant
    #{
    #    method: "getMaxDrainRate",
    #    constant: {intValue: 250}
    #}
    function modifyMaxEnergyModifier(value as int) as int {
        return 25000;
    }

    #mixin ModifyVariable
    #{
    #    method: "getMaxEnergy",
    #    at: {value: "HEAD"}
    #}
    function atMostTierTwo(tier as int) as int {
        return min(tier, 2);
    }
}

#mixin Mixin
#{targets: "zmaster587.libVulpes.tile.multiblock.hatch.TileFluidHatch"}
zenClass MixinTileFluidHatch {
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 16000}
    #}
    function modifyTankCapacity(value as int) as int {
        return 32000;
    }

    #mixin Redirect
    #{
    #   method: "fill",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lnet/minecraft/world/World;func_175685_c(Lnet/minecraft/util/math/BlockPos;Lnet/minecraft/block/Block;Z)V"
    #   }
    #}
    function denyBlockUpdateFill(world as World, pos as BlockPos, block as Block, updateObservers as bool) as void {
        // NO-OP
    }

    #mixin Redirect
    #{
    #   method: "drain",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lnet/minecraft/world/World;func_175685_c(Lnet/minecraft/util/math/BlockPos;Lnet/minecraft/block/Block;Z)V"
    #   }
    #}
    function denyBlockUpdateDrain(world as World, pos as BlockPos, block as Block, updateObservers as bool) as void {
        // NO-OP
    }
}
