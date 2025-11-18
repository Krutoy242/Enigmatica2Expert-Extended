#modloaded loottweaker

import loottweaker.LootTweaker;
import crafttweaker.item.IItemStack;
import loottweaker.vanilla.loot.Functions;
import crafttweaker.data.IData;

val location = 'minecraft:chests/igloo_chest';

scripts.lib.loot.removePools(location,
 ['Ender IO',
 'rats:contaminated_food',
 'pool1'] as string[]
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
 <astralsorcery:itemconstellationpaper>                        : [20,  0, 1, 1],
 <biomesoplenty:log_4:5>                                       : [30,  0, 4, 10],
 <botania:icependant>                                          : [2,   0, 1, 1],
 <iceandfire:dread_torch>                                      : [50,  0, 2, 7],
 <iceandfire:manuscript>                                       : [20,  0, 1, 3],
 <iceandfire:troll_leather_frost>                              : [15,  0, 1, 2],
 <thaumcraft:baubles:3>                                        : [5,   0, 1, 1],
 <twilightforest:arctic_boots>                                 : [5,   0, 1, 1],
 <twilightforest:arctic_chestplate>                            : [5,   0, 1, 1],
 <twilightforest:arctic_helmet>                                : [5,   0, 1, 1],
 <twilightforest:arctic_leggings>                              : [5,   0, 1, 1],
 <twilightforest:ice_bomb>                                     : [20,  0, 1, 3],    
});

loottweaker.LootTweaker.getTable(location).addPool('pool1', 1.0f, 2.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool(location, 'pool1', {
 <harvestcraft:caramelicecreamitem>                            : [25,  0, 1, 2],
 <harvestcraft:cherryicecreamitem>                             : [25,  0, 1, 2],
 <harvestcraft:mintchocolatechipicecreamitem>                  : [25,  0, 1, 2],
 <harvestcraft:mochaicecreamitem>                              : [25,  0, 1, 2],
 <harvestcraft:neapolitanicecreamitem>                         : [25,  0, 1, 2],
 <harvestcraft:pistachioicecreamitem>                          : [25,  0, 1, 2],
 <harvestcraft:spumoniicecreamitem>                            : [25,  0, 1, 2],
 <harvestcraft:strawberryicecreamitem>                         : [25,  0, 1, 2],
 <harvestcraft:vanillaicecreamitem>                            : [25,  0, 1, 2],
 <mctsmelteryio:iceball>                                       : [30,  0, 1, 2],
 <minecraft:deadbush>                                          : [30,  0, 1, 3],
 <minecraft:rabbit_stew>                                       : [25,  0, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.badFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.goodFood);
 
scripts.lib.loot.addSpecialTool(location, <tconstruct:frypan>.withTag({StatsOriginal: {AttackSpeedMultiplier: 1.0 as float, MiningSpeed: 4.5 as float, FreeModifiers: 3, Durability: 607, HarvestLevel: 2, Attack: 4.125 as float}, display: {Name: "Hot pan"}, Stats: {AttackSpeedMultiplier: 1.0 as float, MiningSpeed: 4.5 as float, FreeModifiers: 2, Durability: 607, HarvestLevel: 2, Attack: 4.125 as float}, Special: {Categories: ["tool", "weapon"]}, TinkerData: {Materials: ["treatedwood", "firewood"], Modifiers: ["toolleveling"]}, Modifiers: [{identifier: "ecological", color: -10144478, level: 1}, {identifier: "autosmelt", color: -3386624, level: 1}, {identifier: "toolleveling", color: 16777215, level: 1}], Traits: ["ecological", "autosmelt", "toolleveling", "tconevo.artifact"]}));
