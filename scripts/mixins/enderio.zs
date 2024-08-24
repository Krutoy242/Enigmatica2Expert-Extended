#loader mixin

import native.crazypants.enderio.base.recipe.alloysmelter.AlloyRecipeManager;
import native.crazypants.enderio.base.recipe.Recipe;
import native.java.lang.Boolean;

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

#mixin Mixin
#{targets: "crazypants.enderio.machines.integration.jei.TankRecipeCategory"}
zenClass MixinTankRecipeCategory {
    #mixin Redirect
    #{
    #    method: "addRecipe",
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

