#modloaded thaumcraft
#ignoreBracketErrors

import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.item.WeightedItemStack;
import thaumcraft.aspect.CTAspectStack;
import mods.requious.AssemblyRecipe;

// Taint to Flux Goo
<assembly:crafting_hints>.addJEIRecipe(AssemblyRecipe.create(function (c) {
  c.addFluidOutput('fluid_out', <fluid:flux_goo> * 1000);
})
  .requireItem('input5', <thaumcraft:bottle_taint>)
);

// Add durability to scribbing tools
<thaumcraft:scribing_tools>.maxDamage = 600;

// Missed Cluster furnace recipes
furnace.addRecipe(<thaumcraft:quicksilver> * 2, <thaumcraft:cluster:6>);
furnace.addRecipe(<thermalfoundation:material:128> * 2, <thaumcraft:cluster:2>);
furnace.addRecipe(<thermalfoundation:material:129> * 2, <thaumcraft:cluster:3>);
furnace.addRecipe(<thermalfoundation:material:130> * 2, <thaumcraft:cluster:4>);
furnace.addRecipe(<thermalfoundation:material:131> * 2, <thaumcraft:cluster:5>);

// Fix Infernal Furnace unchangeable nuggets output
craft.shapeless(<thermalfoundation:material:128>, 'aaaaaaaaa', { a: <thaumcraft:nugget:1> });
craft.shapeless(<thermalfoundation:material:129>, 'aaaaaaaaa', { a: <thaumcraft:nugget:2> });
craft.shapeless(<thermalfoundation:material:130>, 'aaaaaaaaa', { a: <thaumcraft:nugget:3> });
craft.shapeless(<thermalfoundation:material:131>, 'aaaaaaaaa', { a: <thaumcraft:nugget:4> });

// Primordial Pearl alt (for some people who dont want to close rifts)
mods.astralsorcery.Altar.addConstellationAltarRecipe(
  'Primordial Pearl alt', <thaumcraft:primordial_pearl>, 1500, 250, Grid([
    'TVT'
    + 'CSC'
    + 'TVT'
    + 'EEEE'
    + '♦♦♦♦◊◊◊◊'], {
    'C': <thaumcraft:causality_collapser>, // Causality Collapser
    'S': <ore:runeSlothB>, // Rune of Sloth
    'T': <thaumcraft:taint_log>, // Taintwood Log
    'E': <contenttweaker:empowered_phosphor>, // Empowered Phosphor
    'V': <thaumcraft:void_seed>, // Void Seed
    '♦': <ore:gemTopaz>, // Topaz
    '◊': <ore:gemTanzanite>, // Tanzanite
  }).shapeless()
);

// Since Alch Brass is cheaper, it should not be used for casts
mods.tconstruct.Casting.removeTableRecipe(<tconstruct:cast>, <liquid:brass>);

// ---------------------------
// No-exploration recipe
for aspect, ingr in {
  aer     : <minecraft:feather>,
  terra   : <minecraft:mossy_cobblestone>,
  ignis   : <rustic:chili_pepper>,
  aqua    : <harvestcraft:freshwateritem>,
  ordo    : <advancedrocketry:misc:1>,
  perditio: <minecraft:gunpowder>,
} as IItemStack[string] {
  mods.rustic.Condenser.addRecipe(
    <thaumcraft:crystal_essence>.withTag({ Aspects: [{ key: aspect, amount: 1 }] }),
    [<thaumcraft:nugget:9>, ingr], null, null
  );
}

function getAnyVisCrystal(key as string = '8', col as int = 0x333333, matchNBTCheck as bool = false) as IItemStack {
  return <thaumcraft:crystal_essence>.withTag(
    utils.shiningTag(col) + {
      Aspects: [{ key: 'ordo', amount: 1 }],
      display: { Name: '§' ~ key ~ '§lAny Different Vis Crystal' },
    } as IData,
    matchNBTCheck);
}

function getAnyVisSalt(key as string = '8', col as int = 0x333333) as IItemStack {
  return <thaumadditions:salt_essence>.withTag(
    utils.shiningTag(col) + {
      Aspects: [{ key: 'ordo', amount: 1 }],
      display: { Name: '§' ~ key ~ '§lAny Vis Salt' },
    } as IData,
    false)
    ?? <thaumcraft:salis_mundus>;
}

/*
████████╗ █████╗ ██████╗ ██╗     ███████╗
╚══██╔══╝██╔══██╗██╔══██╗██║     ██╔════╝
   ██║   ███████║██████╔╝██║     █████╗
   ██║   ██╔══██║██╔══██╗██║     ██╔══╝
   ██║   ██║  ██║██████╔╝███████╗███████╗
   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝
*/

// [Arcane Stone]*9 from [Ordo Vis Crystal][+1]
recipes.removeByRecipeName('thaumcraft:stonearcane');
craft.shapeless(<thaumcraft:stone_arcane> * 9, 'ssss*ssss', {
  's': <ore:stone>, // Stone
  '*': getAnyVisCrystal(),
});

// [Arcane Stone]*36 from [Single Compressed Stone][+1]
craft.make(<thaumcraft:stone_arcane> * 36, ['pretty',
  '* ■ *',
  '■   ■',
  '* ■ *'], {
  '*': getAnyVisCrystal(),
  '■': <ore:compressedStone1x>, // Single Compressed Stone
});

// [Arcane Stone]*64 from [Double Compressed Stone][+1]
craft.make(<thaumcraft:stone_arcane> * 64, ['pretty',
  '*   *',
  '* S *',
  '* * *'], {
  '*': getAnyVisCrystal(),
  'S': <ore:compressedStone2x>, // Double Compressed Stone
});

// [Void Seed] from [Insanium Essence][+4]
craft.remake(<thaumcraft:void_seed> * 4, ['pretty',
  'A I A',
  '© T ©',
  'T E T'], {
  'A': <exnihilocreatio:item_material:3>, // Ancient Spores
  'E': <ore:runeEnvyB>, // Rune of Envy
  '©': <contenttweaker:blasted_coal>, // Blasted Coal
  'I': <ore:essenceInsanium>, // Insanium Essence
  'T': <thaumcraft:taint_rock> | <thaumcraft:taint_soil> | <thaumcraft:taint_crust>, // Tainted Rock
});

// Amber Block
recipes.removeByRecipeName('thaumcraft:ambertoblock');
recipes.addShapeless('Thaumcraft Amber Block',
  <thaumcraft:amber_block>, [
    <ore:gemAmber>, <ore:gemAmber>, <ore:gemAmber>, <ore:gemAmber>, <ore:gemAmber>,
    <ore:gemAmber>, <ore:gemAmber>, <ore:gemAmber>, <ore:gemAmber>,
  ]);

// Amber Gem
recipes.removeByRecipeName('biomesoplenty:amber');
recipes.removeByRecipeName('thaumcraft:amberblocktoamber');
recipes.addShapeless('Amber Gem', <thaumcraft:amber> * 9, [<ore:blockAmber>]);

// Amber Bricks
recipes.remove(<thaumcraft:amber_brick>);
recipes.addShapeless('Thaumcraft Amber Brick',
  <thaumcraft:amber_brick> * 4,
  [<thaumcraft:amber_block>, <thaumcraft:amber_block>, <thaumcraft:amber_block>, <thaumcraft:amber_block>]);

// Mundane Ring
recipes.remove(<thaumcraft:baubles:1>);
recipes.addShaped(<thaumcraft:baubles:1>,
  [[<ore:ingotGold>, <ore:ingotBrass>, <ore:ingotGold>],
    [<ore:ingotBrass>, <ore:clusterGold>, <ore:ingotBrass>],
    [<ore:ingotGold>, <ore:ingotBrass>, <ore:ingotGold>]]);

// Fancy Ring
recipes.remove(<thaumcraft:baubles:5>);
recipes.addShaped(<thaumcraft:baubles:5>,
  [[<ore:ingotGold>, <ore:gemEmerald>, <ore:ingotGold>],
    [<ore:ingotGold>, <thaumcraft:baubles:1>, <ore:ingotGold>],
    [<ore:ingotGold>, <ore:blockGold>, <ore:ingotGold>]]);

