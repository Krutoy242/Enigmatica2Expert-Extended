#modloaded advancedrocketry

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;

scripts.lib.dropt.addDrop(<advancedrocketry:geode>, [<thermalfoundation:geode>]);
scripts.lib.dropt.addDrop(<advancedrocketry:vitrifiedsand>, [
  <qmd:isotope:5>,
  <qmd:isotope:1>,
  <qmd:isotope>,
  <qmd:isotope:8>,
]);
<advancedrocketry:geode>.asBlock().definition.resistance = 160;
<advancedrocketry:vitrifiedsand>.asBlock().definition.resistance = 160;
<advancedrocketry:crystal>.asBlock().definition.resistance = 20;

// Rename basalt as it not oredicted and have different uses
<advancedrocketry:basalt>.displayName = game.localize('e2ee.tile.basalt_sediment');

// [Rocket Assembling Machine] from [Machine Structure][+4]
craft.remake(<advancedrocketry:rocketbuilder>, ['pretty',
  '╱ U ╱',
  'C M C',
  '¤ C ¤'], {
  '╱': <ore:stickTitanium>,          // Titanium Rod
  'U': <advancedrocketry:misc>,      // User Interface
  'C': <advancedrocketry:ic:3>,      // Control Circuit Board
  'M': <libvulpes:structuremachine>, // Machine Structure
  '¤': <ore:gearTitanium>,           // Titanium Gear
});

// [Launch Pad]*9 from [Diorite][+1]
craft.remake(<advancedrocketry:launchpad> * 9, ['pretty',
  '■ ■ ■',
  '■ D ■',
  '■ ■ ■'], {
  '■': <chisel:factory:6>, // Factory Block
  'D': <ore:stoneDiorite>, // Diorite
});

// [Docking Pad] from [Tracking Circuit][+1]
craft.reshapeless(<advancedrocketry:landingpad>, 'LT', {
  'L': <advancedrocketry:launchpad>, // Launch Pad
  'T': <advancedrocketry:ic:1>,      // Tracking Circuit
});
// -----------------------------------------------------------------

// Hint that Basalt Sediments can be obtained with rocket
scripts.jei.crafting_hints.addInsOutCatl(
  [<minecraft:cobblestone> | <minecraft:gravel>],
  <advancedrocketry:basalt>,
  <advancedrocketry:rocketmotor>.withLore(['§6§lRocket burn blocks'])
);

// Airtight Seal Enchant
recipes.addShaped('Airtight Seal Enchant',
  Book(<enchantment:advancedrocketry:spacebreathing>),
  [[<ore:plateTitaniumAluminide>, <advancedrocketry:liquidtank>, <ore:plateTitaniumAluminide>],
    [<ore:ingotCarbon>, <advancedrocketry:blocklens>, <ore:ingotCarbon>],
    [<ore:plateTitaniumAluminide>, <advancedrocketry:liquidtank>, <ore:plateTitaniumAluminide>]], function (out, ins, cInfo) {
    return Book(<enchantment:advancedrocketry:spacebreathing>);
  }, null);

// HeatProof Brick
recipes.remove(<advancedrocketry:blastbrick>);
recipes.addShaped('HeatProof Brick',
  <advancedrocketry:blastbrick> * 6,
  [[<minecraft:brick_block>, <immersiveengineering:stone_decoration:2>, <minecraft:brick_block>],
    [<minecraft:brick_block>, <ore:slimecrystalMagma>, <minecraft:brick_block>],
    [<minecraft:brick_block>, <minecraft:nether_brick>, <minecraft:brick_block>]]);

// Machine Structure
recipes.remove(<libvulpes:structuremachine>);
recipes.addShapedMirrored('Lib Vulpes Machine Structure',
  <libvulpes:structuremachine> * 6,
  [[<ic2:crafting:29>, <ore:plateElite>, <ic2:crafting:29>],
    [<ore:plateElite>, <thermalexpansion:frame:147>, <ore:plateElite>],
    [<ic2:crafting:29>, <ore:plateElite>, <ic2:crafting:29>]]);

// Liquid IO Circuit Board
recipes.remove(<advancedrocketry:ic:5>);
recipes.addShapedMirrored('Liquid IO Circuit Board',
  <advancedrocketry:ic:5>,
  [[<appliedenergistics2:material:54>, <forestry:chipsets:2>.withTag({ T: 2 as short }, false), <appliedenergistics2:material:54>],
    [<appliedenergistics2:material:54>, <immersiveengineering:material:27>, <appliedenergistics2:material:54>],
    [<appliedenergistics2:material:54>, <forestry:chipsets:2>.withTag({ T: 2 as short }, false), <appliedenergistics2:material:54>]]);

