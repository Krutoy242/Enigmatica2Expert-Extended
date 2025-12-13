/*

Magical steam processing

Increase density of the steam by "enriching" it
with magical components.

This reduce size of the required turbine and
increase power output.

Author: 825_Jaded_Vector

*/

#modloaded astralsorcery botania thaumcraft immersiveengineering nuclearcraft

//  ██████╗ █████╗ ████████╗██╗  ██╗   ██╗███████╗████████╗     ██████╗██████╗ ███████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
// ██╔════╝██╔══██╗╚══██╔══╝██║  ╚██╗ ██╔╝██╔════╝╚══██╔══╝    ██╔════╝██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
// ██║     ███████║   ██║   ██║   ╚████╔╝ ███████╗   ██║       ██║     ██████╔╝█████╗  ███████║   ██║   ██║██║   ██║██╔██╗ ██║
// ██║     ██╔══██║   ██║   ██║    ╚██╔╝  ╚════██║   ██║       ██║     ██╔══██╗██╔══╝  ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
// ╚██████╗██║  ██║   ██║   ███████╗██║   ███████║   ██║       ╚██████╗██║  ██║███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
//  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝   ╚══════╝   ╚═╝        ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

// Grade 1 (astral)
scripts.process.alloy([<astralsorcery:itemusabledust:1> * 2, <astralsorcery:itemcraftingcomponent:2>],
  <contenttweaker:naquadah_resevoir_grade_1>.withDamage(
    0.9 * <contenttweaker:naquadah_resevoir_grade_1>.maxDamage
  ), 'only: ArcFurnace AdvRockArc');

// full durability recipe (add celestial crystal to cost)
mods.astralsorcery.Altar.addConstellationAltarRecipe('resevoir grade 1 full',
  <contenttweaker:naquadah_resevoir_grade_1>, 600, 300, [
    null, null, null,
    null, <astralsorcery:itemcelestialcrystal>, null,
    null, null, null,
    null, null, null, null,
    <astralsorcery:itemusabledust:1>, null,
    null, <astralsorcery:itemusabledust:1>,
    <astralsorcery:itemusabledust:1>, null,
    null, <astralsorcery:itemusabledust:1>]);

// extract catalyst from resevoir
recipes.addShapeless(<contenttweaker:naquadah_catalyst_grade_1>, [
  <contenttweaker:naquadah_resevoir_grade_1>.anyDamage().transformDamage(1),
]);

// Grade 2 (botania)
mods.botania.RuneAltar.addRecipe(
  <contenttweaker:naquadah_resevoir_grade_2>.withDamage(0.9 * <contenttweaker:naquadah_resevoir_grade_2>.maxDamage),
  [<botania:corporeaspark>, <botania:manaresource:23>, <botania:manaresource:23>], 20000);
// full durability recipe (add rune to cost)
mods.botania.RuneAltar.addRecipe(<contenttweaker:naquadah_resevoir_grade_2>,
  [<botania:corporeaspark>, <botania:manaresource:23>, <botania:rune:11>, <botania:manaresource:23>], 25000);

// extract catalyst from resevoir
recipes.addShapeless(<contenttweaker:naquadah_catalyst_grade_2>, [
  <contenttweaker:naquadah_resevoir_grade_2>.anyDamage().transformDamage(1),
]);

// Grade 3 (alchemic)
// mods.bloodmagic.AlchemyTable.addRecipe(IItemStack output, IItemStack[] inputs, int syphon, int ticks, int minTier);
mods.bloodmagic.AlchemyTable.addRecipe(<contenttweaker:naquadah_resevoir_grade_3>.withDamage(
  0.9 * <contenttweaker:naquadah_resevoir_grade_3>.maxDamage), [
  <bloodmagic:component:14>,
  <bloodmagic:blood_shard>,
  <minecraft:rabbit_hide>,
], 10000, 60, 4);

// full durability recipe (add weird mob bits to cost)
mods.bloodmagic.AlchemyTable.addRecipe(<contenttweaker:naquadah_resevoir_grade_3>, [
  <bloodmagic:component:14>,
  <bloodmagic:blood_shard>,
  <twilightforest:carminite>,
  <iceandfire:amphithere_feather>,
], 20000, 60, 4);

