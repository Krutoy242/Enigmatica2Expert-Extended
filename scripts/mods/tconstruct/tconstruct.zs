#modloaded tconstruct iceandfire

import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;

<tconstruct:throwball>.maxStackSize = 64;

<blockstate:tconstruct:ore>.block.definition.hardness = 18; // Harvest level defined in mod config

mods.tconstruct.Melting.addEntityMelting(<entity:iceandfire:hippocampus>, <fluid:liquid_helium> * 20);

// Prevent duping bones by crushing => melting => casting bones
mods.tconstruct.Melting.removeRecipe(<fluid:notmilk>);

// Melt vanilla items since autimatic calculation is disabled
scripts.process.melt(<minecraft:cauldron>, <fluid:iron> * (144 * 7));
scripts.process.melt(<minecraft:anvil>, <fluid:iron> * (144 * 31));
scripts.process.melt(<minecraft:anvil:1>, <fluid:iron> * (144 * 23));
scripts.process.melt(<minecraft:anvil:2>, <fluid:iron> * (144 * 15));

// Remove and re-add dragon steel meltable items since they was removed with Gauntlet mod
mods.tconstruct.Melting.removeRecipe(<fluid:dragonsteel_fire>);
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_fire> * 144, <iceandfire:dragonsteel_fire_ingot>);
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_fire> * 1296, <iceandfire:dragonsteel_fire_block>);
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_fire> * 72, <tconstruct:shard>.withTag({Material: "dragonsteel_fire"}));

mods.tconstruct.Melting.removeRecipe(<fluid:dragonsteel_ice>);
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_ice> * 144, <iceandfire:dragonsteel_ice_ingot>);
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_ice> * 1296, <iceandfire:dragonsteel_ice_block>);
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_ice> * 72, <tconstruct:shard>.withTag({Material: "dragonsteel_ice"}));

// Slime Dirt -> Slime
val slimeDirts as IItemStack[][IItemStack] = {
  <minecraft:slime_ball>: [
    <tconstruct:slime_dirt>,
    <tconstruct:slime_grass:1>,
    <tconstruct:slime_grass:6>,
    <tconstruct:slime_grass:11>,
  ],
  <tconstruct:edible:1>: [
    <tconstruct:slime_dirt:1>,
    <tconstruct:slime_grass:2>,
    <tconstruct:slime_grass:7>,
    <tconstruct:slime_grass:12>,
  ],
  <tconstruct:edible:2>: [
    <tconstruct:slime_dirt:2>,
    <tconstruct:slime_grass:3>,
    <tconstruct:slime_grass:8>,
    <tconstruct:slime_grass:13>,
  ],
  <tconstruct:edible:4>: [
    <tconstruct:slime_dirt:3>,
    <tconstruct:slime_grass:4>,
    <tconstruct:slime_grass:9>,
    <tconstruct:slime_grass:14>,
  ],
};

for slime, dirts in slimeDirts {
  for dirt in dirts {
    mods.thermalexpansion.Centrifuge.addRecipe([slime % 50, <minecraft:dirt>], dirt, null, 4000);
    mods.forestry.Centrifuge.addRecipe([slime % 25, <minecraft:dirt>], dirt, 100);
  }
}

// Remove redundant slimes
Purge(<tconstruct:edible:5>).ores([<ore:slimeball>]);
Purge(<tconstruct:slime_congealed:5>).ores([<ore:blockSlimeCongealed>]);

// Removing Bronze / Steel dupes
mods.tconstruct.Melting.removeRecipe(<liquid:bronze>, <ic2:pipe>);
mods.tconstruct.Melting.removeRecipe(<liquid:steel>, <ic2:pipe:1>);

// Remove Iron -> Aluminium exploit
mods.tconstruct.Melting.removeRecipe(<liquid:aluminum>, <minecraft:hopper>);
mods.tconstruct.Melting.removeRecipe(<liquid:iron>, <minecraft:hopper>);

// Cobalt Block Unification
mods.tconstruct.Casting.removeBasinRecipe(<chisel:blockcobalt>);
mods.tconstruct.Casting.addBasinRecipe(<tconstruct:metal>, null, <liquid:cobalt>, 1296);

// Item Rack
Purge(<tconstruct:rack>);

