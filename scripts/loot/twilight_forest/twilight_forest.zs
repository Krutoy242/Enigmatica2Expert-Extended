#modloaded loottweaker twilightforest
#ignoreBracketErrors

// Add Little Blueprints to Aurora caches
scripts.lib.loot.addLootToPool('twilightforest:structures/aurora_cache/common', 'main', {
  <littletiles:recipeadvanced>: [1, 0, 2, 6],
});
scripts.lib.loot.addLootToPool('twilightforest:structures/aurora_room/common', 'main', {
  <littletiles:recipeadvanced>: [1, 0, 2, 6],
});

scripts.lib.loot.addLootToPool('twilightforest:structures/tree_cache/uncommon', 'main', {
  <randomthings:spectresapling>: [1, 0, 1, 2],
});
