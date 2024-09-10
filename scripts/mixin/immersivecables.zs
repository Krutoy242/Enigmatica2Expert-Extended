#loader mixin
#sideonly client

import native.net.minecraft.client.renderer.BufferBuilder;
import native.net.minecraft.util.math.Vec3d;

/*
Wires always be bright.
This will cut 75% of their render time.
Its about +10% of FPS if your base have many wires.
https://i.imgur.com/rYELZzW.png
*/
#mixin Mixin
#{targets: "de.sanandrew.mods.immersivecables.client.render.RenderTileIWConnectable"}
zenClass MixinRenderTileIWConnectable {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "tessellateConnectionFast",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lde/sanandrew/mods/immersivecables/client/render/RenderTileIWConnectable;setLightmap(Lnet/minecraft/client/renderer/BufferBuilder;Lnet/minecraft/util/math/Vec3d;)Lnet/minecraft/client/renderer/BufferBuilder;"
    #    }
    #}
    function simplifyRender(buffer as BufferBuilder, pos as Vec3d) as BufferBuilder {
        return buffer.lightmap(240, 240);
    }
}