// Blank Cast Resmelting
mods.tconstruct.Melting.addRecipe(<liquid:alubrass> * 144, <tconstruct:cast>);

// [Reinforcement] from [Gold Item Casing][+2]
craft.remake(<tconstruct:materials:14>, ['pretty',
  '■ □ ■',
  '■ ⌂ ■',
  '■ □ ■'], {
  '■': <ore:blockSheetmetalGold>, // Gold Sheetmetal
  '□': <tconstruct:large_plate>.withTag({ Material: 'obsidian' }), // Obsidian Large Plate
  '⌂': <ic2:casing:2>, // Gold Item Casing
});

// [Reinforcement]*2 from [Gold Item Casing][+2]
craft.make(<tconstruct:materials:14> * 2, ['pretty',
  '■ □ ■',
  '■ ⌂ ■',
  '■ □ ■'], {
  '■': <ore:blockSheetmetalGold>, // Gold Sheetmetal
  '□': <ore:plateDenseObsidian>, // Dense Obsidian Plate
  '⌂': <ic2:casing:2>, // Gold Item Casing
});

// Faster Alumite Alloying
mods.tconstruct.Alloy.removeRecipe(<liquid:alumite>); // Magically, removing Alumite have effect
mods.tconstruct.Alloy.addRecipe(<liquid:alumite> * 432, [<liquid:aluminum> * 720, <liquid:iron> * 288, <liquid:obsidian> * 288]);

// Alumite alloying in other machines
scripts.process.alloy([<ore:ingotFakeIron> * 2, <ore:ingotAluminium> * 5, <ore:obsidian> * 2], <tconstruct:ingots:6> * 3, 'Only: AlloySmelter ArcFurnace');
scripts.process.alloy([<ore:blockFakeIron> * 2, <ore:blockAluminium> * 5, <ore:obsidian> * 18], <tconstruct:metal:7> * 3, 'Only: AdvRockArc');

// Faster Osmiridium Alloying
// mods.tconstruct.Alloy.removeRecipe(<liquid:osmiridium>); // Removing Osmiridium PlusTic's alloy wouldn't have effect
mods.tconstruct.Alloy.addRecipe(<liquid:osmiridium> * 144, [<liquid:osmium> * 72, <liquid:iridium> * 72]);

// Osgloglas recipe after moving to tconevo
// mods.tconstruct.Alloy.removeRecipe(<liquid:osgloglas>); // Removing Osgloglas PlusTic's alloy wouldn't have effect
mods.tconstruct.Alloy.addRecipe(<liquid:osgloglas> * 144, [<liquid:osmium> * 144, <liquid:refined_obsidian> * 144, <liquid:refined_glowstone> * 144]);

// Faster Bronze Alloying
mods.tconstruct.Alloy.removeRecipe(<liquid:bronze>);
mods.tconstruct.Alloy.addRecipe(<liquid:bronze> * 288, [<liquid:tin> * 72, <liquid:copper> * 216]);
mods.tconstruct.Alloy.addRecipe(<liquid:bronze> * 576, [<liquid:tin> * 144, <liquid:copper> * 432]);

mods.tconstruct.Alloy.removeRecipe(<liquid:alubrass>);
mods.tconstruct.Alloy.addRecipe(<liquid:alubrass> * 288, [<liquid:copper> * 72, <liquid:aluminum> * 216]);
mods.tconstruct.Alloy.addRecipe(<liquid:alubrass> * 576, [<liquid:copper> * 144, <liquid:aluminum> * 432]);

// Aluminium Brass in other machines
scripts.process.alloy([<ore:ingotCopper>, <ore:ingotAluminium> * 3], <tconstruct:ingots:5> * 4, 'only: Kiln strict: ArcFurnace');

// Tinkers' Complement Melter
recipes.remove(<tcomplement:melter>);
recipes.addShaped('TiC Complement',
  <tcomplement:melter>,
  [[<ore:blockSeared>, <tconstruct:seared_tank>, <ore:blockSeared>],
    [<ore:blockSeared>, <tconstruct:smeltery_controller>, <ore:blockSeared>],
    [<ore:blockSeared>, <ore:blockSeared>, <ore:blockSeared>]]);