// extract catalyst from resevoir
recipes.addShapeless(<contenttweaker:naquadah_catalyst_grade_3>, [
  <contenttweaker:naquadah_resevoir_grade_3>.anyDamage().transformDamage(1),
]);

// Grade 4 (alchemic)
mods.thaumcraft.Infusion.registerRecipe('naquadah_resevoir_grade_4_Damaged', 'INFUSION',
  <contenttweaker:naquadah_resevoir_grade_4>.withDamage( // output
    0.9 * <contenttweaker:naquadah_resevoir_grade_4>.maxDamage
  ),
  12, // instability
  Aspects('200💪 30🧠 20🔮'),
  <thaumicaugmentation:material:5>, // cental item
  Grid(['MS'], {
    'M': <thaumcraft:mind:1>,
    'S': <thaumcraft:sanity_soap>,
  }).spiral(1));

// full durability recipe (add ichor to cost)
mods.thaumcraft.Infusion.registerRecipe('naquadah_resevoir_grade_4', 'INFUSION',
  <contenttweaker:naquadah_resevoir_grade_4>, // output
  15, // instability
  Aspects('200💪 30🧠 20👻'),
  <thaumicaugmentation:material:5>, // cental item
  Grid(['MSI'], {
    'M': <thaumcraft:mind:1>,
    'S': <thaumcraft:sanity_soap>,
    'I': <thaumictinkerer:kamiresource:2>,
  }).spiral(1));

// extract catalyst from resevoir
recipes.addShapeless(<contenttweaker:naquadah_catalyst_grade_4>, [
  <contenttweaker:naquadah_resevoir_grade_4>.anyDamage().transformDamage(1),
]);

// Grade5 (ultimate)

mods.astralsorcery.Altar.addTraitAltarRecipe('reservoir_grade_5', <contenttweaker:naquadah_resevoir_grade_5>, 4500, 4000, [
  <contenttweaker:naquadah_resevoir_grade_1>, <thaumictinkerer:proto_clay>, <contenttweaker:naquadah_resevoir_grade_2>,
  <thaumictinkerer:proto_clay>, <rats:idol_of_ratlantis>, <thaumictinkerer:proto_clay>,
  <contenttweaker:naquadah_resevoir_grade_3>, <thaumictinkerer:proto_clay>, <contenttweaker:naquadah_resevoir_grade_4>,
  <animus:component:2>, <animus:component:2>, <animus:component:2>, <animus:component:2>, // outer corners
  <astralsorcery:itemusabledust:1>, <astralsorcery:itemcraftingcomponent:4>, // outer ring top to bottom
  <astralsorcery:itemcraftingcomponent:4>, <astralsorcery:itemusabledust:1>,
  <astralsorcery:itemusabledust:1>, <astralsorcery:itemcraftingcomponent:4>,
  <astralsorcery:itemcraftingcomponent:4>, <astralsorcery:itemusabledust:1>,
  null, null, null, null, // outer ring centers
  // Outer Items, indices 25+
  <botania:rune:11>, <botania:rune:12>,
  <botania:rune:11>, <botania:rune:12>,
], 'astralsorcery.constellation.octans');

// extract catalyst from resevoir
recipes.addShapeless(<contenttweaker:naquadah_catalyst_grade_5>, [
  <contenttweaker:naquadah_resevoir_grade_5>.reuse(),
]);

//  ██████╗ █████╗ ████████╗ █████╗ ██╗  ██╗   ██╗███████╗████████╗    ██████╗ ███████╗ ██████╗██╗  ██╗ █████╗ ██████╗  ██████╗ ███████╗
// ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██║  ╚██╗ ██╔╝██╔════╝╚══██╔══╝    ██╔══██╗██╔════╝██╔════╝██║  ██║██╔══██╗██╔══██╗██╔════╝ ██╔════╝
// ██║     ███████║   ██║   ███████║██║   ╚████╔╝ ███████╗   ██║       ██████╔╝█████╗  ██║     ███████║███████║██████╔╝██║  ███╗█████╗
// ██║     ██╔══██║   ██║   ██╔══██║██║    ╚██╔╝  ╚════██║   ██║       ██╔══██╗██╔══╝  ██║     ██╔══██║██╔══██║██╔══██╗██║   ██║██╔══╝
// ╚██████╗██║  ██║   ██║   ██║  ██║███████╗██║   ███████║   ██║       ██║  ██║███████╗╚██████╗██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗
//  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝   ╚══════╝   ╚═╝       ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝

