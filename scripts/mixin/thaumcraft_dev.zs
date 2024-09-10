#loader mixin

import native.java.util.ArrayList;
import native.net.minecraft.item.ItemStack;
import mixin.CallbackInfoReturnable;

#mixin Mixin
#{targets: "thaumcraft.common.lib.crafting.ThaumcraftCraftingManager"}
zenClass MixinThaumcraftCraftingManager {
    #mixin Static
    #mixin Inject
    #{
    #    method: "generateTagsFromRecipes",
    #    at: {value: "HEAD"},
    #    cancellable: true
    #}
    function skipGenerateAspectsFromRecipes(stack as ItemStack, history as ArrayList, cir as CallbackInfoReturnable) as void {
        cir.cancel();
    }
}
