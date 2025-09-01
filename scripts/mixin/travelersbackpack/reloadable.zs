#modloaded travelersbackpack
#reloadable

import native.com.m4thg33k.tombmanygraves.events.CommonEvents;
import native.com.tiviacz.travelersbackpack.util.BackpackUtils;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;

static commonEvents as CommonEvents = CommonEvents();

scripts.mixin.travelersbackpack.shared.Op.fn
= function (world as World, player as EntityPlayer, itemstack as ItemStack) as bool {
  var pos = BlockPos(0, -1, 0);
  if (native.com.m4thg33k.tombmanygraves.ModConfigs.ASCEND_LIQUID) {
    pos = commonEvents.publicFindValidGraveLocation(player.world, commonEvents.publicAscendFromFluid(player.world, player.position));
  }
  if (pos.y == -1) {
    pos = commonEvents.publicFindValidGraveLocation(player.world, player.position);
  }
  if (pos.y == -1) return false;
  return BackpackUtils.placeBackpack(itemstack, player, world, pos.x, pos.y, pos.z, native.net.minecraft.util.EnumFacing.UP);
};
