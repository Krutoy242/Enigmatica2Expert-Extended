#loader mixin
#modloaded botania redcore
#sideonly client

import native.dev.redstudio.redcore.utils.OptiNotFine;

#mixin {targets: "vazkii.botania.client.core.helper.ShaderHelper"}
zenClass MixinShaderHelper {
    /**
     * @author Krutoy242
     * @reason Replaces the outdated OptiFine check with a more reliable one from RedCore.
     * The original check `Loader.isModLoaded("optifine")` doesn't work correctly in all cases.
     * This ensures that Botania's shaders are disabled when OptiFine's shaders are active, preventing conflicts.
     */
    #mixin Static
    #mixin Overwrite
    function checkIncompatibleMods() as bool {
        return !OptiNotFine.shadersEnabled();
    }
}
