#modloaded thermaldynamics
#loader mixin
#sideonly client

import native.mezz.jei.api.IModRegistry;
import native.mezz.jei.api.ISubtypeRegistry;
import native.mezz.jei.api.recipe.IRecipeCategoryRegistration;

/**
 * @author ZZZank
 */
#mixin {targets: "cofh.thermaldynamics.plugins.jei.JEIPluginTD"}
zenClass MixinJEIPluginTD {

    /**
     * @author ZZZank
     * @reason Skip cover recipe category initialization
     */
    #mixin Overwrite
    function registerCategories(registry as IRecipeCategoryRegistration) as void {
    }

    /**
     * @author ZZZank
     * @reason Skip cover recipe category initialization
     */
    #mixin Overwrite
    function register(registry as IModRegistry) as void {
    }

    /**
     * @author ZZZank
     * @reason We don't need to differentiate covers since we removed cover recipe category
     */
    #mixin Overwrite
    function registerItemSubtypes(subtypeRegistry as ISubtypeRegistry) as void {
    }
}