// Large Plates in Immersive Engineering Metal Press
val pressPlates = {
  advanced_alloy  : <ore:plateAdvancedAlloy> * 9,
  xu_demonic_metal: <extrautils2:simpledecorative:1>,
  lead            : <thermalfoundation:storage:3>,
  iron            : <minecraft:iron_block>,
  electrum        : <thermalfoundation:storage_alloy:1>,
  flint           : <excompressum:compressed_block:5>,
  osgloglas       : <ore:blockOsgloglas>,
  black_quartz    : <ore:blockQuartzBlack>,
  void_crystal    : <actuallyadditions:block_crystal:3>,
  constantan      : <ore:blockConstantan>,
  manyullyn       : <ore:blockManyullyn>,
  pigiron         : <ore:blockPigiron>,
  xu_evil_metal   : <ore:blockEvilMetal>,
  void_metal      : <ore:blockVoid>,
  neutronium      : <ore:blockCosmicNeutronium>,
  enderium        : <ore:blockEnderium>,
} as IIngredient[string];
for out, inp in pressPlates {
  mods.immersiveengineering.MetalPress.addRecipe(
    <tconstruct:large_plate>.withTag({ Material: out }),
    inp, <immersiveengineering:mold>, 16000);
}

scripts.process.compress(<ore:blockQuartzBlack>, <tconstruct:large_plate>.withTag({ Material: 'black_quartz' }), 'only: Compactor');

// EFLN
recipes.remove(<tconstruct:throwball:1>);
recipes.addShapedMirrored('EFLN',
  <tconstruct:throwball:1> * 2,
  [[<ore:dustSulfur>, <ore:gunpowder>, <ore:dustSulfur>],
    [<ore:gunpowder>, <excompressum:compressed_block:5>, <ore:gunpowder>],
    [<ore:dustSulfur>, <ore:gunpowder>, <ore:dustSulfur>]]);

// Removing the ability to smelt dusts into ingots, for Signalum, Lumium, Enderium and Refined Obsidian
mods.tconstruct.Melting.removeRecipe(<liquid:signalum>, <thermalfoundation:material:101>);
mods.tconstruct.Melting.removeRecipe(<liquid:lumium>, <thermalfoundation:material:102>);
mods.tconstruct.Melting.removeRecipe(<liquid:enderium>, <thermalfoundation:material:103>);
mods.tconstruct.Melting.removeRecipe(<liquid:refinedobsidian>, <mekanism:otherdust:5>);
// Removing the ability to smelt redstone/glowstone to make EnderIO alloys
for item in <ore:dustRedstone>.items { mods.tconstruct.Melting.removeRecipe(<liquid:redstone>, item); }
for item in <ore:blockRedstone>.items { mods.tconstruct.Melting.removeRecipe(<liquid:redstone>, item); }
for item in <ore:dustGlowstone>.items { mods.tconstruct.Melting.removeRecipe(<liquid:glowstone>, item); }
for item in <ore:blockGlowstone>.items { mods.tconstruct.Melting.removeRecipe(<liquid:glowstone>, item); }

// Removing the ability to melt coal
val coals as IItemStack[] = [
  <minecraft:coal>,
  <minecraft:coal_block>,
  <thermalfoundation:material:768>,
  <nuclearcraft:ingot_block:8>,
  <nuclearcraft:ingot:8>,
  <nuclearcraft:dust:8>,
];

for item in coals {
  mods.tconstruct.Melting.removeRecipe(<liquid:coal>, item);
}

// Remove Ender Pearl Melting (to remove the ability to alloy Enderium)
mods.tconstruct.Melting.removeRecipe(<liquid:ender>);

// Missed melt recipe for Block Of Ender Pearls
scripts.process.melt(<actuallyadditions:block_misc:6>, <liquid:ender> * 1000, 'Except: Smeltery', { energy: 80000 });

// Gear Cast
mods.tconstruct.Casting.addTableRecipe(<tconstruct:cast_custom:4>, <thermalfoundation:material:23>, <liquid:gold>, 288, true);
mods.tconstruct.Casting.addTableRecipe(<tconstruct:cast_custom:4>, <thermalfoundation:material:23>, <liquid:alubrass>, 144, true);
mods.tconstruct.Casting.addTableRecipe(<tconstruct:cast_custom:4>, <thermalfoundation:material:23>, <liquid:brass>, 144, true);

