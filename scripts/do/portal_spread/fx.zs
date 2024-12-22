/**
 * @file Lib for creating effects
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#modloaded zenutils
#priority 3000
#reloadable

import crafttweaker.world.IVector3d;
import crafttweaker.world.IWorld;
import native.net.minecraft.util.EnumParticleTypes;

// I used class here so we could change function implementation from other files
zenClass FX {
  // Spawn portal-related particles
  static particles as function(IWorld,double,double,double,IVector3d,int)void
    = function (world as IWorld, x as double, y as double, z as double, vel as IVector3d, amount as int) as void {
      (world.native as native.net.minecraft.world.WorldServer).spawnParticle(
        EnumParticleTypes.FIREWORKS_SPARK,
        x + 0.5, y + 0.5, z + 0.5, amount, 0.25, 0.25, 0.25, 0.1, 0);
    };

  zenConstructor() {}
}
