#modloaded ftbquests itemfilters
#loader mixin

import native.net.minecraft.item.ItemStack;
import native.com.latmod.mods.itemfilters.api.ItemFiltersAPI;
import native.com.latmod.mods.itemfilters.item.ItemFiltersItems;
import native.com.latmod.mods.itemfilters.filters.NBTMatchingMode;
import native.java.util.Objects;

/*
  Crafting checks many quest requirements against the player's inventory.
  Compare item and metadata before reading NBT, and avoid temporary streams and lists.
  Keep Item Filters first and preserve the order of requirement alternatives.
*/
#mixin { targets: 'com.feed_the_beast.ftbquests.quest.task.ItemTask' }
zenClass MixinItemTask {
  #mixin Overwrite
  function test(stack as ItemStack) as bool {
    if (stack.func_190926_b() || stack.func_77973_b() == ItemFiltersItems.MISSING) return false;

    // Item Filters can match items other than the filter item itself.
    for rawRequirement in this0.items {
      val requirement = rawRequirement as ItemStack;
      if (ItemFiltersAPI.isFilter(requirement) && ItemFiltersAPI.filter(requirement, stack)) return true;
    }

    val item = stack.func_77973_b();
    val meta = this0.ignoreDamage ? 0 : stack.func_77960_j();

    for rawRequirement in this0.items {
      val requirement = rawRequirement as ItemStack;
      if (ItemFiltersAPI.isFilter(requirement)) continue;
      if (item != requirement.func_77973_b()) continue;
      if (!this0.ignoreDamage && meta != requirement.func_77960_j()) continue;

      if (this0.nbtMode == NBTMatchingMode.IGNORE) return true;

      if (this0.nbtMode == NBTMatchingMode.MATCH) {
        return Objects.equals(item.getNBTShareTag(stack), requirement.func_77973_b().getNBTShareTag(requirement));
      }

      if (this0.nbtMode == NBTMatchingMode.CONTAIN) {
        val expected = requirement.func_77978_p();
        if (isNull(expected) || expected.func_82582_d()) return true;
        val actual = stack.func_77978_p();
        if (isNull(actual) || actual.func_82582_d()) return false;
        val keys = expected.func_150296_c().iterator();
        while keys.hasNext() {
          val key = keys.next() as string;
          if (!Objects.equals(actual.func_74781_a(key), expected.func_74781_a(key))) return false;
        }
        return true;
      }
    }

    return false;
  }
}
