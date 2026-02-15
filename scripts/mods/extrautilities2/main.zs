#modloaded extrautils2 ic2
#priority 1

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

mods.jei.JEI.hideCategory('xu2_machine_extrautils2:furnace');
mods.jei.JEI.hideCategory('xu2_machine_extrautils2:generator_survival');
mods.jei.JEI.hideCategory('xu2_machine_extrautils2:generator');

static machineBlock as IIngredient = <extrautils2:machine>.only(function(item){return !item.hasTag;});

// Recycle spikes
scripts.process.melt(<extrautils2:spike_gold>, <fluid:gold> * (144 * 4));

// Bag of Holding
recipes.remove(<extrautils2:bagofholding>);

// Diamond Spike
recipes.remove(<extrautils2:spike_diamond>);
recipes.addShapedMirrored('Diamond Spike',
  <extrautils2:spike_diamond>,
  [[null, <redstonearsenal:tool.sword_flux>.anyDamage(), null],
    [<immersiveengineering:metal_decoration1_slab:5>, <ore:itemCompressedDiamond>, <immersiveengineering:metal_decoration1_slab:5>],
    [<ore:itemCompressedDiamond>, <ore:itemCompressedDiamond>, <ore:itemCompressedDiamond>]]);

// Redstone Clock
recipes.remove(<extrautils2:redstoneclock>);
recipes.addShaped('XU2 Redstone Clock',
  <extrautils2:redstoneclock>,
  [[<appliedenergistics2:smooth_sky_stone_block>, <randomthings:advancedredstonetorch_on>, <appliedenergistics2:smooth_sky_stone_block>],
    [<randomthings:advancedredstonetorch_on>, <ore:gemRedstone>, <randomthings:advancedredstonetorch_on>],
    [<appliedenergistics2:smooth_sky_stone_block>, <randomthings:advancedredstonetorch_on>, <appliedenergistics2:smooth_sky_stone_block>]]);

// Melting Ender Lilies
mods.thermalexpansion.Crucible.addRecipe(<liquid:ender> * 2000, <extrautils2:enderlilly>, 100000);

// [Ender Fragment] from [Ender Pearl Powder]
recipes.removeByRecipeName('enderio:ender_defragmentation');
craft.shapeless(<enderio:item_material:62>, '‚‚‚‚‚‚‚‚‚', {
  '‚': <ore:nuggetEnderpearl>, // Ender Pearl Powder
});

// [Ender Lilly] from [Ender Fragment]
craft.shapeless(<extrautils2:enderlilly>, 'EEEEEEEEE', {
  'E': <ore:itemEnderFragment>, // Ender Fragment
});

// Removing Easy Moon Stone recipe
recipes.remove(<extrautils2:ingredients:5>);
recipes.addShaped('Moon Stone',
  <extrautils2:ingredients:5>,
  [[<ore:dustLunar>, <ore:dustLunar>, <ore:dustLunar>],
    [<ore:dustLunar>, <ore:ingotUnstable>, <ore:dustLunar>],
    [<ore:dustLunar>, <ore:dustLunar>, <ore:dustLunar>]]);

// Fixing the Slime generator recipe (something went wrong with the oredict)
recipes.remove(<extrautils2:machine>.withTag({ Type: 'extrautils2:generator_slime' }),true);
recipes.addShaped('SlimeGen',
  <extrautils2:machine>.withTag({ Type: 'extrautils2:generator_slime' }),
  [[<ore:slimeball>, <ore:slimeball>, <ore:slimeball>],
    [<ore:slimeball>, <ore:blockSlime>, <ore:slimeball>],
    [<ore:dustRedstone>, <extrautils2:machine>.withTag({ Type: 'extrautils2:generator' }), <ore:dustRedstone>]]);

// Wireless RF Transmitter
recipes.remove(<extrautils2:powertransmitter>);
recipes.addShapedMirrored('Wireless RF Transmitter',
  <extrautils2:powertransmitter>,
  [[null, <extrautils2:ingredients>, null],
    [null, <appliedenergistics2:material:42>, null],
    [<extrautils2:decorativesolid:3>, <extrautils2:decorativesolid:3>, <extrautils2:decorativesolid:3>]]);