// Slime Slings
recipes.remove(<tconstruct:slimesling:*>);
function remakeSlimeSlings(name as string, item as IItemStack, primary as IIngredient) {
  recipes.addShaped('Slime Sling ' ~ name, item, [
    [<ore:slimeball>, null, <ore:slimeball>],
    [<ore:slimeball>, <cyclicmagic:slingshot_weapon>.anyDamage(), <ore:slimeball>],
    [null, primary, null],
  ]);
}

remakeSlimeSlings('Green', <tconstruct:slimesling>, <tconstruct:slime_congealed>);
remakeSlimeSlings('Blue', <tconstruct:slimesling:1>, <tconstruct:slime_congealed:1>);
remakeSlimeSlings('Purple', <tconstruct:slimesling:2>, <tconstruct:slime_congealed:2>);
remakeSlimeSlings('Red', <tconstruct:slimesling:3>, <tconstruct:slime_congealed:3>);
remakeSlimeSlings('Magma', <tconstruct:slimesling:4>, <tconstruct:slime_congealed:4>);

// Remake some metals to able be melted only under amplyfiing tube
mods.mechanics.addTubeRecipe([<biomesoplenty:crystal>] as IItemStack[], <liquid:crystal> * 1000);

// Remove other Fluid Amber Recipes
mods.cyclicmagic.Melter.removeShapedRecipe('amber', 100);
mods.cyclicmagic.Melter.removeShapedRecipe('amber', 1000);
mods.cyclicmagic.Melter.removeShapedRecipe('crystal', 1000);

// Melt blue slimes
scripts.process.melt(<tconstruct:edible:1>, <fluid:blueslime> * 250);
scripts.process.melt(<tconstruct:slime_congealed:1>, <fluid:blueslime> * (250 * 4));
scripts.process.melt(<tconstruct:slime:1>, <fluid:blueslime> * (250 * 9));

// Liquid blue slimy items
scripts.process.squeeze([<tconstruct:slime_dirt:1>], <liquid:blueslime> * 2000, null, <biomesoplenty:mudball>);
scripts.process.squeeze([<tconstruct:slime_leaves>], <liquid:blueslime> * 500, null, null);
scripts.process.squeeze([<tconstruct:slime_grass_tall>], <liquid:blueslime> * 200, null, null);
scripts.process.squeeze([<tconstruct:slime_grass_tall:1>], <liquid:blueslime> * 200, null, null);
scripts.process.squeeze([<tconstruct:slime_sapling>], <liquid:blueslime> * 1000, null, null);
scripts.process.squeeze([<tconstruct:slime_vine_blue_end>], <liquid:blueslime> * 200, null, null);
scripts.process.squeeze([<tconstruct:slime_vine_blue_mid>], <liquid:blueslime> * 200, null, <tconstruct:slime_vine_blue_end>);
scripts.process.squeeze([<tconstruct:slime_vine_blue>], <liquid:blueslime> * 200, null, <tconstruct:slime_vine_blue_mid>);

// Liquid purple slimy items
scripts.process.squeeze([<tconstruct:slime_dirt:2>], <liquid:purpleslime> * 2000, null, <biomesoplenty:mudball>);
scripts.process.squeeze([<tconstruct:slime_leaves:1>], <liquid:purpleslime> * 500, null, null);
scripts.process.squeeze([<tconstruct:slime_grass_tall:4>], <liquid:purpleslime> * 200, null, null);
scripts.process.squeeze([<tconstruct:slime_grass_tall:5>], <liquid:purpleslime> * 200, null, null);
scripts.process.squeeze([<tconstruct:slime_sapling:1>], <liquid:purpleslime> * 1000, null, null);
scripts.process.squeeze([<tconstruct:slime_vine_purple_end>], <liquid:purpleslime> * 200, null, null);
scripts.process.squeeze([<tconstruct:slime_vine_purple_mid>], <liquid:purpleslime> * 200, null, <tconstruct:slime_vine_purple_end>);
scripts.process.squeeze([<tconstruct:slime_vine_purple>], <liquid:purpleslime> * 200, null, <tconstruct:slime_vine_purple_mid>);

// Remove cheap steel recipe
mods.tcomplement.highoven.HighOven.removeMixRecipe(<liquid:steel>);

