#loader mixin

#mixin Mixin
#{targets: "lumien.randomthings.entitys.EntityGoldenChicken"}
zenClass MixinEntityGoldenChicken {
    #mixin ModifyConstant
    #{
    #    method: "func_70636_d",
    #    constant: {expandZeroConditions: GREATER_THAN_ZERO}
    #}
    function modifyIngotDropTimerCheck(value as int) as int {
        return 7;
    }

    #mixin ModifyConstant
    #{
    #    method: "func_70636_d",
    #    constant: {stringValue: "oreGold"}
    #}
    function modifyDropItemOreDict(value as string) as string {
        return "clusterGold";
    }

    #mixin ModifyConstant
    #{
    #    method: "func_70636_d",
    #    constant: {intValue: 600}
    #}
    function modifyNextIngotDropTimer(value as int) as int {
        return 100;
    }
}

#mixin Mixin
#{targets: "lumien.randomthings.handler.DiviningRodHandler"}
zenClass MixinDiviningRodHandler {
    #mixin ModifyConstant
    #{
    #    method: "tick",
    #    constant: {intValue: 60}
    #}
    function modifyDiviningRodBlocksPerTick(value as int) as int {
        return 400;
    }

    #mixin ModifyConstant
    #{
    #    method: "tick",
    #    constant: {intValue: 6}
    #}
    function modifyDiviningRodRadius(value as int) as int {
        return 20;
    }
}
