#modloaded betteranimalsplus
#reloadable

import crafttweaker.entity.IEntityAnimal;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityEquipmentSlot;
import crafttweaker.entity.IEntityEquipmentSlot.mainHand;

function clearPlayerInventory(player as IPlayer) as void {
  for i in 0 .. player.inventorySize {
    val item = player.getInventoryStack(i);
    if (isNull(item)) continue;
    player.replaceItemInInventory(i, null);
  }
}

static armorSlots as IEntityEquipmentSlot[] = [
  head,
  chest,
  feet,
  legs,
] as IEntityEquipmentSlot[];

// --------------------------------
// Geese use items
// --------------------------------
<entity:betteranimalsplus:goose>.onTick(function(entity) {
  val entityLiving as IEntityLivingBase = entity;
  tickGoose(entityLiving);
}, 10);

function tickGoose(entity as IEntityLivingBase) as void {
  val item = entity.getItemInSlot(mainHand());

  // No item in Goose beak
  if (isNull(item)) return;

  // Test random
  if (entity.world.random.nextInt(5) != 0) return;

  val player = entity.world.getFakePlayer();
  player.setToLocationFrom(entity);
  // player.posY -= 0.5;

  // Clear previous fake player inventory
  clearPlayerInventory(player);

  val result = player.simulateRightClickItem(item, mainHand());

  // Prevent of copying armor pieces by equipping them
  for slot in armorSlots {
    val equipment = player.getItemInSlot(slot);
    if (!isNull(equipment) && (equipment has item || item has equipment)) {
      player.replaceItemInInventory(slot.slotIndex, null);
      break;
    }
  }

  // Replace held item of Goose
  entity.setItemToSlot(mainHand(), null);

  // Drop all items in fake player inventory
  for i in 0 .. player.inventorySize {
    val item = player.getInventoryStack(i);
    if (isNull(item)) continue;
    player.replaceItemInInventory(i, null);
    player.dropItem(item);
  }

  // Copyposition if effect teleport
  entity.posX = player.posX;
  entity.posY = player.posY;// + 0.5;
  entity.posZ = player.posZ;
  player.onEntityUpdate();
}