// Fancy Belt
recipes.remove(<thaumcraft:baubles:6>);
recipes.addShaped(<thaumcraft:baubles:6>,
  [[<ore:leather>, <ore:leather>, <ore:leather>],
    [<ore:leather>, <ore:clusterCopper>, <ore:leather>],
    [<ore:gemEmerald>, <thaumcraft:baubles:2>, <ore:gemEmerald>]]);

// Salis Mundus visible recipe (actually not working)
craft.shapeless(<thaumcraft:salis_mundus>, 'DEFCAB', {
  A: utils.reuse(<minecraft:flint>),
  B: utils.reuse(<minecraft:bowl>),
  C: <ore:dustRedstone>,
  D: getAnyVisCrystal('4', 0xFF0000, true),
  E: getAnyVisCrystal('2', 0x00FF00, true),
  F: getAnyVisCrystal('b', 0x00FFFF, true),
}
);

// ---------------------------
// Remake colored candles
val candleColors = [
  <thaumcraft:candle_white>,
  <thaumcraft:candle_orange>,
  <thaumcraft:candle_magenta>,
  <thaumcraft:candle_lightblue>,
  <thaumcraft:candle_yellow>,
  <thaumcraft:candle_lime>,
  <thaumcraft:candle_pink>,
  <thaumcraft:candle_gray>,
  <thaumcraft:candle_silver>,
  <thaumcraft:candle_cyan>,
  <thaumcraft:candle_purple>,
  <thaumcraft:candle_blue>,
  <thaumcraft:candle_brown>,
  <thaumcraft:candle_green>,
  <thaumcraft:candle_red>,
  <thaumcraft:candle_black>,
] as IItemStack[];
for i, candle in candleColors {
  recipes.remove(candle);

  // [White Tallow Candle]*16 from [String][+1]
  craft.make(candle * 16, [
    's',
    'M',
    'M'], {
    's': scripts.vars.oreDye[i],
    'M': <thaumcraft:tallow>, // Magic Tallow
  });
}

// Compressed brain
recipes.remove(<rats:brain_block>);
utils.compact(<thaumcraft:brain>, <rats:brain_block>);

// [Zombie Brain]*8 from [Zombie Essence]*2
craft.make(<thaumcraft:brain> * 8, ['pretty',
  'T T',
  'T T'], {
  'T': <mysticalagriculture:zombie_essence>, // Zombie Essence
});

// Bath salt recipe (this one works)
val VS = getAnyVisSalt();
mods.thaumcraft.Crucible.removeRecipe(<thaumcraft:bath_salts>);
recipes.addShapeless('bathsalts', <thaumcraft:bath_salts> * 8,
  [VS, VS, VS,
    VS, <thaumcraft:salis_mundus>, VS,
    VS, VS, VS]);

/*
██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██████╗ ███████╗███╗   ██╗ ██████╗██╗  ██╗
██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██╔══██╗██╔════╝████╗  ██║██╔════╝██║  ██║
██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██████╔╝█████╗  ██╔██╗ ██║██║     ███████║
██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██╔══██╗██╔══╝  ██║╚██╗██║██║     ██╔══██║
╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██████╔╝███████╗██║ ╚████║╚██████╗██║  ██║
 ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝
*/

function remakeWorkbench(
  name as string,
  research as string,
  visCost as int,
  aspects as CTAspectStack[],
  output as IItemStack,
  gridMap as string[],
  ingrMap as IIngredient[string]
) as void {
  mods.thaumcraft.ArcaneWorkbench.removeRecipe(output.anyAmount());
  mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
    name, research, visCost, aspects, output, Grid(gridMap, ingrMap).shaped()
  );
}

// [Grappler Spool] from [Copper Plate][+2]
remakeWorkbench('GrappleGunSpool', 'GRAPPLEGUN', 25, Aspects('💧'),
  <thaumcraft:grapple_gun_spool>, ['pretty',
    's T s',
    's □ s',
    's s s'], {
    's': <ore:string>, // String
    'T': <minecraft:tripwire_hook>, // Tripwire Hook
    '□': <ore:plateCopper>, // Copper Plate
  });

// [Grappler Head] from [Rare Earths][+2]
remakeWorkbench('GrappleGunTip', 'GRAPPLEGUN', 25, Aspects('⛰️'),
  <thaumcraft:grapple_gun_tip>, ['pretty',
    '‚ T ‚',
    '‚ R ‚',
    '‚ ‚ ‚'], {
    '‚': <ore:nuggetBrass>, // Alchemical Brass Nugget
    'T': <minecraft:tripwire_hook>, // Tripwire Hook
    'R': <thaumcraft:nugget:10>, // Rare Earths
  });

// [Arcane Grappler] from [Grappler Head][+3]
remakeWorkbench('GrappleGun', 'GRAPPLEGUN', 25, Aspects('🔥'),
  <thaumcraft:grapple_gun>, ['pretty',
    '    r',
    'G ‚ ‚',
    '  # #'], {
    'r': <thaumcraft:grapple_gun_spool>, // Grappler Spool
    'G': <thaumcraft:grapple_gun_tip>, // Grappler Head
    '‚': <ore:nuggetFakeIron>, // Iron Alloy Nugget
    '#': <ore:plankWood>, // Greatwood Planks
  });

// Cheaper to help use more
// [Paving Stone of Travel] from [Arcane Stone Brick]
remakeWorkbench('PaveTravel', 'PAVINGSTONES', 10,
  Aspects('⛰️'),
  <thaumcraft:paving_stone_travel> * 4, ['pretty',
    'A A',
    'A A'], {
    'A': <thaumcraft:stone_arcane_brick>, // Arcane Stone Brick
  });

// [Simple Arcane Mechanism] from [Stick][+4]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumcraft:mechanism_simple>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
  'mechanism_simple', // Name
  'BASEARTIFICE', // Research
  10, // Vis cost
  Aspects('🔥 💧'),
  <thaumcraft:mechanism_simple>, // Output
  Grid(['pretty',
    '‚ ‚ ‚',
    '‚ # ‚',
    '‚ ‚ ‚'], {
    '‚': <ore:nuggetBrass>, // Alchemical Brass Nugget
    '#': <ore:stickWood>, // Stick
  }).shaped());

// [Complex Arcane Mechanism] from [Nickel Plate][+5]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumcraft:mechanism_complex>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
  'mechanism_complex', // Name
  'BASEARTIFICE', // Research
  30, // Vis cost
  Aspects('🔥 💧'),
  <thaumcraft:mechanism_complex>, // Output
  Grid(['pretty',
    '  S  ',
    '‚ □ ‚',
    '  S  '], {
    'S': <thaumcraft:mechanism_simple>, // Simple Arcane Mechanism
    '‚': <ore:nuggetThaumium>, // Thaumium Nugget
    '□': <ore:plateNickel>, // Nickel Plate
  }).shaped());

// [Arcane Pattern Crafter] from [Hopper][+5]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumcraft:pattern_crafter>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
  'patterncrafter', // Name
  'ARCANEPATTERNCRAFTER', // Research
  50, // Vis cost
  Aspects('⛰️ 💧'),
  <thaumcraft:pattern_crafter>, // Output
  Grid(['pretty',
    '  ■  ',
    'S # S'], {
    '■': <ore:hopper>, // Hopper
    'S': <thaumcraft:mechanism_simple>, // Simple Arcane Mechanism
    '#': <thaumcraft:plank_greatwood>, // Greatwood Planks
  }).shaped());

// [Vis Battery]*8 from [Vis Resonator][+8]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumcraft:vis_battery>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
  'VisBattery', // Name
  'VISBATTERY@1', // Research
  150, // Vis cost
  Aspects('💨 💧 ⟁ ⚡ ⛰️ 🔥'),
  <thaumcraft:vis_battery> * 8, // Output
  Grid(['pretty',
    'A A A',
    'A V A',
    'A A A'], {
    'A': <thaumcraft:stone_arcane>, // Arcane Stone
    'V': <thaumcraft:vis_resonator>, // Vis Resonator
  }).shaped());

