#modloaded qmd

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.nuclearcraft.ChanceItemIngredient;

// [BSCCO Wire]*6 from [Silver Plate][+1]
mods.immersiveengineering.Blueprint.addRecipe('components', <qmd:part:4> * 2, Grid(['▲□□'], {
  '▲': <qmd:chemical_dust:1>, // BSCCO Dust
  '□': <ore:plateSilver>, // Silver Plate
}).shapeless());

// [Gold Plated Tungsten Wire]*6 from [Gold Item Casing][+1]
mods.immersiveengineering.Blueprint.addRecipe('components', <qmd:part:6> * 6, Grid(['▬▬▬▬⌂⌂'], {
  '▬': <ore:ingotTungsten>, // Tungsten Ingot
  '⌂': <ic2:casing:2>,      // Gold Item Casing
}).shapeless());

// [BSCCO Dust]*3 from [Copper Oxide][+3]
craft.shapeless(<qmd:chemical_dust:1> * 3, '∆♠∆▲♠▲♣♠♣', {
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
mods.qmd.target_chamber.removeRecipeWithInput(<qmd:semiconductor:3>, ((<particle:boron_ion> * 1000000) ^ 600) ~ 2.0);
mods.qmd.target_chamber.addRecipe(
  <ore:waferSilicon>, null, ((<particle:boron_ion> * 1000000) ^ 600) ~ 2.0, <qmd:semiconductor>, null,
  null, null, null, 1000, 1.0, 0
);

// mods.qmd.nucleosynthesis_chamber.addRecipe(IIngredient inputFluid1, IIngredient inputFluid2, IIngredient inputParticle, IIngredient outputFluid1, IIngredient outputFluid2, {long maxEnergy}, {long heatRelased})
mods.qmd.nucleosynthesis_chamber.addRecipe(<liquid:sky_stone> * 52, <liquid:enrichedlava> * 20, <particle:neutron> * 1000000, <liquid:neutronium> * 72, null, 1000000, 874000);

////////////////////////////////////////
//               Unify                //
////////////////////////////////////////
Purge(<qmd:dust:4>).ores([<ore:dustCobalt>]); // Cobalt
Purge(<qmd:ingot:4>).ores([<ore:ingotCobalt>]); // Cobalt
Purge(<qmd:ingot>).furn().ores([<ore:ingotTungsten>]); // Tungsten
Purge(<qmd:ingot:10>).ores([<ore:ingotPlatinum>]); // Platinum
Purge(<qmd:ingot_alloy:4>).ores([<ore:ingotOsmiridium>]); // Osmiridium
Purge(<qmd:ingot:9>).ores([<ore:ingotIridium>]); // Iridium

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
// val TG = <endreborn:item_ingot_wolframium>;
// remakeTarget(<qmd:ingot>, (<particle:proton> * 12500000) ^ 400000    , TG, <qmd:waste_fission>      , null                    , <particle:neutron>        , null                     , 600000  , 0.08, 0);
// remakeTarget(<qmd:ingot>, (<particle:photon> * 4000000) ^ 11000      , TG, <qmd:ingot:6>            , <particle:alpha>        , null                      , null                     , 16500   , 0.25, 2680);
// remakeTarget(<qmd:ingot>, (<particle:proton> * 5000000) ^ 600000     , TG, <qmd:waste_spallation2:1>, <particle:pion_plus>    , null                      , <particle:pion_minus>    , 5000000 , 0.2 , -279000);
// remakeTarget(<qmd:ingot>, (<particle:proton> * 5000000) ^ 5630000    , TG, <qmd:waste_spallation2:1>, <particle:proton>       , null                      , <particle:antiproton>    , 20000000, 0.2 , -1880000);
// remakeTarget(<qmd:ingot>, (<particle:deuteron> * 10000000) ^ 11300000, TG, <qmd:waste_spallation2:1>, <particle:deuteron>     , null                      , <particle:antideuteron>  , 20000000, 0.1 , -3750000);
// remakeTarget(<qmd:ingot>, (<particle:antiproton> * 1000000)        , TG, <qmd:waste_spallation2:1>, <particle:pion_plus>    , <particle:pion_naught>    , <particle:pion_minus>    , 10000000, 1   , 1460000);
// remakeTarget(<qmd:ingot>, (<particle:antideuteron> * 10000000)     , TG, <qmd:waste_spallation2:1>, <particle:pion_plus> * 4, <particle:pion_naught> * 4, <particle:pion_minus> * 4, 10000000, 1   , 2090000);

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

////////////////////////////////////////

//first recipe is fluid-less 2x-2x, second is with fluid, to boost secondary output by 6x, and primary reduced to 1x
// dirty ore compat Mass spectrometer
//Aluminum
mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemaluminium>, null,
   <thermalfoundation:material:68>*32, <thermalfoundation:material>*2, <jaopca:item_dustaquamarine>*8, <jaopca:item_dustsapphire>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemaluminium>, <fluid:terrestrial>*16,
   <thermalfoundation:material:68>*16, <thermalfoundation:material>*6, <jaopca:item_dustaquamarine>*24, <jaopca:item_dustsapphire>*12,
    null, null, null, null, 2.0
    );

//Ardite

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemardite>, null,
   <exnihilocreatio:item_ore_ardite:2>*32, <mekanism:dust:2>*2, <thermalfoundation:material:1>*2, <jaopca:item_dusttopaz>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemardite>, <fluid:terrestrial>*16,
   <exnihilocreatio:item_ore_ardite:2>*16, <mekanism:dust:2>*6, <thermalfoundation:material:1>*6, <jaopca:item_dusttopaz>*12,
    null, null, null, null, 2.0
    );

