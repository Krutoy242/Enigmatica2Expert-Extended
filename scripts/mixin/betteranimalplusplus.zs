#loader mixin

import native.net.minecraft.entity.Entity;

#mixin Mixin
#{targets: "its_meow.betteranimalsplus.common.entity.EntitySharkBase"}
zenClass MixinEntitySharkBase {
    #mixin Redirect
    #{
    #   method: "func_184232_k",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lnet/minecraft/entity/Entity;func_70107_b(DDD)V"
    #   }
    #}
    function fixTeleportingOnGrab(entity as Entity, x as double, y as double, z as double) as void {
        entity.setPosition(this0.posX + this0.motionX, this0.posY + (this0.height / 2.0) + this0.motionY, this0.posZ + this0.motionZ);
    }
}
