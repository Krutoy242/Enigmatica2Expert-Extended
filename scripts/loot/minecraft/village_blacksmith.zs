#modloaded loottweaker
#ignoreBracketErrors

val location = 'minecraft:chests/village_blacksmith';

scripts.lib.loot.removePools(location,
  ['endreborn_inject_pool',
    'rats:contaminated_food',
    'Ender IO',
    'botania_inject_pool']
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
  <mekanism:machineblock2:11>.withTag({tier: 0, mekData: {fluidTank: {FluidName: 'canolaoil', Amount: 40000}}}): [20, 0, 1, 1],
  <mekanism:machineblock2:11>.withTag({tier: 0, mekData: {fluidTank: {FluidName: 'lava', Amount: 40000}}})     : [5,  2, 1, 1],
  <ic2:forge_hammer>                                                                                           : [20, 0, 1, 1],

  <tconstruct:axe_head>.withTag({Material: "black_quartz"})       : [5,  5, 1, 1],
  <tconstruct:axe_head>.withTag({Material: "carbon_fiber"})       : [10, 0, 1, 1],
  <tconstruct:binding>.withTag({Material: "alubrass"})            : [10, 0, 1, 1],
  <tconstruct:binding>.withTag({Material: "invar"})               : [5,  5, 1, 1],
  <tconstruct:binding>.withTag({Material: "paper"})               : [10, 0, 1, 1],
  <tconstruct:cross_guard>.withTag({Material: "amber"})           : [5,  5, 1, 1],
  <tconstruct:kama_head>.withTag({Material: "construction_alloy"}): [10, 0, 1, 1],
  <tconstruct:kama_head>.withTag({Material: "fluix"})             : [5,  5, 1, 1],
  <tconstruct:pick_head>.withTag({Material: "certus_quartz"})     : [5,  5, 1, 1],
  <tconstruct:pick_head>.withTag({Material: "copper"})            : [10, 0, 1, 1],
  <tconstruct:sharpening_kit>.withTag({Material: "dragonbone"})   : [5,  5, 1, 1],
  <tconstruct:sharpening_kit>.withTag({Material: "essence_metal"}): [5,  5, 1, 1],
  <tconstruct:sharpening_kit>.withTag({Material: "flint"})        : [10, 0, 1, 1],
  <tconstruct:shovel_head>.withTag({Material: "aluminium"})       : [10, 0, 1, 1],
  <tconstruct:shovel_head>.withTag({Material: "chocolate"})       : [5,  5, 1, 1],
  <tconstruct:sword_blade>.withTag({Material: "bone"})            : [10, 0, 1, 1],
  <tconstruct:sword_blade>.withTag({Material: "iron"})            : [10, 0, 1, 1],
  <tconstruct:sword_blade>.withTag({Material: "silver"})          : [5,  5, 1, 1],
  <tconstruct:tool_rod>.withTag({Material: "apatite"})            : [10, 0, 1, 1],
  <tconstruct:tool_rod>.withTag({Material: "bronze"})             : [5,  5, 1, 1],
  <tconstruct:tool_rod>.withTag({Material: "rubber"})             : [10, 0, 1, 1],
  <tconstruct:tool_rod>.withTag({Material: "treatedwood"})        : [5,  5, 1, 1],
  <tconstruct:wide_guard>.withTag({Material: "bloodbone"})        : [10, 0, 1, 1],
  <tconstruct:wide_guard>.withTag({Material: "emerald_plustic"})  : [5,  5, 1, 1],

  <botania:brewvial>.withTag({brewKey: "invisibility"}): [5, 10, 1, 1],
  <botania:brewvial>.withTag({brewKey: "emptiness"})   : [5, 10, 1, 1],
});
loottweaker.LootTweaker.getTable(location).getPool('main').setRolls(1, 2);

loottweaker.LootTweaker.getTable(location).addPool('pool1', 1.0f, 2.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool(location, 'pool1', {
  <actuallyadditions:item_food:11>:  [50, 0,  1, 3],
  <advgenerators:turbine_kit_steel>: [10, 30, 1, 3],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.tinkersModifiers);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.techComponents);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.goodFood);

scripts.lib.loot.addSpecialTool(location, <tconstruct:pickaxe>, ['treatedwood', 'dark_steel', 'black_quartz'], 'Blacksmith Pickaxe');
scripts.lib.loot.addRandomCapacitor(location, 0.15f);