/* function addDura (input as IItemStack, amount as int) as IItemStack {
      var output = input.transformDamage(Math.clamp(input.getMaxDamage() - (input.getDamage() - amount), 0, input.getMaxDamage()));
      return output;
} */

// recipes for catalysts repair
// toDo

// ███████╗████████╗███████╗ █████╗ ███╗   ███╗     ██████╗██████╗ ███████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
// ██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║    ██╔════╝██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
// ███████╗   ██║   █████╗  ███████║██╔████╔██║    ██║     ██████╔╝█████╗  ███████║   ██║   ██║██║   ██║██╔██╗ ██║
// ╚════██║   ██║   ██╔══╝  ██╔══██║██║╚██╔╝██║    ██║     ██╔══██╗██╔══╝  ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
// ███████║   ██║   ███████╗██║  ██║██║ ╚═╝ ██║    ╚██████╗██║  ██║███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
// ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝     ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

// Nuclearcraft steam = 2:1 compression, IC2 steam = 6:1 compression, Forge steam = 24:1 compression
// conversion ratio worsens by n^2 for each tier skipped
// crafting speed/costs buffed to support potential of extreme throughput demands of endgame seteps
function steamMixers(grade as int) as void {
  val gradeUp = grade + 1;
  val steamLiquid  = <fluid:magic_steam_grade_${grade}>;
  val steamLiquidUp  = <fluid:magic_steam_grade_${gradeUp}>;
  val cataIn = <item:contenttweaker:naquadah_catalyst_grade_${grade}>;
  val cataUp  = <item:contenttweaker:naquadah_catalyst_grade_${gradeUp}>;
  var steamOutNuc  = 1000 / (grade * grade);
  var steamOutIC2  = 500 / (grade * grade);
  var steamOutForge  = 125 / (grade * grade);

  // ====================
  // Conflux 1
  // ====================

  // IE mixer recipes
  mods.immersiveengineering.Mixer.addRecipe(steamLiquid * steamOutNuc, /* output */ <fluid:high_pressure_steam> * 2000, /* input */ [cataIn], 128);
  mods.immersiveengineering.Mixer.addRecipe(steamLiquid * steamOutIC2, <fluid:ic2superheated_steam> * 2000, [cataIn], 128);
  mods.immersiveengineering.Mixer.addRecipe(steamLiquid * steamOutForge, <fluid:steam> * 2000, [cataIn], 128);
  mods.immersiveengineering.Mixer.addRecipe(steamLiquidUp * 1000, steamLiquid * 2000, [cataUp], 128);

  // IC2 canner recipes
  mods.ic2.Canner.addEnrichRecipe(steamLiquid * steamOutNuc, /* output */ <fluid:high_pressure_steam> * 2000, /* input */cataIn);
  mods.ic2.Canner.addEnrichRecipe(steamLiquid * steamOutIC2, <fluid:ic2superheated_steam> * 2000, cataIn);
  mods.ic2.Canner.addEnrichRecipe(steamLiquid * steamOutForge, <fluid:steam> * 2000, cataIn);
  mods.ic2.Canner.addEnrichRecipe(steamLiquidUp * 1000, steamLiquid * 2000, cataUp);

  // ====================
  // Conflux 2 (2x steam per operation)
  // ====================

  steamOutNuc *= 2;
  steamOutIC2 *= 2;
  steamOutForge *= 2;

  // nuclearcraft enricher recipes
  mods.nuclearcraft.Enricher.addRecipe(cataIn, <fluid:high_pressure_steam> * 4000, /* input */ steamLiquid * steamOutNuc, /* output */ 0.5, 0.1, 0.0);
  mods.nuclearcraft.Enricher.addRecipe(cataIn, <fluid:ic2superheated_steam> * 4000, steamLiquid * steamOutIC2, 0.5, 0.1, 0.0);
  mods.nuclearcraft.Enricher.addRecipe(cataIn, <fluid:steam> * 4000, steamLiquid * steamOutForge, 0.5, 0.1, 0.0);
  mods.nuclearcraft.Enricher.addRecipe(cataUp, steamLiquid * 4000, steamLiquidUp * 2000, 0.5, 0.1, 0.0);

  // ====================
  // Conflux 3 (4x steam per operation)
  // ====================

  steamOutNuc *= 2;
  steamOutIC2 *= 2;
  steamOutForge *= 2;

  // EIO vat recipes
  // vat efficiency mult is brain-hurty.
  // var vatEff = 1;
  // maybe later.

  // ====================
  // Conflux 4 (32x steam per operation)
  // ====================

  steamOutNuc *= 4;
  steamOutIC2 *= 4;
  steamOutForge *= 4;

  // Adv rocketry chem reactor recipes
  val chemReactor = mods.advancedrocketry.RecipeTweaker.forMachine('ChemicalReactor');

  chemReactor.builder().power(30000).timeRequired(2)
  .inputs(<fluid:high_pressure_steam> * 32000, cataIn)
  .outputs(steamLiquid * steamOutNuc).build();

  chemReactor.builder().power(30000).timeRequired(2)
  .inputs(<fluid:ic2superheated_steam> * 32000, cataIn)
  .outputs(steamLiquid * steamOutIC2).build();

  chemReactor.builder().power(30000).timeRequired(2)
  .inputs(<fluid:steam> * 32000, cataIn)
  .outputs(steamLiquid * steamOutForge).build();

  chemReactor.builder().power(30000).timeRequired(2)
  .inputs(steamLiquid * 32000, cataUp)
  .outputs(steamLiquidUp * 16000).build();
}