// Item IO Circuit Board
recipes.remove(<advancedrocketry:ic:4>);
recipes.addShapedMirrored('Item IO Circuit Board',
  <advancedrocketry:ic:4>,
  [[<appliedenergistics2:material:18>, <forestry:chipsets:1>.withTag({ T: 1 as short }, false), <appliedenergistics2:material:18>],
    [<appliedenergistics2:material:18>, <immersiveengineering:material:27>, <appliedenergistics2:material:18>],
    [<appliedenergistics2:material:18>, <forestry:chipsets:1>.withTag({ T: 1 as short }, false), <appliedenergistics2:material:18>]]);

// Control Circuit Board
recipes.remove(<advancedrocketry:ic:3>);
recipes.addShapedMirrored('Control Circuit Board',
  <advancedrocketry:ic:3>,
  [[<ore:circuitElite>, <immersiveengineering:metal_decoration0>, <ore:circuitElite>],
    [<ore:bioplastic>, <immersiveengineering:material:27>, <ore:bioplastic>],
    [<ore:circuitElite>, <immersiveengineering:metal_decoration0>, <ore:circuitElite>]]);

// *======= Remove & Hide =======*
val recipesToRemove = [

  <advancedrocketry:productrod>,
  <advancedrocketry:productrod:1>,
  <libvulpes:productrod:4>,
  <libvulpes:productrod:7>,
  <libvulpes:productrod:10>,
  <immersiveengineering:material:3>,
  <advancedrocketry:productgear:*>,
  <libvulpes:productgear:*>,

] as IItemStack[];

for item in recipesToRemove {
  recipes.remove(item);
}

<ore:stickIron>.remove(<advancedrocketry:productrod:1>);

// [Pressurized Tank] from [Omnivoir][+2]
craft.remake(<advancedrocketry:liquidtank>, ['pretty',
  'T ■ T',
  'T O T',
  'T ■ T'], {
  '■': <ore:blockDilithium>, // Block of Dilithium
  'T': <ore:sheetTitaniumIridium>, // Titanium Iridium Alloy Sheet
  'O': <enderio:block_omni_reservoir>, // Omnivoir
});
recipes.addShapeless('Clearing AdvRock Tank', <advancedrocketry:liquidtank>, [<advancedrocketry:liquidtank>]);

// Mushrooms as energy providers
mods.thermalexpansion.EnervationDynamo.addFuel(<advancedrocketry:electricmushroom>, 90000000);

// Crystalls recycling
val alienCrystals = [
  {Violet: [<advancedrocketry:crystal:0>, <actuallyadditions:item_crystal_empowered:5>, <environmentaltech:kyronite_crystal>]},
  {Green : [<advancedrocketry:crystal:2>, <actuallyadditions:item_crystal_empowered:4>, <environmentaltech:litherite_crystal>]},
  {Orange: [<advancedrocketry:crystal:5>, <actuallyadditions:item_crystal_empowered:2>, <environmentaltech:erodium_crystal>]},
  {Blue  : [<advancedrocketry:crystal:1>, <actuallyadditions:item_crystal_empowered:1>, <environmentaltech:pladium_crystal>]},
  {Red   : [<advancedrocketry:crystal:3>, <actuallyadditions:item_crystal_empowered:0>, <environmentaltech:ionite_crystal>]},
  {Yellow: [<advancedrocketry:crystal:4>, <actuallyadditions:item_crystal_empowered:3>, <environmentaltech:aethium_crystal>]},
] as IItemStack[][string][];

for tier, alienCrystal in alienCrystals {
  for crystalName, ingrs in alienCrystal {
    val input       = ingrs[0];
    val output      = ingrs[1];
    val evt_crystal = ingrs[2];

    // Empowering
    mods.qmd.target_chamber.addRecipe(input, null, (<particle:boron_ion> * 100000) ^ 2000, output, null, null, null, null, 10000, 1.0, 0);

    // Antideutron reaction
    mods.qmd.target_chamber.addRecipe(
      input, null,
      (<particle:antideuteron> * 100000) ^ pow(2, tier - 1),
      evt_crystal, null,
      <particle:pion_minus> * 4, <particle:pion_naught> * 4, <particle:pion_plus> * 4,
      10000000 * pow(2, tier), 1, 2090000 * (tier + 1)
    );
  }
}