// Wireless RF Battery
recipes.remove(<extrautils2:powerbattery>);
recipes.addShapedMirrored('Wireless RF Battery',
  <extrautils2:powerbattery>,
  [[<extrautils2:decorativesolid:3>, <ore:blockRedstone>, <extrautils2:decorativesolid:3>],
    [<ore:gemRedstone>, <immersiveengineering:metal_decoration0:3>, <ore:gemRedstone>],
    [<extrautils2:decorativesolid:3>, <ore:blockRedstone>, <extrautils2:decorativesolid:3>]]);

craft.remake(<extrautils2:rainbowgenerator>, ['pretty',
  '⌃ ⌃ ⌃ ⌃ ⌃ ⌃ ⌃',
  '⌃ ■ ■ a ■ ■ ⌃',
  '⌃ ■ ▬ ▬ ▬ ■ ⌃',
  '⌃ O s i s O ⌃',
  '⌃ ■ ▬ ▬ ▬ ■ ⌃',
  '⌃ ■ ■ R ■ ■ ⌃',
  '⌃ ⌃ ⌃ ⌃ ⌃ ⌃ ⌃'], {
  '⌃': <extrautils2:decorativesolid:6>,
  '■': <chisel:futura:2>,
  'a': <extrautils2:rainbowgenerator:2>,
  '▬': <ore:ingotGold198>,
  'O': <extrautils2:opinium:5>,
  's': <contenttweaker:ball_singularity>.withTag({ completed: 1 as byte }),
  'i': <contenttweaker:machine_case_singularity>.withTag({ completed: 1 as byte }),
  'R': <extrautils2:rainbowgenerator:1>,
});

// Transper Pipe
recipes.remove(<extrautils2:pipe>);
recipes.addShaped('Transfer Pipe',
  <extrautils2:pipe> * 32,
  [[<minecraft:stone_slab>, <minecraft:stone_slab>, <minecraft:stone_slab>],
    [<xnet:netcable:*>, <ore:blockRedstone>, <xnet:netcable:*>],
    [<minecraft:stone_slab>, <minecraft:stone_slab>, <minecraft:stone_slab>]]);

// Analog Crafter
recipes.remove(<extrautils2:analogcrafter>);
recipes.addShaped('Analog Crafter',
  <extrautils2:analogcrafter>,
  [[<ore:workbench>, <ore:workbench>, <ore:workbench>],
    [<ore:workbench>, <minecraft:lever>, <ore:workbench>],
    [<ore:workbench>, <ore:workbench>, <ore:workbench>]]);

// Resonator
recipes.remove(<extrautils2:resonator>);
recipes.addShaped('Resonator',
  <extrautils2:resonator>,
  [[<ore:circuitAdvanced>, machineBlock, <ore:circuitAdvanced>],
    [<ore:plateSteel>, <chisel:glass:1>, <ore:plateSteel>],
    [<ore:plateSteel>, <ore:blockCoalCoke>, <ore:plateSteel>]]);

// Machine Block
recipes.remove(<extrautils2:machine>, true);

// [Machine Block] from [Reinforced Stone][+2]
craft.make(<extrautils2:machine>, ['pretty',
  'P ■ P',
  '■ R ■',
  'P ■ P'], {
  'P': <extrautils2:decorativesolid:2>, // Polished Stone
  '■': <ore:machineBlock>             , // Basic Machine Casing
  'R': <ic2:resource:11>,               // Reinforced Stone
});

// [Machine Block]*2 from [Vacuum Tube][+2]
scripts.mods.extendedcrafting_engineering.makeAlted(
  <extrautils2:machine> * 2, ['pretty',
  'P I P',
  'T B T',
  'P I P'], {
  'P': <extrautils2:decorativesolid:2>,
  'I': <ore:plateConstantan>,
  'T': <ore:plateConstantan>,
  'B': <immersiveengineering:material:26>,
}, 5, {
  'I': <forestry:thermionic_tubes:3>,
  'T': <immersiveengineering:material:26>,
  'B': <extendedcrafting:material:8>,
});

