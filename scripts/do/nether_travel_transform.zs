/*

Spawn entities when entity item travel into Nether

*/

#modloaded requious

// List of recipes
val netherPortalEntityConversion = {
  'forestry:butterfly_ge': <entity:biomesoplenty:wasp>,
} as crafttweaker.entity.IEntityDefinition[string];

// Add JEI entries
for entityItem, entityDef in netherPortalEntityConversion {
  scripts.jei.crafting_hints.addInsOutCatl([<forestry:butterfly_ge:*>], Soul(entityDef.id), <minecraft:obsidian>);
}

// Copy entity IDs to this list
val nehterTravelBlacklist = {
  'biomesoplenty:wasp': true,
} as bool[string];

events.onEntityTravelToDimension(function (e as crafttweaker.event.EntityTravelToDimensionEvent) {
  val world = e.entity.world;
  if (e.entity.world.isRemote()) return;
  if (e.dimension != -1 as int) return;

  // Wasps cant travel to Nether
  if (!isNull(e.entity.definition) && !isNull(nehterTravelBlacklist[e.entity.definition.id])) return e.cancel();

  // Determine item entity
  if (!(e.entity instanceof crafttweaker.entity.IEntityItem)) return;
  val entityItem as crafttweaker.entity.IEntityItem = e.entity;
  if (isNull(entityItem.item)) return;

  // Find spawn entity definition
  val entityDef = netherPortalEntityConversion[entityItem.item.definition.id];
  if (isNull(entityDef)) return;

  // Spawn entities
  for i in 0 .. entityItem.item.amount {
    entityDef.spawnEntity(world, e.entity.position);
  }

  // Remove Item Entity
  e.cancel();
  world.removeEntity(e.entity);
});