// Crystaltine creation
mods.qmd.target_chamber.addRecipe(
  <advancedrocketry:crystal:*>, null,
  (<particle:photon> * 20000000) ^ 19500,
  <ore:blockCrystaltine>.firstItem, null,
  <particle:proton>, <particle:neutron>, null,
  27000, 0.05,-16200
);

// Crystals creation - just photoning Dilithium with different power
for i in 0 .. 6 {
  mods.qmd.target_chamber.addRecipe(
    <ore:gemDilithium>,
    null,
    (<particle:proton> * 2000000) ^ (5000000 * (i + 1)),
    <advancedrocketry:crystal>.definition.makeStack(i),
    null, null, null, null,
    5000000 * (i + 2), 1.0, 0
  );
}

scripts.process.compress(<ore:blockCharcoal>, <advancedrocketry:misc:1>, 'No Exceptions');

// Generator was too cheap compared to other coal gens
// [Coal Generator] from [Furnace][+2]
craft.remake(<libvulpes:coalgenerator>, [
  'B',
  'F',
  '□'], {
  '□': <ore:plateTitanium>, // Titanium Plate
  'B': <ore:itemBattery>, // Small Battery
  'F': <minecraft:furnace>, // Furnace
});

// [Advanced Machine Structure*4] from [Silicon Boule][+2]
recipes.remove(<libvulpes:advstructuremachine>);
mods.advancedrocketry.RecipeTweaker.forMachine('PrecisionAssembler').builder()
  .input(<libvulpes:structuremachine> * 4)
  .inputOre(<ore:sheetTitanium>, 4)
  .inputOre(<ore:gemDilithium>, 2)
  .inputOre(<ore:bouleSilicon>)
  .outputItem(<libvulpes:advstructuremachine> * 4)
  .power(60000)
  .timeRequired(80)
  .build();

// Press recipe instead crafting table
recipes.remove(<advancedrocketry:misc>);
mods.immersiveengineering.MetalPress.addRecipe(<advancedrocketry:misc>, <ore:oc:screen3>, <immersiveengineering:mold:0>, 2000);

// Advanced Alloys
scripts.process.alloy([<ore:ingotRefinedObsidian>, <ore:ingotOsmium>, <ore:ingotRefinedGlowstone>], <ore:ingotOsgloglas>.firstItem * 2, 'only: AdvRockArc');
scripts.process.alloy([<ore:ingotManasteel>, <ore:ingotElvenElementium>, <ore:ingotTerrasteel>, <ore:blockGlass> * 10], <ore:ingotMirion>.firstItem * 6, 'only: AdvRockArc');
scripts.process.alloy([<ore:ingotIridium>, <ore:ingotOsmium>], <ore:ingotOsmiridium>.firstItem * 4, 'only: AdvRockArc');
scripts.process.alloy([<ore:blockDiamond>, <ore:blockRedstone> * 5], <ore:blockCrystalFlux>.firstItem, 'only: AdvRockArc');
scripts.process.alloy([<ore:ingotMagnesium> * 3, <ore:ingotBoron> * 6], <ore:ingotMagnesiumDiboride>.firstItem * 9, 'only: AdvRockArc');
scripts.process.alloy([<ore:dustBorax>, <ore:itemSalt> * 4, <ore:plateCarbon>], <ore:ingotTitanium>.firstItem, 'only: AdvRockArc');

val centrifugeBuilder = mods.advancedrocketry.RecipeTweaker.forMachine('Centrifuge')
  .builder().power(100000).timeRequired(20);

centrifugeBuilder.copy()
  .inputLiquid(<fluid:enrichedlava> * 100)
  .outputs(<fluid:thaumium> * 60, <fluid:livingrock> * 50, <fluid:bound_metal> * 15, <fluid:mirion> * 4)
  .build();
centrifugeBuilder.copy()
  .inputLiquid(<fluid:mirion> * 100)
  .outputs(<fluid:manasteel>, <fluid:terrasteel>, <fluid:elementium>, <fluid:glass> * 6)
  .build();
centrifugeBuilder.copy()
  .inputLiquid(<fluid:flux_goo> * 100)
  .outputs(<thaumcraft:curio> * 4, <thaumcraft:curio:2> * 4, <thaumcraft:curio:4> * 4, <thaumcraft:curio:5> * 2)
  .build();

