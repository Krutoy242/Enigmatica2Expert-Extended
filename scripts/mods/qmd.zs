#modloaded qmd

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.nuclearcraft.ChanceItemIngredient;

// Air available in skyblock
mods.qmd.atmosphere_collector.addRecipe('', '3', <fluid:compressed_air> * 1000);

// Recipes moved from Assembler (removed machine)
mods.immersiveengineering.Blueprint.addRecipe('components', <qmd:potassium_iodine_tablet> * 4, [
  <ore:dustPotassium>, <ore:dustIodine>, <ore:listAllsugar> * 4, <ore:bioplastic>]);

mods.immersiveengineering.Blueprint.addRecipe('components', <ore:wireSSFAF>.firstItem * 6, [
  <ore:dustSSFAF> * 3, <ore:ingotSilver> * 6]);

mods.immersiveengineering.Blueprint.addRecipe('components', <ore:wireYBCO>.firstItem * 6, [
  <ore:dustYBCO> * 3, <ore:ingotSilver> * 6]);

recipes.addShapeless('dustSSFAF', <ore:dustSSFAF>.firstItem * 6, [
  <ore:dustSamarium> * 1, <ore:dustStrontium> * 1, <ore:dustIronFluoride> * 2, <ore:dustArsenic> * 2]);

recipes.addShapeless('dustYBCO', <ore:dustYBCO>.firstItem * 3, [
  <ore:dustYttrium> * 1, <ore:dustBarium> * 2, <ore:dustCopperOxide> * 3]);

// [BSCCO Wire]*6 from [Silver Plate][+1]
mods.immersiveengineering.Blueprint.addRecipe('components', <qmd:part:4> * 6, Grid(['▲□□'], {
  '▲': <qmd:chemical_dust:1>, // BSCCO Dust
  '□': <ore:plateSilver>, // Silver Plate
}).shapeless());

// [Gold Plated Tungsten Wire]*6 from [Gold Item Casing][+1]
mods.immersiveengineering.Blueprint.addRecipe('components', <qmd:part:6> * 6, Grid(['▬▬▬▬⌂⌂'], {
  '▬': <ore:ingotTungsten>, // Tungsten Ingot
  '⌂': <ic2:casing:2>,      // Gold Item Casing
}).shapeless());

// [BSCCO Dust]*3 from [Copper Oxide][+3]
craft.shapeless(<qmd:chemical_dust:1> * 32, '∆♠∆▲♠▲♣♠♣', {
  '∆': <ore:dustBismuth>,     // Bismuth Dust
  '▲': <ore:dustStrontium>,   // Strontium Dust
  '♣': <ore:dustCalcium>,     // Calcium Dust
  '♠': <ore:dustCopperOxide>, // Copper Oxide
});

// [Plastic Scintillator] from [Blue Dye][+1]
scripts.process.alloy([<ore:dyeBlue>, <ore:bioplastic>, <ore:bioplastic>], <qmd:part:3>);

// [Basic Processor] from [N-Type Doped Silicon][+3]
craft.make(<qmd:semiconductor:4> * 4, ['NF','⌂F','□F'], {
  'N': <ore:siliconNDoped>,     // N-Type Doped Silicon
  'F': <fluxnetworks:flux>,     // Flux
  '⌂': <forestry:chipsets:3>.withTag({ T: 3 as short }, false), // Intricate Circuit Board
  '□': <ore:circuitUltimate>, // Ultimate Control Circuit
});

// [Advanced Processor] from [P-Type Doped Silicon][+3]
craft.make(<qmd:semiconductor:5>, ['BF','▲F','PF'], {
  'B': <ore:processorBasic>,    // Basic Processor
  'F': <fluxnetworks:flux>,     // Flux
  '▲': <ore:dustHafniumOxide>,  // Hafnium Oxide
  'P': <ore:siliconPDoped>,     // P-Type Doped Silicon
});

// [Elite Processor] from [Platinum Plate][+3]
craft.make(<qmd:semiconductor:6>, ['AB','▲B','□B'], {
  'A': <ore:processorAdvanced>, // Advanced Processor
  'B': <ore:wireBSCCO>,         // BSCCO Wire
  '▲': <ore:dustHafniumOxide>,  // Hafnium Oxide
  '□': <ore:platePlatinum>,     // Platinum Plate
});

