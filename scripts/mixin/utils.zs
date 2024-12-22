#loader mixin
#priority 2000
#reloadable

import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.NonNullList;
import native.net.minecraftforge.oredict.OreDictionary;

function firstItem(oreName as string) as ItemStack {
  val list as NonNullList = OreDictionary.getOres(oreName);
  if (list.size() <= 0) return null;
  return list.get(0);
}
