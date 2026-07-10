#priority 100
#modloaded thaumcraft

import native.com.blamejared.compat.thaumcraft.handlers.ThaumCraft;
import native.com.pam.harvestcraft.tileentities.TileEntityApiary;
import native.forestry.apiculture.tiles.TileBeeHousingBase;
import native.net.bdew.gendustry.machines.apiary.TileApiary;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.util.ITickable;
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

zenClass SpellApiaryAcceleration extends FocusEffect {

  zenConstructor() {
    super();
  }

  //======================
  //Set up some basic info
  //======================

  function getResearch() as string {
    return 'APIARYACCELERATION';
  }
    
  function getKey() as string {
    return 'thaumcraft.APIARYACCELERATION';
  }

  //===================================
  //Set up focalmanipulator spell stats
  //===================================
    
  function getAspect() as Aspect {
    return ThaumCraft.getAspect(Aspects('🦉')[0]);
  }

  function getComplexity() as int {
    return this.getSettingValue('power') * 5;
  }

  function createSettings() as NodeSetting[] {
    return [
      NodeSetting('power', 'focus.common.power', NodeSetting.NodeSettingIntRange(1, 5))
    ];
  }

  //==========================
  //Set up executable function
  //==========================

  function execute(target as RayTraceResult, trajectory as Trajectory, finalPower as float, num as int) as bool {
    PacketHandler.INSTANCE.sendToAllAround(PacketFXFocusPartImpact(target.hitVec.x, target.hitVec.y, target.hitVec.z, [getKey()]), NetworkRegistry.TargetPoint(this.getPackage().world.provider.getDimension(), target.hitVec.x, target.hitVec.y, target.hitVec.z, 64.0));
    if(target.typeOfHit == RayTraceResult.Type.BLOCK){
      val world = this.getPackage().world;
      val apiary = world.getTileEntity(target.getBlockPos());
      if(isNull(apiary)) return false;
      val bonus = finalPower * this.getSettingValue('power') * 50 as int;

      if(apiary instanceof TileBeeHousingBase || apiary instanceof TileEntityApiary || apiary instanceof TileApiary){
        val house = apiary as ITickable;
        for i in 0 .. bonus{
          house.update();
        }
        world.playSound(null, target.getBlockPos(), SoundsTC.wand, SoundCategory.BLOCKS, 1.0f, world.rand.nextFloat() * 0.4f + 0.8f);
          return true;
        }
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
  
    fb.setMaxAge(8); 
    fb.setRBGColorF(0.95f + world.rand.nextFloat() * 0.05f, 0.95f + world.rand.nextFloat() * 0.05f, 0.0f + world.rand.nextFloat() * 0.05f);
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