// [Machine Block]*3 from [Sturdy Casing][+2]
craft.make(<extrautils2:machine> * 3, ['pretty',
  'P I P',
  'I ⌂ I',
  'P I P'], {
  'P': <extrautils2:decorativesolid:2>, // Polished Stone
  'I': <forestry:thermionic_tubes:3>,   // Iron Electron Tube
  '⌂': <forestry:sturdy_machine>,       // Sturdy Casing
});

// [Sun Crystal (Empty)] from [Pure Certus Quartz Crystal][+1]
recipes.remove(<extrautils2:suncrystal:*>);
craft.remake(<extrautils2:suncrystal:250>, ['pretty',
  '◊ ◊ ◊',
  '◊ ⌃ ◊',
  '◊ ◊ ◊'], {
  '⌃': <appliedenergistics2:material:10>, // Pure Certus Quartz Crystal
  '◊': <ore:gemAmber>, // Amber
});

// Not sure if this would work:
vanilla.seeds.removeSeed(<extrautils2:enderlilly>);

// Remake Chunk loader recipe
remakeEx(<extrautils2:chunkloader>, [
  [<ore:stickTreatedWood>, <ore:eyeofredstone>, <ore:stickTreatedWood>],
  [<ore:stickTreatedWood>, <extrautils2:goldenlasso>.withTag({ Animal: { id: 'minecraft:villager' } }), <ore:stickTreatedWood>],
  [null, <ore:stickTreatedWood>, null]]);

// Fix generator (probably ench table is invisible because of Quark ench changes)
remakeEx(<extrautils2:machine>.withTag({ Type: 'extrautils2:generator_enchant' }), [
  [<ore:blockMagicalWood>, <ore:blockMagicalWood>, <ore:blockMagicalWood>],
  [<ore:blockMagicalWood>, <minecraft:enchanting_table>, <ore:blockMagicalWood>],
  [<ore:dustRedstone>, <extrautils2:machine>.withTag({ Type: 'extrautils2:generator' }), <ore:dustRedstone>]]);

// Cut enderpearl into pieces
scripts.process.mash(<minecraft:ender_pearl> , <extrautils2:endershard> * 16, null);

// Blue quartz as ultimate grid user
// mods.extrautils2.Resonator.add(IItemStack output, IItemStack input, int energy, @Optional boolean addOwnerTag);
mods.extrautils2.Resonator.add(<extrautils2:decorativesolid:6>, <botania:quartztypemana>, 600 * 100);

// Cheap Blue Quartz replica
mods.extrautils2.Resonator.add(<extrautils2:decorativesolid:6> * 64, <extrautils2:poweroverload>, 1400 * 100);

// Make quartzburnt harder (was 8 GP)
mods.extrautils2.Resonator.remove(<extrautils2:decorativesolid:7>);
mods.extrautils2.Resonator.add(<extrautils2:decorativesolid:7>, <minecraft:quartz_block>, 80 * 100);

// Upgrade base from demonic ingot
mods.extrautils2.Resonator.remove(<extrautils2:ingredients:9>);
mods.extrautils2.Resonator.add(<extrautils2:ingredients:9>, <extrautils2:ingredients:11> * 2, 8 * 100);

// Harder Player Chest (was most easy player interface)
craft.remake(<extrautils2:playerchest>, ['pretty',
  'A A A',
  'A C A',
  'A B A'], {
  A: <extrautils2:decorativesolid:7>,
  B: <extrautils2:ingredients:12>,
  C: <enderstorage:ender_storage>,
});

