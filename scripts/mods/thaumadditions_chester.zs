#modloaded 
#reloadable

// Prevent Thaumic Additions Chester dupe from portals
events.onEntityTravelToDimension(function (e as crafttweaker.event.EntityTravelToDimensionEvent) {
  if (
    e.entity.world.remote
    || isNull(e.entity.definition)
    || e.entity.definition.id != 'thaumadditions:chester'
  ) {
    return;
  }

  e.cancel();
});
