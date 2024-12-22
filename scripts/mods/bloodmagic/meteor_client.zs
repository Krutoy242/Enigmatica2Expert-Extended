#modloaded bloodmagic
#reloadable

import crafttweaker.entity.IEntity;
import native.net.minecraft.util.EnumParticleTypes;

// Make smoke trail after the falling meteor
<entity:bloodmagic:meteor>.onTick(function (entity as IEntity) as void {
  (entity.world.native as native.net.minecraft.world.WorldServer).spawnParticle(
    EnumParticleTypes.SMOKE_LARGE,
    entity.posX,
    entity.posY,
    entity.posZ,
    50,
    entity.motionX + 0.5,
    entity.motionY + 0.5,
    entity.motionZ + 0.5, 0.1, 0);
}, 1);
