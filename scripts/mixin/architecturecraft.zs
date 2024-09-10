#loader mixin
#sideonly client

// Fix crash on Java 21+ client
#mixin Mixin
#{targets: "com.elytradev.architecture.client.render.RenderingManager$CustomItemRenderOverrideList"}
zenClass MixinRenderingManagerCustomItemRenderOverrideList {
    #mixin Redirect
    #{
    #   method: "handleItemState",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lnet/minecraft/client/renderer/GlStateManager;func_179103_j(I)V"
    #   }
    #}
    function removeShadeModel(mode as int) as void {
        // NO-OP
    }
}
