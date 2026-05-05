#modloaded extrautils2
#ignoreBracketErrors
#priority 1

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math.min;
import extrautilities2.Tweaker.IMachineRegistry.getMachine;

zenClass Gen {
  var gen as extrautilities2.Tweaker.IMachine;
  var rft as int = 400;
  var defaultTime as int = 2400;

  zenConstructor(shortName as string) {
    gen = getMachine("extrautils2:generator_" + shortName);
  }

  function removeInputs(items as IIngredient[]) as Gen {
    for item in items {
      if (isNull(item)) continue;
      gen.removeRecipe({ 'input': item });
    }
    return this;
  }

  function setDefaultRFTandTime(newRft as int, newTime as int) as Gen {
    rft = newRft;
    defaultTime = newTime;
    return this;
  }

  function addRecipes(items as double[IIngredient]) as Gen {
    for item, mult in items {
      if (isNull(item)) continue;
      val totalRF = (mult * defaultTime * rft) as long;
      val cap = 2000000000L;
      val totalRFCapped = min(totalRF, cap);
      val totalRFResidue = totalRF - totalRFCapped;
      val time = defaultTime * (1.0 + totalRFResidue / cap / 100);
      gen.addRecipe({ 'input': item }, {}, totalRFCapped, time);
    }
    return this;
  }

  function add(rft as int, time as int, input as IIngredient) as Gen {
    if (isNull(input)) return this;
    val totalRF = time as long * rft;
    val cap = 2000000000L;
    val totalRFCapped = min(totalRF, cap);
    val totalRFResidue = totalRF - totalRFCapped;
    if (totalRFResidue > 0 && utils.DEBUG) logger.logWarning(
      "Generator recipe for " ~ input.commandString ~
      " exceeds max RF capacity and its time or rf/t values need to be adjusted about " ~ (totalRFResidue as double / cap) ~ " times.");

    val maxRftWithUpgrades = totalRFCapped / time * 64;
    if (maxRftWithUpgrades > cap && utils.DEBUG) logger.logWarning(
      "Generator recipe for " ~ input.commandString ~
      " produce too much RF/t for max upgrades: " ~ maxRftWithUpgrades ~ " RF/t. Consider changing RF/t or time values.");

    gen.addRecipe({ 'input': input }, {}, totalRFCapped, time);
    return this;
  }
}

/*

List of possible generator names:

survival
culinary
potion
tnt
lava
pink
netherstar
ender
redstone
overclock
dragonsbreath
ice
death
enchant
slime

*/

Gen('tnt')
.removeInputs([
  <minecraft:tnt>,
  <minecraft:gunpowder>,
])
//    rf/t, d    h    m    s    t
.add(  200, 3 * 24 * 60 * 60 * 20, <trinity:salted_bomb_u233>)
.add(  200, 3 * 24 * 60 * 60 * 20, <trinity:salted_bomb_u235>)
.add(  200, 3 * 24 * 60 * 60 * 20, <trinity:salted_bomb_np237>)
.add(  200, 3 * 24 * 60 * 60 * 20, <trinity:salted_bomb_pu239>)
.add(  200, 3 * 24 * 60 * 60 * 20, <trinity:salted_bomb_am242>)
.add(  200, 3 * 24 * 60 * 60 * 20, <trinity:salted_bomb_cm247>)
.add(  200, 3 * 24 * 60 * 60 * 20, <trinity:salted_bomb_bk248>)
.add(  200, 3 * 24 * 60 * 60 * 20, <trinity:salted_bomb_cf249>)
.add(  200, 3 * 24 * 60 * 60 * 20, <trinity:salted_bomb_cf251>)
.add(  200, 4 * 24 * 60 * 60 * 20, <trinity:bomb_u233>)
.add(  200, 4 * 24 * 60 * 60 * 20, <trinity:bomb_u235>)
.add(  200, 4 * 24 * 60 * 60 * 20, <trinity:bomb_np237>)
.add(  200, 4 * 24 * 60 * 60 * 20, <trinity:bomb_pu239>)
.add(  200, 4 * 24 * 60 * 60 * 20, <trinity:bomb_am242>)
.add(  200, 4 * 24 * 60 * 60 * 20, <trinity:bomb_cm247>)
.add(  200, 4 * 24 * 60 * 60 * 20, <trinity:bomb_bk248>)
.add(  200, 4 * 24 * 60 * 60 * 20, <trinity:bomb_cf249>)
.add(  200, 4 * 24 * 60 * 60 * 20, <trinity:bomb_cf251>)
.add(  280, 4 * 24 * 60 * 60 * 20, <trinity:bomb_antimatter>)
;

val generator_lava = getMachine("extrautils2:generator_lava");
generator_lava.removeRecipe({ 'input_lava': <liquid:lava> * 50 });
generator_lava.addRecipe({ 'input_lava': <liquid:enrichedlava> * 50 }, {},
  //      rf, d    h    m    s    t
   100000000,          30 * 60 * 20);

val generator_pink = getMachine("extrautils2:generator_pink");
generator_pink.removeRecipe({ 'input': <*> });

Gen('pink')
//    rf/t, d    h    m    s    t
.add( 1600,           1 * 60 * 20, <tconevo:material:1>)
.add( 1600,           5 * 60 * 20, <industrialforegoing:laser_lens:6>)
.add( 1000,           5 * 60 * 20, <twilightforest:castle_rune_brick>)
.add( 1000,           5 * 60 * 20, <twilightforest:castle_door:2>)
.add( 6000,      1 * 60 * 60 * 20, <enderio:item_alloy_endergy_ingot:4>)
.add( 2000,     10 * 60 * 60 * 20, <qmd:discharge_lamp:6>)
;

