#modloaded emberroot

scripts.lib.loot.tweak('emberroot:entity/fairy_blue'     , 'main', null                    , null, [<astralsorcery:itemusabledust>]        , [1, 6], true);
scripts.lib.loot.tweak('emberroot:entity/fairy_green'    , 'main', null                    , null, [<astralsorcery:itemusabledust>]        , [1, 6], true);
scripts.lib.loot.tweak('emberroot:entity/fairy_orange'   , 'main', null                    , null, [<astralsorcery:itemusabledust>]        , [1, 6], true);
scripts.lib.loot.tweak('emberroot:entity/fairy_pink'     , 'main', null                    , null, [<astralsorcery:itemusabledust>]        , [1, 6], true);
scripts.lib.loot.tweak('emberroot:entity/fairy_purple'   , 'main', null                    , null, [<astralsorcery:itemusabledust>]        , [1, 6], true);
scripts.lib.loot.tweak('emberroot:entity/fairy_red'      , 'main', null                    , null, [<astralsorcery:itemusabledust>]        , [1, 6], true);
scripts.lib.loot.tweak('emberroot:entity/fairy_yellow'   , 'main', null                    , null, [<astralsorcery:itemusabledust>]        , [1, 6], true);
scripts.lib.loot.tweak('emberroot:entity/golem_blue'     , 'main', 'minecraft:iron_nugget' , null, [<extrautils2:unstableingots:1>]        , [2, 4]);
scripts.lib.loot.tweak('emberroot:entity/golem_green'    , 'main', 'minecraft:gunpowder'   , null, [<tconstruct:nuggets:5>]     , [2, 8]);
scripts.lib.loot.tweak('emberroot:entity/golem_orange'   , 'main', 'minecraft:coal'        , null, [<mekanism:nugget:3>]                   , [3, 14]);
scripts.lib.loot.tweak('emberroot:entity/golem_purple'   , 'main', 'minecraft:spider_eye'  , null, [<mechanics:heavy_nugget>]              , [5, 24]);
scripts.lib.loot.tweak('emberroot:entity/golem_red'      , 'main', 'minecraft:redstone'    , null, [<enderio:item_alloy_nugget:4>]         , [1, 4]);
scripts.lib.loot.tweak('emberroot:entity/golem_yellow'   , 'main', 'minecraft:gold_nugget' , null, [<thermalfoundation:material:228>]      , [8, 18]);
scripts.lib.loot.tweak('emberroot:entity/skeleton_frozen', 'main', 'minecraft:ice'         , null, [<mctsmelteryio:iceball> ?? <iceandfire:dragon_ice>]               , [1, 6]);
scripts.lib.loot.tweak('emberroot:entity/sprite_mini'    , 'main', 'minecraft:rotten_flesh', null, [<mysticalagriculture:nature_essence>]  , [1, 3]);
scripts.lib.loot.tweak('emberroot:entity/sprite_normal'  , 'main', 'minecraft:rotten_flesh', null, [<mysticalagriculture:dye_essence>]     , [2, 7]);
scripts.lib.loot.tweak('emberroot:entity/sprite_greater' , 'main', null                    , null, [<mysticalagriculture:platinum_essence>], [1, 3]);

<entity:emberroot:deers>.clearDrops();
scripts.lib.loot.tweak('emberroot:entity/hero', 'main', null, null, [
  <actuallyadditions:item_void_bag> % 10,
  <cyclicmagic:charm_void> % 10,
  <cyclicmagic:sack_ender> % 10,
  <cyclicmagic:storage_bag> % 10,
  <thermalexpansion:satchel:100> % 10
], [1, 1], true);
