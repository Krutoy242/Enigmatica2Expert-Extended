#modloaded forestry thaumcraft

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;

// Remove Crafting Table recipes but keep carpenter's
recipes.remove(<forestry:bronze_shovel>);
recipes.remove(<forestry:bronze_pickaxe>);

// Remove deprecated recipes
recipes.removeByRecipeName('forestry:greenhouse_control');
recipes.removeByRecipeName('forestry:greenhouse_dehumidifier');
recipes.removeByRecipeName('forestry:greenhouse_fan');
recipes.removeByRecipeName('forestry:greenhouse_gearbox');
recipes.removeByRecipeName('forestry:greenhouse_heater');
recipes.removeByRecipeName('forestry:greenhouse_humidifier');
recipes.removeByRecipeName('forestry:greenhouse_hygro');
recipes.removeByRecipeName('forestry:greenhouse_plain');
recipes.removeByRecipeName('forestry:greenhouse_window_roof');
recipes.removeByRecipeName('forestry:greenhouse_window');

// Fix grapes have two different outputs - Fruit Juice and Grape Juice
mods.forestry.Squeezer.removeRecipe(<liquid:juice>, [<rustic:grapes>]);

// Fixing fruit juice amount from tomatos
for tomato in <ore:cropTomato>.items {
  mods.forestry.Squeezer.removeRecipe(<liquid:juice>, [tomato]);
  mods.forestry.Squeezer.addRecipe(<liquid:juice> * 100, [tomato], 100);
}

// Forester's Manual
recipes.remove(<forestry:book_forester>);
recipes.addShapeless('Foresters Manual',
  <forestry:book_forester>,
  [<minecraft:book>, <minecraft:sapling:*>, <minecraft:sapling:*>]);

// Intricate Circuit Board
mods.forestry.Carpenter.removeRecipe(<forestry:chipsets:3>);
scripts.mods.forestry.Carpenter.addRecipe(<forestry:chipsets:3>.withTag({ T: 3 as short }),
  Grid(['pretty',
    '◊ B ◊',
    '◊ E ◊',
    '◊ R ◊'], {
    'B': <forestry:chipsets:0>.withTag({ T: 0 as short }, false), // Basic Circuit Board
    'R': <forestry:chipsets:2>.withTag({ T: 2 as short }, false), // Refined Circuit Board
    'E': <forestry:chipsets:1>.withTag({ T: 1 as short }, false), // Enhanced Circuit Board
    '◊': <ore:gemAmber>, // Amber
  }).shaped(), 40, <liquid:water> * 1000);

// Sturdy Casing
scripts.mods.extendedcrafting_engineering.remakeAlted(
  <forestry:sturdy_machine> * 2, ['pretty',
  '☼ ▬ ☼',
  '▬   ▬',
  '¤ ▬ ¤'], {
  '☼': <ore:gearCopper>,
  '▬': <ore:ingotBronze>,
  '¤': <ore:gearBronze>,
}, 4, {
  '☼': <ore:gearConstantan>,
  '▬': <ore:ingotBrass>,
});

// [Hardened Casing] from [Sturdy Casing][+1]
mods.forestry.Carpenter.removeRecipe(<forestry:hardened_machine>);
scripts.mods.forestry.Carpenter.addRecipe(<forestry:hardened_machine>,
  Grid(['pretty',
    '◊   ◊',
    '  ⌂  ',
    '◊   ◊'], {
    '◊': <ore:gemDiamondRat>,       // Rat Diamond
    '⌂': <forestry:sturdy_machine>, // Sturdy Casing
  }).shaped(), 40, <liquid:water> * 5000);

// Carpenter
recipes.remove(<forestry:carpenter>);
recipes.addShapedMirrored('Carpenter',
  <forestry:carpenter>,
  [[<ore:plankTreatedWood>, <ore:listAllwater>, <ore:plankTreatedWood>],
    [<ore:plankTreatedWood>, <forestry:sturdy_machine>, <ore:plankTreatedWood>],
    [<ore:plankTreatedWood>, <ore:listAllwater>, <ore:plankTreatedWood>]]);