// [Impetus Generator] from [Vis Generator][+9]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumicaugmentation:impetus_generator>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
  'impetus_generator', // Name
  'IMPETUS_GENERATOR', // Research
  700, // Vis cost
  Aspects('2🔥 2⟁ 2⚡ 2💨'),
  <thaumicaugmentation:impetus_generator>, // Output
  Grid(['pretty',
    'E P E',
    'R V R',
    'E I E'], {
    'E': <thaumcraft:stone_eldritch_tile>, // Eldritch Stone
    'P': <thaumcraft:primordial_pearl>.anyDamage(), // Primordial Pearl
    'R': <thaumcraft:nugget:10>, // Rare Earths
    'V': <ore:craftingPiston>, // Piston
    'I': <thaumicaugmentation:material:5>, // Impetus Jewel
  }).shaped());

// [Thaumometer]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:thaumometer');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('thaumometer',
  'FIRSTSTEPS@2',
  20,
  Aspects('💨 🔥 💧 ⛰️ ⟁ ⚡'),
  <thaumcraft:thaumometer>,
  Grid(['pretty',
    '  C  ',
    'C P C',
    '  C  '], {
    'C': <ore:ingotCopper>, // Copper ingot
    'P': <ore:paneGlass>, // Glass pane
  }).shaped());

// [Thaumometer]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:thaumometer');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('thaumometer',
  'FIRSTSTEPS@2',
  20,
  Aspects('💨 🔥 💧 ⛰️ ⟁ ⚡'),
  <thaumcraft:thaumometer>,
  Grid(['pretty',
    '  C  ',
    'C P C',
    '  C  '], {
    'C': <ore:ingotCopper>, // Copper ingot
    'P': <ore:paneGlass>, // Glass pane
  }).shaped());

// [Vis resonator]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:vis_resonator');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('vis_resonator',
  'UNLOCKAUROMANCY@1',
  20,
  Aspects('💨 ⛰️'),
  <thaumcraft:vis_resonator>,
  Grid(['pretty',
    'A A A',
    'A C A',
    'A A A'], {
    'C': <ore:crystalCertus>, // Copper ingot
    'A': <ore:nuggetAluminium>, // Glass pane
  }).shaped());

// [Essentia tubes]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:tube');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('tube',
  'TUBES@2',
  10,
  [],
  <thaumcraft:tube> * 16,
  Grid(['pretty',
    'Q Q Q',
    'S S S',
    'Q Q Q'], {
    'S': <ore:nuggetQuicksilver>, // Quick silver nugget
    'Q': <ore:nuggetQuartzBlack>, // Black quartz nugget
  }).shaped());

// [glass tube] recipe use normal tubes
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumicaugmentation:glass_tube');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('glass_tube',
  'GLASS_TUBE',
  5,
  [],
  <thaumicaugmentation:glass_tube> * 8,
  Grid(['pretty',
    'T T T',
    'T G T',
    'T T T'], {
    'T': <thaumcraft:tube>, //
    'G': <ore:blockGlass>, //
  }).shaped());

// and reverse crafting recipe for [glass tube]
recipes.addShapeless('glass_tube_reverse', <thaumcraft:tube>, [<thaumicaugmentation:glass_tube>]);

// [Essentia filter]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:filter');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('filter',
  'BASEALCHEMY',
  15,
  Aspects('💧'),
  <thaumcraft:filter> * 2,
  Grid(['pretty',
    'C S C'], {
    'C': <ore:ingotCopper>, // Copper ingot
    'S': <thaumcraft:plank_silverwood>, // Silver wood plank
  }).shaped());

// [Alchemical construct]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:alchemicalconstruct');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('alchemicalconstruct',
  'TUBES',
  50,
  Aspects('2💨 2🔥 2💧 2⛰️ 2⟁ 2⚡'),
  <thaumcraft:metal_alchemical> * 2,
  Grid(['pretty',
    'G T G',
    'T F T',
    'G T G'], {
    'G': <thaumcraft:plank_greatwood>, // Greatwood plank
    'T': <thaumcraft:tube>, // Essentia tube
    'F': <thaumcraft:filter>, // Essentia filter
  }).shaped());

// [Void smeltery] recipe require now thaumium smelter
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:essentiasmeltervoid');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('essentiasmeltervoid',
  'ESSENTIASMELTERVOID',
  750,
  Aspects('3🔥'),
  <thaumcraft:smelter_void>,
  Grid(['pretty',
    'B S B',
    'V A V',
    'V V V'], {
    'V': <ore:plateVoid>, // Void plate
    'A': <thaumcraft:metal_alchemical_advanced>, // Advanced alchemical construct
    'B': <ore:plateBrass>, // Brass plate
    'S': <thaumcraft:smelter_thaumium>, // Thaumium smelter
  }).shaped());

// [Redstone inlay]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:redstoneinlay');
mods.thaumcraft.ArcaneWorkbench.registerShapelessRecipe('redstoneinlay',
  'INFUSIONSTABLE',
  25,
  Aspects('💧'),
  <thaumcraft:inlay> * 8,
  Grid(['CR'], {
    'C': <ore:ingotCopper>, // Copper ingot
    'R': <ore:dustRedstone>, // Redstone dust
  }).shapeless());

// [Flux condenser] cheaper clearing machine
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:condenser');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('condenser',
  'FLUXCLEANUP',
  100,
  Aspects('3🔥'),
  <thaumcraft:condenser>,
  Grid(['pretty',
    'G F G',
    'B M B',
    'G T G'], {
    'G': <thaumcraft:plank_greatwood>, // Greatwood plank
    'F': <thaumcraft:filter>, // Essentia filter
    'M': <thaumcraft:mechanism_simple>, // Simple mechanism
    'T': <thaumcraft:tube>, // Essentia Tube
    'B': <thaumcraft:ingot:2>, // Brass ingot
  }).shaped());

// [Condenser Lattice] cheaper flux condenser component
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:condenserlattice');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('condenserlattice',
  'FLUXCLEANUP',
  25,
  Aspects('💨 ⛰️'),
  <thaumcraft:condenser_lattice> * 8,
  Grid(['pretty',
    'S Q S',
    'S F S',
    'S Q S'], {
    'S': <thaumcraft:plank_silverwood>, // Silverwood plank
    'Q': <ore:nuggetQuicksilver>, // Quicksilver nugget
    'F': <thaumcraft:filter>, // Essentia filter
  }).shaped());

// [Arcane Bellows]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:bellows');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('bellows',
  'BELLOWS',
  25,
  Aspects('💨 ⛰️'),
  <thaumcraft:bellows>,
  Grid(['pretty',
    'W W  ',
    'L L A',
    'W W  '], {
    'L': <minecraft:leather>, // Leather
    'W': <ore:plankWood>, // Any plank
    'A': <ore:ingotAluminum>, // Aluminum ingot
  }).shaped());

// [Auxiliary Venting Port]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:smeltervent');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('smeltervent',
  'IMPROVEDSMELTING2',
  150,
  Aspects('💨'),
  <thaumcraft:smelter_vent>,
  Grid(['pretty',
    'B F B',
    'P A P',
    'B T B'], {
    'B': <ore:gemQuartzBlack>, // Black quartz
    'F': <thaumcraft:filter>, // Essentia filter
    'A': <thaumcraft:metal_alchemical>, // Alchemical construct
    'T': <thaumcraft:tube>, // Essentia tube
    'P': <ore:plateBrass>, // Brass plate
  }).shaped());

