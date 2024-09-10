#loader mixin

import native.net.minecraft.nbt.NBTTagCompound;
import native.atm.bloodworkxgaming.oeintegration.MainConfig;

/*
Make each modifier level require empty slot (was only first)
*/
#mixin Mixin
#{targets: "atm.bloodworkxgaming.oeintegration.Handler.IntegrationHandler"}
zenClass MixinIntegrationHandler {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "performTick",
    #    at: {
    #       value: "INVOKE",
    #       target: "Lnet/minecraft/nbt/NBTTagCompound;func_74762_e(Ljava/lang/String;)I"
    #    }
    #}
    function changeToConfig(nbt as NBTTagCompound, key as string) as int {
        return MainConfig.maxTinkersModifersCount;
    }
}

#mixin Mixin
#{targets: "atm.bloodworkxgaming.oeintegration.Integrations.ExcavateModifier"}
zenClass MixinExcavateModifier {
    #mixin ModifyConstant
    #{
    #    method: "<init>",
    #    constant: {intValue: 1, ordinal: 1}
    #}
    function fixArgOrder0(value as int) as int {
        return MainConfig.maxTinkersModifersCount;
    }

    #mixin Redirect
    #{
    #    method: "<init>",
    #    at: {
    #       value: "FIELD",
    #       target: "Latm/bloodworkxgaming/oeintegration/MainConfig;maxTinkersModifersCount:I",
    #       opcode: 178
    #    }
    #}
    function fixArgOrder1() as int {
        return 1;
    }
}

