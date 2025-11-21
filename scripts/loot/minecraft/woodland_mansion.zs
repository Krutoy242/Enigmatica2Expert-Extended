#modloaded loottweaker
#ignoreBracketErrors

import loottweaker.LootTweaker;
import crafttweaker.item.IItemStack;
import loottweaker.vanilla.loot.Functions;
import crafttweaker.data.IData;

val location = 'minecraft:chests/woodland_mansion';

scripts.lib.loot.removePools(location,
 ['rats:contaminated_food',
 'pool2'] as string[]
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
 <rftools:storage_module:2>                               : [10,0,1,1],
 <minecraft:totem_of_undying>                             : [10,0,1,1],
});
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.sigils);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.ancientTomes);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.thaumcraftSpells);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.baubles);

scripts.lib.loot.clearPool(location, 'pool1');
scripts.lib.loot.addLootToPool(location, 'pool1', {
 <randomthings:ingredient:1>           : [5,0,1,3],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.badFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.goodFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicConsumables);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.techComponents);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.upgrades);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.tinkersModifiers);

scripts.lib.loot.addSpecialTool(location, <tconstruct:shortbow>.withTag({StatsOriginal: {AttackSpeedMultiplier: 1.0 as float, MiningSpeed: 6.0 as float, DrawSpeed: 2.65 as float, FreeModifiers: 3, ProjectileBonusDamage: 1.25 as float, Durability: 142, HarvestLevel: 3, Attack: 4.69 as float, Range: 2.1 as float}, display: {Name: "Old Bow"}, Stats: {AttackSpeedMultiplier: 1.0 as float, MiningSpeed: 6.0 as float, DrawSpeed: 2.65 as float, FreeModifiers: 3, ProjectileBonusDamage: 1.25 as float, Durability: 142, HarvestLevel: 3, Attack: 4.69 as float, Range: 2.1 as float}, Special: {Categories: ["launcher", "tool"]}, TinkerData: {Materials: ["bloodwood", "ghostwood", "enchanted_fabric"], Modifiers: ["toolleveling"]}, Modifiers: [{identifier: "tconevo.vampiric", color: -9036526, level: 1}, {identifier: "ecological", color: -9036526, level: 1}, {identifier: "tconevo.foot_fleet", color: -4079167, level: 1}, {identifier: "mirabile", color: -4079167, level: 1}, {identifier: "tconevo.modifiable", color: -10972203, level: 1, CanonicalTraitLevel: 1}, {identifier: "toolleveling", color: 16777215, level: 1}], Traits: ["tconevo.vampiric", "ecological", "tconevo.foot_fleet", "mirabile", "tconevo.modifiable1", "toolleveling", "tconevo.artifact"]}));
