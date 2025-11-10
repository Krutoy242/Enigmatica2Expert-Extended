#modloaded advancedrocketry redcore
#loader mixin
#sideonly client

import mixin.CallbackInfo;
import mixin.CallbackInfoReturnable;
import native.dev.redstudio.redcore.utils.OptiNotFine;
import native.net.minecraft.client.Minecraft;
import native.net.minecraft.client.multiplayer.WorldClient;

/*
Remove render of Asteroid Belt sky to prevent no entity render
https://github.com/dercodeKoenig/AdvancedRocketry/issues/62
*/
#mixin {targets: "zmaster587.advancedRocketry.client.render.planet.RenderAsteroidSky"}
zenClass MixinRenderAsteroidSky {
    #mixin Inject {method: "render", at: {value: "HEAD"}, cancellable: true}
    function noRender(partialTicks as float, world as WorldClient, mc as Minecraft, ci as CallbackInfo) as void {
        ci.cancel();
    }
}

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
