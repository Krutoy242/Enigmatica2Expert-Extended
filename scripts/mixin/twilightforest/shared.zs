#loader mixin
#priority 1000

import native.net.minecraft.item.ItemStack;

zenClass Op {
  static validateUncraft as function(ItemStack,ItemStack[])void;
}