for i in 1 .. 5 {
  steamMixers(i);
}

// ███████╗████████╗███████╗ █████╗ ███╗   ███╗    ██╗   ██╗███████╗███████╗███████╗
// ██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║    ██║   ██║██╔════╝██╔════╝██╔════╝
// ███████╗   ██║   █████╗  ███████║██╔████╔██║    ██║   ██║███████╗█████╗  ███████╗
// ╚════██║   ██║   ██╔══╝  ██╔══██║██║╚██╔╝██║    ██║   ██║╚════██║██╔══╝  ╚════██║
// ███████║   ██║   ███████╗██║  ██║██║ ╚═╝ ██║    ╚██████╔╝███████║███████╗███████║
// ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝     ╚═════╝ ╚══════╝╚══════╝╚══════╝

// powergen!
// mods.nuclearcraft.Turbine.addRecipe(ILiquidStack fluidInput, ILiquidStack fluidOutput, double turbine_power_per_mb, double turbine_expansion_level, double turbine_spin_up_multiplier, @Optional String particleEffect, @Optional double particleSpeedMultiplier);
mods.nuclearcraft.Turbine.addRecipe(<liquid:magic_steam_grade_1>, <liquid:exhaust_steam> * 4, 374.0, 1.8, 1.0, 'enchantmenttable', 1.0);
mods.nuclearcraft.Turbine.addRecipe(<liquid:magic_steam_grade_2>, <liquid:exhaust_steam> * 6, 816.0, 1.8, 1.0, 'enchantmenttable', 1.0);
mods.nuclearcraft.Turbine.addRecipe(<liquid:magic_steam_grade_3>, <liquid:exhaust_steam> * 10, 1768.0, 1.8, 1.0, 'enchantmenttable', 1.0);
mods.nuclearcraft.Turbine.addRecipe(<liquid:magic_steam_grade_4>, <liquid:exhaust_steam> * 16, 3810, 1.8, 1.0, 'enchantmenttable', 1.0);
mods.nuclearcraft.Turbine.addRecipe(<liquid:magic_steam_grade_5>, <liquid:exhaust_steam> * 24, 8160.0, 1.8, 1.0, 'enchantmenttable', 1.0);

// todo: crafting uses for steam
// convert stone into corresponding mod material?
