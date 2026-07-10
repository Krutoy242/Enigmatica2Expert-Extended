#priority 100
#modloaded thaumcraft

import native.com.blamejared.compat.thaumcraft.handlers.ThaumCraft;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.util.math.RayTraceResult;
import native.net.minecraft.world.World;
import native.thaumcraft.api.aspects.Aspect;
import native.thaumcraft.api.casters.FocusEffect;
import scripts.mods.thaumcraft.spellCreation.spellFX.SpellFX;
import native.thaumcraft.api.casters.NodeSetting;
import native.thaumcraft.api.casters.Trajectory;

zenClass SpellExplosion extends FocusEffect {

  zenConstructor() {
    super();
  }

  //======================
  //Set up some basic info
  //======================

  function getResearch() as string {
    return 'EXPLOSION';
  }
    
  function getKey() as string {
    return 'thaumcraft.EXPLOSION';
  }

  //===================================
  //Set up focalmanipulator spell stats
  //===================================
    
  function getAspect() as Aspect {
    return ThaumCraft.getAspect(Aspects('💣')[0]);
  }

  function getComplexity() as int {
    return  5 * this.getSettingValue('power');
  }

  function createSettings() as NodeSetting[] {
    return [
      NodeSetting('power',     'focus.common.power',      NodeSetting.NodeSettingIntRange(1, 4)),
      NodeSetting('destroy',   'focus.common.destroy',    NodeSetting.NodeSettingIntList([0, 1],       ['focus.common.no', 'focus.common.yes']))
    ];
  }

  //==========================
  //Set up executable function
  //==========================

  function execute(target as RayTraceResult, trajectory as Trajectory, finalPower as float, num as int) as bool {
    val world = this.getPackage().world;
    val pos = target.hitVec;
    world.createExplosion(null, pos.x, pos.y, pos.z, this.getSettingValue('power') * 2, this.getSettingValue('destroy') == 1);
    return true;
  }

  function onCast(caster as Entity) {
  }

  //==================
  //Particle rendering
  //==================

  function renderParticleFX(world as World, posX as double, posY as double, posZ as double, motionX as double, motionY as double, motionZ as double) as void {
    if (!isNull(SpellFX.explosion)) SpellFX.explosion(this, world, posX, posY, posZ, motionX, motionY, motionZ);
  }
}
