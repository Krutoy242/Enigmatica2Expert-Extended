#modloaded advancedrocketry
#loader mixin
#sideonly client

import native.org.lwjgl.opengl.GL11;
import mixin.CallbackInfo;
import native.zmaster587.advancedRocketry.api.dimension.solar.StellarBody;
import native.zmaster587.advancedRocketry.dimension.DimensionProperties;
import native.net.minecraft.client.renderer.BufferBuilder;
import native.net.minecraft.util.math.Vec3d;
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