// [Accelerator Casing]*64 from [Steel Chassis][+2]
craft.remake(<qmd:accelerator_casing> * 64, ['pretty',
  '▬ - ▬',
  '- ◙ -',
  '▬ - ▬'], {
  '▬': <ore:ingotStainlessSteel>, // Stainless Steel Ingot
  '-': <ore:ingotTough>,          // Tough Alloy Ingot
  '◙': <ore:steelFrame>,          // Steel Chassis
});

// [Particle Chamber Casing]*64 from [Steel Chassis][+2]
craft.remake(<qmd:particle_chamber_casing> * 64, ['pretty',
  '▬ - ▬',
  '- ◙ -',
  '▬ - ▬'], {
  '▬': <ore:ingotStainlessSteel>, // Stainless Steel Ingot
  '-': <ore:ingotTungsten>,       // Tungsten Ingot
  '◙': <ore:steelFrame>,          // Steel Chassis
});

// [Vacuum Chamber Casing]*64 from [Steel Chassis][+3]
craft.remake(<qmd:containment_casing> * 64, ['pretty',
  '▬ _ ▬',
  '- ◙ -',
  '▬ _ ▬'], {
  '▬': <ore:ingotOsmiridium>,     // Osmiridium Ingot
  '_': <ore:ingotTough>,          // Tough Alloy Ingot
  '-': <ore:ingotStainlessSteel>, // Stainless Steel Ingot
  '◙': <ore:steelFrame>,          // Steel Chassis
});

// [Strontium RTG] from [Strontium-90 Block][+2]
craft.remake(<qmd:rtg_strontium>, ['pretty',
  '□ P □',
  'P ■ P',
  '□ P □'], {
  '□': <ore:plateElite>,       // Elite Plating
  'P': <ore:siliconPDoped>,    // P-Type Doped Silicon
  '■': <ore:blockStrontium90>, // Strontium-90 Block
});

val ingrs = {
  'O': <qmd:luminous_paint:2>, // Orange Radioluminescent Paint
  'H': <nuclearcraft:part:2>, // DU Plating
  'R': <industrialforegoing:plastic>, // Plastic
  'S': <ic2:hazmat_helmet:*> | <ic2:hazmat_helmet:*>.withTag({}, false), // Scuba Helmet
  '⌀': <ic2:hazmat_chestplate:*> | <ic2:hazmat_chestplate:*>.withTag({}, false), // Hazmat Suit
  '○': <ic2:hazmat_leggings:*> | <ic2:hazmat_leggings:*>.withTag({}, false), // Hazmat Suit Leggings
  'u': <ic2:rubber_boots:*> | <ic2:rubber_boots:*>.withTag({}, false), // Rubber Boots
} as IIngredient[string];

// [HEV Helmet] from [Hazmat Suit Headwear][+4]
craft.make(<qmd:helm_hev>, ['pretty',
  'O O O',
  'H S H',
  'R   R'], ingrs
);

// [HEV Chestplate] from [Hazmat Suit Chestpiece][+4]
craft.make(<qmd:chest_hev>, ['pretty',
  'O O O',
  'H ⌀ H',
  'R   R'], ingrs
);

// [HEV Leggings] from [Hazmat Suit Leggings][+4]
craft.make(<qmd:legs_hev>, ['pretty',
  'O O O',
  'H ○ H',
  'R   R'], ingrs
);

// [HEV Boots] from [Hazmat Suit Boots][+4]
craft.make(<qmd:boots_hev>, ['pretty',
  'O O O',
  'H u H',
  'R   R'], ingrs
);

craft.remake(<qmd:part:9> * 4, ['pretty',
  'B 3 B',
  'B E B',
  'B N B'], {
  'B': <qmd:accelerator_cavity:4>,
  '3': <opencomputers:print>,
  'E': <ore:processorElite>,
  'N': <ore:magnetNeodymium>,
});

craft.remake(<qmd:part:10> * 4, ['pretty',
  'A 3 A',
  '□ / □',
  '□ r □'], {
  'A': <ore:processorAdvanced>,
  '3': <opencomputers:print>,
  '□': <ore:plateSilver>,
  '/': <ore:rodNdYAG>,
  'r': <qmd:discharge_lamp:6>,
});