// More Scorched bricks recipes
mods.immersiveengineering.ArcFurnace.addRecipe(<tcomplement:materials:1>, <minecraft:brick>, <immersiveengineering:material:7>, 10, 512);

// Clay bucket use for casts
val bkt = <claybucket:unfiredclaybucket:*>;
mods.tconstruct.Casting.addTableRecipe(<tcomplement:cast_clay>, bkt, <liquid:clay>, 288, true);
mods.tconstruct.Casting.addTableRecipe(<tcomplement:cast>, bkt, <liquid:gold>, 288, true);
mods.tconstruct.Casting.addTableRecipe(<tcomplement:cast>, bkt, <liquid:alubrass>, 144, true);
mods.tconstruct.Casting.addTableRecipe(<tcomplement:cast>, bkt, <liquid:brass>, 144, true);

// Slime mud
craft.reshapeless(<tconstruct:soil:2>, '■sd', {
  '■': <tconstruct:slime_congealed:1>,
  's': <minecraft:sand>,
  'd': <minecraft:dirt:2>,
});
craft.reshapeless(<tconstruct:soil:2>, 'ssssad', {
  'a': <minecraft:sand>,
  's': <tconstruct:edible:1>,
  'd': <minecraft:dirt:2>,
});

// [Green Slimy Grass] from [Mud][+1]
craft.shapeless(<tconstruct:slime_grass:1>, 'ss■ss', {
  's': <ore:slimeballGreen>, // Slimeball
  '■': <ore:blockMud>, // Mud
});

// [Blue Slimy Grass] from [Mud][+1]
craft.shapeless(<tconstruct:slime_grass:2>, 'ss■ss', {
  's': <ore:slimeballBlue>, // Slime Ball
  '■': <ore:blockMud>, // Mud
});

// [Purple Slimy Grass] from [Mud][+1]
craft.shapeless(<tconstruct:slime_grass:8>, 'ss■ss', {
  's': <ore:slimeballPurple>, // Slime Ball
  '■': <ore:blockMud>, // Mud
});

// [Magma Slimy Grass] from [Mud][+1]
craft.shapeless(<tconstruct:slime_grass:14>, 'ss■ss', {
  's': <ore:slimeballMagma>, // Slime Ball
  '■': <ore:blockMud>, // Mud
});

// Mud balls smelted into TCon bricks
furnace.remove(<biomesoplenty:mud_brick>);
furnace.addRecipe(<tconstruct:materials:1>, <biomesoplenty:mudball>);

// Mud bricks from TCon bricks
recipes.remove(<biomesoplenty:mud_brick_block>);
recipes.addShaped(<biomesoplenty:mud_brick_block> * 2, [
  [<tconstruct:materials:1>, <tconstruct:materials:1>, <tconstruct:materials:1>],
  [<tconstruct:materials:1>, null, <tconstruct:materials:1>],
  [<tconstruct:materials:1>, <tconstruct:materials:1>, <tconstruct:materials:1>],
]);

// Molten Quartz and Lapis to blocks
mods.tconstruct.Casting.addBasinRecipe(<minecraft:quartz_block>, null, <liquid:quartz>, 2664);
mods.tconstruct.Casting.addBasinRecipe(<minecraft:lapis_block>, null, <liquid:lapis>, 5994);

// Clearing
utils.clearFluid(<tconstruct:seared_tank:0>);
utils.clearFluid(<tconstruct:seared_tank:1>);

//#######################################################################################
// Chest with all avaliable patterns

// generate all possible patterns
var dataList_allPatterns = [] as IData;
var k = 0 as byte;
for item in loadedMods['tconstruct'].items {
  if (!item.definition.id.startsWith('tconstruct:pattern')) continue;
  if (isNull(item.tag) || isNull(item.tag.PartType)) continue;

  dataList_allPatterns += [{
    Slot  : k,
    id    : 'tconstruct:pattern',
    Count : 1 as byte,
    Damage: 0 as short,
    tag   : item.tag,
  }] as IData;
  k += 1;
}

