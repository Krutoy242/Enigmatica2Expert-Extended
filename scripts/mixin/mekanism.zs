#modloaded mekanism
#loader mixin

import native.net.minecraft.nbt.NBTTagCompound;

/*
Remove default Log=>PLank recipes
for performance and unification reasons
*/
#mixin {targets: "mekanism.common.integration.OreDictManager"}
zenClass MixinOreDictManager {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "init",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lmekanism/common/integration/OreDictManager;addLogRecipes()V"
    #    }
    #}
    function removeLogRecipes() as void {
        // NO-OP
    }
}

/*
Fix crash when NBT is corrupted
*/
#mixin {targets: "mekanism.common.item.ItemBlockMachine"}
zenClass MixinItemBlockMachine {
    #mixin Redirect
    #{
    #    method: "getBaseTier",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lnet/minecraft/nbt/NBTTagCompound;func_74762_e(Ljava/lang/String;)I"
    #    }
    #}
    function fixTierLevel(nbt as NBTTagCompound,key as string) as int {
        return max(0, min(4, nbt.getInteger(key)));
    }
}
