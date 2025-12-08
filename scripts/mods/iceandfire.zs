#modloaded iceandfire tconstruct

import crafttweaker.item.IItemStack;

<iceandfire:myrmex_jungle_egg:*>.maxStackSize = 64;
<iceandfire:myrmex_desert_egg:*>.maxStackSize = 64;
<iceandfire:iceandfire.deathworm_egg>.maxStackSize = 64;
<iceandfire:iceandfire.deathworm_egg:1>.maxStackSize = 64;

// Removed items
Purge(<iceandfire:silver_sword>);
Purge(<iceandfire:armor_silver_metal_helmet>);
Purge(<iceandfire:armor_silver_metal_chestplate>);
Purge(<iceandfire:armor_silver_metal_leggings>);
Purge(<iceandfire:armor_silver_metal_boots>);

// *======= Recipes =======*

// Remove too powerful aspects
<iceandfire:podium>.removeAspects(<aspect:desiderium>);
<iceandfire:podium:1>.removeAspects(<aspect:desiderium>);
<iceandfire:podium:2>.removeAspects(<aspect:desiderium>);
<iceandfire:podium:3>.removeAspects(<aspect:desiderium>);
<iceandfire:podium:4>.removeAspects(<aspect:desiderium>);
<iceandfire:podium:5>.removeAspects(<aspect:desiderium>);

// Disk Platter / Iron Chain Link
craft.remake(<iceandfire:chain_link> * 2, ['AAA', 'A A', 'AAA'], {
  A: <ore:nuggetIron>,
});

// Cockatrice Scepter
recipes.addShaped('Cockatrice Scepter',
  <iceandfire:cockatrice_scepter>,
  [[<ore:boneWither>],
    [<iceandfire:cockatrice_eye>],
    [<ore:boneWither>]]);

// Bone Conversion
recipes.addShapeless('Dragon Bone Conversion', <minecraft:bone> * 9, [<iceandfire:dragonbone>]);

// Dragon Heart -> Draconic Dragon Heart
recipes.addShapeless('Dragon Heart Conversion1',
  <draconicevolution:dragon_heart>,
  [<iceandfire:ice_dragon_heart>]);

recipes.addShapeless('Dragon Heart Conversion2',
  <draconicevolution:dragon_heart>,
  [<iceandfire:fire_dragon_heart>]);

// Witherbone conversion
recipes.addShapeless('Witherbone Conversion1',
  <tconstruct:materials:17>,
  [<iceandfire:witherbone>]);

recipes.addShapeless('Witherbone Conversion2',
  <iceandfire:witherbone>,
  [<tconstruct:materials:17>]);

// Wither Shard remake to prevent conflict
recipes.remove(<iceandfire:wither_shard>);
recipes.addShapeless('Witherbone shard',
  <iceandfire:wither_shard> * 3,
  [<ore:boneWither>, scripts.category.plates_and_casings.anyHammer]);

// Remove existing Ash -> Charcoal recipe (Credit TheShadoWZYE)
recipes.removeShaped(<minecraft:coal:1>,
  [[<iceandfire:ash>, <iceandfire:ash>, <iceandfire:ash>],
    [<iceandfire:ash>, <iceandfire:ash>, <iceandfire:ash>],
    [<iceandfire:ash>, <iceandfire:ash>, <iceandfire:ash>]]);
// Ash -> Coal Coke
recipes.addShaped('Ash To Coal Coke',
  <immersiveengineering:stone_decoration:3>,
  [[<iceandfire:ash>, <iceandfire:ash>, <iceandfire:ash>],
    [<iceandfire:ash>, <iceandfire:ash>, <iceandfire:ash>],
    [<iceandfire:ash>, <iceandfire:ash>, <iceandfire:ash>]]);

Purge(<iceandfire:sapphire_ore>).ores([<ore:oreSapphire>]).furn();
Purge(<iceandfire:sapphire_block>).ores([<ore:blockSapphire>]).furn();
Purge(<iceandfire:sapphire_gem>).ores([<ore:gemSapphire>]).furn();
Purge(<iceandfire:silver_ore>).furn();
Purge(<iceandfire:silver_block>).ores([<ore:blockSilver>]).furn();
Purge(<iceandfire:silver_nugget>).furn();