// Fermenter
recipes.remove(<forestry:fermenter>);
recipes.addShapedMirrored('Fermenter',
  <forestry:fermenter>,
  [[<ore:plankTreatedWood>, <ore:gearBronze>, <ore:plankTreatedWood>],
    [<ore:blockGlass>, <forestry:sturdy_machine>, <ore:blockGlass>],
    [<ore:plankTreatedWood>, <ore:gearBronze>, <ore:plankTreatedWood>]]);

// Squeezer
recipes.remove(<forestry:squeezer>);
recipes.addShapedMirrored('Squeezer',
  <forestry:squeezer>,
  [[<ore:plankTreatedWood>, <ore:blockGlass>, <ore:plankTreatedWood>],
    [<ore:gearTin>, <forestry:sturdy_machine>, <ore:gearTin>],
    [<ore:plankTreatedWood>, <ore:blockGlass>, <ore:plankTreatedWood>]]);

// Thermionic Fabricator
recipes.remove(<forestry:fabricator>);
recipes.addShaped('Thermionic Fabricator',
  <forestry:fabricator>,
  [[<ore:gearGold>, <ore:blockGlass>, <ore:gearGold>],
    [<ore:blockGlass>, <forestry:hardened_machine>, <ore:blockGlass>],
    [<ore:gearGold>, <forestry:impregnated_casing>, <ore:gearGold>]]);

// Removing shapeless bronze crafting recipe
recipes.remove(<forestry:ingot_bronze>);

// More Fermenter compat
val FermenterFluid = {
  <liquid:wildberryjuice>: 1.26,
  <liquid:ironberryjuice>: 1.00,
  <liquid:grapejuice>    : 1.50,
  <liquid:applejuice>    : 1.50,
  <liquid:for.honey>     : 1.50,
  <liquid:honey>         : 1.50,
  <liquid:water>         : 1.00,
} as float[ILiquidStack]$orderly;

for liquid, ratio in FermenterFluid {
  // Most vanilla plants replacement
  mods.forestry.Fermenter.addRecipe(<liquid:biomass>, <harvestcraft:oliveoilitem>, liquid, 60, ratio); // was ~50
  mods.forestry.Fermenter.addRecipe(<liquid:biomass>, <ic2:crafting:20>, liquid, 1000, ratio); // Was 450
  mods.forestry.Fermenter.addRecipe(<liquid:biomass>, <ic2:crafting:21>, liquid, 1500, ratio); // Was 450
}

// Make melons give fruit juice
mods.forestry.Squeezer.addRecipe(<liquid:juice> * 15, [<minecraft:melon>], 8);

// Remove and hide charcoal block
Purge(<forestry:charcoal>).ores([<ore:blockCharcoal>]);

// Remove pulp recipe
mods.forestry.Carpenter.removeRecipe(<forestry:wood_pulp>);
mods.forestry.Carpenter.addRecipe(<thermalfoundation:material:800>, [[<ore:logWood>]], 40, <liquid:water> * 250);

mods.forestry.Carpenter.removeRecipe(<forestry:letters>);
mods.forestry.Carpenter.addRecipe(<forestry:letters>, Grid(['AAA','AAA'], { A: <thermalfoundation:material:800> }).shaped(), 40, <liquid:water> * 250);

// Fertilizer ask less sand but more Apatite
// [Fertilizer*8] from [Sand][+1]
craft.remake(<forestry:fertilizer_compound> * 8,
  ['◊', 's', '◊'], {
    's': <ore:sand>,      // Sand
    '◊': <ore:gemApatite>, // Apatite
  });

// [Fertilizer*16] from [Apatite][+1]
craft.remake(<forestry:fertilizer_compound> * 16, ['pretty',
  '▲ ◊ ▲',
  '▲ ▲ ▲',
  '▲ ◊ ▲'], {
  '▲': <ore:dustAsh>,   // Ash
  '◊': <ore:gemApatite>, // Apatite
});

// Buff light level of lit candles
<forestry:candle:1>.asBlock().definition.lightLevel = 0.95;

// Simplify andvanced bags
val bagNames = [
  'miner',
  'digger',
  'forester',
  'hunter',
  'adventurer',
  'builder',
] as string[];

