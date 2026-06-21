#modloaded villagenames

import crafttweaker.event.EntityLivingUpdateEvent;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.entity.IEntityLiving;

// Fix preventing tagged entities names from despawning
events.onEntityLivingUpdate(function(event as EntityLivingUpdateEvent) as void {
    val entityBase = event.entityLivingBase;
    
    val living as IEntityLiving = entityBase;
    if (living.hasCustomName) {
        living.enablePersistence();
    }
});