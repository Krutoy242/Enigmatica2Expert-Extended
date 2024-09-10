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

/*
Adding core sample trades consume 1-3 seconds load time.
*/
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
    function skipCoreSampleTrades(merchant as IMerchant, recipeList as MerchantRecipeList, random as Random, ci as CallbackInfo) as void {
        ci.cancel();
    }
}

/*
Remove crafting recipes in [Engineer's Manual]

This should save 2-6 seconds of game load.
Usually, it wont take so long for IE to make those 3x3 grid recipe pages.
But in E2EE there is a lot of recipes. IE script made the way it need to iterate all 16000 crafting table recipes for each manual book recipe.
Those recipes makes sense if modpack doesnt have  HEI.
But since most of the recipes are changed and was already not actual, I removed them.
Text on pagest still there, just without 3x3 grid.
*/
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