// [Pattern_Chest] from [Oak_Chest][+4]
recipes.removeByRecipeName('tconstruct:tools/table/chest/pattern');
craft.make(<tconstruct:tooltables:4>.withTag({
  inventory: { Items: dataList_allPatterns },
} as IData + utils.shiningTag(10057489)), ['pretty',
  '# a #',
  'p c p',
  '# M #'], {
  'p': <ore:pattern>, // Blank Pattern
  'a': <tconstruct:book>, // Materials and You
  '#': <forestry:wood_pile>, // Wood Pile
  'c': <ore:chest> | <tconstruct:tooltables:4>, // Oak Chest
  'M': <conarm:book>, // Materials and You - Armory Addendum
});
//#######################################################################################

// [Firewood] from [Pahoehoe_Lava_Bucket][+2]
craft.remake(<tconstruct:firewood:1>, ['pretty',
  'L B L',
  'B ~ B',
  'L B L'], {
  'B': <forestry:bituminous_peat>, // Bituminous Peat
  'L': <tconstruct:firewood>, // Lavawood
  '~': LiquidIngr('ic2pahoehoe_lava'), // Pahoehoe Lava Bucket
});

// Remake to fix weird stone rod HEI scrolling
// [Stone Torch]*4 from [Stone Rod][+1]
craft.remake(<tconstruct:stone_torch> * 4, [
  '©',
  '/'], {
  '©': <minecraft:coal:*>,                // Coal
  '/': <exnihilocreatio:item_material:6>, // Stone Rod
});

// [Silky Cloth] from [Pulverized Gold][+1]
craft.reshapeless(<tconstruct:materials:15>, 'S▲', {
  '▲': <ore:dustGold>, // Pulverized Gold
  'S': <forestry:crafting_material:2>, // Silk Wisp
});

// [Silky Jewel] from [Flux Crystal][+1]
craft.make(<tconstruct:materials:16>, ['pretty',
  '  □  ',
  '□ * □',
  '  □  '], {
  '□': <ore:plateDenseGold>, // Dense Gold Plate
  '*': <ore:gemCrystalFlux>, // Flux Crystal
});

// Remake to avoid recipe conflict with Compressed Mossy Stone
// [Ball of Moss] from [Moss Stone]
craft.remake(<tconstruct:materials:18>, ['pretty',
  '□ □ □',
  '□   □',
  '□ □ □'], {
  '□': <ore:blockMossy>, // Moss Stone
});

// Molten Spectre
scripts.process.melt(<ore:ingotSpectre>, <liquid:spectre> * 144, 'No Exceptions');
mods.tconstruct.Casting.addTableRecipe(<randomthings:ingredient:3>, <tconstruct:cast_custom>, <liquid:spectre>, 144, false);

// [Aethium Armor Trim] from [Mica][+2]
craft.remake(<conarm:armor_trim>.withTag({ Material: 'aethium' }), ['pretty',
  'A I A',
  'L p L',
  'A I A'], {
  'A': <tconstruct:shard>.withTag({ Material: 'aethium' }), // Aethium Shard
  'I': <environmentaltech:interconnect>, // Interconnect
  'L': <ore:crystalLitherite>,
  'p': <environmentaltech:modifier_piezo>,
});

// Lock until endgame to lock mob dropped artifacts
// [Plate of Unsealing] from [Silky Block of Jewel][+2]
craft.remake(<tconevo:material:2>, ['pretty',
  '- ■ -',
  '■ ▀ ■',
  '- ■ -'], {
  '■': <ore:blockCobalt>, // Block of Cobalt
  '▀': <tconstruct:metal:6>, // Silky Block of Jewel
  '-': <ore:ingotUUMatter>, // UU-Metal Ingot
});

// -------------------------------------------------------------------------------

// New liquids
mods.tconstruct.Alloy.addRecipe(<liquid:sunnarium> * 144, [<liquid:liquid_sunshine> * 500, <liquid:flux_goo> * 100, <liquid:mirion> * 72]);
mods.tconstruct.Alloy.addRecipe(<liquid:dark_matter> * 144, [<liquid:neutronium> * 48, <liquid:primal_metal> * 48, <liquid:mana> * 250]);
mods.tconstruct.Alloy.addRecipe(<liquid:red_matter> * 144, [<liquid:supremium> * 432, <liquid:blockfluidantimatter> * 1000, <liquid:dark_matter> * 144]);

// Melt Block of flesh
scripts.process.melt(<ore:blockFlesh>, <liquid:blood> * 360, 'No Exceptions');

