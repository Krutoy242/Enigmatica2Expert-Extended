#loader mixin
#modloaded emberroot
#sideonly client

#mixin {targets: "teamroots.emberroot.entity.fairy.ModelFairy"}
zenClass MixinModelFairy {

    // Rendering Emberoot Fairies causing crashes on AMD cards
    // Fix this by implementing
    // https://github.com/Lothrazar/ERZ/pull/41
    #mixin ModifyArg
    #{
    #   method: "func_78088_a",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lnet/minecraft/client/renderer/OpenGlHelper;func_77475_a(IFF)V"
    #   },
    #   index: 0
    #}
    function fixAMDCrash(value as int) as int {
        return native.net.minecraft.client.renderer.OpenGlHelper.field_77476_b;
    }

}
