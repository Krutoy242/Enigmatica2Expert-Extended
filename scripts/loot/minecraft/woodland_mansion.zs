#modloaded loottweaker
#ignoreBracketErrors

val location = 'minecraft:chests/woodland_mansion';

scripts.lib.loot.removePools(location,
  ['rats:contaminated_food',
    'Ender IO',
    'pool2']
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
  <rftools:storage_module:2>  : [10, 5, 1, 1],
  <minecraft:totem_of_undying>: [10, 5, 1, 1],

  <botania:brewvial>.withTag({brewKey: "waterBreathing"}): [5, 5, 1, 1],
  <botania:brewvial>.withTag({brewKey: "regenWeak"})     : [5, 5, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.sigils);
scripts.lib.loot.addAncientTomes(location, 'main', 52);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.thaumcraftSpells);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.baubles);
loottweaker.LootTweaker.getTable(location).getPool('main').setRolls(1, 2);

scripts.lib.loot.clearPool(location, 'pool1');
scripts.lib.loot.addLootToPool(location, 'pool1', {
  <advgenerators:turbine_kit_adv_alloy> : [5, 20, 1, 3],
  <randomthings:ingredient:1>           : [5, 5,  1, 3],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.badFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.goodFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicConsumables);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.techComponents);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.upgrades);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.tinkersModifiers);

scripts.lib.loot.addSpecialTool(location, <tconstruct:shortbow>, ['bloodwood', 'ghostwood', 'enchanted_fabric'], 'Old Bow');
scripts.lib.loot.addRandomCapacitor(location, 0.15f);
