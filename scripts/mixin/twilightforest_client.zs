#loader mixin
#sideonly client
#modloaded twilightforest redcore

import native.net.minecraftforge.client.IRenderHandler;
import native.dev.redstudio.redcore.utils.OptiNotFine;
import mixin.CallbackInfoReturnable;

#mixin {targets: "twilightforest.world.WorldProviderTwilightForest"}
zenClass MixinWorldProviderTwilightForest {

    #mixin Inject {method: "getSkyRenderer", at: {value: "HEAD"}, cancellable: true}
    function disableSkyOnShaders(cir as CallbackInfoReturnable) as void {
        if (OptiNotFine.shadersEnabled()) {
            cir.setReturnValue(null);
        }
    }
}