// [Deep Dark Portal] from [Block of Evil Infused Iron][+3]
craft.remake(<extrautils2:teleporter:1>, ['pretty',
  '░ Q ░',
  '⌃ ■ ⌃',
  '░ Q ░'], {
  '░': <ore:compressed5xCobblestone>,   // Quintuple Compressed Cobblestone
  'Q': <extrautils2:decorativesolid:7>, // Quartzburnt
  '⌃': <extrautils2:decorativesolid:6>, // Blue Quartz
  '■': <ore:blockEvilMetal>,            // Block of Evil Infused Iron
});

// [Ender_Porcupine] from [Indexer][+2]
craft.remake(<extrautils2:interactionproxy>, ['pretty',
  'E T E',
  'T I T',
  'E T E'], {
  'T': <ore:dustDimensional>,
  'E': <extrautils2:enderlilly>, // Ender Lilly
  'I': <extrautils2:indexer>,     // Indexer
});

// [Redstone Gear] from [Magical Planks][+1]
craft.remake(<extrautils2:ingredients:1>, ['pretty',
  '  ♥  ',
  '♥ M ♥',
  '  ♥  '], {
  '♥': <ore:gemRedstone>,                 // Resonating Redstone Crystal
  'M': <extrautils2:decorativesolidwood>, // Magical Planks
});

// [Chicken Wing Ring] from [Golden Lasso][+3]
craft.remake(<extrautils2:chickenring>, ['pretty',
  'f ▬ f',
  '▬ G ▬',
  '♥ ▬ ♥'], {
  'f': <ore:feather>, // Feather
  '▬': <ore:ingotFakeIron>, // Iron Ingot
  'G': <extrautils2:goldenlasso>.withTag({ Animal: { id: 'minecraft:chicken' } }), // Golden Lasso
  '♥': <ore:gemRedstone>, // Resonating Redstone Crystal
});

craft.remake(<extrautils2:screen>, ['pretty',
  '  S  ',
  'E ♥ E'], {
  'S': <extrautils2:decorativesolid:3>,
  'E': <extrautils2:endershard>,
  '♥': <ore:gemRedstone>,
});

// *======= Ring Of The Flying Squid =======*
remake('Ring Of The Flying Squid',
  <extrautils2:chickenring:1>,
  [[<extrautils2:ineffableglass>, <actuallyadditions:item_misc:19>, <extrautils2:ineffableglass>],
    [<ore:plateDenseGold>, <extrautils2:chickenring>, <ore:plateDenseGold>],
    [<minecraft:golden_apple>, <extrautils2:goldenlasso>.withTag({ Animal: { id: 'minecraft:squid' } }), <minecraft:golden_apple>]]);

// *======= Angel Ring =======*
for i in 0 .. 6 {
  recipes.removeByRecipeName('extrautils2:angel_ring_' ~ i); // Remove shaped
}

// [Angel Ring] from [Ring of the Flying Squid][+2]
craft.make(<extrautils2:angelring>, ['pretty',
  '▬ C ▬',
  '▬ R ▬',
  '▬ ▬ ▬'], {
  '▬': <ore:ingotGold198>,          // Gold-198
  'C': <extrautils2:poweroverload>,
  'R': <extrautils2:chickenring:1>, // Ring of the Flying Squid
});

// [Dragon Egg Mill] from [Redstone Gear][+3]
craft.remake(<extrautils2:passivegenerator:8>, ['pretty',
  'Q e Q',
  'S ♥ S',
  'Q e Q'], {
  'Q': <extrautils2:decorativesolid:7>, // Quartzburnt
  'S': <ore:netherStar>,                // Nether Star
  'e': <ore:eyeofredstone>,             // Eye of Redstone
  '♥': <ore:gearRedstone>,              // Redstone Gear
});

val coreToolIngrs = {
  '⌃': <extrautils2:decorativesolid:6>, // Blue Quartz
  '#': <ore:stickWood>,                 // Stick
  's': <ore:string>,                    // String
  'O': <extrautils2:opinium:8>,         // Opinium Core (Perfected)
} as IIngredient[string];

// [Kikoku] from [Blue Quartz][+1]
craft.remake(<extrautils2:lawsword>, ['O','O','⌃'], coreToolIngrs);