// [Auxiliary Slurry Pump]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:smelteraux');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('smelteraux',
  'IMPROVEDSMELTING',
  100,
  Aspects('💨 ⛰️'),
  <thaumcraft:smelter_aux>,
  Grid(['pretty',
    'B T B',
    'P A P',
    'B F B'], {
    'B': <ore:gemQuartzBlack>, // Black quartz
    'F': <thaumcraft:bellows>, // Arcane bellows
    'A': <thaumcraft:metal_alchemical>, // Alchemical construct
    'T': <thaumcraft:tube>, // Essentia tube
    'P': <ore:plateBrass>, // Brass plate
  }).shaped());

// [Emptying Essentia Transfuser]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:essentiatransportout');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('essentiatransportout',
  'ESSENTIATRANSPORT',
  100,
  Aspects('💨 💧'),
  <thaumcraft:essentia_output>,
  Grid(['pretty',
    'B H B',
    'Q A Q'], {
    'B': <ore:plateBrass>, // Brass plate
    'H': <minecraft:hopper>, // Hopper
    'A': <thaumcraft:metal_alchemical>, // Alchemical construct
    'Q': <ore:gemQuartzBlack>, // Black quartz
  }).shaped());

// [Filling Essentia Transfuser]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:essentiatransportin');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('essentiatransportin',
  'ESSENTIATRANSPORT',
  100,
  Aspects('💨 💧'),
  <thaumcraft:essentia_input>,
  Grid(['pretty',
    'B D B',
    'Q A Q'], {
    'B': <ore:plateBrass>, // Brass plate
    'D': <minecraft:dispenser>, // Dispenser
    'A': <thaumcraft:metal_alchemical>, // Alchemical construct
    'Q': <ore:gemQuartzBlack>, // Black quartz
  }).shaped());

// [Hungry chest]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:HungryChest');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('HungryChest',
  'HUNGRYCHEST',
  15,
  [],
  <thaumcraft:hungry_chest>,
  Grid(['pretty',
    'G T G',
    'G   G',
    'G G G'], {
    'G': <thaumcraft:plank_greatwood>, // Greatwood plank
    'T': <ore:trapdoorWood>, // Trap door
  }).shaped());

// [Automated crossbow]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumcraft:automatedcrossbow');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('automatedcrossbow',
  'BASICTURRET',
  100,
  [],
  <thaumcraft:turret>,
  Grid(['pretty',
    '  M  ',
    'G B G',
    'S   S'], {
    'S': <ore:stickWood>, // Stick
    'G': <thaumcraft:plank_greatwood>, // Greatwood planks
    'M': <thaumcraft:mind>, // Clockwork Mind
    'B': <minecraft:bow:*>, // Bow
  }).shaped());

