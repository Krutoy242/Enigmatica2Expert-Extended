#priority 100
#modloaded thaumcraft ic2

import native.com.blamejared.compat.thaumcraft.handlers.ThaumCraft;
import native.ic2.core.crop.TileEntityCrop;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.util.SoundCategory;
import native.net.minecraft.util.math.RayTraceResult;
import native.net.minecraft.world.World;
import native.net.minecraftforge.fml.common.network.NetworkRegistry;
import native.thaumcraft.api.aspects.Aspect;
import native.thaumcraft.api.casters.FocusEffect;
import native.thaumcraft.api.casters.NodeSetting;
import native.thaumcraft.api.casters.Trajectory;
import native.thaumcraft.client.fx.ParticleEngine;
import native.thaumcraft.client.fx.particles.FXGeneric;
import native.thaumcraft.common.lib.SoundsTC;
import native.thaumcraft.common.lib.network.PacketHandler;
import native.thaumcraft.common.lib.network.fx.PacketFXFocusPartImpact;

zenClass SpellCrossbreed extends FocusEffect {

    zenConstructor() {
        super();
    }

    //======================
    //Set up some basic info
    //======================

    function getResearch() as string {
        return 'CROSSBREED';
    }
    
    function getKey() as string {
        return 'thaumcraft.CROSSBREED';
    }

    //===================================
    //Set up focalmanipulator spell stats
    //===================================
    
    function getAspect() as Aspect {
        return ThaumCraft.getAspect(Aspects('🛎️')[0]);
    }

    function getComplexity() as int {
        return 15;
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

        if (target.typeOfHit != RayTraceResult.Type.BLOCK) return false;

        val block = world.getTileEntity(pos);
        if (isNull(block) || !(block instanceof TileEntityCrop)) return false;

        val tileCrop = block as TileEntityCrop;

        for i in 0 .. 5 {
          if (tileCrop.attemptCrossingPublic()) {
            world.playSound(null, pos, SoundsTC.wand, SoundCategory.AMBIENT, 1.0f, world.rand.nextFloat() * 0.4f + 0.8f);
            return true;
          }
        }

        return false;
    }

    function onCast(caster as Entity) { //optional
        
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
