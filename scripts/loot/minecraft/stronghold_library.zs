#modloaded loottweaker
#ignoreBracketErrors

import loottweaker.LootTweaker;
import crafttweaker.item.IItemStack;
import loottweaker.vanilla.loot.Functions;
import crafttweaker.data.IData;

val location = 'minecraft:chests/stronghold_library';

scripts.lib.loot.removePools(location,
 ['forestry_apiculture_bees',
 'floralchemy_inject_pool'] as string[]
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
 <thaumadditions:wormhole_mirror>.withTag({"tc.charge": 250})                       : [10,0,1,1],
 <cyclicmagic:book_ender>                                                           : [1,0,1,1],
 <thermalfoundation:tome_experience>.withTag({Experience: 10000})                   : [10,0,1,1],
 <rats:plague_doctorate>                                                            : [3,0,1,1],
});
loottweaker.LootTweaker.getTable(location).getPool("main").addItemEntry(<minecraft:book>, 50, 0, [Functions.enchantWithLevels(5, 50, true)],[]);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.sigils);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.ancientTomes);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.thaumcraftSpells);

loottweaker.LootTweaker.getTable(location).addPool('pool1', 1.0f, 2.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool(location, 'pool1', {
 <minecraft:book>                       : [40,0,2,8],
 <minecraft:paper>                      : [100,0,5,13],
 <minecraft:writable_book>              : [10,0,1,3],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.badFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicConsumables);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.celestialNotes);

scripts.lib.loot.addSpecialTool(location, <tconevo:tool_sceptre>.withTag({StatsOriginal: {AttackSpeedMultiplier: 1.0 as float, MiningSpeed: 2.7 as float, DrawSpeed: 1.0 as float, FreeModifiers: 3, ProjectileBonusDamage: 0.0 as float, Durability: 1248, HarvestLevel: 9, Attack: 7.975 as float, Range: 1.15 as float}, display: {Lore: ["", "§6§oSealed below where knowledge burns,","§6§oAmong lost pages the earth still turns.","§6§oA spark of power no vault can keep,","§6§oAwaits the brave who dig too deep.",], Name: "§5Lavos staff"}, Stats: {AttackSpeedMultiplier: 1.0 as float, MiningSpeed: 2.7 as float, DrawSpeed: 1.0 as float, FreeModifiers: 4, ProjectileBonusDamage: 0.0 as float, Durability: 1248, HarvestLevel: 9, Attack: 7.975 as float, Range: 1.15 as float}, Special: {Categories: ["launcher", "weapon", "tool"]}, TinkerData: {Materials: ["livingwood", "vibrant_crystal", "fierymetal", "emeraldic_crystal"], Modifiers: ["toolleveling"]}, Modifiers: [{identifier: "tconevo.modifiable", color: -8824277, level: 2, CanonicalTraitLevel: 2}, {identifier: "ecological", color: -8824277, level: 1}, {identifier: "tconevo.chain_lightning", color: -9845976, level: 1}, {identifier: "flammable", color: -142243, level: 1}, {identifier: "autosmelt", color: -142243, level: 1}, {identifier: "twilit", color: -142243, level: 1}, {identifier: "superheat", color: -142243, level: 1}, {identifier: "momentum", color: -16757248, level: 1}, {identifier: "tconevo.crystalline", color: -16757248, level: 1}, {identifier: "toolleveling", color: 16777215, level: 1}], Traits: ["tconevo.modifiable2", "ecological", "tconevo.chain_lightning", "flammable", "autosmelt", "twilit", "superheat", "momentum", "tconevo.crystalline", "toolleveling", "tconevo.artifact"]}));