Gen('netherstar')
.removeInputs([
  <minecraft:nether_star>,
])
.setDefaultRFTandTime(4000, 2400)
.addRecipes({
  <mysticalagradditions:nether_star_essence>: 0.06,
  <extendedcrafting:material:40>: 1.2,
  <mysticalagradditions:special>: 3.0,
  <mysticalagradditions:nether_star_seeds>: 100.0,
} as double[IIngredient]$orderly);

Gen('ender')
.removeInputs([
  <minecraft:ender_pearl>,
  <minecraft:ender_eye>,
  <thermalfoundation:material:895>,
  <thermalfoundation:storage_alloy:7>,
  <thermalfoundation:material:103>,
  <thermalfoundation:material:167>,
  <thermalfoundation:material:231>,
  <forge:bucketfilled>.withTag({Amount:1000, FluidName:"ender"}),
  <forge:bucketfilled>.withTag({Amount:1000, FluidName:"enderium"}),
])
//    rf/t, d    h    m    s    t
.add( 1600,               10 * 20, <extendedcrafting:material:36>)
.add( 3000,           5 * 60 * 20, <endreborn:item_ingot_endorium>)
.add( 4000,      6 * 60 * 60 * 20, <avaritia:endest_pearl>)
.add( 6000,           5 * 60 * 20, <thermalfoundation:material:167>)
.add( 9000,           5 * 60 * 20, <rftools:infused_enderpearl>)
.add(12000,           5 * 60 * 20, <extendedcrafting:material:48>)
.add(12000,           5 * 60 * 20, <thermalfoundation:material:895>)
.add(24000,          10 * 60 * 20, <redstonerepository:material:1>)
;

val generator_redstone = getMachine("extrautils2:generator_redstone");
generator_redstone.removeRecipe({ 'input': <minecraft:redstone>, 'input_lava': <liquid:lava> * 50 });
generator_redstone.addRecipe({ 'input': <actuallyadditions:item_crystal_empowered>, 'input_lava': <liquid:ic2hot_coolant> * 50 }, {},
  //      rf, d    h    m    s    t
   600000000,          30 * 60 * 20);

Gen('dragonsbreath')
.removeInputs([
  <minecraft:dragon_breath>,
])
//    rf/t, d    h    m    s    t
.add(  500, 2 * 24 * 60 * 60 * 20, <minecraft:dragon_breath>)
;

Gen('ice')
.removeInputs([
  <forge:bucketfilled:*>,
  <minecraft:ice>,
  <minecraft:packed_ice>,
  <minecraft:snow_layer>,
  <minecraft:snow>,
  <minecraft:snowball>,
  <thermalfoundation:material:1025>,
  <thermalfoundation:material:2048>,
  <thermalfoundation:material:2049>,
])
//    rf/t, d    h    m    s    t
.add( 1000,     24 * 60 * 60 * 20, <iceandfire:dragonsteel_ice_ingot>)
.add( 2000,           5 * 60 * 20, <twilightforest:ice_bomb>)
.add( 5000,          20 * 60 * 20, <forestry:pollen:1>)
.add( 5000,          30 * 60 * 20, <thermalfoundation:material:1025>)
.add( 8000,      1 * 60 * 60 * 20, <iceandfire:ice_dragon_blood>)
;

Gen('death')
.removeInputs([
  <minecraft:bone>,
  <minecraft:bone_block>,
  <minecraft:rotten_flesh>,
  <minecraft:skull:1>,
])
//    rf/t, d    h    m    s    t
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:wolfhead_1>)
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:wolfhead_2>)
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:wolfhead_3>)
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:wolfhead_4>)
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:wolfhead_5>)
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:wolfhead_6>)
.add( 1500,      7 * 60 * 60 * 20, <betteranimalsplus:coyotehead_1>)
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:foxhead_1>)
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:foxhead_2>)
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:foxhead_3>)
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:foxhead_4>)
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:boarhead_1>)
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:boarhead_2>)
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:boarhead_3>)
.add( 1500,      4 * 60 * 60 * 20, <betteranimalsplus:boarhead_4>)
.add( 1500,          60 * 60 * 20, <iceandfire:dragon_skull>)
.add( 1500,          60 * 60 * 20, <iceandfire:dragon_skull:1>)
.add( 1500,      2 * 60 * 60 * 20, <iceandfire:hippogryph_skull>)
.add( 1500,      5 * 60 * 60 * 20, <iceandfire:cyclops_skull>)
.add( 1000,          30 * 60 * 20, <iceandfire:cockatrice_skull>)
.add(  500,      3 * 60 * 60 * 20, <iceandfire:stymphalian_skull>)
.add( 1000,          60 * 60 * 20, <iceandfire:troll_skull>)
.add( 2250,      6 * 60 * 60 * 20, <iceandfire:amphithere_skull>)
.add( 2000,      7 * 60 * 60 * 20, <iceandfire:seaserpent_skull>)
.add( 2000,      7 * 60 * 60 * 20, <iceandfire:hydra_skull>)
;

val generator_slime = getMachine("extrautils2:generator_slime");
generator_slime.removeRecipe({ 'input': <minecraft:slime_ball> * 4, 'input2': <minecraft:milk_bucket> });
generator_slime.addRecipe({ 'input': <ore:dropGelatinous>, 'input2': <rats:block_of_cheese> }, {},
  //      rf, d    h    m    s    t
   100000000,          40 * 60 * 20);