val latheBuilder = mods.advancedrocketry.RecipeTweaker.forMachine('Lathe')
  .builder().power(100000).timeRequired(10);

latheBuilder.copy().inputOre(<ore:ingotCopper>).outputItem(<immersiveengineering:material:20> * 5).build();
latheBuilder.copy().inputOre(<ore:ingotElectrum>).outputItem(<immersiveengineering:material:21> * 5).build();
latheBuilder.copy().inputOre(<ore:ingotAluminium>).outputItem(<immersiveengineering:material:22> * 5).build();
latheBuilder.copy().inputOre(<ore:ingotSteel>).outputItem(<immersiveengineering:material:23> * 5).build();
latheBuilder.copy().input(<integrateddynamics:crystalized_menril_chunk>).outputItem(<integrateddynamics:cable> * 2).build();
latheBuilder.copy().inputOre(<ore:crystalPureFluix>).outputItem(<appliedenergistics2:part:16> * 4).build();

craft.remake(<libvulpes:motor>, ['pretty',
  '  ■',
  '╱ E',
  '  ■'], {
  '■': <ore:coilCopper>,
  '╱': <ore:stickSteel>,
  'E': <ic2:crafting:6>,
});

craft.remake(<libvulpes:advancedmotor>, ['pretty',
  '  G',
  '╱ ■',
  '  G'], {
  'G': <ore:coilGold>,
  '╱': <ore:stickTitaniumIridium>,
  '■': <ore:blockMotor>,
});

craft.make(<libvulpes:advancedmotor>, ['pretty',
  '  G ■',
  '/ ╱ E',
  '  G ■'], {
  'G': <ore:coilGold>,
  '■': <ore:coilCopper>,
  '/': <ore:stickTitaniumIridium>,
  '╱': <ore:stickSteel>,
  'E': <ic2:crafting:6>,
});

craft.remake(<libvulpes:enhancedmotor>, ['pretty',
  '  ■',
  '◊ ▄',
  '  ■'], {
  '■': <ore:coilTitanium>,
  '◊': <ore:gemDilithium>,
  '▄': <ore:blockMotor>,
});

craft.make(<libvulpes:enhancedmotor>, ['pretty',
  '▄ G ■',
  '◊ ╱ E',
  '▄ G ■'], {
  '▄': <ore:coilTitanium>,
  'G': <ore:coilGold>,
  '■': <ore:coilCopper>,
  '◊': <ore:gemDilithium>,
  '╱': <ore:stickTitaniumIridium>,
  'E': <ic2:crafting:6>,
});

craft.remake(<libvulpes:elitemotor>, ['pretty',
  '  ■',
  '/ ▄',
  '  ■'], {
  '■': <ore:coilIridium>,
  '/': <redstonerepository:material:6>,
  '▄': <ore:blockMotor>,
});

craft.make(<libvulpes:elitemotor>, ['pretty',
  '■ ▄ G',
  '/ ◊ E',
  '■ ▄ G'], {
  '■': <ore:coilIridium>,
  '▄': <ore:coilTitanium>,
  'G': <ore:coilGold>,
  '/': <redstonerepository:material:6>,
  '◊': <ore:gemDilithium>,
  'E': <ic2:crafting:6>,
});

// [Space Suit Helmet] from [Glass][+3]
recipes.removeShaped(<advancedrocketry:spacehelmet>);
craft.make(<advancedrocketry:spacehelmet>, ['pretty',
  '□ ╱ □',
  '╱ ■ ╱',
  'w w w'], {
  '■': <ore:blockGlass>, // Glass
  '╱': <ore:stickTitanium>, // Titanium Rod
  '□': <ore:plateTitanium>, // Titanium Plate
  'w': <twilightforest:arctic_fur>,
});

// [Space Suit Chest-Piece] from [Titanium Plate][+3]
recipes.removeShaped(<advancedrocketry:spacechestplate>);
craft.make(<advancedrocketry:spacechestplate>, ['pretty',
  'w ╱ w',
  'w □ w',
  'w S w'], {
  '□': <ore:plateTitanium>, // Titanium Plate
  '╱': <ore:stickTitanium>, // Titanium Rod
  'S': <ore:fanSteel>, // Steel Fan
  'w': <twilightforest:arctic_fur>,
});

