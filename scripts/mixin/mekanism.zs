#loader mixin

import native.net.minecraftforge.event.RegistryEvent;

/*
Remove default Log=>PLank recipes
for performance and unification reasons
*/
#mixin Mixin
#{targets: "mekanism.common.integration.OreDictManager"}
zenClass MixinOreDictManager {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "registerRecipes",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lmekansim/common/integration/OreDictManager;addLogRecipes()V"
    #    }
    #}
    function removeLogRecipes(event as RegistryEvent.Register) as void {
        // NO-OP
    }
}
