#norun // unfinished feature
#loader mixin
#modloaded bloodmagic
#priority 3000

import native.net.minecraft.entity.Entity;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;

zenClass Op {
  static currentActivatingPlayer as EntityPlayer;
  static sendPortalMsg as function(EntityPlayer,string)void;
  static lastPortalFail as long[string] = {} as long[string];
  static onPortalCollide as function(World,BlockPos,Entity)void;
  static onPortalLinked as function(string)void;
  static portalKeysCache as string[string] = {} as string[string];
  static cachePortalKey as function(string)void;
}