// Dragons Breath from Dragon Forges
mods.iceandfire.recipes.addFireDragonForgeRecipe(<integrateddynamics:crystalized_chorus_chunk>, <botania:manaresource:15>, <minecraft:dragon_breath>);
mods.iceandfire.recipes.addIceDragonForgeRecipe(<integrateddynamics:crystalized_chorus_chunk>, <botania:manaresource:15>, <minecraft:dragon_breath>);

// ######################################################################
//
// Oredict
//
// ######################################################################

// Ore dragonsteel ingot
<ore:dragonsteelIngot>.add([
  <iceandfire:dragonsteel_fire_ingot>,
  <iceandfire:dragonsteel_ice_ingot>]);

<ore:blockDragonsteel>.add([
  <iceandfire:dragonsteel_fire_block>,
  <iceandfire:dragonsteel_ice_block>]);

// Ore
<ore:chitinMyrmex>.add([
  <iceandfire:myrmex_desert_chitin>,
  <iceandfire:myrmex_jungle_chitin>]);

// Ore Dragon scales blocks
<ore:dragonscaleBlock>.add([
  <iceandfire:dragonscale_blue>,
  <iceandfire:dragonscale_bronze>,
  <iceandfire:dragonscale_gray>,
  <iceandfire:dragonscale_green>,
  <iceandfire:dragonscale_red>,
  <iceandfire:dragonscale_sapphire>,
  <iceandfire:dragonscale_silver>,
  <iceandfire:dragonscale_white>,
]);

// Ore dragonscales
<ore:dragonscales>.add([
  <iceandfire:dragonscales_red>,
  <iceandfire:dragonscales_green>,
  <iceandfire:dragonscales_bronze>,
  <iceandfire:dragonscales_gray>,
  <iceandfire:dragonscales_blue>,
  <iceandfire:dragonscales_white>,
  <iceandfire:dragonscales_sapphire>,
  <iceandfire:dragonscales_silver>,
]);

<ore:dragonFireScales>.add([
  <iceandfire:dragonscales_red>,
  <iceandfire:dragonscales_green>,
  <iceandfire:dragonscales_bronze>,
  <iceandfire:dragonscales_gray>,
]);

<ore:dragonIceScales>.add([
  <iceandfire:dragonscales_blue>,
  <iceandfire:dragonscales_white>,
  <iceandfire:dragonscales_sapphire>,
  <iceandfire:dragonscales_silver>,
]);

// Ore Myrmex Glass
<ore:myrmexResinGlass>.add([
  <iceandfire:myrmex_desert_resin_glass>,
  <iceandfire:myrmex_jungle_resin_glass>,
]);

// Ore Deathworm Chitin
<ore:deathwormChitin>.add([
  <iceandfire:deathworm_chitin:1>,
  <iceandfire:deathworm_chitin:2>,
  <iceandfire:deathworm_chitin>,
]);

// Ore Sea Serpent Scale Block
<ore:seaSerpentScaleBlock>.add([
  <iceandfire:sea_serpent_scale_block_blue>,
  <iceandfire:sea_serpent_scale_block_bronze>,
  <iceandfire:sea_serpent_scale_block_deepblue>,
  <iceandfire:sea_serpent_scale_block_green>,
  <iceandfire:sea_serpent_scale_block_purple>,
  <iceandfire:sea_serpent_scale_block_red>,
  <iceandfire:sea_serpent_scale_block_teal>,
]);

// Ore Sea Serpent Scale
<ore:seaSerpentScaleBlock>.add([
  <iceandfire:sea_serpent_scale_block_blue>,
  <iceandfire:sea_serpent_scale_block_bronze>,
  <iceandfire:sea_serpent_scale_block_deepblue>,
  <iceandfire:sea_serpent_scale_block_green>,
  <iceandfire:sea_serpent_scale_block_purple>,
  <iceandfire:sea_serpent_scale_block_red>,
  <iceandfire:sea_serpent_scale_block_teal>,
]);

