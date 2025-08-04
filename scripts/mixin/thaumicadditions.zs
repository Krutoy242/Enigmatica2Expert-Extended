#modloaded thaumadditions
#loader mixin

import native.net.minecraft.util.math.RayTraceResult;
import native.net.minecraft.entity.projectile.EntityThrowable;

#mixin {targets: "org.zeith.thaumicadditions.entity.EntityMithminiteScythe"}
zenClass MixinEntityMithminiteScythe extends EntityThrowable {
    #mixin Overwrite
    function func_70184_a(result as RayTraceResult) as void {
        return;
    }
}