// [Compound Bow] from [Blue Quartz][+2]
craft.remake(<extrautils2:compoundbow>, ['pretty',
  '  O s',
  'O ⌃  ',
  's    '], coreToolIngrs
);

// [Fire Axe] from [Blue Quartz][+2]
craft.remake(<extrautils2:fireaxe>, ['pretty',
  'O ⌃',
  'O #',
  '  #'], coreToolIngrs
);

// Harder Flat Transfer Nodes
recipes.remove(<extrautils2:flattransfernode:*>);
mods.mechanics.addCrushingBlockRecipe(<extrautils2:grocket:0>, [<extrautils2:flattransfernode:0>], [1.0]);
mods.mechanics.addCrushingBlockRecipe(<extrautils2:grocket:2>, [<extrautils2:flattransfernode:1>], [1.0]);

// [Mechanical User] from [Player Simulator][+4]
craft.remake(<extrautils2:user>, ['pretty',
  '□ ◊ □',
  'M P M',
  'Q Q Q'], {
  'P': <integratedtunnels:part_player_simulator_item>, // Player Simulator
  'Q': <extrautils2:decorativesolid:7>, // Quartzburnt
  '□': <tconstruct:large_plate>.withTag({ Material: 'xu_demonic_metal' }), // Demonic Large Plate
  '◊': <ore:gemMoon>,                   // Moon Stone
  'M': <tconstruct:materials:19>,       // Mending Moss
});

// [Klein Bottle] from [Xorcite Shard][+3]
craft.remake(<extrautils2:klein>, ['pretty',
  'C X C',
  'M □ M',
  'M □ M'], {
  '□': <tconstruct:large_plate>.withTag({ Material: 'xu_demonic_metal' }), // Demonic Large Plate
  'C': <minecraft:web>,                   // Cobweb
  'X': <endreborn:death_essence>,         // Xorcite Shard
  'M': <extrautils2:decorativesolidwood>, // Magical Planks
});

// [Stone Drum] from [Omnivoir][+1]
recipes.removeByRecipeName('extrautils2:drum_16');
craft.make(<extrautils2:drum>, [
  'S',
  'O',
  'S'], {
  'S': <ore:cobblestone>,
  'O': <enderio:block_omni_reservoir>,  // Omnivoir
});

// [Iron Drum] from [Quartzburnt][+3]
recipes.removeByRecipeName('extrautils2:drum_256');
craft.make(<extrautils2:drum:1>, ['pretty',
  '  п  ',
  'S S S',
  '  Q  '], {
  'Q': <extrautils2:decorativesolid:3>,
  'S': <extrautils2:drum>,              // Stone Drum
  'п': <ore:plateDenseIron>,            // Dense Iron Plate
});

// [Reinforced Large Drum] from [Klein Bottle][+3]
recipes.removeByRecipeName('extrautils2:drum_4096');
craft.make(<extrautils2:drum:2>, ['pretty',
  '  □  ',
  'I I I',
  '  K  '], {
  '□': <ore:plateLumium>,         // Lumium Plate
  'I': <extrautils2:drum:1>,      // Iron Drum
  'K': <extrautils2:decorativesolid:7>,
});

// [Demonically Gargantuan Drum] from [High Pressure Steam Bucket][+3]
recipes.removeByRecipeName('extrautils2:drum_65536');
craft.make(<extrautils2:drum:3>, ['pretty',
  '  ~  ',
  'R R R',
  '  ⌃  '], {
  'R': <extrautils2:drum:2>,            // Reinforced Large Drum
  '⌃': <extrautils2:decorativesolid:6>, // Blue Quartz
  '~': <extrautils2:klein>,
});

// High-GP usage ingredient
mods.extrautils2.Resonator.add(<extrautils2:poweroverload>, <extrautils2:decorativesolid:6>, 1300 * 100);

// Make Ferrous Trees better integrated
furnace.remove(<minecraft:iron_nugget>, <extrautils2:ironwood_planks:*>);