// Ore Sea Serpent Scales
<ore:dragonscales>.add([
  <iceandfire:sea_serpent_scales_blue>,
  <iceandfire:sea_serpent_scales_bronze>,
  <iceandfire:sea_serpent_scales_deepblue>,
  <iceandfire:sea_serpent_scales_green>,
  <iceandfire:sea_serpent_scales_purple>,
  <iceandfire:sea_serpent_scales_red>,
  <iceandfire:sea_serpent_scales_teal>,
]);

<ore:iceandfireLily>.add([
  <iceandfire:fire_lily>,
  <iceandfire:frost_lily>,
]);
<ore:myrmexResin>.add([
  <iceandfire:myrmex_desert_resin>,
  <iceandfire:myrmex_jungle_resin>,
]);

// ######################################################################
//
// Crafts
//
// ######################################################################

// Compressed ice variant
utils.compact(<mctsmelteryio:iceball> ?? <iceandfire:dragon_ice>, <iceandfire:dragon_ice>);

// Simplify bricks for less grind
remakeEx(<iceandfire:dragonforge_fire_brick> * 2, [
  [<ore:dragonFireScales>, <ore:bricksStone>, <ore:dragonFireScales>],
  [<ore:bricksStone>, <ore:dragonFireScales>, <ore:bricksStone>],
  [<ore:dragonFireScales>, <ore:bricksStone>, <ore:dragonFireScales>]]);

remakeEx(<iceandfire:dragonforge_ice_brick> * 2, [
  [<ore:dragonIceScales>, <ore:bricksStone>, <ore:dragonIceScales>],
  [<ore:bricksStone>, <ore:dragonIceScales>, <ore:bricksStone>],
  [<ore:dragonIceScales>, <ore:bricksStone>, <ore:dragonIceScales>]]);

// Dragon meal
recipes.remove(<iceandfire:dragon_meal>);
mods.inworldcrafting.FluidToItem.transform(<iceandfire:dragon_meal> * 4, <fluid:blood>, [
  <harvestcraft:groundporkitem> * 4,
  <harvestcraft:groundrabbititem> * 4,
  <harvestcraft:groundfishitem> * 4,
], true);
mods.inworldcrafting.FluidToItem.transform(<iceandfire:dragon_meal> * 8, <fluid:blood>, [
  <harvestcraft:groundvenisonitem>,
  <harvestcraft:groundturkeyitem>,
  <harvestcraft:groundduckitem>,
], true);

// Remove craft table dragon recipes
recipes.remove(<iceandfire:dragonforge_fire_core_disabled>);
recipes.remove(<iceandfire:dragonforge_ice_core_disabled>);

// Spring water recipe
mods.iceandfire.recipes.addIceDragonForgeRecipe(
  <biomesoplenty:jar_filled:1>,
  <minecraft:water_bucket>,
  Bucket('hot_spring_water'));

// Remove craft from shards
recipes.remove(<scalinghealth:heartcontainer>);

// Heart container recipe
mods.iceandfire.recipes.addFireDragonForgeRecipe(
  <cyclicmagic:heart_toxic>,
  Bucket('lifeessence'),
  <scalinghealth:heartcontainer>);
mods.iceandfire.recipes.addIceDragonForgeRecipe(
  <cyclicmagic:heart_toxic>,
  Bucket('lifeessence'),
  <scalinghealth:heartcontainer>);

// Alt for non-dragon players
mods.advancedrocketry.RecipeTweaker.forMachine('Crystallizer').builder()
  .input(<cyclicmagic:heart_toxic>)
  .inputLiquid(<fluid:lifeessence> * 1000)
  .outputItem(<scalinghealth:heartcontainer>)
  .power(100000)
  .timeRequired(20)
  .build();

// [Fire Dragonsteel Ingot] from [Fire Dragon Blood][+1]
scripts.process.alloy([
  <ore:ingotThermoconducting>,    // Thermoconducting Alloy
  <iceandfire:fire_dragon_blood>, // Fire Dragon Blood
], <iceandfire:dragonsteel_fire_ingot>, 'Only: AdvRockArc');

