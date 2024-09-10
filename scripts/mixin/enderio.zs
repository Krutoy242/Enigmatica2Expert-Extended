#loader mixin

import native.crazypants.enderio.base.recipe.alloysmelter.AlloyRecipeManager;
import native.crazypants.enderio.base.recipe.Recipe;
import native.java.lang.Boolean;

/*
Increase [Alloy Smelter] performance

Registering recipes required iterate over big amounts if registry to
find what custom recipes could be x3, like when you can smelt 3 cobblestone at once.
This takes 1-3 seconds on loading time for about ~16 custom recipes.
*/
#mixin Mixin
#{targets: "crazypants.enderio.base.recipe.alloysmelter.AlloyRecipeManager"}
zenClass MixinAlloyRecipeManager {
    #mixin Redirect
    #{
    #    method: "addRecipe",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lcrazypants/enderio/base/recipe/alloysmelter/AlloyRecipeManager;needsSynthetics(Lcrazypants/enderio/base/recipe/Recipe;)Z"
    #    }
    #}
    function noSyntheticRecipe(instance as AlloyRecipeManager, recipe as Recipe) as bool {
        return false;
    }
}

/*
Remove ~40000 pointless recipes from [Fluid Tank] such as "Any Tank + Any Fluid => Tank With Fluid".
Only actual tank recipes (item+fluid=>item) will be shown. This saves 2-6 seconds of modpack loading time.

This is performed by just removing avoiding registering JEI tab if both of this options disabled:
`enableTankFluidInOutJEIRecipes`
`enableTankMendingJEIRecipes`
*/
#mixin Mixin
#{targets: "crazypants.enderio.machines.integration.jei.TankRecipeCategory"}
zenClass MixinTankRecipeCategory {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "register",
    #    at: {
    #        value: "INVOKE",
    #        target: "Ljava/lang/Boolean;booleanValue()Z",
    #        ordinal: 0
    #    }
    #}
    function registerTankRecipeCategory(instance as Boolean) as bool {
        return true;
    }
}

