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
  val level = EnumInfusionEnchantment.getInfusionEnchantmentLevel(heldItem, EnumInfusionEnchantment.REFINING);
  val chance_percent = 40 + 20 * (level - 1) + 10 * event.fortuneLevel;

  val lucky_number = event.world.rand.nextInt(100);
  if (lucky_number >= chance_percent) {
    return;
  }

  var dropAmount = chance_percent / 100;
  if (lucky_number < chance_percent % 100) {
    dropAmount += 1;
  }

  var outputMultiplier = 1;
  val block = event.state.block;
  val blockStack = ItemStack(block, 1, block.getMetaFromState(event.state));
  if (!blockStack.isEmpty()) {
    for oreID in OreDictionary.getOreIDs(blockStack) {
      val oreName = OreDictionary.getOreName(oreID);
      if (isNull(oreName)) continue;
      if (oreName.startsWith('oreNether') || oreName.startsWith('oreEnd')) {
        outputMultiplier = 2;
        break;
      }
    }
  }

  var nonRefinableDrops = [] as [ItemStack];
  var clustersFound = {} as ItemStack[string];
  var hasRefinedSomething = false;

  for originalDrop in event.drops {
    if (isNull(originalDrop) || originalDrop.isEmpty()) continue;

    var cluster as ItemStack = null;
    for oreID in OreDictionary.getOreIDs(originalDrop) {
      val oreName = OreDictionary.getOreName(oreID);
      if (isNull(oreName)) continue;

      var subLen = 0;
      if      (oreName.startsWith('oreNether')) subLen = 9;
      else if (oreName.startsWith('oreEnd'))    subLen = 6;
      else if (oreName.startsWith('dust'))      subLen = 4;
      else if (oreName.startsWith('ore'))       subLen = 3;
      else if (oreName.startsWith('gem'))       subLen = 3;
      else continue;

      val clusterOreName = 'cluster' ~ oreName.substring(subLen);
      val ores = OreDictionary.getOres(clusterOreName);
      if (!ores.isEmpty() && !isNull(ores[0])) {
        cluster = ores[0];
        break;
      }
    }

    if (!isNull(cluster)) {
      hasRefinedSomething = true;
      val clusterKey = toString(cluster);
      if (isNull(clustersFound[clusterKey])) {
        clustersFound[clusterKey] = cluster;
      }
    } else {
      nonRefinableDrops += originalDrop;
    }
  }

  if (!hasRefinedSomething) {
    return;
  }

  var newDrops = nonRefinableDrops;
  val finalAmount = dropAmount * outputMultiplier;
  for key, clusterItem in clustersFound {
    val newClusterStack = clusterItem.copy();
    newClusterStack.setCount(finalAmount);
    newDrops += newClusterStack;
  }

  event.drops.clear();
  for is in newDrops {
    event.drops.add(is);
  }

  event.world.playSound(null, event.getPos(), SoundEvents.ENTITY_EXPERIENCE_ORB_PICKUP, SoundCategory.PLAYERS, 0.2f, 0.7f + event.world.rand.nextFloat() * 0.2f);
};
