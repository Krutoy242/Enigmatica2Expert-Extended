#modloaded cosmeticarmorreworked
#reloadable

import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.inventory.EntityEquipmentSlot;
import native.net.minecraft.item.ItemStack;
import native.lain.mods.cos.api.CosArmorAPI;

// CAR's isSkinArmor hides the slot entirely — both vanilla armor and cosmetic
val visChecker as function(EntityPlayer,EntityEquipmentSlot)bool = function (player as EntityPlayer, slot as EntityEquipmentSlot) as bool {
  val uuid = player.getUniqueID();
  if (isNull(uuid)) return true;

  val cosStacks = CosArmorAPI.getCAStacks(uuid);
  if (isNull(cosStacks)) return true;

  return !cosStacks.isSkinArmor(slot.getSlotIndex());
};
scripts.lib.inventory.armorVisibilityCheckers.add(visChecker);

val carChecker as function(EntityPlayer,ItemStack)bool = function (player as EntityPlayer, item as ItemStack) as bool {
  val uuid = player.getUniqueID();
  if (isNull(uuid)) return false;

  val cosStacks = CosArmorAPI.getCAStacks(uuid);
  if (isNull(cosStacks)) return false;

  val slotCount = cosStacks.slots;
  for i in 0 .. slotCount {
    val cosStack = cosStacks.getStackInSlot(i);
    if (isNull(cosStack) || cosStack.isEmpty()) continue;
    if (!cosStack.isItemEqualIgnoreDurability(item)) continue;
    if (!cosStacks.isSkinArmor(i)) return true;
  }

  return false;
};
scripts.lib.inventory.extraCheckers.add(carChecker);
