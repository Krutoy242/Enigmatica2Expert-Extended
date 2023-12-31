#modloaded betteranimalsplus
#reloadable

import crafttweaker.entity.IEntityAnimal;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.player.IPlayer;

function clearPlayerInventory(player as IPlayer) as void {
  for i in 0 .. player.inventorySize {
    val item = player.getInventoryStack(i);
    if (isNull(item)) continue;
    player.replaceItemInInventory(i, null);
  }
}

// --------------------------------
// Geese use items
// --------------------------------
events.onEntityLivingUpdate(function (e as crafttweaker.event.EntityLivingUpdateEvent) {
  val world = e.entity.world;
  if (
    world.remote
    || !(e.entity instanceof IEntityAnimal)
    || (e.entity instanceof IPlayer)
    || e.entity.definition.id != 'betteranimalsplus:goose'
    || world.time % 10 != 0
  ) return;

  val entity as IEntityLivingBase = e.entity;

  val item = entity.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand());

  // No item in Goose beak
  if (isNull(item)) return;

  // Test random
  if (world.random.nextInt(5) != 0) return;

  val player = world.getFakePlayer();
  player.setToLocationFrom(entity);
  // player.posY -= 0.5;

  // Clear previous fake player inventory
  clearPlayerInventory(player);

  val result = player.simulateRightClickItem(item, crafttweaker.entity.IEntityEquipmentSlot.mainHand());

  // Replace held item of Goose
  entity.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand(), result.item);

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
});
