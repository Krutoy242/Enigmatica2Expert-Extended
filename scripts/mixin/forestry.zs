#modloaded forestry
#loader mixin

import native.forestry.api.recipes.ISqueezerManager;
import native.forestry.api.recipes.IFermenterRecipe;
import native.net.minecraft.item.ItemStack;
import mixin.CallbackInfoReturnable;

/*
Remove ~1500 [Squeezer] (forestry) capsule recipes,
when forestry cans and capsules filled/squeezed with every liquid in game.
*/
#mixin {targets: "forestry.core.ModuleFluids"}
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
#mixin {targets: "forestry.factory.recipes.FermenterRecipeManager"}
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

#mixin {targets: "forestry.factory.tiles.TileRaintank"}
zenClass MixinTileRainTank {
    #mixin Static
    #mixin ModifyConstant {method: "<clinit>", constant: {intValue: 10}}
    function increaseFluidPerOperation(value as int) as int {
        return 500000;
    }

    #mixin ModifyConstant {method: "dumpFluidBelow", constant: {intValue: 50}}
    function dumpBelowPerOperation(value as int) as int {
        return 50000;
    }

    #mixin ModifyConstant {method: "updateServerSide", constant: {intValue: 20}}
    function descreaseInterval(value as int) as int {
        return 5;
    }

    #mixin ModifyConstant {method: "<init>", constant: {intValue: 30000}}
    function increaseCapacity(value as int) as int {
        return 500000000;
    }
}

/*
Blaze Tubes rework
Increase speed and power usage
*/
#mixin {targets: "forestry.factory.ModuleFactory"}
zenClass MixinModuleFactory {
    #mixin ModifyConstant {method: "doInit", constant: {doubleValue: 0.125}}
    function increaseSpeedAndPower0(value as double) as double { return 1.0; }

    #mixin ModifyConstant {method: "doInit", constant: {doubleValue: 0.25}}
    function increaseSpeedAndPower1(value as double) as double { return 5.0; }

    #mixin ModifyConstant {method: "doInit", constant: {floatValue: 0.05}}
    function increaseSpeedAndPower2(value as float) as float { return 0.05f; }

    #mixin ModifyConstant {method: "doInit", constant: {floatValue: 0.10}}
    function increaseSpeedAndPower3(value as float) as float { return 0.15f; }
}
