#modloaded loottweaker iceandfire
#ignoreBracketErrors

import crafttweaker.item.IItemStack;

val caveloot as int[][IItemStack] = {
  <environmentaltech:litherite_crystal>       : [3, 0, 1, 1],
  <ic2:nuclear:7>                             : [3, 0, 1, 1],
  <minecraft:gold_block>                      : [3, 0, 1, 1],
  <thermalfoundation:material:70>             : [3, 0, 1, 1],
  <extendedcrafting:storage>                  : [3, 0, 1, 1],
  <nuclearcraft:uranium:8>                    : [3, 0, 1, 1],
  <nuclearcraft:neptunium>                    : [3, 0, 1, 1],
  <nuclearcraft:plutonium>                    : [3, 0, 1, 1],
  <nuclearcraft:californium:2> * 3            : [3, 0, 1, 1],
  <nuclearcraft:californium:18> * 3           : [3, 0, 1, 1],
  <nuclearcraft:californium:19> * 3           : [3, 0, 1, 1],
  <nuclearcraft:curium>                       : [3, 0, 1, 1],
  <actuallyadditions:block_crystal>           : [3, 0, 1, 1],
  <actuallyadditions:block_crystal:1>         : [3, 0, 1, 1],
  <actuallyadditions:block_crystal:2>         : [3, 0, 1, 1],
  <actuallyadditions:block_crystal:3>         : [3, 0, 1, 1],
  <actuallyadditions:block_crystal:4>         : [3, 0, 1, 1],
  <actuallyadditions:item_crystal_empowered>  : [3, 0, 1, 1],
  <actuallyadditions:item_crystal_empowered:1>: [3, 0, 1, 1],
  <actuallyadditions:item_crystal_empowered:2>: [3, 0, 1, 1],
  <actuallyadditions:item_crystal_empowered:3>: [3, 0, 1, 1],
  <actuallyadditions:item_crystal_empowered:4>: [3, 0, 1, 1],
  <actuallyadditions:item_crystal_empowered:5>: [3, 0, 1, 1],
  <botania:manaring>.withTag({ mana: 5000 })  : [3, 0, 1, 1],
  <botania:auraring>                          : [3, 0, 1, 1],
  <botania:magnetring>                        : [3, 0, 1, 1],
  <mysticalagriculture:prudentium_apple>      : [3, 0, 1, 1],
  <mysticalagriculture:intermedium_apple>     : [3, 0, 1, 1],
  <mysticalagriculture:superium_apple>        : [3, 0, 1, 1],
  <biomesoplenty:gem:6>                       : [3, 0, 1, 1],
  <thermalfoundation:storage_alloy>           : [3, 0, 1, 1],
};

scripts.lib.loot.addLootToPool('iceandfire:fire_dragon_female_cave', 'fire_dragon_cave', caveloot);
scripts.lib.loot.addLootToPool('iceandfire:fire_dragon_male_cave', 'fire_dragon_cave', caveloot);
scripts.lib.loot.addLootToPool('iceandfire:ice_dragon_female_cave', 'ice_dragon_cave', caveloot);
scripts.lib.loot.addLootToPool('iceandfire:ice_dragon_male_cave', 'ice_dragon_cave', caveloot);

