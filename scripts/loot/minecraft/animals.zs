#modloaded loottweaker

import crafttweaker.item.IItemStack;
import loottweaker.vanilla.loot.Functions;
import loottweaker.vanilla.loot.Conditions;

val poolSheepMeat = loottweaker.LootTweaker.getTable('minecraft:entities/sheep').getPool('main');
poolSheepMeat.removeEntry('minecraft:mutton');
poolSheepMeat.addItemEntry(<minecraft:mutton>, 1, 0, [
    Functions.setCount(2, 5),
    Functions.parse({
        "function": "minecraft:furnace_smelt",
        "conditions": [
            {
                "properties": { "minecraft:on_fire": true },
                "entity": "this",
                "condition": "minecraft:entity_properties"
            }
        ]
    }),
    Functions.lootingEnchantBonus(0, 1, 0)
], []);

val poolCowMeat = loottweaker.LootTweaker.getTable('minecraft:entities/cow').getPool('pool1');
poolCowMeat.removeEntry('minecraft:beef');
poolCowMeat.addItemEntry(<minecraft:beef>, 1, 0, 
[Functions.setCount(5, 12), 
Functions.parse({
              "function": "minecraft:furnace_smelt",
              "conditions": [
                {
                  "properties": {
                    "minecraft:on_fire": true
                  },
                  "entity": "this",
                  "condition": "minecraft:entity_properties"
                }
              ]
            }),
Functions.lootingEnchantBonus(0, 1, 0)], []);

val poolCowLeather = loottweaker.LootTweaker.getTable('minecraft:entities/cow').getPool('main');
poolCowLeather.removeEntry('minecraft:leather');
poolCowLeather.addItemEntry(<minecraft:leather>, 1, 0, [
    Functions.setCount(3, 5),
    Functions.lootingEnchantBonus(0, 1, 0)
], []);

val poolHorseLeather = loottweaker.LootTweaker.getTable('minecraft:entities/horse').getPool('main');
poolHorseLeather.removeEntry('minecraft:leather');
poolHorseLeather.addItemEntry(<minecraft:leather>, 7, 12, [
    Functions.lootingEnchantBonus(0, 1, 0)
], []);

val poolDonkeyLeather = loottweaker.LootTweaker.getTable('minecraft:entities/donkey').getPool('main');
poolDonkeyLeather.removeEntry('minecraft:leather');
poolDonkeyLeather.addItemEntry(<minecraft:leather>, 7, 12, [
    Functions.lootingEnchantBonus(0, 1, 0)
], []);

val poolMuleLeather = loottweaker.LootTweaker.getTable('minecraft:entities/mule').getPool('main');
poolMuleLeather.removeEntry('minecraft:leather');
poolMuleLeather.addItemEntry(<minecraft:leather>, 7, 12, [
    Functions.lootingEnchantBonus(0, 1, 0)
], []);

val poolLlamaLeather = loottweaker.LootTweaker.getTable('minecraft:entities/llama').getPool('main');
poolLlamaLeather.removeEntry('minecraft:leather');
poolLlamaLeather.addItemEntry(<minecraft:leather>, 7, 12, [
    Functions.lootingEnchantBonus(0, 1, 0)
], []);
