#loader mixin
#priority 3000

import mixin.CallbackInfo;
import native.net.minecraft.item.ItemStack;
import native.net.minecraftforge.event.world.BlockEvent.HarvestDropsEvent;

zenClass Op {
  static doRefining as function(HarvestDropsEvent,ItemStack)void;
}
