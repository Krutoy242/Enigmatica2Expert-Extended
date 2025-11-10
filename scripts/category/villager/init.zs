#norun // WIP for roidtweaker migration

#loader preinit
#modloaded roidtweaker

import mods.roidtweaker.minecraft.villager.Villager;

// Adds "necromancer" career to the Priest profession.
Villager.addCareer('minecraft:priest', 'necromancer');

// Adds a new "Stock Trader" villager.
Villager.addProfession(
  'crafttweaker:stock_trader',
  'vtt:textures/entity/villager/stock_trader.png',
  'vtt:textures/entity/zombie_villager/zombie_stock_trader.png'
);
Villager.addCareer('crafttweaker:stock_trader', 'stock_trader');