// [Tungsten Filament] from [Tungsten Ingot]
scripts.process.alloy([<endreborn:item_ingot_wolframium>, <ore:dustTungsten>],
  <qmd:source>.withTag({ particle_storage: { particle_amount: 50000000, particle_capacity: 50000000 } }),
  'except: AlloyFurnace Kiln induction alloySmelter'
);

val alloyMachines = 'except: alloyFurnace kiln';
scripts.process.alloy([<ore:ingotNeodymium>, <ore:ingotFerroboron>, <ore:ingotFerroboron>], <qmd:part:8>); // [Neodymium Magnet] from [Neodymium Ingot][+1]
scripts.process.alloy([<ore:dustTungsten>     , <ore:ingotGraphite>]       , <qmd:ingot_alloy>   * 2, alloyMachines); // [Tungsten Carbide Ingot]*2 from [Graphite Ingot][+1]
scripts.process.alloy([<ore:ingotNiobium> * 3 , <ore:ingotTin>]            , <qmd:ingot_alloy:1> * 4, alloyMachines); // [Niobium-Tin Ingot]*4 from [Tin Ingot][+1]
scripts.process.alloy([<ore:ingotSteel> * 5   , <ore:ingotChromium>]       , <qmd:ingot_alloy:2> * 6, alloyMachines); // [Stainless Steel Ingot]*6 from [Chromium Ingot][+1]
scripts.process.alloy([<ore:ingotNiobium>     , <ore:ingotTitanium>]       , <qmd:ingot_alloy:3> * 2, alloyMachines); // [Niobium-Titanium Ingot]*2 from [Titanium Ingot][+1]
scripts.process.alloy([<ore:ingotNickel>      , <ore:ingotChromium>]       , <qmd:ingot_alloy:5> * 2, alloyMachines); // [Nichrome Ingot]*2 from [Chromium Ingot][+1]
scripts.process.alloy([<ore:ingotNichrome> * 2, <ore:ingotNiobiumTitanium>], <qmd:ingot_alloy:6> * 3, alloyMachines); // [Super Alloy Ingot]*3 from [Niobium-Titanium Ingot][+1]

// [Copper Oxide] from [Universal Fluid Cell][+1]
scripts.process.fill(<ore:dustCopper>, <fluid:oxygen> * 1000, <qmd:chemical_dust:4>, 'except: NCInfuser Casting DryingBasin');

// [Hafnium Oxide] from [Universal Fluid Cell][+1]
scripts.process.fill(<ore:dustHafnium>, <fluid:oxygen> * 1000, <qmd:chemical_dust:5>, 'except: NCInfuser Casting DryingBasin');

// Remove Silicon Boule
mods.nuclearcraft.Crystallizer.removeRecipeWithOutput(<libvulpes:productboule:3>);
mods.nuclearcraft.Melter.addRecipe(<ore:blockSilicon>, <fluid:silicon> * 1296);
Purge(<qmd:semiconductor:3>).ores([<ore:waferSilicon>]); // Silicon Wafer, replaced by Adv. Rock.
Purge(<qmd:semiconductor:2>).ores([<ore:bouleSilicon>]); // Silicon boule
mods.nuclearcraft.FissionIrradiator.removeRecipeWithOutput(<qmd:semiconductor:1>);
mods.nuclearcraft.FissionIrradiator.addRecipe(<ore:waferSilicon>, <qmd:semiconductor:1>, 120000, 0, 0, 0);
mods.rats.recipes.addArcheologistRatRecipe(<advancedrocketry:wafer>, <qmd:semiconductor:1>);

// Molten Silicon from pre-AR sources
scripts.process.melt(<ore:ingotSilicon>, <fluid:silicon> * 144, 'except: melter');
scripts.process.melt(<ore:blockSilicon>, <fluid:silicon> * 1296, 'except: melter');
mods.tconstruct.Casting.addTableRecipe(<appliedenergistics2:material:5>, <tconstruct:cast_custom:2>, <liquid:silicon>, 144, false);
mods.tconstruct.Casting.addBasinRecipe(<contenttweaker:silicon_block>, null, <liquid:silicon>, 1296, false);
mods.inworldcrafting.FluidToItem.transform(<libvulpes:productboule:3>, <fluid:silicon>, [<contenttweaker:silicon_block>], true);
scripts.process.saw(<ore:bouleSilicon>, <advancedrocketry:wafer>, 'except: shapeless mekSawmill AdvRockCutter', null, 0, { hardness: 9 });

