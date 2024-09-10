#loader mixin

import native.net.minecraftforge.event.RegistryEvent;
import mixin.CallbackInfo;

#mixin Mixin
#{targets: "morph.avaritia.Avaritia"}
zenClass MixinAvaritia {
    #mixin Inject
    #{
    #    method: "registerRecipes",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lmorph/avaritia/recipe/AvaritiaRecipeManager;init()V"
    #    },
    #    cancellable: true
    #}
    function removeRecipes(event as RegistryEvent.Register, ci as CallbackInfo) as void {
        ci.cancel();
    }
}
