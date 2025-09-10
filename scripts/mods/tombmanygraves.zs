#modloaded tombmanygraves

/*

Idea taken from DJ2 modpack

*/

// Doesnt get called if keepInventory is true, so we dont have to factor that possibility in.
events.onPlayerDeathDrops(function (e as crafttweaker.event.PlayerDeathDropsEvent) {
  var drops = [] as crafttweaker.entity.IEntityItem[];
  for item in e.items {
    // If its a Death List, spawn the item as an entity in-world. Otherwise, keep it in the droplist.
    if (item.item.definition.id == 'tombmanygraves:death_list') e.player.world.spawnEntity(item);
    else drops += item;
  }
  e.items = drops;
});
