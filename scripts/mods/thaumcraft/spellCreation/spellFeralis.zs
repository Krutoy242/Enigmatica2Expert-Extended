#priority 100
#modloaded thaumcraft

import native.com.blamejared.compat.thaumcraft.handlers.ThaumCraft;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.entity.passive.AbstractHorse;
import native.net.minecraft.entity.passive.EntityAnimal;
import native.net.minecraft.entity.passive.EntityOcelot;
import native.net.minecraft.entity.passive.EntityTameable;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.util.EnumParticleTypes;
import native.net.minecraft.util.math.RayTraceResult;
import native.net.minecraft.world.World;
import native.net.minecraft.world.WorldServer;
import native.net.minecraftforge.fml.common.network.NetworkRegistry;
import native.thaumcraft.api.aspects.Aspect;
import native.thaumcraft.api.casters.FocusEffect;
import native.thaumcraft.api.casters.NodeSetting;
import native.thaumcraft.api.casters.Trajectory;
import native.thaumcraft.client.fx.ParticleEngine;
import native.thaumcraft.client.fx.particles.FXGeneric;
import native.thaumcraft.common.lib.network.PacketHandler;
import native.thaumcraft.common.lib.network.fx.PacketFXFocusPartImpact;

zenClass SpellFeralis extends FocusEffect {

    zenConstructor() {
        super();
    }

    //======================
    //Set up some basic info
    //======================

    function getResearch() as string {
        return 'FERALIS';
    }
    
    function getKey() as string {
        return 'thaumcraft.FERALIS';
    }

    //===================================
    //Set up focalmanipulator spell stats
    //===================================
    
    function getAspect() as Aspect {
        return ThaumCraft.getAspect(Aspects('🙌')[0]); //BUG using  it produce ⚙️
    }

    function getComplexity() as int {
        return 10;
    }

    function createSettings() as NodeSetting[] {
        return [];
    }

    //==========================
    //Set up executable function
    //==========================

    function execute(target as RayTraceResult, trajectory as Trajectory, finalPower as float, num as int) as bool {
        val world = this.getPackage().world;
        val pos = target.getBlockPos();

        PacketHandler.INSTANCE.sendToAllAround(PacketFXFocusPartImpact(target.hitVec.x, target.hitVec.y, target.hitVec.z, [getKey()]), NetworkRegistry.TargetPoint(world.provider.getDimension(), target.hitVec.x, target.hitVec.y, target.hitVec.z, 64.0));

        val caster = this.getPackage().getCaster();
        if(!(caster instanceof EntityPlayer)) return false;
        val player = caster as EntityPlayer;

        val entity = target.entityHit;

        if (isNull(entity) || target.typeOfHit != RayTraceResult.Type.ENTITY || !entity instanceof EntityAnimal) return false;
        if(entity instanceof EntityTameable){
            val entityTame = entity as EntityTameable;

            val wasOwned = isNull(entityTame.getOwner());
            (world as WorldServer).spawnParticle(EnumParticleTypes.HEART, entityTame.posX, entityTame.posY + entityTame.eyeHeight, entityTame.posZ, 7, 0.5, 0.5, 0.5, 0.01, 0);
            entityTame.setTamedBy(player);
            if(wasOwned) return true;

            //entityTame.setSitting(true);
            entityTame.heal(entityTame.getMaxHealth());
            entityTame.setAttackTarget(null);

            if(entityTame instanceof EntityOcelot){
                (entityTame as EntityOcelot).setTameSkin(1 + world.rand.nextInt(3));
            }

            return true;
        }

        if(entity instanceof AbstractHorse){
            val horse = entity as AbstractHorse;
            horse.setTamedBy(player);
            (world as WorldServer).spawnParticle(EnumParticleTypes.HEART, horse.posX, horse.posY + horse.eyeHeight, horse.posZ, 7, 0.5, 0.5, 0.5, 0.01, 0);
        }

        return false;
    }

    function onCast(caster as Entity) {
        
    }

    //==================
    //Particle rendering
    //==================

    function renderParticleFX(world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
        val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX, motionY, motionZ);
    
        fb.setMaxAge(8); //Particle lifetime (in ticks)
        fb.setRBGColorF(0.863f + (world.rand.nextFloat() - 0.5f) * 0.05f, 0.698f + (world.rand.nextFloat() - 0.5f) * 0.05f, 0.314f + (world.rand.nextFloat() - 0.5f) * 0.05f);
        //fb.setAlphaF(0.0f); //Transparency
        fb.setGridSize(16); //Particle texture size
        fb.setParticles(72 + world.rand.nextInt(4), 1, 1);
        fb.setScale(2.0 + world.rand.nextFloat() * 4.0); //Particle size
        fb.setLoop(false);
        fb.setSlowDown(0.9);
        fb.setGravity(0.0);
        fb.setRotationSpeed(world.rand.nextFloat(), 0.0);
    
        ParticleEngine.addEffectWithDelay(world, fb, world.rand.nextInt(4));
    }

}
