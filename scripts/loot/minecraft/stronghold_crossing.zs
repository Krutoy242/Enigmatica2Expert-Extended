#modloaded loottweaker
#ignoreBracketErrors

import loottweaker.LootTweaker;
import crafttweaker.item.IItemStack;
import loottweaker.vanilla.loot.Functions;
import crafttweaker.data.IData;

val location = 'minecraft:chests/stronghold_crossing';

scripts.lib.loot.removePools(location,
 ['floralchemy_inject_pool',
 'forestry_apiculture_bees',
 'manuscript',
 'rats:contaminated_food',
 'token_fragment',
 'rat_upgrade_basic'] as string[]
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
 <enderio:item_dark_steel_sword>                               : [5,0,1,1],
 <cyclicmagic:charm_void>                          : [30,0,1,1],
 <cyclicmagic:sack_ender>                          : [20,0,1,1],
 <cyclicmagic:soulstone>                           : [5,0,1,1],
 <thaumicwonders:primordial_grain>                 : [10,0,1,3],
});
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.sigils);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.ancientTomes);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.baubles);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.psiSpells);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.thaumcraftSpells);

loottweaker.LootTweaker.getTable(location).addPool('pool1', 1.0f, 2.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool(location, 'pool1', {
 <advgenerators:turbine_kit_enderium>      : [1,0,1,1],
 <astralsorcery:itemperkgem>               : [1,0,1,1],
 <astralsorcery:itemperkgem:1>             : [1,0,1,1],
 <astralsorcery:itemperkgem:2>             : [1,0,1,1],
 <botania:manaresource:15>                 : [5,0,1,2],
 <cyclicmagic:soulstone>                   : [2,0,1,1],
 <deepmoblearning:pristine_matter_enderman>: [5,0,1,2],
 <enderio:item_material:16>                : [2,0,1,1],
 <enderio:item_material:56>                : [2,0,1,1],
 <enderio:item_material:58>                : [10,0,10,32],
 <extendedcrafting:material:40>            : [2,0,1,1],
 <extrautils2:suncrystal:250>              : [3,0,1,1],
 <minecraft:ender_eye>                     : [10,0,1,3],
 <randomthings:ingredient:1>               : [3,0,1,2],
 <tconstruct:materials:18>                 : [5,0,1,4],
 <thaumadditions:dawn_totem>               : [5,0,1,1],
 <thaumadditions:twilight_totem>           : [5,0,1,1],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicComponents);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicConsumables);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.techComponents);

scripts.lib.loot.addSpecialTool(location, <plustic:laser_gun>.withTag({LockCooldown: 0, StatsOriginal: {AttackSpeedMultiplier: 1.0 as float, LaserGunPower: 5.0 as float, MiningSpeed: 2.25 as float, FreeModifiers: 3, Durability: 53, HarvestLevel: 2, LaserGunEnergy: 10000000, Attack: 5.0 as float, LaserGunRange: 25.0 as float}, display: {Name: "The Pew Pew Gun"}, Stats: {AttackSpeedMultiplier: 1.1 as float, LaserGunPower: 5.0 as float, MiningSpeed: 2.25 as float, FreeModifiers: 2, Durability: 53, HarvestLevel: 2, LaserGunEnergy: 10000000, Attack: 5.0 as float, LaserGunRange: 25.0 as float}, Special: {Categories: ["weapon", "tool"]}, AttackDuration: 0, TinkerData: {Materials: ["tanzanite", "certus_quartz", "starmetal", "copper"], Modifiers: ["toolleveling"]}, Modifiers: [{identifier: "freezing", color: -43521, level: 1}, {identifier: "lightweight", color: -3743233, level: 1}, {identifier: "tconevo.crystalline", color: -3743233, level: 1}, {identifier: "im_a_superstar", color: -14529617, level: 1}, {identifier: "unnatural", color: -14529617, level: 1}, {identifier: "established", color: -1204473, level: 1}, {identifier: "toolleveling", color: 16777215, level: 1}], Traits: ["freezing", "lightweight", "tconevo.crystalline", "im_a_superstar", "unnatural", "established", "toolleveling", "tconevo.artifact"]}));
