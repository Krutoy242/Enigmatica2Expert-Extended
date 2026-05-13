#modloaded baubles twilightforest
#loader mixin

import native.baubles.api.IBauble;
import native.baubles.api.BaubleType;
import native.net.minecraft.item.ItemStack;

#mixin { targets: 'twilightforest.item.ItemTFLampOfCinders' }
zenClass MixinLampOfCinders extends IBauble {
  function getBaubleType(stack as ItemStack) as BaubleType {
    return BaubleType.TRINKET;
  }
}