//AstralStarMetal

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemastralstarmetal>, null,
   <astralsorcery:itemcraftingcomponent:2>*32, <thermalfoundation:material:66>*2, <qmd:dust>*2, <jaopca:item_dustsapphire>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemastralstarmetal>, <fluid:terrestrial>*16,
   <astralsorcery:itemcraftingcomponent:2>*16, <thermalfoundation:material:66>*6, <qmd:dust>*6, <jaopca:item_dustsapphire>*12,
    null, null, null, null, 2.0
    );

//Boron

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemboron>, null,
   <nuclearcraft:dust:5>*32, <nuclearcraft:dust:7>*2, <ic2:dust:11>*2, <actuallyadditions:item_dust:7>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemboron>, <fluid:terrestrial>*16,
   <nuclearcraft:dust:5>*16, <nuclearcraft:dust:7>*6, <ic2:dust:11>*6, <actuallyadditions:item_dust:7>*12,
    null, null, null, null, 2.0
    );

    //Cobalt

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemcobalt>, null,
   <exnihilocreatio:item_ore_cobalt:2>*32, <thermalfoundation:material>*2, <thermalfoundation:material:69>*2, <nuclearcraft:dust:5>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemcobalt>, <fluid:terrestrial>*16,
   <exnihilocreatio:item_ore_cobalt:2>*16, <thermalfoundation:material>*6, <thermalfoundation:material:69>*6, <nuclearcraft:dust:5>*6,
    null, null, null, null, 2.0
    );

    //Copper

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemcopper>, null,
   <thermalfoundation:material:64>*32, <thermalfoundation:material:65>*2, <thermalfoundation:material:1>*2, <thermalfoundation:material>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemcopper>, <fluid:terrestrial>*16,
   <thermalfoundation:material:64>*16, <thermalfoundation:material:65>*6, <thermalfoundation:material:1>*6, <thermalfoundation:material>*6,
    null, null, null, null, 2.0
    );
    
    //Draconium

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemdraconium>, null,
   <draconicevolution:draconium_dust>*32, <exnihilocreatio:item_ore_ardite:2>*2, <astralsorcery:itemcraftingcomponent:2>*2, <jaopca:item_dustamethyst>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemdraconium>, <fluid:terrestrial>*16,
   <draconicevolution:draconium_dust>*16, <exnihilocreatio:item_ore_ardite:2>*6, <astralsorcery:itemcraftingcomponent:2>*6, <jaopca:item_dustamethyst>*12,
    null, null, null, null, 2.0
    );
    
    //Gold

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemgold>, null,
   <thermalfoundation:material:1>*32, <thermalfoundation:material:66>*2, <thermalfoundation:material:68>*2, <thermalfoundation:material:72>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemgold>, <fluid:terrestrial>*16,
   <thermalfoundation:material:1>*16, <thermalfoundation:material:66>*6, <thermalfoundation:material:68>*6, <thermalfoundation:material:72>*6,
    null, null, null, null, 2.0
    );
    
    //Iridium

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemiridium>, null,
   <thermalfoundation:material:71>*32, <thermalfoundation:material:70>*2, <mekanism:dust:2>*2, <jaopca:item_dustdimensionalshard>*6,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemiridium>, <fluid:terrestrial>*16,
   <thermalfoundation:material:71>*16, <thermalfoundation:material:70>*6, <mekanism:dust:2>*6, <jaopca:item_dustdimensionalshard>*18,
    null, null, null, null, 2.0
    );
    
    //Iron

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemiron>, null,
   <thermalfoundation:material>*32, <thermalfoundation:material:69>*2, <thermalfoundation:material:1>*2, <thermalfoundation:material:65>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemiron>, <fluid:terrestrial>*16,
   <thermalfoundation:material>*16, <thermalfoundation:material:69>*6, <thermalfoundation:material:1>*6, <thermalfoundation:material:65>*6,
    null, null, null, null, 2.0
    );
    
    //Lead

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemlead>, null,
   <thermalfoundation:material:67>*32, <thermalfoundation:material:64>*2, <thermalfoundation:material:66>*2, <immersiveengineering:metal:14>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemlead>, <fluid:terrestrial>*16,
   <thermalfoundation:material:67>*16, <thermalfoundation:material:64>*6, <thermalfoundation:material:66>*6, <immersiveengineering:metal:14>*6,
    null, null, null, null, 2.0
    );
    
    //Lithium

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemlithium>, null,
   <ic2:dust:11>*32, <thermalfoundation:material:68>*2, <jaopca:item_dusttopaz>*4, <jaopca:item_dustapatite>*20,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemlithium>, <fluid:terrestrial>*16,
   <ic2:dust:11>*16, <thermalfoundation:material:68>*6, <jaopca:item_dusttopaz>*12, <jaopca:item_dustapatite>*60,
    null, null, null, null, 2.0
    );
    
    //Magnesium

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemmagnesium>, null,
   <nuclearcraft:dust:7>*32, <thermalfoundation:material>*2, <thermalfoundation:material:64>*2, <thermalfoundation:material:69>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemmagnesium>, <fluid:terrestrial>*16,
   <nuclearcraft:dust:7>*16, <thermalfoundation:material>*6, <thermalfoundation:material:64>*6, <thermalfoundation:material:69>*6,
    null, null, null, null, 2.0
    );
        
    //Mithril

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemmithril>, null,
   <thermalfoundation:material:72>*32, <thermalfoundation:material:1>*2, <astralsorcery:itemcraftingcomponent:2>*2, <thermalfoundation:material:72>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemmithril>, <fluid:terrestrial>*16,
   <thermalfoundation:material:72>*16, <thermalfoundation:material:1>*6, <astralsorcery:itemcraftingcomponent:2>*6, <thermalfoundation:material:72>*6,
    null, null, null, null, 2.0
    );
        
    //Nickel

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemnickel>, null,
   <thermalfoundation:material:69>*32, <thermalfoundation:material:70>*2, <mekanism:dust:2>*2, <exnihilocreatio:item_ore_cobalt:2>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemnickel>, <fluid:terrestrial>*16,
   <thermalfoundation:material:69>*16, <thermalfoundation:material:70>*6, <mekanism:dust:2>*6, <exnihilocreatio:item_ore_cobalt:2>*6,
    null, null, null, null, 2.0
    );
        
    //Osmium

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemosmium>, null,
  <mekanism:dust:2>*32, <thermalfoundation:material:69>*2, <thermalfoundation:material:70>*2, <thermalfoundation:material:71>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemosmium>, <fluid:terrestrial>*16,
   <mekanism:dust:2>*16, <thermalfoundation:material:69>*6, <thermalfoundation:material:70>*6, <thermalfoundation:material:71>*6,
    null, null, null, null, 2.0
    );
        
    //Platinum

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemplatinum>, null,
   <thermalfoundation:material:70>*32, <thermalfoundation:material:69>*2, <thermalfoundation:material:71>*2, <draconicevolution:draconium_dust>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemplatinum>, <fluid:terrestrial>*16,
   <thermalfoundation:material:70>*16, <thermalfoundation:material:69>*6, <thermalfoundation:material:71>*6, <draconicevolution:draconium_dust>*6,
    null, null, null, null, 2.0
    );
        
    //Silver

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemsilver>, null,
   <thermalfoundation:material:66>*32, <thermalfoundation:material:67>*2, <thermalfoundation:material:1>*2, <thermalfoundation:material:71>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemsilver>, <fluid:terrestrial>*16,
   <thermalfoundation:material:66>*16, <thermalfoundation:material:67>*6, <thermalfoundation:material:1>*6, <thermalfoundation:material:71>*6,
    null, null, null, null, 2.0
    );
        
    //Thorium

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemthorium>, null,
   <nuclearcraft:dust:3>*32, <immersiveengineering:metal:14>*2, <nuclearcraft:dust:5>*2, <libvulpes:productdust:7>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemthorium>, <fluid:terrestrial>*16,
   <nuclearcraft:dust:3>*16, <immersiveengineering:metal:14>*6, <nuclearcraft:dust:5>*6, <libvulpes:productdust:7>*6,
    null, null, null, null, 2.0
    );
        
    //Tin

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemtin>, null,
   <thermalfoundation:material:65>*32, <thermalfoundation:material>*2, <thermalfoundation:material:67>*2, <thermalfoundation:material:64>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemtin>, <fluid:terrestrial>*16,
   <thermalfoundation:material:65>*16, <thermalfoundation:material>*6, <thermalfoundation:material:67>*6, <thermalfoundation:material:64>*6,
    null, null, null, null, 2.0
    );
        
    //Titanium

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemtitanium>, null,
   <libvulpes:productdust:7>*32, <qmd:dust>*2, <nuclearcraft:dust:7>*2, <exnihilocreatio:item_ore_ardite:2>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemtitanium>, <fluid:terrestrial>*16,
   <libvulpes:productdust:7>*16, <qmd:dust>*6, <nuclearcraft:dust:7>*6, <exnihilocreatio:item_ore_ardite:2>*6,
    null, null, null, null, 2.0
    );
            
    //Tungsten

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemtungsten>, null,
   <qmd:dust>*32, <nuclearcraft:dust:7>*2, <thermalfoundation:material:71>*2, <libvulpes:productdust:7>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemtungsten>, <fluid:terrestrial>*16,
   <qmd:dust>*16, <nuclearcraft:dust:7>*6, <thermalfoundation:material:71>*6, <libvulpes:productdust:7>*6,
    null, null, null, null, 2.0
    );
            
    //Uranium

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemuranium>, null,
   <immersiveengineering:metal:14>*32, <thermalfoundation:material:67>*2, <ic2:dust:11>*2, <nuclearcraft:dust:3>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemuranium>, <fluid:terrestrial>*16,
   <immersiveengineering:metal:14>*16, <thermalfoundation:material:67>*6, <ic2:dust:11>*6, <nuclearcraft:dust:3>*6,
    null, null, null, null, 2.0
    );
            
    //Amber

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemamber>, null,
   <jaopca:item_dustamber>*64, <thermalfoundation:material>*2, <ic2:dust:5>*4, <appliedenergistics2:material:2>*6,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemamber>, <fluid:terrestrial>*16,
   <jaopca:item_dustamber>*32, <thermalfoundation:material>*6, <ic2:dust:5>*12, <appliedenergistics2:material:2>*18,
    null, null, null, null, 2.0
    );
                
    //Amethyst

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemamethyst>, null,
   <jaopca:item_dustamethyst>*32, <exnihilocreatio:item_ore_cobalt:2>*2, <jaopca:item_dustchargedcertusquartz>*4, <astralsorcery:itemcraftingcomponent:2>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemamethyst>, <fluid:terrestrial>*16,
   <jaopca:item_dustamethyst>*16, <exnihilocreatio:item_ore_cobalt:2>*6, <jaopca:item_dustchargedcertusquartz>*12, <astralsorcery:itemcraftingcomponent:2>*6,
    null, null, null, null, 2.0
    );
            
    //Apatite

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemapatite>, null,
   <jaopca:item_dustapatite>*128, <thermalfoundation:material:68>*2, <nuclearcraft:dust:7>*2, <nuclearcraft:dust:3>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemapatite>, <fluid:terrestrial>*16,
   <jaopca:item_dustapatite>*64, <thermalfoundation:material:68>*6, <nuclearcraft:dust:7>*6, <nuclearcraft:dust:3>*6,
    null, null, null, null, 2.0
    );
            
    //Aquamarine

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemaquamarine>, null,
   <jaopca:item_dustaquamarine>*128, <thermalfoundation:material:68>*2, <actuallyadditions:item_dust:3>*4, <libvulpes:productdust:7>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemaquamarine>, <fluid:terrestrial>*16,
   <jaopca:item_dustaquamarine>*64, <thermalfoundation:material:68>*6, <actuallyadditions:item_dust:3>*12, <libvulpes:productdust:7>*6,
    null, null, null, null, 2.0
    );
            
    //Certus

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemcertusquartz>, null,
   <appliedenergistics2:material:2>*68, <appliedenergistics2:material:3>*6, <ic2:dust:5>*4, <ic2:dust:9>*20,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemcertusquartz>, <fluid:terrestrial>*16,
   <appliedenergistics2:material:2>*36, <appliedenergistics2:material:3>*18, <ic2:dust:5>*12, <ic2:dust:9>*60,
    null, null, null, null, 2.0
    );
            
    //Charged Certus

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemchargedcertusquartz>, null,
   <jaopca:item_dustchargedcertusquartz>*48, <ic2:dust:5>*4, <jaopca:item_dusttopaz>*4, <jaopca:item_dustdimensionalshard>*6,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemchargedcertusquartz>, <fluid:terrestrial>*16,
   <jaopca:item_dustchargedcertusquartz>*24, <ic2:dust:5>*12, <jaopca:item_dusttopaz>*12, <jaopca:item_dustdimensionalshard>*18,
    null, null, null, null, 2.0
    );
            
    //Coal

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemcoal>, null,
   <thermalfoundation:material:768>*128, <actuallyadditions:item_dust:7>*4, <appliedenergistics2:material:3>*6, <appliedenergistics2:material:2>*6,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemcoal>, <fluid:terrestrial>*16,
   <thermalfoundation:material:768>*64, <actuallyadditions:item_dust:7>*12, <appliedenergistics2:material:3>*18, <appliedenergistics2:material:2>*18,
    null, null, null, null, 2.0
    );
            
    //Diamond

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemdiamond>, null,
   <ic2:dust:5>*48, <appliedenergistics2:material:2>*6, <jaopca:item_dustmalachite>*4, <jaopca:item_dustsapphire>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemdiamond>, <fluid:terrestrial>*16,
   <ic2:dust:5>*24, <appliedenergistics2:material:2>*18, <jaopca:item_dustmalachite>*12, <jaopca:item_dustsapphire>*12,
    null, null, null, null, 2.0
    );
            
    //Dilithium

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemdilithium>, null,
   <libvulpes:productdust>*32, <ic2:dust:11>*2, <jaopca:item_dustdimensionalshard>*6, <astralsorcery:itemcraftingcomponent:2>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemdilithium>, <fluid:terrestrial>*16,
   <libvulpes:productdust>*16, <ic2:dust:11>*6, <jaopca:item_dustdimensionalshard>*18, <astralsorcery:itemcraftingcomponent:2>*6,
    null, null, null, null, 2.0
    );
            
    //Dimensional Shard

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemdimensionalshard>, null,
   <jaopca:item_dustdimensionalshard>*64, <astralsorcery:itemcraftingcomponent:2>*2, <jaopca:item_dustperidot>*4, <jaopca:item_dusttanzanite>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemdimensionalshard>, <fluid:terrestrial>*16,
   <jaopca:item_dustdimensionalshard>*32, <astralsorcery:itemcraftingcomponent:2>*6, <jaopca:item_dustperidot>*12, <jaopca:item_dusttanzanite>*12,
    null, null, null, null, 2.0
    );
            
    //Emerald

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygememerald>, null,
   <actuallyadditions:item_dust:3>*48, <jaopca:item_dustperidot>*4, <jaopca:item_dusttanzanite>*4, <jaopca:item_dustmalachite>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygememerald>, <fluid:terrestrial>*16,
   <actuallyadditions:item_dust:3>*24, <jaopca:item_dustperidot>*12, <jaopca:item_dusttanzanite>*12, <jaopca:item_dustmalachite>*12,
    null, null, null, null, 2.0
    );
            
    //Lapis Lazuli

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemlapis>, null,
   <ic2:dust:9>*128, <jaopca:item_dustapatite>*20, <jaopca:item_dustsapphire>*4, <ic2:dust:5>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemlapis>, <fluid:terrestrial>*16,
   <ic2:dust:9>*64, <jaopca:item_dustapatite>*60, <jaopca:item_dustsapphire>*12, <ic2:dust:5>*12,
    null, null, null, null, 2.0
    );
            
    //Malachite

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemmalachite>, null,
   <jaopca:item_dustmalachite>*48, <ic2:dust:9>*20, <thermalfoundation:material:64>*2, <qmd:dust>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemmalachite>, <fluid:terrestrial>*16,
   <jaopca:item_dustmalachite>*24, <ic2:dust:9>*60, <thermalfoundation:material:64>*6, <qmd:dust>*6,
    null, null, null, null, 2.0
    );
            
    //Peridot

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemperidot>, null,
   <jaopca:item_dustperidot>*48, <actuallyadditions:item_dust:3>*4, <ic2:dust:5>*4, <nuclearcraft:dust:7>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemperidot>, <fluid:terrestrial>*16,
   <jaopca:item_dustperidot>*24, <actuallyadditions:item_dust:3>*12, <ic2:dust:5>*12, <nuclearcraft:dust:7>*6,
    null, null, null, null, 2.0
    );
            
    //Quartz

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemquartz>, null,
   <appliedenergistics2:material:3>*64, <thermalfoundation:material>*2, <ic2:dust:5>*4, <jaopca:item_dustamethyst>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemquartz>, <fluid:terrestrial>*16,
   <appliedenergistics2:material:3>*32, <thermalfoundation:material>*6, <ic2:dust:5>*12, <jaopca:item_dustamethyst>*12,
    null, null, null, null, 2.0
    );
            
    //Black Quartz

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemquartzblack>, null,
   <actuallyadditions:item_dust:7>*48, <thermalfoundation:material:768>*10, <jaopca:item_dustaquamarine>*8, <jaopca:item_dusttopaz>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemquartzblack>, <fluid:terrestrial>*16,
   <actuallyadditions:item_dust:7>*24, <thermalfoundation:material:768>*30, <jaopca:item_dustaquamarine>*24, <jaopca:item_dusttopaz>*12,
    null, null, null, null, 2.0
    );
            
    //Ruby

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemruby>, null,
   <jaopca:item_dustruby>*48, <thermalfoundation:material:68>*2, <nuclearcraft:dust:7>*2, <jaopca:item_dustsapphire>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemruby>, <fluid:terrestrial>*16,
   <jaopca:item_dustruby>*24, <thermalfoundation:material:68>*6, <nuclearcraft:dust:7>*6, <jaopca:item_dustsapphire>*12,
    null, null, null, null, 2.0
    );
            
    //Sapphire

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemsapphire>, null,
   <jaopca:item_dustsapphire>*48, <thermalfoundation:material:68>*2, <draconicevolution:draconium_dust>*2, <libvulpes:productdust:7>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemsapphire>, <fluid:terrestrial>*16,
   <jaopca:item_dustsapphire>*24, <thermalfoundation:material:68>*6, <draconicevolution:draconium_dust>*6, <libvulpes:productdust:7>*6,
    null, null, null, null, 2.0
    );
            
    //Tanzanite

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemtanzanite>, null,
   <jaopca:item_dusttanzanite>*48, <appliedenergistics2:material:3>*6, <ic2:dust:5>*4, <jaopca:item_dustamethyst>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemtanzanite>, <fluid:terrestrial>*16,
   <jaopca:item_dusttanzanite>*24, <appliedenergistics2:material:3>*18, <ic2:dust:5>*12, <jaopca:item_dustamethyst>*12,
    null, null, null, null, 2.0
    );
            
    //Topaz

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemtopaz>, null,
   <jaopca:item_dusttopaz>*48, <actuallyadditions:item_dust:7>*2, <appliedenergistics2:material:3>*3, <ic2:dust:5>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemtopaz>, <fluid:terrestrial>*16,
   <jaopca:item_dusttopaz>*24, <actuallyadditions:item_dust:7>*8, <appliedenergistics2:material:3>*16, <ic2:dust:5>*8,
    null, null, null, null, 2.0
    );
            
    //Trinitite

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemtrinitite>, null,
   <jaopca:item_dusttrinitite>*32, <jaopca:item_dusttrinitite>*2, <jaopca:item_dusttrinitite>*2, <jaopca:item_dusttrinitite>*2,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemtrinitite>, <fluid:terrestrial>*16,
   <jaopca:item_dusttrinitite>*16, <jaopca:item_dusttrinitite>*6, <jaopca:item_dusttrinitite>*6, <jaopca:item_dusttrinitite>*6,
    null, null, null, null, 2.0
    );
                
    //Redstone

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemredstone>, null,
   <minecraft:redstone>*128, <thermalfoundation:material:768>*10, <actuallyadditions:item_dust:7>*4, <actuallyadditions:item_dust:7>*4,
    null, null, null, null, 2.0
    );

mods.qmd.mass_spectrometer.addRecipe(
  <jaopca:item_dirtygemredstone>, <fluid:terrestrial>*16,
   <minecraft:redstone>*64, <thermalfoundation:material:768>*30, <actuallyadditions:item_dust:7>*12, <actuallyadditions:item_dust:7>*12,
    null, null, null, null, 2.0
    );


