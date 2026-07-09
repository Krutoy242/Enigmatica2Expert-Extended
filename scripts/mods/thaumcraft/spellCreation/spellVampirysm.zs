#priority 100
#modloaded thaumcraft

import crafttweaker.damage.IDamageSource;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.player.IPlayer;
import native.com.blamejared.compat.thaumcraft.handlers.ThaumCraft;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.entity.IEntityOwnable;
import native.net.minecraft.util.math.RayTraceResult;
import native.net.minecraft.world.World;
import native.net.minecraftforge.fml.common.network.NetworkRegistry;
import native.thaumcraft.api.aspects.Aspect;
import native.thaumcraft.api.casters.FocusEffect;
import native.thaumcraft.api.casters.NodeSetting;
import native.thaumcraft.api.casters.Trajectory;
import native.thaumcraft.client.fx.ParticleEngine;
import native.thaumcraft.client.fx.particles.FXGeneric;
import native.thaumcraft.common.lib.network.PacketHandler;
import native.thaumcraft.common.lib.network.fx.PacketFXFocusPartImpact;

zenClass SpellVampirysm extends FocusEffect {

    zenConstructor() {
        super();
    }

    //======================
    //Set up some basic info
    //======================

    function getResearch() as string {
        return 'VAMPIRYSM';
    }
    
    function getKey() as string {
        return 'thaumcraft.VAMPIRYSM';
    }

    //===================================
    //Set up focalmanipulator spell stats
    //===================================
    
    function getAspect() as Aspect {
        return ThaumCraft.getAspect(Aspects('🩸')[0]);
    }

    function getComplexity() as int {
        return this.getSettingValue('power') * 3 + this.getSettingValue('lifesteal') * 2 + this.getSettingValue('bloodOrb') * 5;
    }

    function getDamageForDisplay(finalPower as float) as float {
        return (1.0f + this.getSettingValue('power')) * finalPower;
    }

    function createSettings() as NodeSetting[] {
        return [
            NodeSetting('power',     'focus.common.power',      NodeSetting.NodeSettingIntRange(1, 5)),
            NodeSetting('lifesteal', 'focus.common.lifesteal',  NodeSetting.NodeSettingIntList([1, 2, 3, 4], ['10%', '20%', '30%', '40%'])),
            NodeSetting('bloodOrb',  'focus.common.bloodOrb',   NodeSetting.NodeSettingIntList([0, 1],       ['focus.common.no', 'focus.common.yes']))
            ];
    }

    //==========================
    //Set up executable function
    //==========================

    function execute(target as RayTraceResult, trajectory as Trajectory, finalPower as float, num as int) as bool {
        PacketHandler.INSTANCE.sendToAllAround(PacketFXFocusPartImpact(target.hitVec.x, target.hitVec.y, target.hitVec.z, [getKey()]), NetworkRegistry.TargetPoint(this.getPackage().world.provider.getDimension(), target.hitVec.x, target.hitVec.y, target.hitVec.z, 64.0));
        if(isNull(target.entityHit) && target.typeOfHit != RayTraceResult.Type.ENTITY) return false;
        
        val damage = this.getDamageForDisplay(finalPower);
        val lifesteal = this.getSettingValue('lifesteal');
        val casterWrapper = this.getPackage().getCaster();
        if(isNull(casterWrapper)) return false;
        val caster as IEntityLivingBase = casterWrapper.wrapper;

        target.entityHit.wrapper.attackEntityFrom(IDamageSource.createIndirectMagicDamage(caster, caster), damage);
        if(isNull(caster)) return false;
        caster.heal(damage * lifesteal / 10);
        if(this.getSettingValue('bloodOrb') == 1){
            val player as IPlayer = caster.native instanceof IEntityOwnable ? (caster.native as IEntityOwnable).getOwner().wrapper : caster;
            if(!isNull(player) && !isNull(player.soulNetwork)) player.soulNetwork.add(10 * lifesteal * damage, 50000000);
        }
        return true;
    }

    function onCast(caster as Entity) {
        
    }

    //==================
    //Particle rendering
    //==================

    function renderParticleFX(world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
        val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX, motionY, motionZ);
    
        fb.setMaxAge(8); 
        fb.setRBGColorF(0.47 + world.rand.nextFloat() * 0.05, 0.07 + world.rand.nextFloat() * 0.02, 0.07 + world.rand.nextFloat() * 0.02);
        fb.setGridSize(16); 
        fb.setParticles(72 + world.rand.nextInt(4), 1, 1);
        fb.setScale(2.0 + world.rand.nextFloat() * 4.0); 
        fb.setLoop(false);
        fb.setSlowDown(0.9);
        fb.setGravity(0.0);
        fb.setRotationSpeed(world.rand.nextFloat(), 0.0);
    
        ParticleEngine.addEffectWithDelay(world, fb, world.rand.nextInt(4));
    }
    
}