// Unburnt
scripts.process.melt(<extrautils2:ironwood_log:0>   , <liquid:iron> *  16, 'No Exceptions');
scripts.process.melt(<extrautils2:ironwood_planks:0>, <liquid:iron> *  8, 'No Exceptions');

// Burnt
scripts.process.melt(<extrautils2:ironwood_log:1>   , <liquid:iron> * 144, 'No Exceptions');
scripts.process.melt(<extrautils2:ironwood_planks:1>, <liquid:iron> *  80, 'No Exceptions');
mods.tconstruct.Casting.addTableRecipe(<extrautils2:ironwood_sapling>, <ore:treeSapling>, <liquid:iron>, 576, true, 1);

// [Climograph Base Unit] cheaper for easy biome manipulation
craft.remake(<extrautils2:terraformer:9>, ['pretty',
  '▬ S ▬',
  'S ■ S',
  '▬ S ▬'], {
  '▬': <ore:ingotFakeIron>,       // Iron Alloy Ingot
  'S': <ic2:crafting:20>,
  '■': <ore:blockSheetmetalIron>, // Iron Sheetmetal
});

// [Antenna]*8 from [Antenna Base][+2]
craft.remake(<extrautils2:terraformer:1> * 16, ['pretty',
  '/   /',
  '/ A /',
  '/ C /'], {
  '/': <minecraft:end_rod>,         // End Rod
  'A': <xnet:antenna_base>,         // Antenna Base
  'C': <extrautils2:terraformer:9>, // Climograph Base Unit
});

// -----------------------------------------------------------------------------------------------
// - Biome Markers
// -----------------------------------------------------------------------------------------------

// [Biome Marker] from [Plantball][+2]
recipes.removeByRecipeName('extrautils2:biome_marker');
craft.make(<extrautils2:biomemarker>, ['pretty',
  'd ▬ d',
  '▬ P ▬',
  'd ▬ d'], {
  'd': <ore:dyeMagenta>,  // Magenta Dye
  '▬': <ore:ingotTin>,    // Tin Ingot
  'P': <ic2:crafting:20>, // Plantball
});

for biome, input in {
  'minecraft:hell'           : <ore:blockCobalt>,
  'minecraft:sky'            : <endreborn:block_decorative_lormyte>,
  'rats:ratlantis'           : <rats:marbled_cheese_raw>,
  'minecraft:taiga'          : <minecraft:snow>,
  'minecraft:swampland'      : <twilightforest:twilight_log:2> | <biomesoplenty:log_1:6>,
  'minecraft:ice_flats'      : <biomesoplenty:hard_ice>,
  'minecraft:desert'         : Bucket('sand'),
  'minecraft:jungle'         : <minecraft:vine>,
  'thaumcraft:magical_forest': <thaumcraft:vishroom>,
} as IIngredient[string] {
  recipes.addShapeless(<extrautils2:biomemarker>.withTag({ Biome: biome }), [<extrautils2:biomemarker>, input]);
}
// -----------------------------------------------------------------------------------------------

// Fix enchanting tables in craft
// [Magic Infuser] from [Climograph Base Unit][+1]
craft.reshapeless(<extrautils2:terraformer:8>, 'CEE', {
  'C': <extrautils2:terraformer:9>,   // Climograph Base Unit
  'E': <endreborn:block_essence_ore>, // Essence Ore
});

// [Mechanical Crafter] from [Redstone Gear][+2]
craft.remake(<extrautils2:crafter>, ['pretty',
  '# # #',
  '░ ♥ ░',
  '░ ░ ░'], {
  '#': <extrautils2:ironwood_planks:0>, // Ferrous-Juniper Planks
  '░': <ore:cobblestone>,               // Cobblestone
  '♥': <ore:gearRedstone>,              // Redstone Gear
});
craft.make(<extrautils2:crafter>, ['pretty',
  '# # #',
  '░ ♥ ░',
  '░ ░ ░'], {
  '#': <extrautils2:ironwood_planks:1>, // Ferrous-Juniper Planks
  '░': <ore:cobblestone>,               // Cobblestone
  '♥': <ore:gearRedstone>,              // Redstone Gear
});

