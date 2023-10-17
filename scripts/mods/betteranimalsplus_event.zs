#modloaded betteranimalsplus
#reloadable

#norun

// --------------------------------
// Geese use items
// --------------------------------
events.onEntityLivingUpdate(function(e as crafttweaker.event.EntityLivingUpdateEvent) {
  val world = e.entity.world;
  if(
    world.remote
    || isNull(e.entity.definition)
    || e.entity.definition.id != 'betteranimalsplus:goose'
  ) return;

  // val item = e.entity.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand());
  val item = e.entity.heldEquipment.length > 0 ? e.entity.heldEquipment[0] : null;
  print('~~~ isNull(item): '~isNull(item));
  if(isNull(item)) return;

  // val fakeOCPlayer = world.getPlayerByUUID(
  //   mods.zenutils.UUID.fromString('7e506b5d-2ccb-4ac4-a249-5624925b0c67')
  // );
  // print('~~~ isNull(fakeOCPlayer): '~isNull(fakeOCPlayer));

  // val player = world.getClosestPlayer(e.entity.x as double, e.entity.y as double, e.entity.z as double, 999999.0, true);
  val player = world.getFakePlayer();

  player.posX = e.entity.x;
  player.posY = e.entity.y;
  player.posZ = e.entity.z;

  player.simulateRightClickItem(item, crafttweaker.entity.IEntityEquipmentSlot.mainHand());
  print(' ~~ simulated');
});