val vax = <ore:itemBeeswax>;
for name in bagNames {
  val splBag = itemUtils.getItem('forestry:' ~ name ~ '_bag');
  val advBag = itemUtils.getItem('forestry:' ~ name ~ '_bag_t2');
  mods.forestry.Carpenter.removeRecipe(advBag);

  recipes.addShaped('adv ' ~ name, advBag, [
    [null, <quark:gold_button>, null],
    [vax, splBag, vax],
    [null, <ore:fabricHemp>, null],
  ]);
}

mods.forestry.Carpenter.removeRecipe(<forestry:oak_stick>);
mods.forestry.Carpenter.removeRecipe(<forestry:impregnated_casing>);
for oil in [<liquid:oliveoil>, <liquid:seed.oil>] as ILiquidStack[] {
  // Use OreDict recipe for impregnated stick
  scripts.mods.forestry.Carpenter.addRecipe(<forestry:oak_stick> * 2, [[<ore:logWood>],[<ore:logWood>]], 40, oil * 100);
  mods.thermalexpansion.Transposer.addFillRecipe(<forestry:oak_stick> * 9, <additionalcompression:logwood_compressed>, oil * 900, 9000);

  // Use OreDict recipe for Impregnated Casing
  mods.forestry.Carpenter.addRecipe(<forestry:impregnated_casing>,
    Grid(['AAA','A A','AAA'], { A: <ore:logWood> }).shaped(), 40, oil * 250
  );
  scripts.processUtils.avdRockXmlRecipeFlatten('PrecisionAssembler',
    <forestry:impregnated_casing>, [[<additionalcompression:logwood_compressed>]], oil * 250
  );
}

// Cheaper capsules
mods.forestry.Carpenter.removeRecipe(<forestry:wood_pulp>);
mods.forestry.Carpenter.removeRecipe(<forestry:crafting_material:4>);
mods.forestry.Carpenter.removeRecipe(<forestry:iodine_capsule>);
scripts.mods.forestry.Carpenter.addRecipe(<forestry:crafting_material:4>, [[<forestry:honeydew>, <ic2:fluid_cell>]], 100, <fluid:water> * 1000);
scripts.mods.forestry.Carpenter.addRecipe(<forestry:iodine_capsule>, [[<forestry:honey_drop>, <ic2:fluid_cell>]], 100, <fluid:water> * 1000);

# [Honey Pot] from [Honey Drop][+1]
craft.remake(<forestry:honey_pot>, [
  "B",
  "H",
  "B"], {
  "B": <ore:itemBeeswax>, # Beeswax
  "H": <ore:dropHoney>,   # Honey Drop
});

# [Ambrosia] from [Royal Jelly][+1]
craft.remake(<forestry:ambrosia>, [
  "B",
  "R",
  "B"], {
  "B": <ore:itemBeeswax>,    # Beeswax
  "R": <ore:dropRoyalJelly>, # Royal Jelly
});

// Proven Frames recycling
// [Impregnated Stick]*16 from [Proven Frame]
scripts.process.sawWood(<forestry:frame_proven>, <forestry:oak_stick> * 3);

// Unbreakable recipe
// [Proven Frame] from [Proven Frame][+7]
mods.thaumcraft.Infusion.registerRecipe(
  "frame_proven", # Name
  "INFUSION", # Research
  <forestry:frame_proven>.withTag({ench: [{}], enchantmentColor: 16579587, Unbreakable: 1 as byte}), # Output
  3, # Instability
  Aspects('40💨 40✊ 40🛎️'),
  <forestry:frame_proven>, # Central Item
  Grid(['pretty',
  '  ▲  ',
  '‚   ‚',
  '  ▬  '], {
  '▲': <ore:dustMana>,          // Mana Dust
  '‚': <ore:nuggetMithrillium>, // Mithrillium Nugget
  '▬': <ore:ingotGlitch>,       // Glitch Infused Ingot
}).spiral(1));

<forestry:wax_cast>.maxDamage = 32;

// [Advanced Analyzer] from [Analyzer][+2]
craft.remake(<requious:adv_bee_analyzer>, ['pretty',
  'S t S',
  'S A S'], {
  'A': <forestry:analyzer>,            // Analyzer
  'S': <forestry:crafting_material:6>, // Scented Paneling
  't': <forestry:propolis:1>,          // Sticky Propolis
});

