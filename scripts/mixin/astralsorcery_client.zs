#loader mixin
#modloaded astralsorcery redcore
#sideonly client

import native.dev.redstudio.redcore.utils.OptiNotFine;
import native.java.lang.Object;

#mixin {targets: "hellfirepvp.astralsorcery.client.sky.RenderSkybox"}
zenClass MixinRenderSkybox {
    #mixin Redirect
    #{
    #    method: "render",
    #    at: {
    #        value: "INVOKE",
    #        target: "Ljava/util/List;contains(Ljava/lang/Object;)Z"
    #    }
    #}
    function fixShadersSkyRender(list as [Object], dimension as Object) as bool {
        if (OptiNotFine.shadersEnabled()) return true;
        return list has dimension;
    }
}