// Way cheaper to keep easy roads
craft.remake(<tconstruct:brownstone:1> * 64, ['pretty',
  's ‚ s',
  's s s',
  's D s'], {
  's': <ore:sandstone>,
  '‚': <ore:nuggetFakeIron>,
  'D': <tconstruct:materials:2>,
});

// Simple Seared bricks
furnace.addRecipe(<tconstruct:materials>, <forestry:ash>, 0.5);

// ---------------------------------
// Conversion between block and brick
// ---------------------------------

// [Dried Bricks]*2 from [Dried Brick]
recipes.removeByRecipeName('tconstruct:gadgets/dried/dried_bricks');
craft.make(<tconstruct:dried_clay:1> * 2, ['pretty',
  'D D D',
  'D   D',
  'D D D'], {
  'D': <tconstruct:materials:2>, // Dried Brick
});

// [Dried Clay] from [Dried Brick]
craft.reshapeless(<tconstruct:dried_clay>, 'DDDD', {
  'D': <tconstruct:materials:2>, // Dried Brick
});

// Conversion between block and brick [Dried Brick]*4 from [Dried Clay]
craft.reshapeless(<tconstruct:materials:2> * 4, 'D', {
  'D': <tconstruct:dried_clay>, // Dried Clay
});

// ---------------------------------

// Unefficient Seared stone alt
mods.mechanics.addTubeRecipe([<extrautils2:compressedcobblestone:1>], <liquid:stone> * 1000);
mods.mechanics.addTubeRecipe([<additionalcompression:stone_compressed:1>], <liquid:stone> * 1000);

// Stone sharpening kit alt for repairing automatisation
mods.tconstruct.Casting.addTableRecipe(
  <tconstruct:sharpening_kit>.withTag({ Material: 'stone' }),
  <tconstruct:cast>.withTag({ PartType: 'tconstruct:sharpening_kit' }),
  <liquid:stone>, 144, false
);

// Alt recipe
scripts.mods.forestry.ThermionicFabricator.addCast(<tconstruct:clear_glass> * 16, Grid([
  'ggg', 'g g', 'ggg'], {
  'g': <ore:blockGlass>,
}).shaped(), <liquid:glass> * 6000, <forestry:wax_cast:*>);

// Pigiron high-tech recipe
scripts.process.alloy([
  <ore:blockIron>,
  <ore:blockFlesh>,
  <ore:clay> * 9,
], <ore:blockPigiron>.firstItem, 'only: AdvRockArc');

// ------------------------------------------------------------------------------
// Melting / casting rework
// based on Mixin changes in TConstruct
// ------------------------------------------------------------------------------

// Blood Magic Tcon Integration adds many slate - cast recipes
mods.tconstruct.Casting.removeTableRecipe(<tconstruct:cast_custom:3>);

// Manyullin block alt
scripts.process.alloy([<ore:blockCobalt>, <ore:blockArdite>], <tconstruct:metal:2>, 'only: AdvRockArc');

for castFluid in [
  <fluid:alubrass> * 144,
  <fluid:gold> * 288,
] as ILiquidStack[] {
  // Create casts from basic materials only such as stone
  for id, cost in scripts.mods.tconstruct.vars.partCosts {
    mods.tconstruct.Casting.addTableRecipe(
      <tconstruct:cast>.withTag({ PartType: id }),
      scripts.mods.tconstruct.vars.getSampleToolPart(id),
      castFluid, castFluid.amount, true);
  }

  // ------------
  // Special add cases
  // ------------
  mods.tconstruct.Casting.addTableRecipe(<tconstruct:cast_custom:1>, <minecraft:gold_nugget>, castFluid, castFluid.amount, true);
  
  for plate in [
    <thermalfoundation:material:32>,
    <thermalfoundation:material:33>,
    <thermalfoundation:material:320>,
    <thermalfoundation:material:321>,
  ] as IItemStack[] {
    mods.tconstruct.Casting.addTableRecipe(<tconstruct:cast_custom:3>, plate, castFluid, castFluid.amount, true);
  }
}
// ------------------------------------------------------------------------------

// [Stone Ladder]*3 from [Stone Rod]
craft.remake(<tconstruct:stone_ladder> * 3, ['pretty',
  '/   /',
  '/ / /',
  '/   /'], {
  '/': <ore:stickStone>, // Stone Rod
});
