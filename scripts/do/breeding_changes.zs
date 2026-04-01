#reloadable

import native.com.github.alexthe666.iceandfire.entity.EntityAmphithere;
import native.java.lang.Class;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.entity.EntityAgeable;
import native.net.minecraft.entity.passive.EntityChicken;
import native.net.minecraft.entity.passive.EntityCow;
import native.net.minecraft.entity.passive.EntityDonkey;
import native.net.minecraft.entity.passive.EntityHorse;
import native.net.minecraft.entity.passive.EntityLlama;
import native.net.minecraft.entity.passive.EntityMule;
import native.net.minecraft.entity.passive.EntityOcelot;
import native.net.minecraft.entity.passive.EntityParrot;
import native.net.minecraft.entity.passive.EntityPig;
import native.net.minecraft.entity.passive.EntityRabbit;
import native.net.minecraft.entity.passive.EntitySheep;
import native.net.minecraft.entity.passive.EntityTameable;
import native.net.minecraft.entity.passive.EntityWolf;

/* 
First idea to implement this feature was to use mixins, however it's not supported directly on vanilla minecraft.

Second idea was to use BabyEntitySpawnEvent with have a problem that is called before animals AI spawnChild() method - this method overrides
growth timer i wanted for animals (even when event is canceled). So the code right now replace child(s) to apply correct timers, while catenation
set correct growth timers for both parents - since spawnChild() overrides both parents timers it needs to be casted after that. I decided to
better make catenation instead of calling .onTick() method to check if parents timers should be corrected.
*/

// [growthTimeTicks, breedingCooldownTicks, children, bonusChildren]
static breedingStats as int[][Class] = {
    EntityCow.class:        [-72000, 24000, 1, 0],
    EntitySheep.class:      [-36000, 12000, 1, 0],
    EntityPig.class:        [-12000, 6000,  2, 2],
    EntityChicken.class:    [-6000,  6000,  1, 0],
    EntityRabbit.class:     [-7200,  3600,  1, 1],

    EntityHorse.class:      [-72000, 24000, 1, 0],
    EntityDonkey.class:     [-72000, 24000, 1, 0],
    EntityMule.class:       [-72000, 24000, 1, 0],
    EntityLlama.class:      [-72000, 24000, 1, 0],

    EntityWolf.class:       [-24000, 12000, 1, 1],
    EntityOcelot.class:     [-24000, 12000, 1, 0],
    EntityParrot.class:     [-12000, 8000,  1, 0]
};

events.register(function(event as native.net.minecraftforge.event.entity.living.BabyEntitySpawnEvent) {
    
    val world = event.getParentA().world;
    if (world.isRemote) return;

    val parentARaw = event.getParentA();
    val parentBRaw = event.getParentB();
    val childRaw = event.getChild();

    if (isNull(parentARaw) || isNull(parentBRaw) || isNull(childRaw)) return;
    if (!(parentARaw instanceof EntityAgeable) || !(parentBRaw instanceof EntityAgeable) || !(childRaw instanceof EntityAgeable)) return;

    if (parentARaw instanceof EntityAmphithere && parentBRaw instanceof EntityAmphithere 
    && (parentARaw as EntityTameable).isTamed() && (parentBRaw as EntityTameable).isTamed()) {
        (childRaw as EntityAgeable).getEntityData().setInteger("ScalingHealth.IsBlight", 1);
        return;
    }

    val parentA as EntityAgeable = parentARaw as EntityAgeable;
    val parentB as EntityAgeable = parentBRaw as EntityAgeable;

    val clazz = childRaw.getClass();
    if (!(breedingStats has clazz)) return;

    event.setCanceled(true);

    val stats = breedingStats[clazz];
    val rand = parentA.getRNG();

    val childCount = stats[2] + (stats[3] != 0 ? rand.nextInt(stats[3] + 1) : 0);
    for i in 0 .. childCount {
        val child = parentA.createChild(parentB) as EntityAgeable;
        if (isNull(child)) continue;
        child.setGrowingAge(stats[0]);
        child.setLocationAndAngles(parentA.posX, parentA.posY, parentA.posZ, 0.0F, 0.0F);
        parentA.world.spawnEntity(child);
    }
    
    mods.zenutils.CatenationPersistence.startPersistedCatenation("applyBreedingCooldown", parentA.world)
        .withEntity(parentA as Entity, "parentA")
        .withEntity(parentB as Entity, "parentB")
        .withData({cooldown: stats[1]}, 'cooldown')
        .start();
    
});

mods.zenutils.CatenationPersistence.registerPersistedCatenation("applyBreedingCooldown")
    .setCatenationFactory(function(world) {
        return world.catenation()
            .then(function(world, context) {
                val parents = [
                    context.getEntity("parentA").native,
                    context.getEntity("parentB").native
                ] as EntityAgeable[];
                val cooldown = context.getPersistedData('cooldown').cooldown;

                for p in parents {
                    if (isNull(p) || !(p instanceof EntityAgeable)) continue;
                    p.setGrowingAge(cooldown);
                }
            })
            .start();
    })
    .addEntityHolder("parentA")
    .addEntityHolder("parentB")
    .addDataHolder('cooldown')
.register();