// Unify P-Type Doped Silicon
<ore:siliconWafer>.add(<advancedrocketry:wafer>);

// mods.qmd.nucleosynthesis_chamber.addRecipe(IIngredient inputFluid1, IIngredient inputFluid2, IIngredient inputParticle, IIngredient outputFluid1, IIngredient outputFluid2, {long maxEnergy}, {long heatRelased})
mods.qmd.nucleosynthesis_chamber.addRecipe(<liquid:sky_stone> * 52, <liquid:enrichedlava> * 20, <particle:neutron> * 1000000, <liquid:neutronium> * 72, null, 1000000, 874000000);

////////////////////////////////////////
//               Unify                //
////////////////////////////////////////
mods.immersiveengineering.ArcFurnace.removeRecipe(<qmd:ingot>); // Tungsten from Ore and Dust

function remakeTarget(
  oldItem as IIngredient,
  particle as mod.qmd.particle.IParticleStack,
  newItem as IIngredient,
  output as IItemStack,
  p1 as mod.qmd.particle.IParticleStack,
  p2 as mod.qmd.particle.IParticleStack,
  p3 as mod.qmd.particle.IParticleStack,
  maxEnergy as int,
  crossSection as double,
  energyReleased as int = 0
) as void {
  mods.qmd.target_chamber.removeRecipeWithInput(oldItem, particle);
  mods.qmd.target_chamber.addRecipe(newItem, null, particle, output, null, p1, p2, p3, maxEnergy, crossSection, energyReleased);
}

// Tungsten ingot replacement
val TG = <endreborn:item_ingot_wolframium>;
remakeTarget(<qmd:ingot>, (<particle:proton> * 12500000) ^ 400000    , TG, <qmd:waste_fission>      , null                    , <particle:neutron>        , null                     , 600000  , 0.08, 0);
remakeTarget(<qmd:ingot>, (<particle:photon> * 4000000) ^ 11000      , TG, <qmd:ingot:6>            , <particle:alpha>        , null                      , null                     , 16500   , 0.25, 2680);
remakeTarget(<qmd:ingot>, (<particle:proton> * 5000000) ^ 600000     , TG, <qmd:waste_spallation2:1>, <particle:pion_plus>    , null                      , <particle:pion_minus>    , 5000000 , 0.2 , -279000);
remakeTarget(<qmd:ingot>, (<particle:proton> * 5000000) ^ 5630000    , TG, <qmd:waste_spallation2:1>, <particle:proton>       , null                      , <particle:antiproton>    , 20000000, 0.2 , -1880000);
remakeTarget(<qmd:ingot>, (<particle:deuteron> * 10000000) ^ 11300000, TG, <qmd:waste_spallation2:1>, <particle:deuteron>     , null                      , <particle:antideuteron>  , 20000000, 0.1 , -3750000);
remakeTarget(<qmd:ingot>, (<particle:antiproton> * 1000000)        , TG, <qmd:waste_spallation2:1>, <particle:pion_plus>    , <particle:pion_naught>    , <particle:pion_minus>    , 10000000, 1   , 1460000);
remakeTarget(<qmd:ingot>, (<particle:antideuteron> * 10000000)     , TG, <qmd:waste_spallation2:1>, <particle:pion_plus> * 4, <particle:pion_naught> * 4, <particle:pion_minus> * 4, 10000000, 1   , 2090000);

// Melt tungsten misssed recipe
scripts.process.melt(<endreborn:item_ingot_wolframium>, <fluid:tungsten> * 144);

// Cast missing recipe
mods.tconstruct.Casting.addTableRecipe(<endreborn:wolframium_nugget>, <tconstruct:cast_custom:1>, <liquid:tungsten>, 16, false, 40);
mods.tconstruct.Casting.addTableRecipe(<endreborn:item_ingot_wolframium>, <tconstruct:cast_custom>, <liquid:tungsten>, 144, false, 200);
mods.tconstruct.Casting.addBasinRecipe(<endreborn:block_wolframium>, null, <liquid:tungsten>, 1296, false, 800);