// [Ice Dragonsteel Ingot] from [Ice Dragon Blood][+1]
scripts.process.alloy([
  <ore:ingotThermoconducting>,   // Thermoconducting Alloy
  <iceandfire:ice_dragon_blood>, // Ice Dragon Blood
], <iceandfire:dragonsteel_ice_ingot>, 'Only: AdvRockArc');

// Lily crafts
mods.inworldcrafting.FluidToItem.transform(<iceandfire:fire_lily>, <liquid:pyrotheum>, [<extrautils2:enderlilly>]);
mods.inworldcrafting.FluidToItem.transform(<iceandfire:frost_lily>, <liquid:cryotheum>, [<extrautils2:enderlilly>]);

recipes.addShapeless(<iceandfire:dragonforge_ice_core_disabled>, [<iceandfire:dragonforge_ice_core>]);
recipes.addShapeless(<iceandfire:dragonforge_fire_core_disabled>, [<iceandfire:dragonforge_fire_core>]);

// Make resin blocks 3x3 instead of 2x2
recipes.remove(<iceandfire:myrmex_desert_resin_block>);
recipes.remove(<iceandfire:myrmex_jungle_resin_block>);
utils.compact(<iceandfire:myrmex_desert_resin>, <iceandfire:myrmex_desert_resin_block>);
utils.compact(<iceandfire:myrmex_jungle_resin>, <iceandfire:myrmex_jungle_resin_block>);

// Make Myrmex Glass as x81 of resin (double compresseed)
furnace.remove(<iceandfire:myrmex_desert_resin_glass>);
furnace.remove(<iceandfire:myrmex_jungle_resin_glass>);
utils.compact(<iceandfire:myrmex_desert_resin_block>, <iceandfire:myrmex_desert_resin_glass>);
utils.compact(<iceandfire:myrmex_jungle_resin_block>, <iceandfire:myrmex_jungle_resin_glass>);

// Recycling myrmex resin
function addResinRecycle(input as IItemStack, amount as int, isDesert as bool) as void {
  val output = (isDesert ? <iceandfire:myrmex_desert_resin> : <iceandfire:myrmex_jungle_resin>) % (2 * amount);
  mods.thermalexpansion.Centrifuge.addRecipe([output], input, <liquid:resin> * (120 * amount), 2000);
  mods.forestry.Squeezer.addRecipe(<liquid:resin> * (100 * amount), [input], 10, output);
}
addResinRecycle(<iceandfire:myrmex_resin>         , 1, true);
addResinRecycle(<iceandfire:myrmex_resin:1>       , 1, false);
addResinRecycle(<iceandfire:myrmex_resin_sticky>  , 2, true);
addResinRecycle(<iceandfire:myrmex_resin_sticky:1>, 2, false);
addResinRecycle(<iceandfire:desert_myrmex_cocoon> , 8, true);
addResinRecycle(<iceandfire:jungle_myrmex_cocoon> , 8, false);

// StackSize was 1
<iceandfire:ambrosia>.maxStackSize = 64;

// Add recipe because snow villages is disabled
// [Fishing Spear] from [Steel Arrow Head][+2]
craft.remake(<iceandfire:fishing_spear>, ['pretty',
  'S    ',
  '  M  ',
  '    M'], {
  'S': <tconstruct:arrow_head>.withTag({ Material: 'steel' }), // Steel Arrow Head
  'M': <extrautils2:decorativesolidwood>, // Magical Planks
});
craft.make(<iceandfire:fishing_spear>, ['pretty',
  'S    ',
  '  M  ',
  '    M'], {
  'S': <tconstruct:knife_blade>.withTag({ Material: 'steel' }), // Steel Arrow Head
  'M': <extrautils2:decorativesolidwood>, // Magical Planks
});

// Add obtaining
// [Dreadwood Log]*8 from [Dread Shard][+1]
craft.make(<iceandfire:dreadwood_log> * 8, ['pretty',
  '# # #',
  '# D #',
  '# # #'], {
  '#': <randomthings:spectrelog>, // Spectre Wood
  'D': <iceandfire:dread_shard>,  // Dread Shard
});