// Remake recipe, because original recipe cant actually accept any propolis (but shows any)
craft.reshapeless(<forestry:bituminous_peat> * 8, 'PPPPrPPPP', {
  'r': <forestry:propolis:*>,
  'P': <ore:brickPeat>,
});

// Bitumen from peat
mods.rustic.CrushingTub.addRecipe(<liquid:oil> * 500, <thermalfoundation:material:892>, <forestry:bituminous_peat>);

// Honey drop on evaporation
mods.rustic.EvaporatingBasin.addRecipe(<forestry:honey_drop>, <liquid:for.honey>      * 1000);
mods.rustic.EvaporatingBasin.addRecipe(<forestry:honey_drop>, <liquid:honey>          * 1000);

// Pipete clearing
recipes.addShapeless('Pipete clearing', <forestry:pipette>, [<forestry:pipette>]);

// Alt for players who hate bees
val RJ = <harvestcraft:royaljellyitem>; // Royal Jelly
mods.actuallyadditions.Empowerer.addRecipe(<forestry:royal_jelly>, <actuallyadditions:item_worm>, RJ, RJ, RJ, RJ, 250000, 200, [1.0, 1.0, 0.0]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<forestry:royal_jelly>, 1000000, 1000000, <actuallyadditions:item_worm>, [RJ, RJ, RJ, RJ]);

// [Portable Analyzer] from [Redstone][+2]
mods.forestry.Carpenter.removeRecipe(<forestry:portable_alyzer>);
craft.make(<forestry:portable_alyzer>, ['pretty',
  '⌂ G ⌂',
  '⌂ G ⌂',
  '⌂ ♥ ⌂'], {
  '⌂': <ic2:casing:3>,     // Iron Item Casing
  'G': <ore:paneGlass>,    // Glass Pane
  '♥': <ore:dustRedstone>, // Redstone
});

// Phosphor line
val PH = <forestry:phosphor>;
val Po = <contenttweaker:ore_phosphor>;
val Pn = <contenttweaker:nugget_phosphor>;
recipes.addShapeless('ingot phosphor', PH, [Pn, Pn, Pn, Pn, Pn, Pn, Pn, Pn, Pn]);
recipes.addShapeless('nuggets phosphor', Pn * 9, [PH]);
scripts.process.crush(<ore:blockApatite>, Po, 'only: IECrusher', [Pn], [0.05]);
mods.ic2.ThermalCentrifuge.addRecipe([Po * 9, Pn * 4], <forestry:resource_storage> * 9);

// Phosphor Benefication
furnace.addRecipe(Pn, Po);
scripts.processWork.workEx('infernalfurnace', null, [Po], null, null, null, [Pn * 2], [0.5], null);
scripts.process.crush(Po, Pn, 'only: IECrusher Pulverizer', [Pn], [0.5]);
scripts.process.magic([Po], [Pn * 3]);

// Remove automatic TE recipes
mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material:866>, Po);
mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material:865>, Po);
mods.thermalexpansion.InductionSmelter.removeRecipe(<minecraft:sand>, Po);

// Cheaper farm blocks
val farmBlocks = [
  <minecraft:stonebrick>,
  <minecraft:stonebrick:1>,
  <minecraft:stonebrick:2>,
  <minecraft:brick_block>,
  <minecraft:sandstone:2>,
  <minecraft:sandstone:1>,
  <minecraft:nether_brick>,
  <minecraft:stonebrick:3>,
  <minecraft:quartz_block>,
  <minecraft:quartz_block:1>,
  <minecraft:quartz_block:2>,
] as IIngredient[];
for i, input in farmBlocks {
  // [Farm Block] from [Tin Electron Tube][+3]
  craft.remake(<forestry:ffarm>.withTag({ FarmBlock: i }) * 12, ['pretty',
    '▬ ⌃ ▬',
    '# T #'], {
    '⌃': input,
    '▬': <ore:ingotCopper>,             // Copper Ingot
    '#': <ore:slabWood>,                // Wood Slab
    'T': <forestry:thermionic_tubes:1>, // Tin Electron Tube
  });
}

