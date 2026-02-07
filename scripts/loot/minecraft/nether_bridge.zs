#modloaded loottweaker
#ignoreBracketErrors

val location = 'minecraft:chests/nether_bridge';

scripts.lib.loot.removePools(location,
  ['endreborn_inject_pool',
    'Ender IO',
    'xuLootDropOfEvil',
    'lavacharm']
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
  <mekanism:machineblock2:11>.withTag({tier: 0, mekData: {fluidTank: {FluidName: 'pyrotheum', Amount: 40000}}}): [20, 0, 1, 1],
  <randomthings:lavacharm>             : [10, 0, 1, 1],
  <randomthings:obsidianskullring>     : [10, 0, 1, 1],
  <cyclicmagic:book_ender>             : [5,  3, 1, 1],
  <thaumadditions:meteor_belt>         : [1,  1, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.tinkersModifiers);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.ancientTomes);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.baubles);

loottweaker.LootTweaker.getTable(location).addPool('pool1', 1.0f, 2.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool(location, 'pool1', {
  <harvestcraft:netherwingsitem>         : [50, 0, 1, 3],
  <thaumicwonders:panacea>               : [40, 0, 1, 1],
  <iceandfire:ambrosia>                  : [30, 0, 1, 1],
  <minecraft:blaze_rod>                  : [60, 0, 1, 2],
  <minecraft:skull:1>                    : [30, 0, 1, 1],
  <deepmoblearning:living_matter_hellish>: [25, 0, 1, 3],
  <nuclearcraft:plutonium>               : [3,  2, 1, 1],
  <thaumicwonders:panacea:1>             : [5,  5, 1, 1],
  <extendedcrafting:material:140>        : [20, 0, 1, 2],
  <nuclearcraft:americium>               : [2,  2, 1, 1],
  <thaumcraft:causality_collapser>       : [10, 0, 1, 1],
  <nuclearcraft:californium:5>           : [1,  1, 1, 1],
  <advgenerators:turbine_kit_manyullyn>  : [10, 0, 1, 2],

  <botania:brewvial>.withTag({brewKey: "fireResistance"}): [5,  2, 1, 1],
  <botania:brewvial>.withTag({brewKey: "bloodthirst"})   : [5,  2, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.badFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicConsumables);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.thaumcraftSpells);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.upgrades);

scripts.lib.loot.addSpecialTool(location, <tconstruct:scythe>, ['void_metal', 'xu_demonic_metal', 'plague_metal', 'fierymetal'], '§4Faiasaisu');
scripts.lib.loot.addRandomCapacitor(location, 0.15f);
