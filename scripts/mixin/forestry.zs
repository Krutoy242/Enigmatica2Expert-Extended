#loader mixin

import native.forestry.api.recipes.ISqueezerManager;
import native.forestry.api.recipes.IFermenterRecipe;
import native.net.minecraft.item.ItemStack;
import mixin.CallbackInfoReturnable;

/*
Remove ~1500 [Squeezer] (forestry) capsule recipes,
when forestry cans and capsules filled/squeezed with every liquid in game.
*/
#mixin Mixin
#{targets: "forestry.core.ModuleFluids"}
zenClass MixinModuleFluids {
    #mixin Redirect
    #{
    #   method: "doInit",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lforestry/api/recipes/ISqueezerManager;addContainerRecipe(ILnet/minecraft/item/ItemStack;Lnet/minecraft/item/ItemStack;F)V"
    #   }
    #}
    function removeRecipe(manager as ISqueezerManager, timePerItem as int, emptyContainer as ItemStack, remnants as ItemStack, chance as float) as void {
        // NO-OP
    }
}

/*
Remove default no-fermentated recipe flood
for better performance and less HEI junk.
*/
#mixin Mixin
#{targets: "forestry.factory.recipes.FermenterRecipeManager"}
zenClass MixinFermenterRecipeManager {
    #mixin Inject
    #{
    #   method: "addRecipe(Lforestry/api/recipes/IFermenterRecipe;)Z",
    #   at: {value: "HEAD"},
    #   cancellable: true
    #}
    function removeRecipe(recipe as IFermenterRecipe, cir as CallbackInfoReturnable) as void {
        if (recipe.fermentationValue <= 0) {
            cir.setReturnValue(false);
        }
    }
}

#mixin Mixin
#{targets: "forestry.factory.tiles.TileRaintank"}
zenClass MixinTileRainTank {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "<clinit>",
    #    constant: {intValue: 10}
    #}
    function increaseCapacity(value as int) as int {
        return 30000;
    }
}
