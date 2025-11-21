#modloaded loottweaker
#ignoreBracketErrors

import loottweaker.LootTweaker;
import crafttweaker.item.IItemStack;
import loottweaker.vanilla.loot.Functions;
import crafttweaker.data.IData;

val location = 'minecraft:chests/end_city_treasure';

scripts.lib.loot.removePools(location,
 ['floralchemy_inject_pool',
 'spectrecoil_number',
 'forestry_arboriculture_items'] as string[]
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
 <extrautils2:itembuilderswand>                          : [30,  0, 1, 1],
 <randomthings:weatheregg:2>                             : [10, 0, 1, 1],
 <randomthings:weatheregg:1>                             : [10, 0, 1, 1],
 <randomthings:weatheregg>                               : [10, 0, 1, 1],
 <mysticalagradditions:stuff:3>                          : [20, 0, 2, 5],
 <botania:brewvial>.withTag({brewKey: "absorption"})     : [10, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "nightVision"})    : [10, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "invisibility"})   : [10, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "resistance"})     : [10, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "regen"})          : [10, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "jumpBoost"})      : [10, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "healing"})        : [10, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "haste"})          : [10, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "speed"})          : [10, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "strength"})       : [10, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "warpWard"})       : [10, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "allure"})         : [10, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "bloodthirst"})    : [10, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "emptiness"})      : [5, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "featherFeet"})    : [5, 0, 1, 1],
 <botania:brewvial>.withTag({brewKey: "overload"})       : [5, 0, 1, 1],
 <advgenerators:turbine_kit_enderium>                    : [20, 0, 1, 1],

 <enderio:item_soul_vial:1>.withTag({entityId: 'minecraft:shulker'}) : [16, 0, 1, 1],
 <enderio:item_soul_vial:1>.withTag({entityId: 'quark:stoneling'}) : [1, 0, 1, 1],
 <enderio:item_soul_vial:1>.withTag({entityId: 'betteranimalsplus:tarantula'}) : [1, 0, 1, 1],
 <enderio:item_soul_vial:1>.withTag({entityId: 'quark:archaeologist'}) : [1, 0, 1, 1],
 <enderio:item_soul_vial:1>.withTag({entityId: 'thaumcraft:eldritchcrab'}) : [1, 0, 1, 1],

 <mekanism:energycube>.withTag({tier: 0, mekData: {energyStored: 3.0E7}}) : [1, 0, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.thaumcraftSpells);

loottweaker.LootTweaker.getTable(location).addPool('pool1', 1.0f, 2.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool(location, 'pool1', {
 <cyclicmagic:corrupted_chorus>                          : [10, 0, 1, 1],
 <thaumcraft:bottle_taint>                               : [10, 0, 1, 2],
 <minecraft:end_crystal>                                 : [1, 0, 1, 1],
 <endreborn:dragon_scales>                               : [30, 0, 2, 5],
 <endreborn:item_end_essence>                            : [10, 0, 1, 1],
 <randomthings:ingredient:2>                             : [10, 0, 4, 9],
 <extendedcrafting:material:40>                          : [10, 0, 1, 1],
 <ic2:misc_resource:1>                                   : [10, 0, 2, 3],
 <minecraft:dragon_breath>                               : [5, 0, 1, 1],
 <iceandfire:fire_dragon_blood>                          : [3, 0, 1, 1],
 <iceandfire:ice_dragon_blood>                           : [3, 0, 1, 1],
 <quark:diamond_heart>                                   : [3, 0, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.goodFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicConsumables);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.psiSpells);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.thaumcraftSpells);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.upgrades);

scripts.lib.loot.addSpecialTool(location, <tconstruct:shuriken>.withTag({StatsOriginal: {AttackSpeedMultiplier: 1.0 as float, Accuracy: 1.0 as float, MiningSpeed: 8.685625 as float, FreeModifiers: 3, Durability: 1171, HarvestLevel: 13, Attack: 9.293125 as float}, EnergizedEnergy: 0, display: {Lore: ["", "§6§oForged in silence where shadows bled,", "§6§oEach shard a whisper the End once said.", "§6§oBorn of storms beyond the veil,", "§6§oIt strikes — and none live to tell the tale."], Name: "§5Whispershard"}, Stats: {AttackSpeedMultiplier: 1.0 as float, Accuracy: 1.0 as float, MiningSpeed: 8.762625 as float, FreeModifiers: 0, Durability: 1184, HarvestLevel: 13, Attack: 9.348126 as float}, Special: {Categories: ["no_melee", "tool", "projectile"], alienStatBonus: {identifier: "", color: 0, attack: 0.034999996 as float, durability: 8, speed: 0.049 as float}, alienStatPool: {identifier: "", color: 16777215, attack: 1.324999 as float, durability: 260, speed: 1.924998 as float}}, PhotovoltaicRate: 724, Modifiers: [{identifier: "endspeed", color: -15835295, level: 1}, {identifier: "enderference", color: -15835295, level: 1}, {identifier: "tconevo.mortal_wounds", color: -15835295, level: 1}, {identifier: "tconevo.energized", color: -15567754, level: 2, CanonicalTraitLevel: 2}, {identifier: "tconevo.juggernaut", color: -15567754, level: 1}, {identifier: "alien", color: -2041712, level: 1}, {identifier: "unnatural", color: -262989, level: 1}, {identifier: "toolleveling", color: 16777215, level: 1}, {identifier: "soulbound", color: 16120748}, {identifier: "tconevo.photovoltaic", color: 3894951, level: 1, modifierUsed: 1 as byte}, {identifier: "shulking", current: 50, color: 11193599, max: 50, level: 1, extraInfo: "49 / 50"}], TinkerData: {UsedModifiers: 2, Materials: ["enderium", "gelid_enderium", "endstone", "end_steel"], Modifiers: ["toolleveling", "soulbound", "tconevo.photovoltaic", "shulking"]}, Traits: ["endspeed", "enderference", "tconevo.mortal_wounds", "tconevo.energized2", "tconevo.juggernaut", "alien", "unnatural", "toolleveling", "tconevo.photovoltaic", "shulking", "tconevo.artifact"]}));