// Sodium Chlorde (salt)
Purge(<qmd:chemical_dust:3>).ores([<ore:dustSodiumChloride>, <ore:dustSalt>]);

// Fix salt melting duplicate recipe
mods.nuclearcraft.Melter.removeRecipeWithOutput(<fluid:sodium_chloride> * 666);
mods.nuclearcraft.Crystallizer.removeRecipeWithInput(<fluid:sodium_chloride_solution> * 666);

// Sodium Nitrate (niter)
Purge(<qmd:chemical_dust:2>).ores([<ore:dustSaltpeter>, <ore:dustNiter>, <ore:dustSodiumNitrate>]);
mods.nuclearcraft.Crystallizer.removeRecipeWithInput(<fluid:sodium_nitrate_solution> * 666);
mods.nuclearcraft.Crystallizer.addRecipe(<fluid:sodium_nitrate_solution> * 666, <thermalfoundation:material:772>);

////////////////////////////////////////
// Replacing Mercury with Quicksilver //
////////////////////////////////////////

mods.industrialforegoing.FluidDictionary.add("fluid_quicksilver", "mercury", 1);
mods.industrialforegoing.FluidDictionary.add("mercury", "fluid_quicksilver", 1);

// Mercury should be very heat-resistant
mods.nuclearcraft.FissionHeating.removeRecipeWithOutput(<fluid:high_pressure_mercury> * 2);
mods.nuclearcraft.Turbine.removeRecipeWithOutput(<liquid:exhaust_mercury> * 3);
mods.nuclearcraft.Turbine.addRecipe(<fluid:high_pressure_mercury> * 2, <liquid:mercury>, 13925000, 3.0, 1.0);
mods.qmd.nucleosynthesis_chamber_heater.removeRecipeWithInput(<fluid:mercury>);
mods.qmd.nucleosynthesis_chamber_heater.removeRecipeWithInput(<fluid:hot_mercury>);
mods.qmd.nucleosynthesis_chamber_heater.addRecipe(<fluid:mercury>, <fluid:high_pressure_mercury> * 2, 512000);

// Below, taken from Multiblock-Madness
// https://github.com/Filostorm/Multiblock-Madness/blob/19659008c64234f96d5607df3f9ca6df7adee778/scripts/Non%20Mod%20Scripts/unification.zs#L150-L301

// New Ore Leacher Recipes
mods.qmd.ore_leacher.addRecipe(<ore:oreRedstone>, <liquid:nitric_acid> * 16, <liquid:hydrochloric_acid> * 16, <liquid:sulfuric_acid> * 16, <minecraft:redstone> * 12, <thaumcraft:quicksilver> * 3, null, 1.0, 1.0, 0);
mods.qmd.ore_leacher.addRecipe(<ore:dustRedstone>, <liquid:nitric_acid> * 16, <liquid:hydrochloric_acid> * 16, <liquid:sulfuric_acid> * 16,
  ChanceItemIngredient.create(<thaumcraft:quicksilver>, 50, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:771>, 50, 0),
  null, 1.0, 1.0, 0.001);

// New Fuel Reprocessor Recipes
mods.nuclearcraft.FuelReprocessor.addRecipe(<qmd:waste_spallation:1>,
  ChanceItemIngredient.create(<nuclearcraft:fission_dust:1>, 9, 0),
  ChanceItemIngredient.create(<nuclearcraft:fission_dust:2>, 15, 0),
  ChanceItemIngredient.create(<nuclearcraft:fission_dust>, 40, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:67>, 35, 0),
  ChanceItemIngredient.create(<thaumcraft:quicksilver>, 1, 0),
  null,
  null,
  null);

mods.nuclearcraft.FuelReprocessor.addRecipe(<qmd:waste_spallation:2>,
  ChanceItemIngredient.create(<nuclearcraft:fission_dust:1>, 13, 0),
  ChanceItemIngredient.create(<nuclearcraft:fission_dust:2>, 17, 0),
  ChanceItemIngredient.create(<nuclearcraft:fission_dust>, 16, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:67>, 50, 0),
  ChanceItemIngredient.create(<thaumcraft:quicksilver>, 4, 0),
  null,
  null,
  null);

