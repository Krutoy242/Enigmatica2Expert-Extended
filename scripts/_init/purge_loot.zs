#priority 3000
#modloaded loottweaker

import loottweaker.LootTweaker as ltt;

for item in [
  'actuallyadditions:block_misc:4',
  'actuallyadditions:item_misc:5',

  'forestry:broken_bronze_shovel',
  'forestry:broken_bronze_pickaxe',
  'forestry:kit_pickaxe',
  'forestry:kit_shovel',

  'ic2:ingot',
  'ic2:filled_tin_can',

  'iceandfire:silver_nugget',
  'iceandfire:silver_ingot',
  'iceandfire:sapphire_gem',

  'immersiveengineering:pickaxe_steel',
  'immersiveengineering:shovel_steel',
  'immersiveengineering:axe_steel',
  'immersiveengineering:sword_steel',

  'minecraft:iron_pickaxe',
  'minecraft:iron_sword',
  'minecraft:milk_bucket',
  'minecraft:name_tag',
  'minecraft:obsidian',
  'minecraft:water_bucket',

  'minecraft:golden_helmet',
  'minecraft:golden_chestplate',
  'minecraft:golden_leggings',
  'minecraft:golden_boots',
  'minecraft:iron_helmet',
  'minecraft:iron_chestplate',
  'minecraft:iron_leggings',
  'minecraft:iron_boots',
  'minecraft:diamond_helmet',
  'minecraft:diamond_chestplate',
  'minecraft:diamond_leggings',
  'minecraft:diamond_boots',
  'minecraft:leather_helmet',
  'minecraft:leather_chestplate',
  'minecraft:leather_leggings',
  'minecraft:leather_boots',

  'twilightforest:uncrafting_table',
  'enderio:item_dark_steel_sword',
  'enderio:item_travel_staff',
  'enderio:item_material:9',
  'cyclicmagic:book_ender',

  'minecraft:golden_hoe',
  'minecraft:diamond_hoe',
  'minecraft:iron_hoe',
  'minecraft:stone_hoe',
  'minecraft:wooden_hoe',
  'minecraft:golden_axe',
  'minecraft:golden_pickaxe',
  'minecraft:golden_shovel',
  'minecraft:golden_sword',
  'minecraft:diamond_axe',
  'minecraft:diamond_pickaxe',
  'minecraft:diamond_shovel',
  'minecraft:diamond_sword',
  'minecraft:stone_axe',
  'minecraft:stone_pickaxe',
  'minecraft:stone_shovel',
  'minecraft:stone_sword',
  'minecraft:wooden_axe',
  'minecraft:wooden_pickaxe',
  'minecraft:wooden_shovel',
  'minecraft:wooden_sword',
  'minecraft:iron_sword',
  'minecraft:bow',
  'minecraft:iron_axe',
  'minecraft:iron_pickaxe',
  'minecraft:iron_shovel',
] as string[] {
  mods.ltt.LootTable.removeGlobalItem(item);
}

// Bunch of individual removals due to things being stubborn by MorganSimic
// remove IC2 Copper/Tin Ingots from all loot sources

val lootsource = [
  'simple_dungeon',
  'village_blacksmith',
  'abandoned_mineshaft',
  'desert_pyramid',
  'end_city_treasure',
  'igloo_chest',
  'jungle_temple',
  'nether_bridge',
  'stronghold_corridor',
  'stronghold_crossing',
  'stronghold_library',
] as string[];

for source in lootsource {
  val wordIC2 = 'ic2:chests/' + source;
  val poolIC2 = ltt.getTable(wordIC2).getPool('ic2');
  poolIC2.removeEntry('copper_ingot');
  poolIC2.removeEntry('tin_ingot');
}

// Village Blacksmith removal
val ic2smith = ltt.getTable('ic2:chests/village_blacksmith').getPool('ic2');
val EIOsmith = ltt.getTable('enderio:chests/village_blacksmith').getPool('Ender IO');

// IC2 bronze ingot
ic2smith.removeEntry('bronze_ingot');

// EIO wooden gear
EIOsmith.removeEntry('enderio:item_material:9');

// EIO stone gear
EIOsmith.removeEntry('enderio:item_material:10');

// EIO wooden gear
ltt.getTable('enderio:chests/simple_dungeon').getPool('Ender IO').removeEntry('enderio:item_material:9');

// EIO wooden gear
ltt.getTable('enderio:chests/abandoned_mineshaft').getPool('Ender IO').removeEntry('enderio:item_material:9');

// immersive engineering village metal removal
val MetalToRemove = [
  'copper_ingot',
  'aluminium_ingot',
  'lead_nugget',
  'silver_nugget',
  'nugget_nickel',
] as string[];

for thing in MetalToRemove {
  ltt.getTable('immersiveengineering:chests/engineers_house').getPool('immersiveengineering:engineers_village_house_0').removeEntry(thing);
}

// myrmex loot chest removal
val myrmexchest = ltt.getTable('iceandfire:myrmex_loot_chest').getPool('myrmex_loot_chest');

// silver ingot
myrmexchest.removeEntry('iceandfire:silver_ingot');

// silver nugget
myrmexchest.removeEntry('iceandfire:silver_nugget');

// sapphire
ltt.getTable('iceandfire:ice_dragon_male_cave').getPool('ice_dragon_cave').removeEntry('iceandfire:sapphire_gem');

// ice_dragon_female_cave
val dragoncave = ltt.getTable('iceandfire:ice_dragon_female_cave').getPool('ice_dragon_cave');

// silver
dragoncave.removeEntry('iceandfire:silver_ingot');
dragoncave.removeEntry('iceandfire:silver_nugget');

// sapphire
dragoncave.removeEntry('iceandfire:sapphire_gem');

// sapphire
ltt.getTable('iceandfire:mausoleum_chest').getPool('mausoleum_chest').removeEntry('iceandfire:sapphire_gem');
ltt.getTable('iceandfire:mausoleum_chest').getPool('mausoleum_chest').removeEntry('iceandfire:silver_ingot');

// woodland mansion removal

// EIO stone gear
ltt.getTable('enderio:chests/woodland_mansion').getPool('Ender IO').removeEntry('enderio:item_material:10');
