#modloaded travelersbackpack
#loader mixin
#priority 3000

import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.world.World;

zenClass Op {
  static fn as function(World,EntityPlayer,ItemStack)bool;
}