// Alternative instead using machines
mods.iceandfire.recipes.addFireDragonForgeRecipe(<ore:ingotPigiron>.firstItem, <darkutils:material>, <extrautils2:ingredients:17>);
mods.iceandfire.recipes.addIceDragonForgeRecipe(<ore:ingotPigiron>.firstItem, <darkutils:material>, <extrautils2:ingredients:17>);
mods.iceandfire.recipes.addFireDragonForgeRecipe(<ore:blockPigiron>.firstItem, <darkutils:wither_block>, <extrautils2:simpledecorative:2>);
mods.iceandfire.recipes.addIceDragonForgeRecipe(<ore:blockPigiron>.firstItem, <darkutils:wither_block>, <extrautils2:simpledecorative:2>);

// Skyblock alt for dragon scales
scripts.lib.tooltip.desc.both(<mysticalagradditions:stuff:3>, 'kill.slime.by.cockatrice');
scripts.do.entity_kill_entity.add('minecraft:slime', 'iceandfire:if_cockatrice', <mysticalagradditions:stuff:3>);

// Dragon Scales
val listConversionScales as IItemStack[] = [
  <ic2:plate:10>,  <iceandfire:dragonscales_red>, <iceandfire:dragonscale_red>,
  <ic2:plate:14>,  <iceandfire:dragonscales_green>, <iceandfire:dragonscale_green>,
  <ic2:plate:9>,   <iceandfire:dragonscales_bronze>,  <iceandfire:dragonscale_bronze>,
  <ic2:plate:15>,  <iceandfire:dragonscales_gray>, <iceandfire:dragonscale_gray>,
  <ic2:plate:16>,  <iceandfire:dragonscales_blue>, <iceandfire:dragonscale_blue>,
  <ic2:plate:17>,  <iceandfire:dragonscales_white>, <iceandfire:dragonscale_white>,
  <ic2:plate:13>,  <iceandfire:dragonscales_sapphire>, <iceandfire:dragonscale_sapphire>,
  <ic2:plate:12>,  <iceandfire:dragonscales_silver>, <iceandfire:dragonscale_silver>,
];

for i, input in listConversionScales {
  if (i % 3 != 0) continue;

  // Plate -> Scale
  val output = listConversionScales[i + 1];
  mods.rats.recipes.addArcheologistRatRecipe(input, output);

  // Scale Block -> Plate
  val block = listConversionScales[i + 2];
  mods.rats.recipes.addArcheologistRatRecipe(block, input);

  // [Dragon Scales] from [Dragon Scale]
  recipes.addShapeless(output, [<mysticalagradditions:stuff:3>, input]);
}

// Peaceful Skyblock alt
// [Fire Dragon Blood]*8 from [Imbued Slate][+1]
craft.shapeless(<iceandfire:fire_dragon_blood> * 8, 'BBBBIBBBB', {
  'B': <rustic:fluid_bottle>.withTag({ Fluid: { FluidName: 'wine', Amount: 1000, Tag: { Quality: 1.0 as float } } }).noReturn(), // Bottle of Wine
  'I': <bloodmagic:slate:2>, // Imbued Slate
});

// [Ice Dragon Blood]*8 from [Imbued Slate][+1]
craft.shapeless(<iceandfire:ice_dragon_blood> * 8, 'BBBBIBBBB', {
  'B': <rustic:fluid_bottle>.withTag({ Fluid: { FluidName: 'ale', Amount: 1000, Tag: { Quality: 1.0 as float } } }).noReturn(), // Bottle of Ale
  'I': <bloodmagic:slate:2>, // Imbued Slate
});

recipes.addShapeless('Heart Fire', <iceandfire:fire_dragon_heart>, [<cyclicmagic:heart_toxic>, <iceandfire:fire_dragon_blood>]);
recipes.addShapeless('Heart Ice', <iceandfire:ice_dragon_heart>, [<cyclicmagic:heart_toxic>, <iceandfire:ice_dragon_blood>]);

