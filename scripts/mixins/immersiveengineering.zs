#loader mixin

import native.net.minecraft.entity.IMerchant;
import native.net.minecraft.village.MerchantRecipeList;
import native.java.util.Random;
import native.blusunrize.lib.manual.IManualPage;
import native.blusunrize.lib.manual.ManualPages;
import mixin.CallbackInfo;

#mixin Mixin
#{targets: "blusunrize.immersiveengineering.common.blocks.metal.TileEntitySilo"}
zenClass MixinTileEntitySilo {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clinit>",
    #    constant: {intValue: 41472}
    #}
    function buffStorage(value as int) as int {
        return 0xffff00;
    }
}

#mixin Mixin
#{targets: [
#   "blusunrize.immersiveengineering.common.util.IEVillagerHandler$OreveinMapForEmeralds",
#   "blusunrize.immersiveengineering.common.util.IEVillagerHandler"
#]}
zenClass MixinIEVillagerHandler {
    #mixin Inject
    #{
    #    method: "func_190888_a",
    #    at: {value: "HEAD"},
    #    cancellable: true
    #}
    function showManaNumericalValue(merchant as IMerchant, recipeList as MerchantRecipeList, random as Random, ci as CallbackInfo) as void {
        ci.cancel();
    }
}

#mixin Mixin
#{targets: "blusunrize.lib.manual.ManualInstance"}
zenClass MixinManualInstance {
    #mixin Redirect
    #{
    #   method: "indexRecipes",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lblusunrize/lib/manual/IManualPage;recalculateCraftingRecipes()V"
    #   }
    #}
    function removeCraftingRecipes(page as IManualPage) as void {
        // NO-OP
    }
}

#mixin Mixin
#{targets: "blusunrize.lib.manual.ManualPages$Crafting"}
zenClass MixinManualPagesCrafting {
    #mixin Redirect
    #{
    #   method: "<init>",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lblusunrize/lib/manual/ManualPages$Crafting;recalculateCraftingRecipes()V"
    #   }
    #}
    function removeCraftingRecipes(page as ManualPages.Crafting) as void {
        // NO-OP
    }
}

#mixin Mixin
#{targets: "blusunrize.lib.manual.ManualPages$CraftingMulti"}
zenClass MixinManualPagesCraftingMulti {
    #mixin Redirect
    #{
    #   method: "<init>",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lblusunrize/lib/manual/ManualPages$CraftingMulti;recalculateCraftingRecipes()V"
    #   }
    #}
    function removeCraftingRecipes(page as ManualPages.CraftingMulti) as void {
        // NO-OP
    }
}
