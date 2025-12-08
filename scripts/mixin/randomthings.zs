#modloaded randomthings
#loader mixin

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

#mixin {targets: "lumien.randomthings.handler.DiviningRodHandler"}
zenClass MixinDiviningRodHandler {
    #mixin ModifyConstant {method: "tick", constant: {intValue: 60}}
    function buffScanSpeed(value as int) as int {
        return 400;
    }

    #mixin ModifyConstant {method: "tick", constant: {intValue: 6}}
    function buffRadius(value as int) as int {
        return 20;
    }
}

#mixin {targets: "lumien.randomthings.block.spectretree.BlockSpectreLeaf"}
zenClass MixinBlockSpectreLeaf {
    #mixin ModifyConstant {method: "dropApple", constant: {intValue: 55}}
    function increaseEctoplasmDrop(value as int) as int {
        return 2;
    }
}
