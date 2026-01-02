#modloaded loottweaker
#ignoreBracketErrors

val location = 'minecraft:chests/desert_pyramid';

scripts.lib.loot.removePools(location,
  ['endreborn_inject_pool',
    'forestry_factory_items',
    'manuscript',
    'moms_spaghetti',
    'rats:contaminated_food',
    'token_fragment',
    'rat_upgrade_basic',
    'Ender IO',
    'botania_inject_pool']
);

scripts.lib.loot.removeEtriesFromPool(location, 'main', [
  'minecraft:diamond',
  'minecraft:iron_ingot',
  'minecraft:gold_ingot',
  'minecraft:emerald',
  'minecraft:bone',
  'minecraft:spider_eye',
  'minecraft:rotten_flesh',
  'quark:rune',
  'rftoolsdim:parcel',
  'actuallyadditions:drillCore',
  'actuallyadditions:batWings',
  'cyclicmagic:item.tool_auto_torch',
  'cyclicmagic:item.sack_ender',
  'cyclicmagic:item.apple_emerald',
  'cyclicmagic:item.tool_harvest_crops',
  'cyclicmagic:item.tool_elevate',
  'cyclicmagic:item.glove_climb',
  'cyclicmagic:item.ender_lightning',
  'cyclicmagic:item.ender_pearl_mounted',
  'cyclicmagic:item.ender_pearl_reuse',
  'cyclicmagic:item.sprout_seed',
  'cyclicmagic:item.cyclic_wand_build',
  'cyclicmagic:item.ender_tnt_6',
]);

scripts.lib.loot.addLootToPool(location, 'main', {
  <extrautils2:itembuilderswand>                : [30,  0, 1, 1],
  <minecraft:totem_of_undying>                  : [5,   0, 1, 1],
  <quark:archaeologist_hat>                     : [30,  0, 1, 1],
  <randomthings:lavacharm>.withTag({charge: 68}): [20,  0, 1, 1],
  <randomthings:waterwalkingboots>              : [20,  0, 1, 1],
  <randomthings:weatheregg:1>                   : [5,   0, 1, 1],
  <randomthings:weatheregg:2>                   : [5,   0, 1, 1],
  <randomthings:weatheregg>                     : [5,   0, 1, 1],
  <rats:archeologist_hat>                       : [20,  0, 1, 1],
  <rats:piper_hat>                              : [20,  0, 1, 1],
  <scalinghealth:heartcontainer>                : [30,  0, 1, 1],

  <thaumcraft:elemental_axe>.withTag({infench: [{lvl: 1 as short, id: 2 as short}, {lvl: 1 as short, id: 0 as short}]}) : [5, 0, 1, 1],
  <thaumcraft:elemental_hoe>                                                                                            : [5,   0, 1, 1],
  <thaumcraft:elemental_pick>.withTag({infench: [{lvl: 1 as short, id: 4 as short}, {lvl: 2 as short, id: 3 as short}]}): [5, 0, 1, 1],
  <thaumcraft:elemental_shovel>.withTag({infench: [{lvl: 1 as short, id: 1 as short}]})                                 : [5, 0, 1, 1],
  <thaumcraft:elemental_sword>.withTag({infench: [{lvl: 2 as short, id: 5 as short}]})                                  : [5, 0, 1, 1],
  <thermalfoundation:tome_experience>.withTag({Experience: 10000})                                                      : [10, 0, 1, 1],
  <twilightforest:charm_of_keeping_1>                                                                                   : [30, 0, 1, 1],
  <twilightforest:charm_of_life_1>                                                                                      : [30, 0, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.upgrades);
scripts.lib.loot.addLootToPool(location, 'main', scripts.loot.preMadeLoot.thaumcraftSpells);
loottweaker.LootTweaker.getTable(location).getPool('main').setRolls(1, 2);

scripts.lib.loot.clearPool(location, 'pool1');
scripts.lib.loot.addLootToPool(location, 'pool1', {
  <advgenerators:turbine_kit_gold>: [10, 0, 1, 3],
  <endreborn:item_end_essence>    : [50, 0, 2, 3],
  <extrautils2:suncrystal>        : [30, 0, 1, 1],
  <forestry:ash>                  : [50, 0, 2, 7],
  <forestry:royal_jelly>          : [10, 0, 1, 1],
  <iceandfire:dragonbone>         : [80, 0, 2, 5],
  <iceandfire:fire_dragon_blood>  : [2,  0, 1, 1],
  <iceandfire:ice_dragon_blood>   : [2,  0, 1, 1],
  <iceandfire:pixie_dust>         : [60, 0, 1, 2],
  <mia:torch_gold>                : [100, 0, 3, 16],
  <randomthings:ingredient:10>    : [20, 0, 1, 1],
  <randomthings:ingredient:11>    : [1,  0, 1, 1],
  <rats:rat_diamond>              : [20, 0, 1, 3],
  <rats:token_fragment>           : [5, 0, 1, 1],
  <rustic:candle_gold>            : [20, 0, 2, 10],
  <tconstruct:spaghetti>          : [5, 0, 3, 7],
  <thaumcraft:fabric>             : [30, 0, 3, 7],

  <botania:brewvial>.withTag({brewKey: "clear"})      : [5, 0, 1, 1],
  <botania:brewvial>.withTag({brewKey: "featherFeet"}): [5, 0, 1, 1],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.badFood);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.magicConsumables);

scripts.lib.loot.addSpecialTool(location, <tconstruct:longsword>, ['sunnarium', 'amethyst', 'electrum'], '§e§nStiletto of Montu');
