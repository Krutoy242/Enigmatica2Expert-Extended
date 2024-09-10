#loader mixin

import native.mezz.jei.api.recipe.IRecipeCategoryRegistration;
import native.mezz.jei.api.IModRegistry;
import native.mezz.jei.api.IJeiRuntime;

/*
Disable all smelteryio JEI categories
*/
#mixin Mixin
#{targets: "mctmods.smelteryio.library.util.jei.JEI"}
zenClass MixinSmelteryIOJEI {
    #mixin Overwrite
    function registerCategories(registry as IRecipeCategoryRegistration) as void {
        // NO-OP
    }

    #mixin Overwrite
    function register(registry as IModRegistry) as void {
        // NO-OP
    }

    #mixin Overwrite
    function onRuntimeAvailable(runtime as IJeiRuntime) as void {
        // NO-OP
    }
}
