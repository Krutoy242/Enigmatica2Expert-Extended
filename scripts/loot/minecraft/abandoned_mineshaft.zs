#modloaded loottweaker
#ignoreBracketErrors

import crafttweaker.data.IData;

val location = 'minecraft:chests/abandoned_mineshaft';

scripts.lib.loot.removePools(location,
  ['endreborn_inject_pool',
    'openmods_inject_pool',
    'forestry_factory_items',
    'forestry_storage_items',
    'manuscript',
    'Ender IO',
    'spectrecoil_number',
    'rats:contaminated_food',
    'token_fragment',
    'rat_upgrade_basic',
    'AE2 Crystals',
    'AE2 DUSTS',
    'botania_inject_pool',
    'pool2']
);

scripts.lib.loot.removeEtriesFromPool(location, 'main', [
  'actuallyadditions:drillCore',
]);
scripts.lib.loot.removeEtriesFromPool('enderio:chests/abandoned_mineshaft', 'Ender IO', [
  'enderio:item_alloy_ingot:6',
  'enderio:block_exit_rail:0',
]);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
  <minecraft:tnt>                                             : [100, 0, 1, 12],
  <cyclicmagic:ender_tnt_6>                                   : [80, 0, 1, 36],
  <cyclicmagic:ender_tnt_3>                                   : [80, 0, 1, 11],
  <tconstruct:materials:14>                                   : [20, 0, 1, 2],
  <tconstruct:pick_head>.withTag({Material: 'invar'})         : [10, 0, 1, 1],
  <tconstruct:pick_head>.withTag({Material: 'iron'})          : [10, 0, 1, 1],
  <tconstruct:pick_head>.withTag({Material: 'black_quartz'})  : [10, 0, 1, 1],
  <tconstruct:binding>.withTag({Material: 'pink_slime'})      : [10, 0, 1, 1],
  <tconstruct:tool_rod>.withTag({Material: 'bone'})           : [10, 0, 1, 1],
  <tconstruct:tough_tool_rod>.withTag({Material: 'bone'})     : [10, 0, 1, 1],
  <tconstruct:hammer_head>.withTag({Material: 'lead'})        : [10, 0, 1, 1],
  <tconstruct:large_plate>.withTag({Material: 'black_quartz'}): [10, 0, 1, 1],
  <tconstruct:large_plate>.withTag({Material: 'fluix'})       : [10, 0, 1, 1],
  <tconstruct:pick_head>.withTag({Material: 'ruby'})          : [3, 0, 1, 1],
  <tconstruct:binding>.withTag({Material: 'cobalt'})          : [3, 0, 1, 1],
  <tconstruct:tool_rod>.withTag({Material: 'pigiron'})        : [3, 0, 1, 1],
  <tconstruct:hammer_head>.withTag({Material: 'boron'})       : [3, 0, 1, 1],
  <tconstruct:large_plate>.withTag({Material: 'obsidian'})    : [3, 0, 1, 1],
  <tconstruct:materials:16>                                   : [1, 0, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.tinkersModifiers);
loottweaker.LootTweaker.getTable(location).getPool('main').setRolls(1, 2);

