/*
 * 👕 CosmeticArmorReworked — read the player's cosmetic armor slots.
 *
 * WHY THIS IS SPLIT IN THREE FILES:
 *   `CosArmorAPI.getCAStacks` resolves through the *server's* save folder
 *   (InventoryManager.getSavesDirectory -> getMinecraftServerInstance), so on a client
 *   connected to a dedicated server the very first call NPEs — "server is null".
 *   The client must use `getCAStacksClient`, which reads the packet-synced cache
 *   instead, but that method is @SideOnly(CLIENT) and stripped from the server jar,
 *   so a script mentioning it cannot even be parsed server-side.
 *   Hence: this file holds the logic, the `_client` / `_server` companions register
 *   the accessor their own side is allowed to call.
 */
#modloaded cosmeticarmorreworked
#priority 3900
#reloadable

import native.lain.mods.cos.api.inventory.CAStacksBase;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.inventory.EntityEquipmentSlot;
import native.net.minecraft.item.ItemStack;

// Filled by cosmeticarmorreworked_client.zs / _server.zs (only one of them loads).
static stacksGetters as [function(EntityPlayer)CAStacksBase] = [];

function getStacks(player as EntityPlayer) as CAStacksBase {
  for i, getter in stacksGetters {
    val stacks = getter(player);
    if (!isNull(stacks)) return stacks;
  }
  return null;
}

// CAR's isSkinArmor hides the slot entirely — both vanilla armor and cosmetic
val visChecker as function(EntityPlayer,EntityEquipmentSlot)bool = function (player as EntityPlayer, slot as EntityEquipmentSlot) as bool {
  val cosStacks = getStacks(player);
  if (isNull(cosStacks)) return true;

  return !cosStacks.isSkinArmor(slot.getSlotIndex());
};
scripts.lib.inventory.armorVisibilityCheckers.add(visChecker);

val carChecker as function(EntityPlayer,ItemStack)bool = function (player as EntityPlayer, item as ItemStack) as bool {
  val cosStacks = getStacks(player);
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