// [Void siphon]
mods.thaumcraft.Infusion.removeRecipe(<thaumcraft:void_siphon>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('VoidSiphon',
  'VOIDSIPHON',
  400,
  Aspects('2⟁ 2⛰️ 2⚡'),
  <thaumcraft:void_siphon>,
  Grid(['pretty',
    '  T  ',
    'B M B',
    'S S S'], {
    'S': <thaumcraft:stone_arcane>, // Arcane stone
    'B': <thaumcraft:plate>, // Brass plate
    'M': <thaumcraft:mechanism_complex>, // Complex arcane mechanism
    'T': <astralsorcery:itemcraftingcomponent:1>, // Starmetal ingot
}).shaped());

/*
██╗███╗   ██╗███████╗███████╗██████╗ ███╗   ██╗ █████╗ ██╗
██║████╗  ██║██╔════╝██╔════╝██╔══██╗████╗  ██║██╔══██╗██║
██║██╔██╗ ██║█████╗  █████╗  ██████╔╝██╔██╗ ██║███████║██║
██║██║╚██╗██║██╔══╝  ██╔══╝  ██╔══██╗██║╚██╗██║██╔══██║██║
██║██║ ╚████║██║     ███████╗██║  ██║██║ ╚████║██║  ██║███████╗
╚═╝╚═╝  ╚═══╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝
*/

// Unification for the Smelting Bonus
// IIngredient input, IItemStack stack
function swapBonus(input as IIngredient, wrong as IItemStack, right as WeightedItemStack) as void {
  mods.thaumcraft.SmeltingBonus.removeSmeltingBonus(input, wrong);
  mods.thaumcraft.SmeltingBonus.addSmeltingBonus(input, right);
}

for i, oreBase in 'Copper Tin Silver Lead'.split(' ') {
  val wrong = <thaumcraft:nugget>.definition.makeStack(i + 1);
  val nugget = oreDict['nugget' ~ oreBase].firstItem;
  swapBonus(oreDict['ore' ~ oreBase], wrong, nugget % 33);
  swapBonus(<thaumcraft:cluster>.definition.makeStack(i + 2), wrong, nugget * 2 % 33);
}

/*
██╗███╗   ██╗███████╗██╗   ██╗███████╗██╗ ██████╗ ███╗   ██╗
██║████╗  ██║██╔════╝██║   ██║██╔════╝██║██╔═══██╗████╗  ██║
██║██╔██╗ ██║█████╗  ██║   ██║███████╗██║██║   ██║██╔██╗ ██║
██║██║╚██╗██║██╔══╝  ██║   ██║╚════██║██║██║   ██║██║╚██╗██║
██║██║ ╚████║██║     ╚██████╔╝███████║██║╚██████╔╝██║ ╚████║
╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝ ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝
*/

// Shapeless Totem of Undying
mods.thaumcraft.Infusion.removeRecipe(<thaumcraft:charm_undying>);
recipes.addShapeless('Totem conversion', <thaumcraft:charm_undying>, [<minecraft:totem_of_undying>]);

// Crimson Rites
mods.thaumcraft.Infusion.registerRecipe('crimson_rites', 'INFUSION',
  <thaumcraft:curio:6>, 15,
  Aspects('30🍇 15⚰️ 30🔮 10✨'),
  <thaumcraft:thaumonomicon>,
  [<thaumcraft:ingot>, <thaumictinkerer:energetic_nitor>, <thaumcraft:salis_mundus>, <thaumictinkerer:energetic_nitor>, <thaumcraft:salis_mundus>, <thaumictinkerer:energetic_nitor>, <thaumcraft:ingot>, <thaumictinkerer:energetic_nitor>]);

// [Crimson Blade] from [Skullfire Sword][+6]
craft.remake(<thaumcraft:crimson_blade>, ['pretty',
  '          □ T',
  '        □ T □',
  '      □ T □  ',
  'п п B S □    ',
  '  C B B      ',
  'п F C п      ',
  'F п   п      '], {
  '□': <ore:plateMithminite>, // Mithminite Plate
  'T': <thaumadditions:taintkin> ?? <thaumcraft:taint_soil>, // Taintkin
  'п': <ore:plateVoid>, // Void Metal Plate
  'B': <bloodmagic:bound_sword>.withTag({ Unbreakable: 1 as byte, activated: 1 as byte }, false), // Bound Blade
  'S': <avaritia:skullfire_sword>.anyDamage(), // Skullfire Sword
  'C': <thaumcraft:curio:6>, // Crimson Rites
  'F': <botania:brewflask>.withTag({ brewKey: 'bloodthirst' }), // Flask of Crimson Shade (6)
});

// [Spawn Lesser Crimson Portal] from [Golden Egg][+3]
mods.thaumcraft.Infusion.registerRecipe('spawn_lesser_crimson_portal', 'INFUSION',
  <minecraft:spawn_egg>.withTag({ EntityTag: { id: 'thaumcraft:cultistportallesser' } }), 15,
  Aspects('90🍇 45⚰️ 90🔮 30✨'),
  <randomthings:ingredient:11>, // Golden Egg
  Grid(['-K-T-K-T'], {
    '-': <thaumictinkerer:energetic_nitor>, // Energetic Nitor
    'K': <extrautils2:klein>, // Klein Bottle
    'T': <thaumcraft:taint_log>, // Taintwood Log
  }).shapeless());

// [Control Seal_ Block Breaker] from [Blank Seal][+3]
mods.thaumcraft.Infusion.removeRecipe(<thaumcraft:seal:15>);
mods.thaumcraft.Infusion.registerRecipe(
  'SealBreak', // Name
  'SEALBREAK', // Research
  <thaumcraft:seal:15>, // Output
  1, // Instability
  Aspects('10⚡'),
  <thaumcraft:seal>, // Central Item
  Grid(['oG'], {
    'o': <minecraft:golden_pickaxe>.anyDamage(), // Golden Pickaxe
    'G': <minecraft:golden_shovel>.anyDamage(), // Golden Shovel
  }).spiral(1));

// [Biothaumic Mind] from [Clockwork Mind][+2]
mods.thaumcraft.Infusion.removeRecipe(<thaumcraft:mind:1>);
mods.thaumcraft.Infusion.registerRecipe(
  'MindBiothaumic', // Name
  'MINDBIOTHAUMIC', // Research
  <thaumcraft:mind:1>, // Output
  1, // Instability
  Aspects('10🧠'),
  <thaumcraft:mind>, // Central Item
  Grid(['ZZ'], {
    'Z': <thaumcraft:brain>, // Zombie Brain
  }).spiral(1));

// [Causality Collapser]*4 from [TNT][+4]
mods.thaumcraft.Infusion.removeRecipe(<thaumcraft:causality_collapser>);
mods.thaumcraft.Infusion.registerRecipe(
  'CausalityCollapser', // Name
  'RIFTCLOSER', // Research
  <thaumcraft:causality_collapser>, // Output
  2, // Instability
  Aspects('20👽 20🍇'),
  <thaumictinkerer:energetic_nitor>, // Central Item
  Grid(['pretty',
    '  ▲  ',
    'D   D',
    '  ▲  '], {
    '▲': <ore:dustBedrock>, // Grains of Infinity
    'D': <cyclicmagic:ender_tnt_1>, // Dynamite I
  }).spiral(1));

// --------------------------------------------
// Remake items that output more than 1

mods.thaumcraft.Infusion.removeRecipe(<thaumicwonders:shimmerleaf_seed>);
mods.thaumcraft.Crucible.registerRecipe(
  'shimmerleaf_seed', // Name
  'TWOND_MYSTIC_GARDENING@1', // Research
  <thaumicwonders:shimmerleaf_seed>, // Output
  <rustic:tomato_seeds>, // Input
  Aspects('60✨')
);

mods.thaumcraft.Infusion.removeRecipe(<thaumicwonders:cinderpearl_seed>);
mods.thaumcraft.Crucible.registerRecipe(
  'cinderpearl_seed', // Name
  'TWOND_MYSTIC_GARDENING@1', // Research
  <thaumicwonders:cinderpearl_seed>, // Output
  <rustic:chili_pepper_seeds>, // Input
  Aspects('60🔥')
);

mods.thaumcraft.Infusion.removeRecipe(<thaumicwonders:vishroom_spore>);
mods.thaumcraft.Crucible.registerRecipe(
  'vishroom_spore', // Name
  'TWOND_MYSTIC_GARDENING@1', // Research
  <thaumicwonders:vishroom_spore>, // Output
  <rustic:apple_seeds>, // Input
  Aspects('60🔮')
);

// [Focus tier 2]
mods.thaumcraft.Infusion.removeRecipe(<thaumcraft:focus_2>);
mods.thaumcraft.Infusion.registerRecipe(
  'focus_2', // Name
  'FOCUSADVANCED@1', // Research
  <thaumcraft:focus_2>, // Output
  2, // Instability
  Aspects('50⟁ 25🔮'),
  <thaumcraft:focus_1>, // CentralItem
  [<thaumcraft:quicksilver>, <astralsorcery:itemcraftingcomponent>, <thaumcraft:quicksilver>, <botania:spark>]
);

// [Focus tier 3]
mods.thaumcraft.Infusion.removeRecipe(<thaumcraft:focus_3>);
mods.thaumcraft.Infusion.registerRecipe(
  'focus_3', // Name
  'FOCUSGREATER@1', // Research
  <thaumcraft:focus_3>, // Output
  4, // Instability
  Aspects('50〇 100🔷 50⟁ 25🔮'),
  <thaumcraft:focus_2>, // CentralItem
  [<ore:manaPearl>, <thaumcraft:quicksilver>, <iceandfire:pixie_dust>, <thaumcraft:quicksilver>, <ore:manaDiamond>, <thaumcraft:quicksilver>, <iceandfire:pixie_dust>, <thaumcraft:quicksilver>]
);

// [Focus ancient]
mods.thaumcraft.Infusion.registerRecipe(
  'focus_ancient', // Name
  'FOCUSANCIENT', // Research
  <thaumicaugmentation:focus_ancient>, // Output
  3, // Instability
  Aspects('100〇 25👽'),
  <thaumcraft:focus_2>, // CentralItem
  [<thaumcraft:quicksilver>, <ore:nuggetVoid>, <thaumcraft:quicksilver>, <ore:nuggetVoid>]
);

// [Primal metal]
mods.thaumcraft.Infusion.removeRecipe(<tconevo:metal:20>);
mods.thaumcraft.Infusion.registerRecipe(
  'primal_metal', // Name
  'TCONEVO_PRIMALMETAL', // Research
  <tconevo:metal:20>, // Output
  2, // Instability
  Aspects('10💨 10🔥 10⟁ 10💧 10⛰️ 10⚡ 30🔩'),
  <tconevo:material>, // CentralItem
  [<thaumicwonders:primordial_grain>, <thaumcraft:salis_mundus>]
);

// [Arcane bore]
mods.thaumcraft.Infusion.removeRecipe(<thaumcraft:turret:2>);
mods.thaumcraft.Infusion.registerRecipe(
  'ArcaneBore', // Name
  'ARCANEBORE', // Research
  <thaumcraft:turret:2>, // Output
  1, // Instability
  Aspects('25💣 50⚙️'),
  <thaumcraft:turret>, // CentralItem
  [<thaumcraft:plank_greatwood>, <thaumcraft:plate>, <thaumcraft:plank_greatwood>, <minecraft:iron_pickaxe:*>]
);

/*
 ██████╗██████╗ ██╗   ██╗ ██████╗██╗██████╗ ██╗     ███████╗
██╔════╝██╔══██╗██║   ██║██╔════╝██║██╔══██╗██║     ██╔════╝
██║     ██████╔╝██║   ██║██║     ██║██████╔╝██║     █████╗
██║     ██╔══██╗██║   ██║██║     ██║██╔══██╗██║     ██╔══╝
╚██████╗██║  ██║╚██████╔╝╚██████╗██║██████╔╝███████╗███████╗
 ╚═════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚═╝╚═════╝ ╚══════╝╚══════╝
*/

scripts.jei.crafting_hints.addInsOutCatl([<minecraft:cauldron>, <thaumcraft:salis_mundus>], <thaumcraft:crucible>);
scripts.jei.crafting_hints.addInsOutCatl([<ore:bookshelf>, <thaumcraft:salis_mundus>], <thaumcraft:thaumonomicon>);
scripts.jei.crafting_hints.addInsOutCatl([<ore:workbench>, <thaumcraft:salis_mundus>], <thaumcraft:arcane_workbench>);

function remakeCrucible(name as string, research as string, output as IItemStack, input as IIngredient, aspects as CTAspectStack[]) as void {
  mods.thaumcraft.Crucible.removeRecipe(output.anyAmount());
  mods.thaumcraft.Crucible.registerRecipe(name, research, output, input, aspects);
}

mods.thaumcraft.Crucible.registerRecipe('Quartz ore fix', 'METALPURIFICATION', <thaumcraft:cluster:7>, <ore:oreQuartz>, Aspects('5🔩 5⟁'));

// Tallow harder
mods.thaumcraft.Crucible.removeRecipe(<thaumcraft:tallow>);
mods.thaumcraft.Crucible.registerRecipe('hedge_tallow', 'HEDGEALCHEMY@1', <thaumcraft:tallow>, <minecraft:rotten_flesh>, Aspects('🔥'));
mods.thaumcraft.Crucible.registerRecipe('Tallow from tallow', 'HEDGEALCHEMY@1', <thaumcraft:tallow> * 2, <quark:tallow>, Aspects('2🔥'));

// Cheaper stuff
remakeCrucible('nitor', 'BASEALCHEMY', <thaumcraft:nitor_yellow> * 10, <minecraft:glowstone_dust>, Aspects('10💪 10🔥 10🕯️'));
// remakeCrucible("hedge_dye"      , "HEDGEALCHEMY@2", <minecraft:dye> * 2, <minecraft:dye>, Aspects('🦉'));
// remakeCrucible("hedge_slime"    , "HEDGEALCHEMY@2", <minecraft:slime_ball> * 2, <minecraft:slime_ball>, Aspects('❤️'));
// remakeCrucible("hedge_glowstone", "HEDGEALCHEMY@2", <minecraft:glowstone_dust> * 2, <minecraft:glowstone_dust>, Aspects('2🕯️ 🦉'));
// remakeCrucible("hedge_gunpowder", "HEDGEALCHEMY@2", <minecraft:gunpowder> * 2, <minecraft:gunpowder>, Aspects('5💣'));
remakeCrucible('hedge_leather', 'HEDGEALCHEMY@2', <minecraft:leather>, <minecraft:rotten_flesh>, Aspects('2🐺'));

// TODO: Remove this temporary recipe when resolved: https://github.com/LoliKingdom/Thaumic-Speedup/issues/3
remakeCrucible('hedge_web', 'HEDGEALCHEMY@3', <minecraft:web>, <minecraft:string>, Aspects('2🔗'));
remakeCrucible('hedge_string', 'HEDGEALCHEMY@3', <minecraft:string>, <minecraft:wheat>, Aspects('2🐺'));

// Cheaper metals
remakeCrucible('brassingot', 'METALLURGY@1', <thaumcraft:ingot:2> * 2, <ore:ingotAlubrass>, Aspects('5🛠️'));
remakeCrucible('thaumiumingot', 'METALLURGY@2', <thaumcraft:ingot>, <ore:ingotLead>, Aspects('5🔮 5⛰️'));

// [Ash Block] from [Compressed Dust][+1]
remakeCrucible('ash_block', 'HEDGEALCHEMY@3', <biomesoplenty:ash_block> * 9, <ore:compressed1xDust>, Aspects('🧨'));

// Cheaper to less microcraftings
// [Sanitizing Soap] from [Phial of Cognitio Essentia]*6[+2]
mods.thaumcraft.Crucible.removeRecipe(<thaumcraft:sanity_soap>);
mods.thaumcraft.Crucible.registerRecipe(
  'SaneSoap', // Name
  'SANESOAP', // Research
  <thaumcraft:sanity_soap>, // Output
  <ore:blockFlesh>, // Input
  Aspects('60🧠 60❤️')
);

// [Sanity soap]
mods.thaumcraft.Crucible.removeRecipe(<thaumcraft:sanity_soap>);
mods.thaumcraft.Crucible.registerRecipe(
  'SaneSoap', // Name
  'SANESOAP', // Research
  <thaumcraft:sanity_soap>, // Output
  <thaumcraft:bath_salts>, // Input
  Aspects('5🔷')
);
// [Sanity soap] alternative
mods.botania.ManaInfusion.addAlchemy(<thaumcraft:sanity_soap>, <thaumcraft:bath_salts>, 2500);

// [Focus tier 1]
mods.thaumcraft.Crucible.removeRecipe(<thaumcraft:focus_1>);
mods.thaumcraft.Crucible.registerRecipe(
  'focus_1', // Name
  'BASEAUROMANCY@1', // Research
  <thaumcraft:focus_1>, // Output
  <thaumcraft:quicksilver>, // Input
  Aspects('5✨ 10🔮 20💎')
);

// [Alumentum]
mods.thaumcraft.Crucible.removeRecipe(<thaumcraft:alumentum>);
mods.thaumcraft.Crucible.registerRecipe(
  'alumentum', // Name
  'ALUMENTUM', // Research
  <thaumcraft:alumentum> * 10, // Output
  <minecraft:coal>, // Input
  Aspects('10💪 10🔥 5⚡')
);

// [Energetic nitor]
mods.thaumcraft.Crucible.removeRecipe(<thaumictinkerer:energetic_nitor>);
mods.thaumcraft.Crucible.registerRecipe(
  'energetic_nitor', // Name
  'TT_ENERGETIC_NITOR', // Research
  <thaumictinkerer:energetic_nitor>, // Output
  <thaumcraft:nitor_yellow>, // Input
  Aspects('25🕯️ 25💪 10🔥 10💨')
);

// Native cluster fix
function NativeClusterRecipe(name as string, native as IItemStack, ore as IItemStack) as void {
  mods.thaumcraft.Crucible.removeRecipe(native);
  mods.thaumcraft.Crucible.registerRecipe(
    name, // Name
    'METALPURIFICATION', // Research
    native, // Output
    ore, // Input
    Aspects('5⟁ 5🔩')
  );
}

NativeClusterRecipe('metal_purification_aluminium'          , <jaopca:item_clusteraluminium>          , <thermalfoundation:ore:4>);
NativeClusterRecipe('metal_purification_nickel'             , <jaopca:item_clusternickel>             , <thermalfoundation:ore:5>);
NativeClusterRecipe('metal_purification_iridium'            , <jaopca:item_clusteriridium>            , <thermalfoundation:ore:7>);
NativeClusterRecipe('metal_purification_platinum'           , <jaopca:item_clusterplatinum>           , <thermalfoundation:ore:6>);
NativeClusterRecipe('metal_purification_uranium'            , <jaopca:item_clusteruranium>            , <immersiveengineering:ore:5>);
NativeClusterRecipe('metal_purification_osmium'             , <jaopca:item_clusterosmium>             , <mekanism:oreblock>);
NativeClusterRecipe('metal_purification_ardite'             , <jaopca:item_clusterardite>             , <tconstruct:ore:1>);
NativeClusterRecipe('metal_purification_cobalt'             , <jaopca:item_clustercobalt>             , <tconstruct:ore>);
NativeClusterRecipe('metal_purification_tungsten'           , <jaopca:item_clustertungsten>           , <endreborn:block_wolframium_ore>);
NativeClusterRecipe('metal_purification_starmetal'          , <jaopca:item_clusterastralstarmetal>    , <astralsorcery:blockcustomore:1>);
NativeClusterRecipe('metal_purification_boron'              , <jaopca:item_clusterboron>              , <nuclearcraft:ore:5>);
NativeClusterRecipe('metal_purification_lithium'            , <jaopca:item_clusterlithium>            , <nuclearcraft:ore:6>);
NativeClusterRecipe('metal_purification_magnesium'          , <jaopca:item_clustermagnesium>          , <nuclearcraft:ore:7>);
NativeClusterRecipe('metal_purification_thorium'            , <jaopca:item_clusterthorium>            , <nuclearcraft:ore:3>);
NativeClusterRecipe('metal_purification_manainfusedingot'   , <jaopca:item_clustermithril>            , <thermalfoundation:ore:8>);
NativeClusterRecipe('metal_purification_blackquartz'        , <jaopca:item_clusterquartzblack>        , <actuallyadditions:block_misc:3>);
NativeClusterRecipe('metal_purification_draconium'          , <jaopca:item_clusterdraconium>          , <draconicevolution:draconium_ore>);
NativeClusterRecipe('metal_purification_titanium'           , <jaopca:item_clustertitanium>           , <libvulpes:ore0:8>);
NativeClusterRecipe('metal_purification_coal'               , <jaopca:item_clustercoal>               , <minecraft:coal_ore>);
NativeClusterRecipe('metal_purification_emerald'            , <jaopca:item_clusteremerald>            , <minecraft:emerald_ore>);
NativeClusterRecipe('metal_purification_lapis'              , <jaopca:item_clusterlapis>              , <minecraft:lapis_ore>);
NativeClusterRecipe('metal_purification_redstone'           , <jaopca:item_clusterredstone>           , <minecraft:redstone_ore>);
NativeClusterRecipe('metal_purification_diamond'            , <jaopca:item_clusterdiamond>            , <minecraft:diamond_ore>);
NativeClusterRecipe('metal_purification_dimensionalshard'   , <jaopca:item_clusterdimensionalshard>   , <rftools:dimensional_shard_ore>);
NativeClusterRecipe('metal_purification_dilithium'          , <jaopca:item_clusterdilithium>          , <libvulpes:ore0>);
NativeClusterRecipe('metal_purification_certusquartz'       , <jaopca:item_clustercertusquartz>       , <appliedenergistics2:quartz_ore>);
NativeClusterRecipe('metal_purification_chargedcertusquartz', <jaopca:item_clusterchargedcertusquartz>, <appliedenergistics2:charged_quartz_ore>);
NativeClusterRecipe('metal_purification_aquamarine'         , <jaopca:item_clusteraquamarine>         , <astralsorcery:blockcustomsandore>);
NativeClusterRecipe('metal_purification_apatite'            , <jaopca:item_clusterapatite>            , <forestry:resources>);
NativeClusterRecipe('metal_purification_amber'              , <jaopca:item_clusteramber>              , <biomesoplenty:gem_ore:7>);
NativeClusterRecipe('metal_purification_amberthaumcraft'    , <jaopca:item_clusteramber>              , <thaumcraft:ore_amber>);
NativeClusterRecipe('metal_purification_trinitite'          , <jaopca:item_clustertrinitite>          , <trinity:trinitite>);
NativeClusterRecipe('metal_purification_malachite'          , <jaopca:item_clustermalachite>          , <biomesoplenty:gem_ore:5>);
NativeClusterRecipe('metal_purification_topaz'              , <jaopca:item_clustertopaz>              , <biomesoplenty:gem_ore:3>);
NativeClusterRecipe('metal_purification_tanzanite'          , <jaopca:item_clustertanzanite>          , <biomesoplenty:gem_ore:4>);
NativeClusterRecipe('metal_purification_sapphire'           , <jaopca:item_clustersapphire>           , <biomesoplenty:gem_ore:6>);
NativeClusterRecipe('metal_purification_ruby'               , <jaopca:item_clusterruby>               , <biomesoplenty:gem_ore:1>);
NativeClusterRecipe('metal_purification_peridot'            , <jaopca:item_clusterperidot>            , <biomesoplenty:gem_ore:2>);
NativeClusterRecipe('metal_purification_amethyst'           , <jaopca:item_clusteramethyst>           , <biomesoplenty:gem_ore>);

/*
███████╗███╗   ██╗████████╗██╗████████╗██═╗    ██╗
██╔════╝████╗  ██║╚══██╔══╝██║╚══██╔══╝ ╚██═╗██╔═╝
█████╗  ██╔██╗ ██║   ██║   ██║   ██║      ╚██╔═╝
██╔══╝  ██║╚██╗██║   ██║   ██║   ██║       ██║
███████╗██║ ╚████║   ██║   ██║   ██║       ██║
╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝   ╚═╝       ╚═╝
*/

function L(legend as string) as string {
  if (legend == 'hvanilla') {
    return 'CREATION_HOSTILE_VANILLA';
  }
  if (legend == 'pvanilla') {
    return 'CREATION_PASSIVE_VANILLA';
  }
  if (legend == 'vanilla_nether') {
    return 'CREATION_HOSTILE_VANILLA_NETHER';
  }
  if (legend == 'vanilla_end') {
    return 'CREATION_HOSTILE_VANILLA_END';
  }
  if (legend == 'elementals') {
    return 'CREATION_HOSTILE_ELEMENTALS';
  }
}

function soulRecipe(entityId as string, research as string, aspects as CTAspectStack[], items as IIngredient[] = []) as void {
  if (items.length == 0) {
    mods.thaumcraft.Crucible.registerRecipe(
      entityId, L(research),
      <enderio:item_soul_vial:1>.withTag({ entityId: entityId }),
      <enderio:item_soul_vial>,
      aspects
    );
  }
  else {
    mods.thaumcraft.Infusion.registerRecipe(
      entityId, L(research),
      <enderio:item_soul_vial:1>.withTag({ entityId: entityId }),
      2,
      aspects,
      <enderio:item_soul_vial>,
      items
    );
  }
}

function IsThatEgg(egg as IItemStack, entityId as string) as IItemStack {
  if (egg.name == <minecraft:spawn_egg>.name) {
    return <minecraft:spawn_egg>.withTag({ EntityTag: { id: entityId } });
  }
  else {
    return egg;
  }
}

function eggRecipe(entityId as string, research as string, aspects as CTAspectStack[], output as IItemStack = <minecraft:spawn_egg>, input as IIngredient = <minecraft:egg>, items as IIngredient[] = []) as void {
  if (items.length == 0) {
    mods.thaumcraft.Crucible.registerRecipe(
      entityId, L(research),
      IsThatEgg(output, entityId),
      input,
      aspects
    );
  }
  else {
    mods.thaumcraft.Infusion.registerRecipe(
      entityId, L(research),
      IsThatEgg(output, entityId),
      2,
      aspects,
      input,
      items
    );
  }
}

// Passive Vanilla
eggRecipe('minecraft:cow'          , 'pvanilla', Aspects('30🐺 30⛰️ 15🛡️'));
eggRecipe('minecraft:sheep'        , 'pvanilla', Aspects('30🐺 30⛰️ 15🔨'));
eggRecipe('minecraft:pig'          , 'pvanilla', Aspects('30🐺 30⛰️ 15❤️'));
eggRecipe('minecraft:chicken'      , 'pvanilla', Aspects('30🐺 30🕊️ 15🍃'));
eggRecipe('minecraft:rabbit'       , 'pvanilla', Aspects('30🐺 30⛰️ 15👁️'));
eggRecipe('minecraft:wolf'         , 'pvanilla', Aspects('60🐺 30⛰️ 15🗡️'));
eggRecipe('minecraft:ocelot'       , 'pvanilla', Aspects('60🐺 30⛰️ 15✊'));
eggRecipe('minecraft:parrot'       , 'pvanilla', Aspects('60🐺 30🕊️ 15🛎️'));
eggRecipe('minecraft:horse'        , 'pvanilla', Aspects('120🐺 30⛰️ 15🏃'));
eggRecipe('minecraft:donkey'       , 'pvanilla', Aspects('90🐺 30⛰️ 15🔗'));
eggRecipe('minecraft:mule'         , 'pvanilla', Aspects('90🐺 30⛰️ 15🙌'));
eggRecipe('minecraft:llama'        , 'pvanilla', Aspects('90🐺 30⛰️ 15🔄'));
eggRecipe('minecraft:squid'        , 'pvanilla', Aspects('30🐺 30💧 15🌑'));
eggRecipe('minecraft:bat'          , 'pvanilla', Aspects('30🐺 30🕊️ 15🌑'));
// eggRecipe("minecraft:mooshroom" ,"pvanilla" , Aspects('30🐺 30⛰️ 15🍇'));
eggRecipe('minecraft:polar_bear'   , 'pvanilla', Aspects('150🐺 30⛰️ 60🧊'));

// Hostile Vanilla Overworld
soulRecipe('minecraft:zombie'        , 'hvanilla', Aspects('50💀 50⚰️ 100👨'));
soulRecipe('minecraft:husk'          , 'hvanilla', Aspects('50💀 50⚰️ 100👨 50⚡'));
soulRecipe('minecraft:skeleton'      , 'hvanilla', Aspects('50⚰️ 50⚡ 100🗡️'));
soulRecipe('minecraft:stray'         , 'hvanilla', Aspects('50⚰️ 50⚡ 100🗡️ 50🧊'));
soulRecipe('minecraft:creeper'       , 'hvanilla', Aspects('100💣 50🔥 25⚗️ 50⚡'));
soulRecipe('minecraft:spider'        , 'hvanilla', Aspects('100🐺 50🔗 50🦉'));
soulRecipe('minecraft:cave_spider'   , 'hvanilla', Aspects('75🐺 50🔗 50🦉 25⚗️'));
soulRecipe('minecraft:witch'         , 'hvanilla', Aspects('100👨 50🔮 50⚗️'));
soulRecipe('minecraft:slime'         , 'hvanilla', Aspects('50💧 50❤️'));
soulRecipe('minecraft:guardian'      , 'hvanilla', Aspects('100💧 50🛡️ 50🦉'));
soulRecipe('minecraft:silverfish'    , 'hvanilla', Aspects('100⚡ 50〇 50🔗'));
soulRecipe('minecraft:zombie_horse'  , 'hvanilla', Aspects('100🐺 50💀 50🏃'));
soulRecipe('minecraft:skeleton_horse', 'hvanilla', Aspects('100🐺 50⚰️ 50🏃'));
soulRecipe('minecraft:giant'         , 'hvanilla', Aspects('500💀 500🛡️ 500🦄')); // Probably recipe to delete

// Hostile Vanilla Nether
soulRecipe('minecraft:zombie_pigman'  , 'vanilla_nether', Aspects('50💀 50⚰️ 100🐺'));
soulRecipe('minecraft:magma_cube'     , 'vanilla_nether', Aspects('50💧 50❤️ 25🧨'));
soulRecipe('minecraft:wither_skeleton', 'vanilla_nether', Aspects('50⚰️ 100⚡ 100🗡️ 100👻'));
soulRecipe('minecraft:ghast'          , 'vanilla_nether', Aspects('250👻 50🕊️ 100♒'));

// Hostile Vanilla End
soulRecipe('minecraft:enderman' , 'vanilla_end', Aspects('200👽 100🌑'));
soulRecipe('minecraft:endermite', 'vanilla_end', Aspects('100👽 50〇 50🔗'));
soulRecipe('minecraft:shulker'  , 'vanilla_end', Aspects('200👽 100🕊️ 50🛎️'));

// Elementals
soulRecipe('minecraft:blaze'              , 'elementals', Aspects('60🔥 60🧨'));
soulRecipe('thermalfoundation:blizz'      , 'elementals', Aspects('60💧 60🧊'));
soulRecipe('thermalfoundation:basalz'     , 'elementals', Aspects('60⛰️ 60🔩'));
soulRecipe('thermalfoundation:blitz'      , 'elementals', Aspects('60💨 60🍃'));

soulRecipe('tconstruct:blueslime'         , 'hvanilla'  , Aspects('100☀️ 100⚗️'));
soulRecipe('twilightforest:kobold'        , 'hvanilla'  , Aspects('100☀️ 100🛡️'));
soulRecipe('twilightforest:swarm_spider'  , 'hvanilla'  , Aspects('100☀️ 100🌑'));
soulRecipe('twilightforest:penguin'       , 'hvanilla'  , Aspects('100☀️ 100🦉'));
soulRecipe('twilightforest:minotaur'      , 'hvanilla'  , Aspects('100☀️ 100🦄'));

soulRecipe('minecraft:villager'           , 'hvanilla'  , Aspects('500👨 500🐀 500🙌'));
soulRecipe('minecraft:villager_golem'     , 'hvanilla'  , Aspects('500👨 500🐀 500☀️'));
soulRecipe('minecraft:evocation_illager'  , 'hvanilla'  , Aspects('500👨 500🐀 500💀'));
soulRecipe('minecraft:vindication_illager', 'hvanilla'  , Aspects('500👨 500🐀 500👁️'));
soulRecipe('minecraft:illusion_illager'   , 'hvanilla'  , Aspects('500👨 500🐀 500❤️'));

soulRecipe('minecraft:vex'                , 'hvanilla'  , Aspects('500👽 500🐲 500👁️'));

/*
 ██████╗ ████████╗██╗  ██╗███████╗██████╗
██╔═══██║╚══██╔══╝██║  ██║██╔════╝██╔══██╗
██║   ██║   ██║   ███████║█████╗  ██████╔╝
██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗
╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║
 ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
*/

scripts.process.crushRock(<thaumicaugmentation:stone>,
  [<jaopca:item_dusttanzanite>, <jaopca:item_dustdimensionalshard>, <actuallyadditions:item_dust:7>],
  [0.8, 0.2, 0.1],
  'only: rockCrusher');

scripts.process.crushRock(<thaumicaugmentation:stone:1>,
  [<jaopca:item_dusttanzanite>, <jaopca:item_dustdimensionalshard>, <thaumadditions:salt_essence>.withTag({ Aspects: [{ amount: 1, key: 'vitium' }] }) ?? <harvestcraft:saltitem>],
  [0.8, 0.2, 0.1],
  'only: rockCrusher');

scripts.process.crushRock(<thaumicaugmentation:stone:2>,
  [<jaopca:item_dusttanzanite>, <jaopca:item_dustdimensionalshard>, <thaumadditions:salt_essence>.withTag({ Aspects: [{ amount: 1, key: 'vitium' }] }) ?? <harvestcraft:saltitem>],
  [0.8, 0.3, 0.1],
  'only: rockCrusher');

// Skyblock alt
mods.thaumcraft.SalisMundus.addSingleConversion(<ore:plankWood>, <thaumcraft:plank_silverwood>);
mods.thaumcraft.SalisMundus.addSingleConversion(<ore:logWood>, <thaumcraft:log_greatwood>);
scripts.jei.crafting_hints.addInsOutCatl([<ore:plankWood>, <thaumcraft:salis_mundus>], <thaumcraft:plank_silverwood>);
scripts.jei.crafting_hints.addInsOutCatl([<ore:logWood>, <thaumcraft:salis_mundus>], <thaumcraft:log_greatwood>);

// Tattered scrolls alt recipe
mods.astralsorcery.Altar.addConstellationAltarRecipe(
  'Tattered Scrolls alt', <thaumicaugmentation:research_notes>, 1500, 250, Grid([
    'KCK'
    + 'NIN'
    + 'KVK'
    + 'LERP'
    + 'HHGGGGHH'], {
    'K': <astralsorcery:itemknowledgeshare>, // Scroll of written expertise
    'V': <thaumadditions:void_fruit> ?? <thaumicwonders:void_beacon>, // Void fruit
    'C': <thaumcraft:curiosity_band>, // Curiosity band
    'I': <thaumicaugmentation:material:3>, // Impetus Cell
    'G': <thaumicwonders:primordial_grain>, // Primordial grain
    'H': <warptheory:item_something>, // Hunk of Somethink
    'N': <enderio:item_material:75>, // Infinity reagent
    'L': <botania:rune:9>, // Rune of Lust
    'E': <botania:rune:14>, // Rune of Envy
    'R': <botania:rune:11>, // Rune of Greed
    'P': <botania:rune:15>, // Rune of Pride
  }).shapeless()
);

mods.tconstruct.Melting.removeRecipe(<liquid:gold>, <thaumcraft:filter>);
mods.tconstruct.Melting.removeRecipe(<liquid:gold>, <thaumcraft:inlay>);

// Pech wand peaceful alt
mods.bloodmagic.BloodAltar.addRecipe(<thaumcraft:pech_wand>, <redstonerepository:tool.wrench_gelid>, 4, 80000, 200, 200);

// Other mobs hints
scripts.jei.crafting_hints.addInsOutsCatl([], [
  <entity:thaumcraft:cultistcleric>.asStack(),
  <entity:thaumcraft:cultistknight>.asStack(),
  <entity:thaumcraft:cultistleader>.asStack(),
], <entity:thaumcraft:cultistportalgreater>.asIngr());
scripts.jei.crafting_hints.addInsOutsCatl([], [
  <thaumcraft:banner_crimson_cult> * 4,
  <thaumcraft:loot_crate_common> * 9,
], <entity:thaumcraft:cultistportalgreater>.asIngr());
