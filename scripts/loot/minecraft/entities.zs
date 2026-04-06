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
scripts.lib.loot.tweak('minecraft:entities/sheep', 'main', 'minecraft:mutton', null, [<minecraft:mutton>], [2,5], false, 1, true);

scripts.lib.loot.tweak('minecraft:entities/cow', 'pool1', 'minecraft:beef', null, [<minecraft:beef>], [5,12], false, 1, true);
scripts.lib.loot.tweak('minecraft:entities/cow', 'main', 'minecraft:leather', null, [<minecraft:leather>], [3,5]);

scripts.lib.loot.tweak('minecraft:entities/horse',  'main', 'minecraft:leather', null, [<minecraft:leather>], [7,12]);
scripts.lib.loot.tweak('minecraft:entities/donkey', 'main', 'minecraft:leather', null, [<minecraft:leather>], [7,12]);
scripts.lib.loot.tweak('minecraft:entities/mule',   'main', 'minecraft:leather', null, [<minecraft:leather>], [7,12]);
scripts.lib.loot.tweak('minecraft:entities/llama',  'main', 'minecraft:leather', null, [<minecraft:leather>], [7,12]);
