#modloaded loottweaker
#ignoreBracketErrors

val location = 'minecraft:chests/end_city_treasure';

scripts.lib.loot.removePools(location,
  ['floralchemy_inject_pool',
    'spectrecoil_number',
    'Ender IO',
    'forestry_arboriculture_items']
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
  <extrautils2:itembuilderswand>                       : [30, 0, 1, 1],
  <randomthings:weatheregg:2>                          : [10, 0, 1, 1],
  <randomthings:weatheregg:1>                          : [10, 0, 1, 1],
  <randomthings:weatheregg>                            : [10, 0, 1, 1],
  <mysticalagradditions:stuff:3>                       : [20, 0, 2, 5],

  <enderio:item_soul_vial:1>.withTag({entityId: 'minecraft:shulker'})          : [16, 5, 1, 1],
  <enderio:item_soul_vial:1>.withTag({entityId: 'quark:stoneling'})            : [1,  1, 1, 1],
  <enderio:item_soul_vial:1>.withTag({entityId: 'betteranimalsplus:tarantula'}): [1,  1, 1, 1],
  <enderio:item_soul_vial:1>.withTag({entityId: 'quark:archaeologist'})        : [1,  1, 1, 1],
  <enderio:item_soul_vial:1>.withTag({entityId: 'thaumcraft:eldritchcrab'})    : [1,  1, 1, 1],

  <mekanism:energycube>.withTag({tier: 0, mekData: {energyStored: 3.0e7}}): [1, 0, 1, 1],

  <botania:brewvial>.withTag({brewKey: "calamity"})       : [2, 2, 1, 1],
  <botania:brewvial>.withTag({brewKey: "depthbound"})     : [2, 2, 1, 1],
  <botania:brewvial>.withTag({brewKey: "sanguine_oath"})  : [2, 2, 1, 1],
  <botania:brewvial>.withTag({brewKey: "scarlet_veil"})   : [2, 2, 1, 1],
  <botania:brewvial>.withTag({brewKey: "warbound"})       : [2, 2, 1, 1],
  <botania:brewvial>.withTag({brewKey: "aerial_delirium"}): [2, 2, 1, 1],
  <botania:brewvial>.withTag({brewKey: "overload"})       : [2, 2, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.thaumcraftSpells);
loottweaker.LootTweaker.getTable(location).getPool('main').setRolls(1, 2);

loottweaker.LootTweaker.getTable(location).addPool('pool1', 1.0f, 2.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool(location, 'pool1', {
  <cyclicmagic:corrupted_chorus>      : [10,  0, 1, 1],
  <thaumcraft:bottle_taint>           : [10,  0, 1, 2],
  <minecraft:end_crystal>             : [1,   0, 1, 1],
  <endreborn:dragon_scales>           : [30,  0, 2, 5],
  <endreborn:item_end_essence>        : [10,  0, 1, 1],
  <randomthings:ingredient:2>         : [10,  0, 4, 9],
  <extendedcrafting:material:40>      : [10,  0, 1, 1],
  <ic2:misc_resource:1>               : [10,  0, 2, 3],
  <minecraft:dragon_breath>           : [5,   0, 1, 1],
  <iceandfire:fire_dragon_blood>      : [3,   0, 1, 1],
  <iceandfire:ice_dragon_blood>       : [3,   0, 1, 1],
  <quark:diamond_heart>               : [3,   0, 1, 1],
  <advgenerators:turbine_kit_enderium>: [10, 10, 1, 2],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.goodFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicConsumables);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.psiSpells);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.thaumcraftSpells);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.upgrades);

scripts.lib.loot.addSpecialTool(location, <tconstruct:shuriken>, ['enderium', 'gelid_enderium', 'endstone', 'end_steel'], '§5Whispershard');
scripts.lib.loot.addRandomCapacitor(location, 0.15f);
