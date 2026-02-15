#modloaded advancedrocketry redcore
#loader mixin
#sideonly client

import mixin.CallbackInfoReturnable;
import native.dev.redstudio.redcore.utils.OptiNotFine;

#mixin {targets: "zmaster587.advancedRocketry.world.provider.WorldProviderSpace"}
zenClass MixinWorldProviderSpace {
    #mixin Inject {method: "getSkyRenderer", at: {value: "HEAD"}, cancellable: true}
    function disableSkyOnShaders(cir as CallbackInfoReturnable) as void {
        if (OptiNotFine.shadersEnabled()) cir.setReturnValue(null);
    }
}

#mixin {targets: "zmaster587.advancedRocketry.world.provider.WorldProviderAsteroid"}
zenClass MixinWorldProviderAsteroid {
    #mixin Inject {method: "getSkyRenderer", at: {value: "HEAD"}, cancellable: true}
    function disableSkyOnShaders(cir as CallbackInfoReturnable) as void {
        if (OptiNotFine.shadersEnabled()) cir.setReturnValue(null);
    }
}

#mixin {targets: "zmaster587.advancedRocketry.world.provider.WorldProviderPlanet"}
zenClass MixinWorldProviderPlanet {
    #mixin Inject {method: "getSkyRenderer", at: {value: "HEAD"}, cancellable: true}
    function disableSkyOnShaders(cir as CallbackInfoReturnable) as void {
        if (OptiNotFine.shadersEnabled()) cir.setReturnValue(null);
    }
}
