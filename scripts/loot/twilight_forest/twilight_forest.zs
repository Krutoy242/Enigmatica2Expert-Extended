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

scripts.lib.loot.tweak('twilightforest:entities/helmet_crab', 'fish', 'minecraft:fish', null, [<harvestcraft:crabrawitem>], [1, 3], false, 1, true);
scripts.lib.loot.tweak('twilightforest:entities/deer', 'meat', 'twilightforest:raw_venison', null, [<harvestcraft:venisonrawitem>], [1, 3], false, 1, true);

scripts.lib.loot.tweak('twilightforest:entities/ice_crystal', 'main', null, null, [<iceandfire:dragon_ice>], [1, 3]);
scripts.lib.loot.tweak('twilightforest:entities/pinch_beetle', 'main', null, null, [<thermalfoundation:material:2051>], [1, 3]);
scripts.lib.loot.tweak('twilightforest:entities/redcap_sapper', 'main', null, null, [<tconevo:material> % 50], [1, 2], true);
scripts.lib.loot.tweak('twilightforest:entities/redcap', 'main', null, null, [<tconevo:material> % 50], [1, 2], true);
scripts.lib.loot.tweak('twilightforest:entities/slime_beetle', 'main', null, null, [<tconstruct:materials:9>], [1, 3]);
scripts.lib.loot.tweak('twilightforest:entities/wraith', 'main', null, null, [<enderio:block_holier_fog>], [10, 40]);
scripts.lib.loot.tweak('twilightforest:entities/tower_broodling', 'main', null, null, [<plustic:osgloglasnugget> % 50], [1, 3], true);
scripts.lib.loot.tweak('twilightforest:entities/tower_golem', 'main', null, null, [<mekanism:enrichedalloy> % 50], [1, 2], true);
scripts.lib.loot.tweak('twilightforest:entities/harbinger_cube', 'main', null, null, [<appliedenergistics2:material:20>], [1, 3]);
scripts.lib.loot.tweak('twilightforest:entities/squirrel', 'main', null, null, [
  <harvestcraft:chestnutitem> % 30,
  <harvestcraft:hazelnutitem> % 30,
  <harvestcraft:nutmegitem> % 30,
  <harvestcraft:peanutitem> % 30,
  <harvestcraft:waterchestnutitem> % 30
], [1, 1]);
