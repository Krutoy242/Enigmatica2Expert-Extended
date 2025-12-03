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
  <mekanism:machineblock2:11>.withTag({tier: 0, mekData: {fluidTank: {FluidName: 'pyrotheum', Amount: 40000}}}): [20, 0, 1, 1],
  <mekanism:machineblock2:11>.withTag({tier: 0, mekData: {fluidTank: {FluidName: 'lava', Amount: 40000}}})     : [5, 0, 1, 1],
  <ic2:forge_hammer>                                                                                           : [20, 0, 1, 1],

  <tcomplement:sledge_head>.withTag({Material: 'alumite'})   : [5, 0, 1, 1],
  <tcomplement:sledge_head>.withTag({Material: 'boron'})     : [10, 0, 1, 1],
  <tcomplement:sledge_head>.withTag({Material: 'steel'})     : [10, 0, 1, 1],
  <tconstruct:axe_head>.withTag({Material: 'alumite'})       : [5, 0, 1, 1],
  <tconstruct:axe_head>.withTag({Material: 'boron'})         : [10, 0, 1, 1],
  <tconstruct:axe_head>.withTag({Material: 'steel'})         : [10, 0, 1, 1],
  <tconstruct:binding>.withTag({Material: 'aluminium'})      : [10, 0, 1, 1],
  <tconstruct:binding>.withTag({Material: 'apatite'})        : [10, 0, 1, 1],
  <tconstruct:binding>.withTag({Material: 'bronze'})         : [5, 0, 1, 1],
  <tconstruct:binding>.withTag({Material: 'certus_quartz'})  : [10, 0, 1, 1],
  <tconstruct:pick_head>.withTag({Material: 'alumite'})      : [5, 0, 1, 1],
  <tconstruct:pick_head>.withTag({Material: 'boron'})        : [10, 0, 1, 1],
  <tconstruct:pick_head>.withTag({Material: 'steel'})        : [10, 0, 1, 1],
  <tconstruct:sharpening_kit>.withTag({Material: 'lead'})    : [10, 0, 1, 1],
  <tconstruct:sharpening_kit>.withTag({Material: 'obsidian'}): [5, 0, 1, 1],
  <tconstruct:sharpening_kit>.withTag({Material: 'osmium'})  : [10, 0, 1, 1],
  <tconstruct:sharpening_kit>.withTag({Material: 'pigiron'}) : [10, 0, 1, 1],
  <tconstruct:shovel_head>.withTag({Material: 'alumite'})    : [5, 0, 1, 1],
  <tconstruct:shovel_head>.withTag({Material: 'boron'})      : [10, 0, 1, 1],
  <tconstruct:shovel_head>.withTag({Material: 'steel'})      : [10, 0, 1, 1],
  <tconstruct:tool_rod>.withTag({Material: 'aluminium'})     : [10, 0, 1, 1],
  <tconstruct:tool_rod>.withTag({Material: 'apatite'})       : [10, 0, 1, 1],
  <tconstruct:tool_rod>.withTag({Material: 'bronze'})        : [5, 0, 1, 1],
  <tconstruct:tool_rod>.withTag({Material: 'certus_quartz'}) : [10, 0, 1, 1],
});
loottweaker.LootTweaker.getTable(location).getPool('main').setRolls(1, 2);

loottweaker.LootTweaker.getTable(location).addPool('pool1', 1.0f, 2.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool(location, 'pool1', {
  <actuallyadditions:item_food:11>:  [50, 0, 1, 3],
  <advgenerators:turbine_kit_steel>: [10, 0, 1, 3],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.tinkersModifiers);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.techComponents);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.goodFood);

scripts.lib.loot.addSpecialTool(location, <tconstruct:pickaxe>, ['treatedwood', 'dark_steel', 'black_quartz'], 'Blacksmith Pickaxe');
scripts.lib.loot.addRandomCapacitor(location, 0.15f);
