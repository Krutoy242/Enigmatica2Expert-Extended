#priority 9000
#modloaded contenttweaker botania
#loader contenttweaker

import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.randomtweaker.cote.SubTileEntityInGame;
import native.net.minecraft.util.EnumFacing;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;

$expand SubTileEntityInGame$isRedstonePowered(world as IWorld, pos as IBlockPos) as bool {
  for dir in EnumFacing.VALUES {
    if ((world as World).getRedstonePower((pos as BlockPos).offset(dir), dir) != 0) return true;
  }
  return false;
}