// [Space Suit Leggings] from [Titanium Rod][+1]
recipes.removeShaped(<advancedrocketry:spaceleggings>);
craft.make(<advancedrocketry:spaceleggings>, ['pretty',
  'w □ w',
  'w   w',
  'w   w'], {
  '□': <ore:plateTitanium>, // Titanium Plate
  'w': <twilightforest:arctic_fur>,
});

// [Space Suit Boots] from [Titanium Rod][+2]
recipes.removeShaped(<advancedrocketry:spaceboots>);
craft.make(<advancedrocketry:spaceboots>, ['pretty',
  '  ╱  ',
  'w   w',
  '□   □'], {
  '□': <ore:plateTitanium>, // Titanium Plate
  '╱': <ore:stickTitanium>, // Titanium Rod
  'w': <twilightforest:arctic_fur>,
});

// [Suit Workstation] from [Crafting Table][+3]
recipes.removeShaped(<advancedrocketry:suitworkstation>);
craft.make(<advancedrocketry:suitworkstation>, ['pretty',
  '* * *',
  '3 w 3',
  '■ ■ ■'], {
  '■': <ore:blockTitanium>, // Titanium Block
  '3': <enderio:item_basic_capacitor:1>,
  'w': <ore:workbench>, // Crafting Table
  '*': <ore:crystalEmeraldic>, // Emeradic Crystal
});

// [Low Pressure Tank] from [Titanium Plate][+2]
craft.make(<advancedrocketry:pressuretank>, ['pretty',
  'п ◘ п',
  '□ ◘ □',
  '□ ◘ □'], {
  '□': <ore:plateIron>, // Iron Plate
  '◘': <ic2:fluid_cell>.withTag({ Fluid: { FluidName: 'steam', Amount: 1000 } }), // Universal Fluid Cell
  'п': <ore:plateTitanium>, // Titanium Plate
});

// [Pressure Tank] from [Titanium Plate][+2]
craft.make(<advancedrocketry:pressuretank:1>, ['pretty',
  'п ◘ п',
  '□ ◘ □',
  '□ ◘ □'], {
  '□': <ore:plateSteel>, // Steel Plate
  '◘': <ic2:fluid_cell>.withTag({ Fluid: { FluidName: 'ic2superheated_steam', Amount: 1000 } }), // Universal Fluid Cell
  'п': <ore:plateTitanium>, // Titanium Plate
});

// [High Pressure Tank] from [Titanium Plate][+2]
craft.make(<advancedrocketry:pressuretank:2>, ['pretty',
  'п ◘ п',
  '□ ◘ □',
  '□ ◘ □'], {
  '□': <ore:plateAluminium>, // Aluminum Plate
  '◘': <ic2:fluid_cell>.withTag({ Fluid: { FluidName: 'high_pressure_steam', Amount: 1000 } }), // Universal Fluid Cell
  'п': <ore:plateTitanium>, // Titanium Plate
});

// [Super High Pressure Tank] from [Titanium Plate][+2]
craft.make(<advancedrocketry:pressuretank:3>, ['pretty',
  'п ◘ п',
  '□ ◘ □',
  '□ ◘ □'], {
  '□': <ore:plateTitaniumIridium>, // Titanium Iridium Alloy Plate
  '◘': <ic2:fluid_cell>.withTag({ Fluid: { FluidName: 'preheated_water', Amount: 1000 } }), // Universal Fluid Cell
  'п': <ore:plateTitanium>, // Titanium Plate
});

// [Hover Upgrade] from [Control Circuit Board][+3]
craft.make(<advancedrocketry:itemupgrade>, ['pretty',
  '  o  ',
  '□ C □',
  '* * *'], {
  '□': <ore:plateTitanium>, // Titanium Plate
  'C': <advancedrocketry:ic:3>, // Control Circuit Board
  '*': <ore:crystalEmeraldic>, // Emeradic Crystal
  'o': <advgenerators:controller>, // Control Circuit
});

// [Flight Speed Control Upgrade] from [Control Circuit Board][+3]
craft.make(<advancedrocketry:itemupgrade:1>, ['pretty',
  '  M  ',
  '□ C □',
  '* * *'], {
  '□': <ore:plateTitanium>, // Titanium Plate
  'C': <advancedrocketry:ic:3>, // Control Circuit Board
  '*': <ore:crystalEmeraldic>, // Emeradic Crystal
  'M': <ore:processorBasic>,
});

// [Bionic Leg Upgrade] from [Control Circuit][+2]
craft.make(<advancedrocketry:itemupgrade:2>, [
  '■',
  'C',
  'F'], {
  '■': <ore:blockMotor>, // Motor
  'C': <advgenerators:controller>, // Control Circuit
  'F': <ore:foodFrograw>, // Frog Leg
});

