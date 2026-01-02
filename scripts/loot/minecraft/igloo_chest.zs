#modloaded loottweaker
#ignoreBracketErrors

val location = 'minecraft:chests/igloo_chest';

scripts.lib.loot.removePools(location,
  ['Ender IO',
    'rats:contaminated_food',
    'pool1']
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
  <astralsorcery:itemconstellationpaper>: [20,  0, 1, 1],
  <biomesoplenty:log_4:5>               : [30,  0, 4, 10],
  <botania:icependant>                  : [2,   0, 1, 1],
  <iceandfire:dread_torch>              : [50,  0, 2, 7],
  <iceandfire:manuscript>               : [20,  0, 1, 3],
  <iceandfire:troll_leather_frost>      : [15,  0, 1, 2],
  <thaumcraft:baubles:3>                : [5,   0, 1, 1],
  <twilightforest:arctic_boots>         : [5,   0, 1, 1],
  <twilightforest:arctic_chestplate>    : [5,   0, 1, 1],
  <twilightforest:arctic_helmet>        : [5,   0, 1, 1],
  <twilightforest:arctic_leggings>      : [5,   0, 1, 1],
  <twilightforest:ice_bomb>             : [20,  0, 1, 3],
});
loottweaker.LootTweaker.getTable(location).getPool('main').setRolls(1, 2);

loottweaker.LootTweaker.getTable(location).addPool('pool1', 1.0f, 2.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool(location, 'pool1', {
  <harvestcraft:caramelicecreamitem>          : [25,  0, 1, 2],
  <harvestcraft:cherryicecreamitem>           : [25,  0, 1, 2],
  <harvestcraft:mintchocolatechipicecreamitem>: [25,  0, 1, 2],
  <harvestcraft:mochaicecreamitem>            : [25,  0, 1, 2],
  <harvestcraft:neapolitanicecreamitem>       : [25,  0, 1, 2],
  <harvestcraft:pistachioicecreamitem>        : [25,  0, 1, 2],
  <harvestcraft:spumoniicecreamitem>          : [25,  0, 1, 2],
  <harvestcraft:strawberryicecreamitem>       : [25,  0, 1, 2],
  <harvestcraft:vanillaicecreamitem>          : [25,  0, 1, 2],
  <mctsmelteryio:iceball>                     : [30,  0, 1, 2],
  <minecraft:deadbush>                        : [30,  0, 1, 3],
  <minecraft:rabbit_stew>                     : [25,  0, 1, 1],

  <botania:brewvial>.withTag({brewKey: "warpWard"}): [5,  0, 1, 1],
  <botania:brewvial>.withTag({brewKey: "allure"})  : [5,  0, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.badFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.goodFood);

scripts.lib.loot.addSpecialTool(location, <tconstruct:frypan>, ['treatedwood', 'firewood'], 'Hot pan');
