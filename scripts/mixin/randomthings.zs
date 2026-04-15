#modloaded randomthings
#loader mixin

import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.world.IBlockAccess;
import native.net.minecraft.util.math.BlockPos;

/*
Make Golden Chicken eat [Native Gold Cluster] to lay x8 [Gold Ingot]
*/
#mixin {targets: "lumien.randomthings.entitys.EntityGoldenChicken"}
zenClass MixinEntityGoldenChicken {
    #mixin ModifyConstant
    #{
    #    method: "func_70636_d",
    #    constant: {expandZeroConditions: GREATER_THAN_ZERO, ordinal: 1}
    #}
    function modifyIngotDropTimerCheck(value as int) as int {
        return 7;
    }

    #mixin ModifyConstant {method: "func_70636_d", constant: {intValue: 3}}
    function modifyItemDropCount(value as int) as int {
        return 1;
    }

    #mixin ModifyConstant {method: "func_70636_d", constant: {stringValue: "oreGold"}}
    function modifyDropItemOreDict(value as string) as string {
        return "clusterGold";
    }

    #mixin ModifyConstant {method: "func_70636_d", constant: {intValue: 600}}
    function modifyNextIngotDropTimer(value as int) as int {
        return 100;
    }
}

#mixin {targets: "lumien.randomthings.block.spectretree.BlockSpectreLeaf"}
zenClass MixinBlockSpectreLeaf {
    #mixin ModifyConstant {method: "dropApple", constant: {intValue: 55}}
    function increaseEctoplasmDrop(value as int) as int {
        return 2;
    }
}

/*
Add light emission
Dont know why its not by default in RT
*/
#mixin {targets: "lumien.randomthings.block.BlockBlockLuminous"}
zenClass MixinBlockBlockLuminous {
    function getLightValue(state as IBlockState, world as IBlockAccess, pos as BlockPos) as int {
        return 15;
    }
}

#mixin {targets: "lumien.randomthings.block.BlockBlockLuminousTranslucent"}
zenClass MixinBlockBlockLuminousTranslucent {
    function getLightValue(state as IBlockState, world as IBlockAccess, pos as BlockPos) as int {
        return 15;
    }
}