scripts.lib.loot.clearPool(location, 'pool1');
scripts.lib.loot.addLootToPool(location, 'pool1', {
  <harvestcraft:applejellysandwichitem>        : [10, 0, 3, 7],
  <harvestcraft:apricotjellysandwichitem>      : [10, 0, 3, 7],
  <harvestcraft:blackberryjellysandwichitem>   : [10, 0, 3, 7],
  <harvestcraft:blueberryjellysandwichitem>    : [10, 0, 3, 7],
  <harvestcraft:bolognasandwichitem>           : [10, 0, 3, 7],
  <harvestcraft:cherryjellysandwichitem>       : [10, 0, 3, 7],
  <harvestcraft:cranberryjellysandwichitem>    : [10, 0, 3, 7],
  <harvestcraft:figjellysandwichitem>          : [10, 0, 3, 7],
  <harvestcraft:friedbolognasandwichitem>      : [10, 0, 3, 7],
  <harvestcraft:gooseberryjellysandwichitem>   : [10, 0, 3, 7],
  <harvestcraft:grapefruitjellysandwichitem>   : [10, 0, 3, 7],
  <harvestcraft:groiledcheesesandwichitem>     : [10, 0, 3, 7],
  <harvestcraft:hamandcheesesandwichitem>      : [10, 0, 3, 7],
  <harvestcraft:hamsweetpicklesandwichitem>    : [10, 0, 3, 7],
  <harvestcraft:honeysandwichitem>             : [10, 0, 3, 7],
  <harvestcraft:kiwijellysandwichitem>         : [10, 0, 3, 7],
  <harvestcraft:lemonjellysandwichitem>        : [10, 0, 3, 7],
  <harvestcraft:limejellysandwichitem>         : [10, 0, 3, 7],
  <harvestcraft:mangojellysandwichitem>        : [10, 0, 3, 7],
  <harvestcraft:orangejellysandwichitem>       : [10, 0, 3, 7],
  <harvestcraft:papayajellysandwichitem>       : [10, 0, 3, 7],
  <harvestcraft:peachjellysandwichitem>        : [10, 0, 3, 7],
  <harvestcraft:peanutbutterbananasandwichitem>: [10, 0, 3, 7],
  <harvestcraft:pearjellysandwichitem>         : [10, 0, 3, 7],
  <harvestcraft:persimmonjellysandwichitem>    : [10, 0, 3, 7],
  <harvestcraft:plumjellysandwichitem>         : [10, 0, 3, 7],
  <harvestcraft:pomegranatejellysandwichitem>  : [10, 0, 3, 7],
  <harvestcraft:raspberryjellysandwichitem>    : [10, 0, 3, 7],
  <harvestcraft:starfruitjellysandwichitem>    : [10, 0, 3, 7],
  <harvestcraft:strawberryjellysandwichitem>   : [10, 0, 3, 7],
  <harvestcraft:toastsandwichitem>             : [10, 0, 3, 7],
  <harvestcraft:tunafishsandwichitem>          : [10, 0, 3, 7],
  <harvestcraft:watermelonjellysandwichitem>   : [10, 0, 3, 7],

  <advgenerators:turbine_kit_bronze>: [2,0,1,3],
  <cookingforblockheads:cow_jar>    : [10, 0, 1, 1],
  <tconstruct:moms_spaghetti>       : [5, 0, 1, 2],
  <harvestcraft:minerstewitem>      : [3, 0, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.badFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.goodFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicConsumables);

val common as IData[] = [
 {tab: [2, 10], item: <ic2:crushed>},
 {tab: [2, 10], item: <ic2:crushed:2>},
 {tab: [2, 10], item: <ic2:crushed:5>},
 {tab: [2, 10], item: <jaopca:item_crushedaluminium>},
 {tab: [1, 3], item: <jaopca:item_clusteraluminium>},
 {tab: [1, 3], item: <jaopca:item_clusterapatite>},
 {tab: [1, 3], item: <jaopca:item_clustercoal>},
 {tab: [1, 3], item: <jaopca:item_clusterlapis>},
 {tab: [1, 3], item: <jaopca:item_clusterredstone>},
 {tab: [1, 3], item: <thaumcraft:cluster>},
 {tab: [1, 3], item: <thaumcraft:cluster:2>},
 {tab: [1, 3], item: <thaumcraft:cluster:3>},
];

val uncommon as IData[] = [
 {tab: [2, 8], item: <ic2:crushed:1>},
 {tab: [2, 8], item: <ic2:crushed:3>},
 {tab: [1, 3], item: <jaopca:item_clustercertusquartz>},
 {tab: [1, 3], item: <jaopca:item_clusteramber>},
 {tab: [1, 3], item: <jaopca:item_clusterosmium>},
 {tab: [1, 3], item: <jaopca:item_clusterquartzblack>},
 {tab: [1, 3], item: <jaopca:item_clusternickel>},
 {tab: [2, 8], item: <jaopca:item_crushednickel>},
 {tab: [2, 8], item: <jaopca:item_crushedosmium>},
 {tab: [1, 3], item: <thaumcraft:cluster:1>},
 {tab: [1, 3], item: <thaumcraft:cluster:5>},
 {tab: [1, 3], item: <thaumcraft:cluster:6>}
];

val rare as IData[] = [
 {tab: [1, 4], item: <ic2:crushed:4>},
 {tab: [1, 4], item: <ic2:crushed:6>},
 {tab: [1, 2], item: <jaopca:item_clusterdiamond>},
 {tab: [1, 2], item: <jaopca:item_clusteremerald>},
 {tab: [1, 2], item: <jaopca:item_clusteruranium>},
 {tab: [1, 2], item: <thaumcraft:cluster:4>}
];

scripts.lib.loot.addBackpackPool(location);
scripts.lib.loot.addBackpackEmpty(location, 3);
scripts.lib.loot.addBackpackWithLoot(location, common, uncommon, rare, 3);
scripts.lib.loot.addBackpackForestryWithLoot(<forestry:miner_bag>, location, common, common, uncommon, 5);
scripts.lib.loot.addBackpackForestryWithLoot(<forestry:miner_bag_t2>, location, common, uncommon, uncommon, 5);
scripts.lib.loot.addBackpackCyclicWithLoot(location, uncommon, uncommon, rare);

scripts.lib.loot.addSpecialTool(location, <tconstruct:hammer>, ['dragonbone', 'refined_obsidian', 'treatedwood', 'osmium'], '§e§nWifewarder');
scripts.lib.loot.addRandomCapacitor(location, 0.15f);