// Recycle Fangs
scripts.process.squeeze(
  [<iceandfire:hydra_fang>],
  <fluid:potion>.withTag({ Potion: 'cofhcore:poison4' }) * 150,
  'only: Squeezer IndustrialSqueezer'
);

// Vegan challenge alt
mods.roidtweaker.randomthings.Imbuing.addRecipe(
  <iceandfire:hydra_fang>,
  <iceandfire:dragonbone>,
  [<biomesoplenty:plant_0:4>,
  <minecraft:poisonous_potato>,
  <biomesoplenty:bramble_plant>,
]);

// ######################################################################
//
// Dragon armor recycling
//
// ######################################################################
// * Since its disabled in MIA configs

// Iron
mods.tconstruct.Melting.addRecipe(<fluid:iron> * (22 * 144), <iceandfire:dragonarmor_iron>);
mods.tconstruct.Melting.addRecipe(<fluid:iron> * (22 * 144), <iceandfire:dragonarmor_iron:1>);
mods.tconstruct.Melting.addRecipe(<fluid:iron> * (36 * 144), <iceandfire:dragonarmor_iron:2>);
mods.tconstruct.Melting.addRecipe(<fluid:iron> * (13 * 144), <iceandfire:dragonarmor_iron:3>);
// Gold
mods.tconstruct.Melting.addRecipe(<fluid:gold> * (22 * 144), <iceandfire:dragonarmor_gold>);
mods.tconstruct.Melting.addRecipe(<fluid:gold> * (22 * 144), <iceandfire:dragonarmor_gold:1>);
mods.tconstruct.Melting.addRecipe(<fluid:gold> * (36 * 144), <iceandfire:dragonarmor_gold:2>);
mods.tconstruct.Melting.addRecipe(<fluid:gold> * (13 * 144), <iceandfire:dragonarmor_gold:3>);
// Diamond
mods.thermalexpansion.Pulverizer.addRecipe(<minecraft:diamond> * 22, <iceandfire:dragonarmor_diamond>, 30000);
mods.thermalexpansion.Pulverizer.addRecipe(<minecraft:diamond> * 22, <iceandfire:dragonarmor_diamond:1>, 30000);
mods.thermalexpansion.Pulverizer.addRecipe(<minecraft:diamond> * 36, <iceandfire:dragonarmor_diamond:2>, 30000);
mods.thermalexpansion.Pulverizer.addRecipe(<minecraft:diamond> * 13, <iceandfire:dragonarmor_diamond:3>, 30000);
// Silver
mods.tconstruct.Melting.addRecipe(<fluid:silver> * (22 * 144), <iceandfire:dragonarmor_silver>);
mods.tconstruct.Melting.addRecipe(<fluid:silver> * (22 * 144), <iceandfire:dragonarmor_silver:1>);
mods.tconstruct.Melting.addRecipe(<fluid:silver> * (36 * 144), <iceandfire:dragonarmor_silver:2>);
mods.tconstruct.Melting.addRecipe(<fluid:silver> * (13 * 144), <iceandfire:dragonarmor_silver:3>);
// Fire Dragonsteel
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_fire> * (22 * 144), <iceandfire:dragonarmor_dragonsteel_fire>);
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_fire> * (22 * 144), <iceandfire:dragonarmor_dragonsteel_fire:1>);
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_fire> * (36 * 144), <iceandfire:dragonarmor_dragonsteel_fire:2>);
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_fire> * (13 * 144), <iceandfire:dragonarmor_dragonsteel_fire:3>);
// Ice Dragonsteel
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_ice> * (22 * 144), <iceandfire:dragonarmor_dragonsteel_ice>);
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_ice> * (22 * 144), <iceandfire:dragonarmor_dragonsteel_ice:1>);
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_ice> * (36 * 144), <iceandfire:dragonarmor_dragonsteel_ice:2>);
mods.tconstruct.Melting.addRecipe(<fluid:dragonsteel_ice> * (13 * 144), <iceandfire:dragonarmor_dragonsteel_ice:3>);