// [Padded Landing Boots] from [Control Circuit][+2]
craft.make(<advancedrocketry:itemupgrade:3>, [
  'RCw'], {
  'R': <ic2:rubber_boots>.anyDamage(), // Rubber Boots
  'C': <advgenerators:controller>, // Control Circuit
  'w': <twilightforest:arctic_fur>,
});

// [Anti-Fog Visor] from [Traveller's Goggles (Base)][+1]
craft.shapeless(<advancedrocketry:itemupgrade:4>,
  'CT', {
    'C': <advgenerators:controller>, // Control Circuit
    'T': <conarm:travel_goggles_base>, // Traveller's Goggles (Base)
  });

// [Beacon Finder] from [Engineer's Goggles][+1]
craft.shapeless(<advancedrocketry:beaconfinder>,
  'CE', {
    'C': <advgenerators:controller>, // Control Circuit
    'E': <actuallyadditions:item_engineer_goggles>, // Engineer's Goggles
  });

// [Jet Pack] from [Cobweb][+3]
craft.remake(<advancedrocketry:jetpack>, ['pretty',
  'L C L',
  '╱ C ╱',
  '▲   ▲'], {
  '╱': <ore:stickTitanium>, // Titanium Rod
  '▲': <ore:dustPyrotheum>, // Pyrotheum Dust
  'C': <minecraft:web>, // Cobweb
  'L': <advancedrocketry:pressuretank>, // Low Pressure Tank
});

// [Atmosphere Analyzer] from [User Interface][+1]
craft.shapeless(<advancedrocketry:atmanalyser>,
  'BU', {
    'B': <ore:itemBattery>, // Small Battery
    'U': <advancedrocketry:misc>, // User Interface
  });

// [Input Hatch] from [Machine Structure][+3]
craft.remake(<libvulpes:hatch>, ['pretty',
  '  I  ',
  'S M S',
  '  ♥  '], {
  'I': <enderio:block_buffer>, // Item Buffer
  'S': <ore:itemSimpleChassiParts>, // Simple Machine Parts
  'M': <libvulpes:structuremachine>, // Machine Structure
  '♥': <ore:gearRedstone>, // Redstone Gear
});

// [Output Hatch] from [Machine Structure][+3]
craft.remake(<libvulpes:hatch:1>, ['pretty',
  '  I  ',
  'S M S',
  '  ♥  '], {
  'I': <actuallyadditions:block_laser_relay_item>, // Item Laser Relay
  'S': <ore:itemSimpleChassiParts>, // Simple Machine Parts
  'M': <libvulpes:structuremachine>, // Machine Structure
  '♥': <ore:gearRedstone>, // Redstone Gear
});

// [Fluid Input Hatch] from [Machine Structure][+3]
craft.remake(<libvulpes:hatch:2>, ['pretty',
  '  F  ',
  'S M S',
  '  ¤  '], {
  'F': <actuallyadditions:block_laser_relay_fluids>, // Fluid Laser Relay
  'S': <ore:itemSimpleChassiParts>, // Simple Machine Parts
  'M': <libvulpes:structuremachine>, // Machine Structure
  '¤': <ore:gearVibrant>, // Vibrant Bimetal Gear
});

// [Fluid Output Hatch] from [Machine Structure][+3]
craft.remake(<libvulpes:hatch:3>, ['pretty',
  '  F  ',
  'S M S',
  '  ¤  '], {
  'F': <extrautils2:flattransfernode:1>, // Flat Transfer Node (Fluids)
  'S': <ore:itemSimpleChassiParts>, // Simple Machine Parts
  'M': <libvulpes:structuremachine>, // Machine Structure
  '¤': <ore:gearVibrant>, // Vibrant Bimetal Gear
});

// [Power Input Plug] from [Machine Structure][+3]
recipes.removeByRecipeName('libvulpes:forgepowerinput');
craft.make(<libvulpes:forgepowerinput>, ['pretty',
  '  Σ  ',
  'S M S',
  'B B B'], {
  'Σ': <enderio:block_buffer:1>, // Power Buffer
  'S': <ore:itemSimpleChassiParts>, // Simple Machine Parts
  'M': <libvulpes:structuremachine>, // Machine Structure
  'B': <ore:itemBattery>, // Single Battery
});

