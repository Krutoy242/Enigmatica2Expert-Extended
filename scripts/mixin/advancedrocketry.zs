#loader mixin

#mixin Mixin
#{targets: "zmaster587.advancedRocketry.integration.jei.MachineRecipe"}
zenClass MixinMachineRecipe {
    #mixin ModifyConstant
    #{
    #    method: "drawInfo",
    #    constant: {stringValue: "Time: %d s"}
    #}
    function showTimeInTicksTooltip(value as string) as string {
        return "Time: %d t";
    }

    #mixin ModifyConstant
    #{
    #    method: "drawInfo",
    #    constant: {intValue: 20}
    #}
    function showTimeInTicksFraction(value as int) as int {
        return 1;
    }
}