scripts.lib.loot.addLootToPool('iceandfire:myrmex_trash_chest', 'myrmex_trash_chest', {
  <harvestcraft:aridgarden>                                    : [20, 0, 1, 1],
  <harvestcraft:frostgarden>                                   : [20, 0, 1, 1],
  <harvestcraft:shadedgarden>                                  : [20, 0, 1, 1],
  <harvestcraft:soggygarden>                                   : [20, 0, 1, 1],
  <harvestcraft:tropicalgarden>                                : [20, 0, 1, 1],
  <harvestcraft:windygarden>                                   : [20, 0, 1, 1],
  <randomthings:spectresapling>                                : [3, 0, 1, 1],
  <scalinghealth:heartdust>                                    : [10, 0, 1, 1],
  <thermalfoundation:material:800>                             : [40, 0, 1, 1],
  <appliedenergistics2:material:46>                            : [5, 0, 1, 1],
  <enderio:block_infinity_fog>                                 : [15, 0, 1, 1],
  <tconstruct:materials:18>                                    : [30, 0, 1, 1],
  <thermalexpansion:florb>.withTag({ Fluid: 'blockfluiddirt' }): [5, 0, 1, 1],
  <mysticalagriculture:crafting>                               : [50, 0, 1, 1],
  <mysticalagriculture:nature_seeds>                           : [1, 0, 1, 1],
  <mysticalagriculture:wood_seeds>                             : [1, 0, 1, 1],
  <mysticalagriculture:water_seeds>                            : [1, 0, 1, 1],
  <mysticalagriculture:ice_seeds>                              : [1, 0, 1, 1],
  <mysticalagriculture:zombie_seeds>                           : [1, 0, 1, 1],
  <mysticalagriculture:stone_seeds>                            : [1, 0, 1, 1],
  <mysticalagriculture:dirt_seeds>                             : [1, 0, 1, 1],
  <exnihilocreatio:item_material:3>                            : [40, 0, 1, 1],
  <extrautils2:enderlilly>                                     : [5, 0, 1, 1],
});

scripts.lib.loot.addLootToPool('iceandfire:myrmex_loot_chest', 'myrmex_loot_chest', {
  <thermalfoundation:material:198>       : [5, 0, 1, 1],
  <thermalfoundation:material:194>       : [40, 0, 1, 1],
  <mekanism:nugget:1>                    : [50, 0, 1, 1],
  <plustic:osmiridiumnugget>             : [2, 0, 1, 1],
  <minecraft:skull:4>                    : [30, 0, 1, 1],
  <minecraft:skull>                      : [20, 0, 1, 1],
  <betteranimalsplus:golden_goose_egg>   : [5, 0, 1, 1],
  <betteranimalsplus:antler>             : [15, 0, 1, 1],
  <betteranimalsplus:blubber>            : [20, 0, 1, 1],
  <randomthings:lotusseeds>              : [5, 0, 1, 1],
  <randomthings:spectreanchor>           : [1, 0, 1, 1],
  <enderio:block_enderman_skull:2>       : [10, 0, 1, 1],
  <ic2:nuclear:5>                        : [10, 0, 1, 1],
  <hole_filler_mod:throwable_hole_filler>: [70, 0, 1, 1],
  <cyclicmagic:corrupted_chorus>         : [5, 0, 1, 1],
  <cyclicmagic:glowing_chorus>           : [5, 0, 1, 1],
});

scripts.lib.loot.addLootToPool('iceandfire:myrmex_desert_food_chest', 'myrmex_desert_food_chest', {
  <iceandfire:fire_dragon_flesh>                    : [20, 0, 1, 1],
  <iceandfire:dragon_meal>                          : [20, 0, 1, 1],
  <betteranimalsplus:turkey_raw>                    : [20, 0, 1, 1],
  <betteranimalsplus:pheasantraw>                   : [20, 0, 1, 1],
  <additionalcompression:cropwheat_compressed:1>    : [6, 0, 1, 1],
  <additionalcompression:croppotato_compressed>     : [6, 0, 1, 1],
  <additionalcompression:cropcarrot_compressed>     : [6, 0, 1, 1],
  <additionalcompression:cropmelon_compressed:1>    : [6, 0, 1, 1],
  <additionalcompression:cropapple_compressed>      : [6, 0, 1, 1],
  <additionalcompression:cropsugarcane_compressed:1>: [6, 0, 1, 1],
});

