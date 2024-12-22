#modloaded immersiveengineering
#loader mixin
#sideonly client

import native.blusunrize.lib.manual.IManualPage;
import native.blusunrize.lib.manual.ManualPages;

/*
Remove crafting recipes in [Engineer's Manual]

This should save 2-6 seconds of game load.
Usually, it wont take so long for IE to make those 3x3 grid recipe pages.
But in E2EE there is a lot of recipes. IE script made the way it need to iterate all 16000 crafting table recipes for each manual book recipe.
Those recipes makes sense if modpack doesnt have  HEI.
But since most of the recipes are changed and was already not actual, I removed them.
Text on pagest still there, just without 3x3 grid.
*/
#mixin {targets: "blusunrize.lib.manual.ManualInstance"}
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

#mixin {targets: "blusunrize.lib.manual.ManualPages$Crafting"}
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

#mixin {targets: "blusunrize.lib.manual.ManualPages$CraftingMulti"}
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
