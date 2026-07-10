#priority 100
#modloaded thaumcraft

import native.com.blamejared.compat.thaumcraft.handlers.ThaumCraft;
import native.hellfirepvp.astralsorcery.common.util.effect.time.TimeStopController;
import native.hellfirepvp.astralsorcery.common.util.effect.time.TimeStopZone;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.util.SoundCategory;
import native.net.minecraft.util.math.BlockPos;
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

zenClass SpellChronostasis extends FocusEffect {

  zenConstructor() {
    super();
  }

  //======================
  //Set up some basic info
  //======================

  function getResearch() as string {
    return 'CHRONOSTASIS';
  }
    
  function getKey() as string {
    return 'thaumcraft.CHRONOSTASIS';
  }

  //===================================
  //Set up focalmanipulator spell stats
  //===================================
    
  function getAspect() as Aspect {
    return ThaumCraft.getAspect(Aspects('♾️')[0]);
  }

  function getComplexity() as int {
    return  5 * this.getSettingValue('range') * this.getSettingValue('duration');
  }

  function createSettings() as NodeSetting[] {
    return [
      NodeSetting('range',      'focus.common.range',    NodeSetting.NodeSettingIntList( [1, 2, 3, 4], ['5', '10', '20', '40'])),
      NodeSetting('duration',  'focus.common.duration',  NodeSetting.NodeSettingIntRange(1, 5))
    ];
  }

  //==========================
  //Set up executable function
  //==========================

  function execute(target as RayTraceResult, trajectory as Trajectory, finalPower as float, num as int) as bool {
    PacketHandler.INSTANCE.sendToAllAround(PacketFXFocusPartImpact(target.hitVec.x, target.hitVec.y, target.hitVec.z, [this.getKey()]), NetworkRegistry.TargetPoint(this.getPackage().world.provider.getDimension(), target.hitVec.x, target.hitVec.y, target.hitVec.z, 64.0));
    if(this.getPackage().getCaster() instanceof EntityPlayer){
      val player = this.getPackage().getCaster() as EntityPlayer;
      if (player.cooldownTracker.hasCooldown(<thaumcraft:caster_basic>.native.getItem())) return false;
      
      val world = this.getPackage().world;
      val range = 5 * pow(2, this.getSettingValue('range') - 1) ;
      val duration = (finalPower * this.getSettingValue('duration') * 10) as int;
      val pos = BlockPos(trajectory.source.add(trajectory.direction));

      player.cooldownTracker.setCooldown(<thaumcraft:caster_basic>.native.getItem(), duration);
      
      TimeStopController.freezeWorldAt(TimeStopZone.EntityTargetController.noPlayers(), world, pos, true, range, duration);
      world.playSound(null, pos, SoundsTC.wand, SoundCategory.AMBIENT, 1.0f, world.rand.nextFloat() * 0.4f + 0.8f);
      return true;
    }
    return false;
  }

  function onCast(caster as Entity) {
  }

  //==================
  //Particle rendering
  //==================

  function renderParticleFX(world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
    val fb as FXGeneric = FXGeneric(world, posX, posY, posZ, motionX * 0.5, motionY * 0.5, motionZ * 0.5);
    
    fb.setMaxAge(50);
    fb.setRBGColorF(0.095f + world.rand.nextFloat() * 0.01f, 0.095f + world.rand.nextFloat() * 0.01f, 0.435f + world.rand.nextFloat() * 0.01f);
    fb.setGridSize(16);
    fb.setParticles(72 + world.rand.nextInt(4), 1, 1);
    fb.setScale(20.0f + world.rand.nextFloat() * 4.0); 
    fb.setLoop(false);
    fb.setSlowDown(0.8);
    fb.setGravity(0.0f);
    fb.setRotationSpeed(world.rand.nextFloat(), 0.1f);
    
    ParticleEngine.addEffectWithDelay(world, fb, world.rand.nextInt(4));
  }
}
