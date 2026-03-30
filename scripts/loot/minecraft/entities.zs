#modloaded loottweaker

import loottweaker.vanilla.loot.Functions;
import loottweaker.vanilla.loot.Conditions;

// Add 100% Guardian Diode to Guardian
val guardTbl = loottweaker.LootTweaker.getTable('minecraft:entities/elder_guardian');
guardTbl.getPool('pool3').removeEntry('minecraft:gameplay/fishing/fish');
guardTbl.addPool('diode', 1, 1, 1, 1).addItemEntry(<enderio:item_material:56>, 1, 0, [Functions.lootingEnchantBonus(0, 1, 0)], [Conditions.killedByPlayer()]);

// Add drops to vanilla entities
scripts.lib.loot.tweak('minecraft:entities/endermite', 'main', null, null, [<appliedenergistics2:material:46>], [1, 3]);
scripts.lib.loot.tweak('minecraft:entities/endermite', 'main', null, null, [<contenttweaker:item_ore_tungsten> % 25], [1, 1], true);

val endermanPool = loottweaker.LootTweaker.getTable('minecraft:entities/enderman').getPool('main'); // Enderman (make enderpearls drop 100% of the time)
endermanPool.removeEntry('minecraft:ender_pearl'); // Remove main enderpearl entry
endermanPool.addItemEntry(<minecraft:ender_pearl>, 1, 0, [Functions.lootingEnchantBonus(0, 1, 0)], [Conditions.killedByPlayer()]);

// More Zombie Pigman gold drop
loottweaker.LootTweaker.getTable('minecraft:entities/zombie_pigman').getPool('main')
  .addItemEntry(<minecraft:gold_ingot>, 1, 0, [Functions.lootingEnchantBonus(0, 1, 0)], [Conditions.killedByPlayer()]);

// Vex
loottweaker.LootTweaker.getTable('minecraft:entities/vex').getPool('main')
  .addItemEntry(<deepmoblearning:living_matter_overworldian>, 1, 0, [Functions.lootingEnchantBonus(0, 1, 0), Functions.setCount(0, 1)], [Conditions.killedByPlayer()]);

// Animal drop changes
val poolSheepMeat = loottweaker.LootTweaker.getTable('minecraft:entities/sheep').getPool('main');
poolSheepMeat.removeEntry('minecraft:mutton');
poolSheepMeat.addItemEntry(<minecraft:mutton>, 1, 0, [
  Functions.setCount(2, 5),
  {
    "function": "minecraft:furnace_smelt",
    "conditions": [
      {
        "properties": { "minecraft:on_fire": true },
        "entity": "this",
        "condition": "minecraft:entity_properties"
      }
    ]
  },
  Functions.lootingEnchantBonus(0, 1, 0)
], []);

val poolCowMeat = loottweaker.LootTweaker.getTable('minecraft:entities/cow').getPool('pool1');
poolCowMeat.removeEntry('minecraft:beef');
poolCowMeat.addItemEntry(<minecraft:beef>, 1, 0, [
  Functions.setCount(5, 12), 
  {
    "function": "minecraft:furnace_smelt",
    "conditions": [
      {
        "properties": { "minecraft:on_fire": true },
        "entity": "this",
        "condition": "minecraft:entity_properties"
      }
    ]
  },
  Functions.lootingEnchantBonus(0, 1, 0)
], []);

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