// [Mechanical Miner] from [Redstone Gear][+3]
craft.remake(<extrautils2:miner>, ['pretty',
  '# ▲ #',
  '░ ♥ ░',
  '░ ░ ░'], {
  '#': <extrautils2:ironwood_planks:1>, // Raw Ferrous-Juniper Planks
  '▲': <ore:dustCoke>,                  // Coke Dust
  '░': <ore:cobblestone>,               // Cobblestone
  '♥': <ore:gearRedstone>,              // Redstone Gear
});
craft.make(<extrautils2:miner>, ['pretty',
  '# ▲ #',
  '░ ♥ ░',
  '░ ░ ░'], {
  '#': <extrautils2:ironwood_planks>, // Ferrous-Juniper Planks
  '▲': <ore:dustCoke>,                // Coke Dust
  '░': <ore:cobblestone>,             // Cobblestone
  '♥': <ore:gearRedstone>,            // Redstone Gear
});

// [Sandy Glass] from [Sand][+1]
craft.reshapeless(<extrautils2:decorativesolid:4> * 6, 'sGGG', {
  's': <ore:sand>, // Sand
  'G': <quark:glass_shards:*>, // Glass Shard
});

function remakeEnchanterRecipe(
  oldInput as IItemStack,
  oldLapis as IItemStack,
  input as IIngredient,
  input_lapis as IIngredient,
  output as IItemStack,
  energy as int,
  time as int
) as void {
  val enchanter = extrautilities2.Tweaker.IMachineRegistry.getMachine('extrautils2:enchanter');
  enchanter.removeRecipe({ input: oldInput, input_lapis: oldLapis });
  enchanter.addRecipe({ input: input, input_lapis: input_lapis }, { output: output }, energy, time);
}

remakeEnchanterRecipe(<minecraft:gold_block>, <minecraft:dye:4> * 9      , <ore:blockElectrum>, <ore:blockLapis>      , <extrautils2:simpledecorative>  ,  50000, 20 * 30);
remakeEnchanterRecipe(<minecraft:gold_ingot>, <minecraft:dye:4>          , <ore:ingotElectrum>, <ore:gemLapis>        , <extrautils2:ingredients:12>    ,   8000, 20 * 10);
remakeEnchanterRecipe(<minecraft:iron_block> * 8, <minecraft:nether_star> * 9, <ore:blockPigiron> , <ore:netherStar>      , <extrautils2:simpledecorative:2>, 500000, 4800);
remakeEnchanterRecipe(<minecraft:iron_ingot> * 8, <minecraft:nether_star>    , <ore:ingotPigiron> , <ore:nuggetNetherStar>, <extrautils2:ingredients:17>    ,  80000, 480);

// Turn Red Orchids straight into redstone Ore
scripts.do.burnt_in_fluid.add(<extrautils2:redorchid>, <blockstate:minecraft:redstone_ore>, 'stone', 1.0 / 3.0);

// Allow Ferrous-Juniper saplings to drop from Ferrous-Juniper Leaves when breaking with Crook
mods.exnihilocreatio.Crook.addRecipe(<extrautils2:ironwood_leaves>, <extrautils2:ironwood_sapling>, 0.2, 0.28);

// Remake removed AA crusher benefits
scripts.process.crush(<minecraft:gold_ore>, <thermalfoundation:material:1> * 2, 'only: IECrusher', [<contenttweaker:dust_tiny_silver>], [1.0f]);
scripts.process.crush(<minecraft:gravel>, <minecraft:sand>, 'only: IECrusher', [<minecraft:flint>], [0.5f]);
scripts.process.crush(<immersiveengineering:material:19>, <immersiveengineering:material:18>, 'only: IECrusher');
scripts.process.crush(<minecraft:prismarine_shard>, <minecraft:prismarine_crystals>, 'only: IECrusher');
