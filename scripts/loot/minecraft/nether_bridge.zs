#modloaded loottweaker
#ignoreBracketErrors

import loottweaker.LootTweaker;
import crafttweaker.item.IItemStack;
import loottweaker.vanilla.loot.Functions;
import crafttweaker.data.IData;

val location = 'minecraft:chests/nether_bridge';

scripts.lib.loot.removePools(location,
 ['endreborn_inject_pool',
 'Ender IO',
 'xuLootDropOfEvil',
 'lavacharm']
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
 <randomthings:lavacharm>                          : [10,  0, 1, 1],
 <randomthings:obsidianskullring>                  : [10,  0, 1, 1],
 <cyclicmagic:book_ender>                          : [5,  0, 1, 1],
 <thaumadditions:meteor_belt>                      : [1,  0, 1, 1],
 <advgenerators:turbine_kit_manyullyn>             : [10,  0, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.tinkersModifiers);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.ancientTomes);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.baubles);
 
loottweaker.LootTweaker.getTable(location).addPool('pool1', 1.0f, 2.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool(location, 'pool1', {
 <harvestcraft:netherwingsitem>                    : [50,  0, 1, 3],
 <thaumicwonders:panacea>                          : [40,  0, 1, 1],
 <iceandfire:ambrosia>                             : [30,  0, 1, 1],
 <minecraft:blaze_rod>                             : [60,  0, 1, 2],
 <minecraft:skull:1>                               : [30,  0, 1, 1],
 <deepmoblearning:living_matter_hellish>           : [25,  0, 1, 3],
 <nuclearcraft:plutonium>                          : [3,  0, 1, 1],
 <thaumicwonders:panacea:1>                        : [5,  0, 1, 1],
 <extendedcrafting:material:140>                   : [20,  0, 1, 2],
 <nuclearcraft:americium>                          : [2,  0, 1, 1],
 <thaumcraft:causality_collapser>                  : [10,  0, 1, 1],
 <nuclearcraft:californium:5>                      : [1,  0, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.badFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicConsumables);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.thaumcraftSpells);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.upgrades);

scripts.lib.loot.addSpecialTool(location, <tconstruct:scythe>.withTag({StatsOriginal: {AttackSpeedMultiplier: 1.0 as float, MiningSpeed: 0.375 as float, FreeModifiers: 3, Durability: 866, HarvestLevel: 7, Attack: 8.99 as float}, display: {Lore: ["", "§6§oForged in flames, now cursed with blight,", "§6§oFaiasaisu spreads an endless fight.", "§6§oA plague of torment, death`s cruel hand,", "§6§oIts fires burn, while sickness takes the land."], Name: "§4Faiasaisu"}, Stats: {AttackSpeedMultiplier: 1.0 as float, MiningSpeed: 0.375 as float, FreeModifiers: 1, Durability: 866, HarvestLevel: 7, Attack: 8.99 as float}, Special: {Categories: ["aoe", "tool", "weapon", "harvest"], RepairCount: 1}, TinkerData: {UsedModifiers: 1, Materials: ["void_metal", "xu_demonic_metal", "plague_metal", "fierymetal"], Modifiers: ["toolleveling", "flame"]}, Modifiers: [{identifier: "tconevo.sundering", color: -10282897, level: 1}, {identifier: "tconevo.warping", color: -10282897, level: 1}, {identifier: "tconevo.ruination", color: -10282897, level: 1}, {identifier: "xu_whispering", color: -6079744, level: 1}, {identifier: "plague_shot", color: -11447216, level: 1}, {identifier: "disease", color: -11447216, level: 1}, {identifier: "twilit", color: -142243, level: 1}, {identifier: "flammable", color: -142243, level: 1}, {identifier: "toolleveling", color: 16777215, level: 1, bonus_modifiers: 0, xp: 83}, {identifier: "flame", current: 1, color: 11874311, max: 1, level: 1}], Traits: ["tconevo.sundering", "tconevo.warping", "tconevo.ruination", "xu_whispering", "plague_shot", "disease", "twilit", "flammable", "toolleveling", "flame", "tconevo.artifact"]}));
