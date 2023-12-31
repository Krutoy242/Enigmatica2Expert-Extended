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

// I used class here so we could change function implementation from other files
zenClass FX {
  // Spawn portal-related particles
  static particles as function(IWorld,double,double,double,IVector3d,int)void
    = function (world as IWorld, x as double, y as double, z as double, vel as IVector3d, amount as int) as void {
      server.commandManager.executeCommandSilent(<minecraft:dirt>.createEntityItem(world, x as int, y as int, z as int),
        '/particle fireworksSpark '
        ~ ((x + 0.5)) ~ ' ' ~ (y + 0.5) ~ ' ' ~ ((z + 0.5))
        ~ ' 0.25 0.25 0.25 0.02 ' ~ amount
      );
    };

  zenConstructor() {}
}
