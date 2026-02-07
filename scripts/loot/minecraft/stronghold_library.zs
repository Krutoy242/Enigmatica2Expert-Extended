#modloaded loottweaker
#ignoreBracketErrors

import loottweaker.vanilla.loot.Functions;

val location = 'minecraft:chests/stronghold_library';

scripts.lib.loot.removePools(location,
  ['forestry_apiculture_bees',
    'floralchemy_inject_pool']
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
  <thaumadditions:wormhole_mirror>.withTag({'tc.charge': 250})    : [10, 0, 1, 1],
  <cyclicmagic:book_ender>                                        : [1,  1, 1, 1],
  <thermalfoundation:tome_experience>.withTag({Experience: 10000}): [10, 0, 1, 1],
  <rats:plague_doctorate>                                         : [3,  2, 1, 1],

  <botania:brewvial>.withTag({brewKey: "absorption"}): [5, 2, 1, 1],
  <botania:brewvial>.withTag({brewKey: "healing"})   : [5, 2, 1, 1],
});
loottweaker.LootTweaker.getTable(location).getPool('main').addItemEntry(<minecraft:book>, 50, 0, [Functions.enchantWithLevels(5, 50, true)], []);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.sigils);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.ancientTomes);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.thaumcraftSpells);
loottweaker.LootTweaker.getTable(location).getPool('main').setRolls(1, 2);

loottweaker.LootTweaker.getTable(location).addPool('pool1', 1.0f, 2.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool(location, 'pool1', {
  <minecraft:book>         : [40,  0, 2, 8],
  <minecraft:paper>        : [100, 0, 5, 13],
  <minecraft:writable_book>: [10, 10, 1, 3],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.badFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicConsumables);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.celestialNotes);

scripts.lib.loot.addSpecialTool(location, <tconevo:tool_sceptre>, ['livingwood', 'vibrant_crystal', 'fierymetal', 'emeraldic_crystal'], '§5Lavos staff');