// [Single Battery] from [Iridium Rod][+2]
craft.remake(<libvulpes:battery>, ['pretty',
  '  ╱  ',
  '⌂ : ⌂',
  '⌂ : ⌂'], {
  '╱': <ore:stickIridium>, // Iridium Rod
  '⌂': <ic2:casing:5>, // Steel Item Casing
  ':': <ore:oc:capacitor>, // Capacitor
});

// [Steel Fan] from [Steel Rod][+2]
craft.remake(<libvulpes:productfan:6>, ['pretty',
  '⌂ S ⌂',
  'S ╱ S',
  '⌂ S ⌂'], {
  '⌂': <ic2:casing:5>, // Steel Item Casing
  'S': <ore:wireSteel>, // Steel Wire
  '╱': <ore:stickSteel>, // Steel Rod
});

// [Nuclear Thermal Fission Core] from [Solid Fuel Fission Controller][+3]
craft.remake(<advancedrocketry:nuclearcore>, ['pretty',
  'M P M',
  'B S B',
  'M P M'], {
  'M': <libvulpes:structuremachine>, // Machine Structure
  'P': <advancedrocketry:liquidtank>, // Pressurized Tank
  'B': <ore:processorBasic>, // Basic Processor
  'S': <nuclearcraft:solid_fission_controller>, // Solid Fuel Fission Controller
});

// Some Alts with advanced machines
scripts.process.solution([<thermalfoundation:material:771> * 30], [<fluid:oxygen>       * 1500], [<fluid:sulfuric_acid> * 3000], null, 'only: ChemicalReactor', { energy: 140000, time: 15 });
scripts.process.solution([<thermalfoundation:material:771> * 30], [<fluid:liquidoxygen> * 1500], [<fluid:sulfuric_acid> * 3000], null, 'only: ChemicalReactor', { energy: 140000, time: 15 });
mods.advancedrocketry.RecipeTweaker.forMachine('Crystallizer').builder()
  .inputOre(<ore:dustFluorite>, 6)
  .inputLiquid(<fluid:sulfuric_acid> * 6000)
  .outputItem(<nuclearcraft:compound> * 6)
  .build();

// Remove carbon (defined in ExNihilio configs)
recipes.remove(<advancedrocketry:misc:1>);

// Endorum
mods.advancedrocketry.RecipeTweaker.forMachine('Crystallizer').builder()
  .input(<extrautils2:enderlilly>)
  .inputLiquid(<fluid:ice> * 1000)
  .outputItem(<endreborn:item_raw_endorium> * 10)
  .build();

// [Basic Circuit Plate] from [Graphite Ingot][+2]
mods.advancedrocketry.RecipeTweaker.forMachine('PrecisionLaserEtcher').builder()
  .inputOre(<ore:plateGold>)
  .inputOre(<ore:ingotGraphite>)
  .inputOre(<ore:waferSilicon>)
  .outputItem(<advancedrocketry:itemcircuitplate>)
  .power(100000)
  .timeRequired(20)
  .build();

// [Advanced Circuit Plate] from [Energetic Alloy Ingot][+2]
mods.advancedrocketry.RecipeTweaker.forMachine('PrecisionLaserEtcher').builder()
  .inputOre(<ore:circuitUltimate>)
  .inputOre(<ore:ingotEnergeticAlloy>)
  .inputOre(<ore:waferSilicon>)
  .outputItem(<advancedrocketry:itemcircuitplate:1>)
  .power(140000)
  .timeRequired(20)
  .build();

// [Station Light]*12 from [Glowstone][+1]
craft.remake(<advancedrocketry:circlelight> * 12, ['pretty',
  '  A  ',
  'A g A',
  '  A  '], {
  'A': <ore:sheetAluminum> | <ore:sheetAluminium>, // Aluminum Sheet
  'g': <ore:glowstone> | <ore:blockGlowstone>, // Glowstone
});

// [Thermite Torch]*8 from [Stick][+1]
craft.remake(<advancedrocketry:thermitetorch> * 8, [
  '▲',
  '#'], {
  '▲': <ore:dustThermite>, // Thermite
  '#': <ore:stickWood>, // Stick
});

// Harder to match other mod complexity
// [Basic Lens] from [Quartz Glass]
craft.remake(<advancedrocketry:lens>, ['pretty',
  '  ⌃  ',
  '⌃   ⌃'], {
  '⌃': <appliedenergistics2:quartz_glass>, // Quartz Glass
});

