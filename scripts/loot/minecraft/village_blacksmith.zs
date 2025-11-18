#modloaded loottweaker

import loottweaker.LootTweaker;
import crafttweaker.item.IItemStack;
import loottweaker.vanilla.loot.Functions;
import crafttweaker.data.IData;

val location = 'minecraft:chests/village_blacksmith';

scripts.lib.loot.removePools(location,
 ['endreborn_inject_pool',
 'rats:contaminated_food',
 'botania_inject_pool'] as string[]
);

scripts.lib.loot.clearPool(location, 'main');
scripts.lib.loot.addLootToPool(location, 'main', {
 <mekanism:machineblock2:11>.withTag({tier: 0, mekData: {fluidTank: {FluidName: "pyrotheum", Amount: 40000}}})       : [20,0,1,1],
 <mekanism:machineblock2:11>.withTag({tier: 0, mekData: {fluidTank: {FluidName: "lava", Amount: 40000}}})            : [5,0,1,1],
 <ic2:forge_hammer>         : [20,0,1,1],

 <tcomplement:sledge_head>.withTag({Material: "alumite"})     : [5,0,1,1],
 <tcomplement:sledge_head>.withTag({Material: "boron"})       : [10,0,1,1],
 <tcomplement:sledge_head>.withTag({Material: "steel"})       : [10,0,1,1],
 <tconstruct:axe_head>.withTag({Material: "alumite"})         : [5,0,1,1],
 <tconstruct:axe_head>.withTag({Material: "boron"})           : [10,0,1,1],
 <tconstruct:axe_head>.withTag({Material: "steel"})           : [10,0,1,1],
 <tconstruct:binding>.withTag({Material: "aluminium"})        : [10,0,1,1],
 <tconstruct:binding>.withTag({Material: "apatite"})          : [10,0,1,1],
 <tconstruct:binding>.withTag({Material: "bronze"})           : [5,0,1,1],
 <tconstruct:binding>.withTag({Material: "certus_quartz"})    : [10,0,1,1],
 <tconstruct:pick_head>.withTag({Material: "alumite"})        : [5,0,1,1],
 <tconstruct:pick_head>.withTag({Material: "boron"})          : [10,0,1,1],
 <tconstruct:pick_head>.withTag({Material: "steel"})          : [10,0,1,1],
 <tconstruct:sharpening_kit>.withTag({Material: "lead"})      : [10,0,1,1],
 <tconstruct:sharpening_kit>.withTag({Material: "obsidian"})  : [5,0,1,1],
 <tconstruct:sharpening_kit>.withTag({Material: "osmium"})    : [10,0,1,1],
 <tconstruct:sharpening_kit>.withTag({Material: "pigiron"})   : [10,0,1,1],
 <tconstruct:shovel_head>.withTag({Material: "alumite"})      : [5,0,1,1],
 <tconstruct:shovel_head>.withTag({Material: "boron"})        : [10,0,1,1],
 <tconstruct:shovel_head>.withTag({Material: "steel"})        : [10,0,1,1],
 <tconstruct:tool_rod>.withTag({Material: "aluminium"})       : [10,0,1,1],
 <tconstruct:tool_rod>.withTag({Material: "apatite"})         : [10,0,1,1],
 <tconstruct:tool_rod>.withTag({Material: "bronze"})          : [5,0,1,1],
 <tconstruct:tool_rod>.withTag({Material: "certus_quartz"})   : [10,0,1,1],
});

loottweaker.LootTweaker.getTable(location).addPool('pool1', 1.0f, 2.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool(location, 'pool1', {
 <actuallyadditions:item_food:11>            : [50,0,1,3],
});
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.tinkersModifiers);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.techComponents);
scripts.lib.loot.addLootToPool(location, 'pool1', scripts.loot.preMadeLoot.goodFood);

scripts.lib.loot.addSpecialTool(location, <tconstruct:pickaxe>.withTag({StatsOriginal: {AttackSpeedMultiplier: 1.0 as float, MiningSpeed: 5.25 as float, FreeModifiers: 3, Durability: 617, HarvestLevel: 7, Attack: 6.48 as float}, display: {Name: "Blacksmith Pickaxe"}, Stats: {AttackSpeedMultiplier: 1.0 as float, MiningSpeed: 5.25 as float, FreeModifiers: 2, Durability: 617, HarvestLevel: 7, Attack: 6.48 as float}, Special: {Categories: ["aoe", "harvest", "tool"]}, TinkerData: {Materials: ["treatedwood", "dark_steel", "black_quartz"], Modifiers: ["toolleveling"]}, Modifiers: [{identifier: "ecological", color: -10144478, level: 1}, {identifier: "enderference", color: -9671572, level: 1}, {identifier: "jagged", color: -11053225, level: 1}, {identifier: "depthdigger", color: -11053225, level: 1}, {identifier: "toolleveling", color: 16777215, level: 1}], Traits: ["ecological", "enderference", "jagged", "depthdigger", "toolleveling", "tconevo.artifact"]}));