mods.nuclearcraft.FuelReprocessor.addRecipe(<qmd:waste_spallation:3>,
  ChanceItemIngredient.create(<nuclearcraft:fission_dust:2>, 22, 0),
  ChanceItemIngredient.create(<nuclearcraft:fission_dust>, 15, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:67>, 55, 0),
  ChanceItemIngredient.create(<thaumcraft:quicksilver>, 5, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:1>, 1, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:70>, 2, 0),
  null,
  null);

mods.nuclearcraft.FuelReprocessor.addRecipe(<qmd:waste_spallation:4>,
  ChanceItemIngredient.create(<nuclearcraft:fission_dust:2>, 22, 0),
  ChanceItemIngredient.create(<nuclearcraft:fission_dust>, 14, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:67>, 55, 0),
  ChanceItemIngredient.create(<thaumcraft:quicksilver>, 5, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:1>, 1, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:70>, 3, 0),
  null,
  null);

mods.nuclearcraft.FuelReprocessor.addRecipe(<qmd:waste_spallation:5>,
  ChanceItemIngredient.create(<nuclearcraft:fission_dust:2>, 36, 0),
  ChanceItemIngredient.create(<nuclearcraft:fission_dust>, 17, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:67>, 34, 0),
  ChanceItemIngredient.create(<thaumcraft:quicksilver>, 7, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:1>, 2, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:70>, 4, 0),
  null,
  null);

mods.nuclearcraft.FuelReprocessor.addRecipe(<qmd:waste_spallation:6>,
  ChanceItemIngredient.create(<nuclearcraft:fission_dust:2>, 21, 0),
  ChanceItemIngredient.create(<nuclearcraft:fission_dust>, 12, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:67>, 55, 0),
  ChanceItemIngredient.create(<thaumcraft:quicksilver>, 7, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:1>, 1, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:70>, 4, 0),
  null,
  null);

mods.nuclearcraft.FuelReprocessor.addRecipe(<qmd:waste_spallation:8>,
  ChanceItemIngredient.create(<nuclearcraft:fission_dust:2>, 10, 0),
  ChanceItemIngredient.create(<nuclearcraft:fission_dust>, 7, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:67>, 62, 0),
  ChanceItemIngredient.create(<thaumcraft:quicksilver>, 11, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:1>, 2, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:70>, 8, 0),
  null,
  null);

mods.nuclearcraft.FuelReprocessor.addRecipe(<qmd:waste_spallation:7>,
  ChanceItemIngredient.create(<nuclearcraft:fission_dust:2>, 36, 0),
  ChanceItemIngredient.create(<nuclearcraft:fission_dust>, 6, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:67>, 39, 0),
  ChanceItemIngredient.create(<thaumcraft:quicksilver>, 10, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:1>, 2, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:70>, 7, 0),
  null,
  null);

mods.nuclearcraft.FuelReprocessor.addRecipe(<qmd:waste_spallation:9>,
  ChanceItemIngredient.create(<thermalfoundation:material:67>, 58, 0),
  ChanceItemIngredient.create(<thaumcraft:quicksilver>, 18, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:1>, 3, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:70>, 10, 0),
  ChanceItemIngredient.create(<thermalfoundation:material:71>, 6, 0),
  ChanceItemIngredient.create(<mekanism:dust:2>, 5, 0),
  null,
  null);

////////////////////////////////////////

// Low-energy alt recipe
// [Basalt Sediment] from [Basalt]
mods.qmd.target_chamber.addRecipe(
  <ore:stoneBasalt>, null,
  (<particle:boron_ion> * 1000000) ^ 20,
  <advancedrocketry:basalt>,
  null, null, null, null,
  2000, 1.0, 0
);

// Low-energy alt recipe
// [Draconium Infused Obsidian] from [Obsidian]
mods.qmd.target_chamber.addRecipe(
  <ore:obsidian>, null,
  (<particle:boron_ion> * 1000000) ^ 20,
  <draconicevolution:infused_obsidian>,
  null, null, null, null,
  2000, 1.0, 0
);