// [Vacuum-Chamber High Power Laser Emitter] from [Advanced Machine Structure][+5]
craft.remake(<advancedrocketry:vacuumlaser>, ['pretty',
  'Y R O',
  'L ⌂ L',
  'T T T'], {
  'Y': <advancedrocketry:crystal:4>, // Yellow Crystal Block
  'R': <advancedrocketry:crystal:3>, // Red Crystal Block
  'O': <advancedrocketry:crystal:5>, // Orange Crystal Block
  'L': <advancedrocketry:blocklens>, // Lens
  '⌂': <ore:casingCentrifuge>, // Advanced Machine Structure
  'T': <ore:sheetTitaniumIridium>, // Titanium Iridium Alloy Sheet
});

// Way harder [Rocket Fuel] recipe for using as ingredients in other recipes
mods.tconstruct.Alloy.addRecipe(<liquid:rocketfuel> * 1000, [
  <liquid:gasoline> * 1000,
  <liquid:syngas> * 1000,
  <liquid:liquidfusionfuel> * 200,
  <liquid:empoweredoil> * 200,
  <liquid:refined_fuel> * 200,
]);

// Craft for Enriched Lava as exploration alt
mods.tconstruct.Alloy.addRecipe(<liquid:enrichedlava> * 1000, [
  <liquid:ic2pahoehoe_lava> * 2000, // Pahoehoe Lava
  <liquid:xu_demonic_metal> * 1000, // Molten Demon Metal
  <liquid:xu_enchanted_metal> * 288, // Enchanted Metal
  <liquid:sic_vapor> * 250, // Silicon Carbide Vapor
]);

//####################################
// Remake coils harder
//####################################
// [Copper Coil] from [Copper Turbine Dynamo Coil]
recipes.remove(<libvulpes:coil0:4>);
recipes.addShapeless(<libvulpes:coil0:4>, [<nuclearcraft:turbine_dynamo_coil:4>]);

// [Gold Coil] from [Gold Turbine Dynamo Coil]
recipes.remove(<libvulpes:coil0:2>);
recipes.addShapeless(<libvulpes:coil0:2>, [<nuclearcraft:turbine_dynamo_coil:3>]);

// [Aluminum Coil] from [Aluminum Turbine Dynamo Coil]
recipes.remove(<libvulpes:coil0:9>);
recipes.addShapeless(<libvulpes:coil0:9>, [<nuclearcraft:turbine_dynamo_coil:2>]);

// [Iridium Coil] from [Beryllium Turbine Dynamo Coil][+1]
craft.remake(<libvulpes:coil0:10>, ['pretty',
  '□ □ □',
  '□ B □',
  '□ □ □'], {
  '□': <ore:plateTitaniumIridium>, // Titanium Iridium Alloy Plate
  'B': <nuclearcraft:turbine_dynamo_coil:1>, // Beryllium Turbine Dynamo Coil
});

// [Titanium Coil] from [Beryllium Turbine Dynamo Coil][+1]
craft.remake(<libvulpes:coil0:7>, ['pretty',
  '□ □ □',
  '□ B □',
  '□ □ □'], {
  '□': <ore:plateTitanium>, // Titanium Plate
  'B': <nuclearcraft:turbine_dynamo_coil:1>, // Beryllium Turbine Dynamo Coil
});
//####################################

// Skyblock recipe
// [Lightwood Leaves]*8 from [Moon Turf][+2]
mods.thaumcraft.Infusion.registerRecipe(
  'alienleaves', // Name
  'INFUSION', // Research
  <advancedrocketry:alienleaves> * 8, // Output
  3, // Instability
  Aspects('100ඞ'),
  <advancedrocketry:moonturf>, // Central Item
  Grid(['pretty',
    'L L L',
    'L   L',
    'L L L'], {
    'L': <twilightforest:magic_leaves:1>, // Leaves of Transformation
  }).spiral(1));

// [Precision Assembler] from [Machine Structure][+4]
craft.remake(<advancedrocketry:precisionassemblingmachine>, ['pretty',
  '  U  ',
  'I M C',
  '¤ ¤ ¤'], {
  'U': <advancedrocketry:misc>,      // User Interface
  'I': <advancedrocketry:ic:4>,      // Item IO Circuit Board
  'M': <libvulpes:structuremachine>, // Machine Structure
  'C': <advancedrocketry:ic:3>,      // Control Circuit Board
  '¤': <ore:gearDiamond>,            // Diamond Gear
});
