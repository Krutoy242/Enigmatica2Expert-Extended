#priority 4000
#reloadable
#modloaded zenutils

import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.inventory.EntityEquipmentSlot;
import native.net.minecraft.item.ItemStack;

// Optional visibility checkers (e.g. CAR marks a slot as hidden). All must pass.
static armorVisibilityCheckers as [function(EntityPlayer,EntityEquipmentSlot)bool] = [];

// Extra checkers registered by mod-specific files (e.g. CosmeticArmorReworked)
static extraCheckers as [function(EntityPlayer,ItemStack)bool] = [];

function doesTheyWear(player as IPlayer, item as IItemStack) as bool {
  val nativePlayer = player as EntityPlayer;
  val nativeItem = item as ItemStack;

  // Check regular armor slots
  if (_checkSlot(nativePlayer, nativeItem, EntityEquipmentSlot.HEAD)) return true;
  if (_checkSlot(nativePlayer, nativeItem, EntityEquipmentSlot.CHEST)) return true;
  if (_checkSlot(nativePlayer, nativeItem, EntityEquipmentSlot.LEGS)) return true;
  if (_checkSlot(nativePlayer, nativeItem, EntityEquipmentSlot.FEET)) return true;

  // Extra checkers from mods (e.g. CosmeticArmorReworked)
  for i, _checker in extraCheckers {
    if (!isNull(_checker) && _checker(nativePlayer, nativeItem)) return true;
  }

  return false;
}

function _checkSlot(player as EntityPlayer, item as ItemStack, slot as EntityEquipmentSlot) as bool {
  val stack = player.getItemStackFromSlot(slot);
  if (isNull(stack)) return false;
  if (stack.isEmpty()) return false;
  if (!stack.isItemEqualIgnoreDurability(item)) return false;
  // Respect visibility overrides (e.g. CAR marks this slot as hidden)
  for i, c in armorVisibilityCheckers {
    if (!c(player, slot)) return false;
  }
  return true;
}
