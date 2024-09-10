#loader mixin

import native.mezz.jei.collect.ListMultiMap;
import native.net.minecraftforge.fml.common.ProgressManager.ProgressBar;
import mixin.CallbackInfo;

/*
Increase HEI recipe iteration by 1-3 seconds.
Since there istens of thouthands HEI recipes, rapid calling of progress bar steps caused excess second of waiting.
*/
#mixin Mixin
#{targets: "mezz.jei.recipes.RecipeRegistry"}
zenClass MixinRecipeRegistry {
    var step as int;

    #mixin ModifyArg
    #{
    #    method: "addRecipes",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lnet/minecraftforge/fml/common/ProgressManager;push(Ljava/lang/String;I)Lnet/minecraftforge/fml/common/ProgressManager$ProgressBar;"
    #    }
    #}
    function updateProgressBarLess0(value as int) as int {
        return value / 100;
    }

    #mixin Inject
    #{
    #    method: "addRecipes",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lmezz/jei/recipes/RecipeRegistry;addRecipe(Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;)V"
    #    }
    #}
    function updateStep(unsortedRecipes as [any], recipes as ListMultiMap, ci as CallbackInfo) as void {
        step += 1;
    }

    #mixin Redirect
    #{
    #    method: "addRecipes",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lnet/minecraftforge/fml/common/ProgressManager$ProgressBar;step(Ljava/lang/String;)V"
    #    }
    #}
    function updateProgressBarLess1(bar as ProgressBar, meg as string) as void {
        if (step % 100 == 99) {
            bar.step(meg);
        }
    }
}