scripts.lib.loot.addLootToPool('iceandfire:myrmex_jungle_food_chest', 'myrmex_jungle_food_chest', {
  <iceandfire:ice_dragon_flesh>                  : [20, 0, 1, 1],
  <iceandfire:dragon_meal>                       : [20, 0, 1, 1],
  <betteranimalsplus:turkey_raw>                 : [20, 0, 1, 1],
  <betteranimalsplus:pheasantraw>                : [20, 0, 1, 1],
  <additionalcompression:meatporkchop_compressed>: [2, 0, 1, 1],
  <additionalcompression:meatbeef_compressed>    : [2, 0, 1, 1],
  <additionalcompression:meatchicken_compressed> : [2, 0, 1, 1],
  <additionalcompression:meatfish_compressed>    : [2, 0, 1, 1],
  <additionalcompression:meatrotten_compressed>  : [2, 0, 1, 1],
  <additionalcompression:spidereye_compressed>   : [2, 0, 1, 1],
  <additionalcompression:egg_compressed>         : [2, 0, 1, 1],
});

scripts.lib.loot.addLootToPool('iceandfire:cyclops_cave', 'cyclops_cave', {
  <enderio:item_material:2>        : [70, 0, 1, 4],
  <enderio:item_material:35>       : [30, 0, 1, 4],
  <enderio:item_material:68>       : [10, 0, 1, 4],
  <qmd:semiconductor:1>            : [8, 0, 1, 4],
  <rftools:storage_module:1>       : [6, 0, 1, 4],
  <rftools:storage_module:2>       : [2, 0, 1, 4],
  FluidCell('nutrient_distillation'): [20, 0, 1, 4],
  FluidCell('ender_distillation')   : [10, 0, 1, 4],
});

scripts.lib.loot.addLootToPool('iceandfire:cyclops_cave', 'cyclops_cave', {
  <enderio:item_inventory_charger_basic>.withTag({ 'enderio.darksteel.upgrade.energyUpgrade': { level: 0, energy: 1000000 } })    : [20, 0, 1, 1],
  <enderio:item_inventory_charger>.withTag({ 'enderio.darksteel.upgrade.energyUpgrade': { level: 1, energy: 7500000 } })          : [6, 0, 1, 1],
  <enderio:item_inventory_charger_vibrant>.withTag({ 'enderio.darksteel.upgrade.energyUpgrade': { level: 3, energy: 125000000 } }): [2, 0, 1, 1],
});

scripts.lib.loot.addLootToPool('iceandfire:hydra_cave', 'hydra_cave', {
  FluidCell('liquid_sunshine')        : [1, 0, 1, 10],
  <contenttweaker:empowered_phosphor>: [10, 0, 1, 10],
  <thermalfoundation:material:229>   : [50, 0, 1, 10],
  <ic2:dust:28>                      : [22, 0, 1, 10],
  <ic2:dust:2>                       : [20, 0, 1, 10],
  <ic2:dust:16>                      : [18, 0, 1, 10],
  <ic2:dust:19>                      : [16, 0, 1, 10],
  <ic2:dust:20>                      : [14, 0, 1, 10],
  <ic2:dust:21>                      : [12, 0, 1, 10],
  <ic2:dust:23>                      : [10, 0, 1, 10],
  <ic2:dust:26>                      : [8, 0, 1, 10],
  <ic2:dust:31>                      : [2, 0, 1, 10],
});

scripts.lib.loot.addLootToPool('iceandfire:mausoleum_chest', 'mausoleum_chest', {
  <conarm:resist_mat> * 4       : [3, 0, 1, 1],
  <conarm:resist_mat_fire> * 10 : [3, 0, 1, 1],
  <conarm:resist_mat_proj> * 10 : [3, 0, 1, 1],
  <conarm:resist_mat_blast> * 10: [3, 0, 1, 1],
  <botania:autocraftinghalo>    : [2, 0, 1, 1],
  <forestry:carton> * 4         : [60, 0, 1, 1],
  <danknull:dank_null_panel_2>  : [20, 0, 1, 1],
  <danknull:dank_null_panel_3>  : [10, 0, 1, 1],
  <danknull:dank_null_panel_4>  : [3, 0, 1, 1],
});