// Since tubes was buffed via mixins, make Blazing Tube recipe way harder
mods.forestry.ThermionicFabricator.removeCast(<forestry:thermionic_tubes:7> * 4);
scripts.mods.forestry.ThermionicFabricator.addCast(<forestry:thermionic_tubes:7> * 4, Grid(['pretty',
  '  ▲  ',
  '♥ ▲ ♥',
  '▲ ▲ ▲'], {
  '▲': <ore:dustPyrotheum>,
  '♥': <ore:nuggetRedstoneAlloy>,
}).shaped(), <fluid:glass> * 500);

// Cheaper usage of Blazing Tube since it costy
craft.remake(<forestry:farm_nether>, ['pretty',
  '▬ ▲ ▬',
  '▲ ⌂ ▲',
  '▬ B ▬'], {
  '▬': <ore:ingotBrickNether>,
  '▲': <ore:dustBlaze>,
  '⌂': <forestry:flexible_casing>,
  'B': <forestry:chipsets:0>.withTag({ T: 0 as short }, false),
});

// Recycling
scripts.process.melt(<forestry:smoker>, <fluid:tin> * (144 * 5));

// [Carton] from [Compressed Sawdust]
scripts.process.crush(<thermalfoundation:material:801> /* Compressed Sawdust */, <forestry:carton>, 'only: CrushingBlock');

// Remove all fireproof recipes. Fireproof only obtainable through breeding.
for log, plank in scripts.lib.wood.logPlankFireproof {
  mods.forestry.ThermionicFabricator.removeCast(log);
  mods.forestry.ThermionicFabricator.removeCast(plank * 5);
}

// Remove Propolis => glass recipes
for i in 0 .. 16 {
  mods.forestry.ThermionicFabricator.removeCast(<minecraft:stained_glass>.definition.makeStack(i) * 4);
}

// [Ash Bricks] from [Mud Brick][+1]
craft.make(<forestry:ash_brick>, ['pretty',
  '▲ M ▲',
  'M   M',
  '▲ M ▲'], {
  '▲': <ore:dustAsh>,            // Ash
  'M': <tconstruct:materials:1>, // Mud Brick
});

// Make x2 cheaper to help with Wood Piles
// [Loam]*8 from [Compost][+2]
craft.remake(<forestry:loam> * 8, ['pretty',
  'c C c',
  '▲ c ▲',
  'c C c'], {
  'c': <ore:clay>, // Clay
  'C': <forestry:fertilizer_bio>,   // Compost
  '▲': <ore:dust>,                  // Dust
});

recipes.remove(<forestry:fertilizer_bio>);

// [Compost]*6 from [Mud Ball][+1]
craft.make(<forestry:fertilizer_bio> * 6, ['pretty',
  '  W  ',
  'W M W',
  '  W  '], {
  'W': <minecraft:wheat>, // Wheat
  'M': <ore:ballMud>,     // Mud Ball
});

// [Compost]*6 from [Mud Ball][+1]
craft.make(<forestry:fertilizer_bio> * 6, ['pretty',
  '  A  ',
  'A M A',
  '  A  '], {
  'A': <harvestcraft:barleyitem>, // Barley
  'M': <ore:ballMud>,             // Mud Ball
});

// [Compost]*6 from [Mud Ball][+1]
craft.make(<forestry:fertilizer_bio> * 6, ['pretty',
  '  A  ',
  'A M A',
  '  A  '], {
  'A': <harvestcraft:oatsitem>, // Oats
  'M': <ore:ballMud>,           // Mud Ball
});

// [Compost]*6 from [Mud Ball][+1]
craft.make(<forestry:fertilizer_bio> * 6, ['pretty',
  '  A  ',
  'A M A',
  '  A  '], {
  'A': <harvestcraft:ryeitem>, // Rye
  'M': <ore:ballMud>,          // Mud Ball
});

// [Compost]*6 from [Mud Ball][+1]
craft.make(<forestry:fertilizer_bio> * 6, ['pretty',
  '  ▲  ',
  '▲ M ▲',
  '  ▲  '], {
  '▲': <ore:dustAsh>, // Ash
  'M': <ore:ballMud>, // Mud Ball
});

// [Arborist's Chest] from [Oak Chest][+2]
craft.remake(<forestry:tree_chest>, ['pretty',
  '  ■  ',
  'P c P',
  'P P P'], {
  '■': <ore:blockGlass>, // Glass
  'P': <ic2:crafting:20>, // Plantball
  'c': <ore:chest>, // Oak Chest
});
