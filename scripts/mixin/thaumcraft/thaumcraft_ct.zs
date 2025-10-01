#modloaded thaumcraft
#reloadable
#priority -100

import native.net.minecraft.init.SoundEvents;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.SoundCategory;
import native.net.minecraftforge.event.world.BlockEvent.HarvestDropsEvent;
import native.net.minecraftforge.oredict.OreDictionary;
import native.thaumcraft.common.lib.enchantment.EnumInfusionEnchantment;

scripts.mixin.thaumcraft.shared.Op.doRefining
= function (event as HarvestDropsEvent, heldItem as ItemStack) as void {
  val chance_percent = 40 + 20 * (level - 1) + 10 * event.fortuneLevel;

  val lucky_number = event.world.rand.nextInt(100);
  if (lucky_number >= chance_percent) { // if chance < 1, refining may not trigger at all
      return;
  }

  var dropAmount = chance_percent / 100;
  if (lucky_number < chance_percent % 100) {
      dropAmount += 1;
  }

  var outputMultiplier = 1;
  for oreID in OreDictionary.getOreIDs(ItemStack(event.state.block)) {
      val newName = OreDictionary.getOreName(oreID);
      if (isNull(newName)) continue;
      
      if (newName.startsWith("oreNether") || newName.startsWith("oreEnd")) {
          outputMultiplier = 2;
          break;
      }
  }

  var newDrops as [ItemStack] = [] as [ItemStack];
  var replacementItem as ItemStack = null;
  var foundReplacement = false;

  for is in event.drops {
      if (isNull(is) || is.isEmpty()) continue;

      var found = false;
      
      for oreID in OreDictionary.getOreIDs(is) {
          val newName = OreDictionary.getOreName(oreID);
          if (isNull(newName)) continue;
          
          var subLen = 0;
          if (newName.startsWith("oreNether")) {
              subLen = 9;
          } else if (newName.startsWith("oreEnd")) {
              subLen = 6;
          } else if (newName.startsWith("ore") || newName.startsWith("gem")) {
              subLen = 3;
          } else if (newName.startsWith("dust")) {
              subLen = 4;
          } else {
              continue;
          }

          val oreName = "cluster" + newName.substring(subLen);
          val list as NonNullList = OreDictionary.getOres(oreName);
          for item in OreDictionary.getOres(oreName) {
              if (isNull(item)) continue;

              if (!foundReplacement) {
                  replacementItem = item as ItemStack;
                  foundReplacement = true;
              }

              found = true;
              break;
          }

          if (found) break;
      }

      if (!found) { // not found ore, adding item as it is
          newDrops += is;
      }
  }

  if (!foundReplacement) return;

  replacementItem.setCount(dropAmount * outputMultiplier);
  newDrops += replacementItem;

  event.drops.clear();
  for is in newDrops {
      event.drops.add(is);
  }

  event.world.playSound(null, event.getPos(), SoundEvents.ENTITY_EXPERIENCE_ORB_PICKUP, SoundCategory.PLAYERS, 0.2F, 0.7F + event.world.rand.nextFloat() * 0.2F);
};
