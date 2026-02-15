#modloaded chisel modtweaker
#ignoreBracketErrors

import crafttweaker.item.IItemStack;
import mods.chisel.Carving.addVariation;

recipes.remove(<chisel:block_charcoal2:1>);

// Chisel Lavastone / Environmental Tech Basalt
recipes.remove(<chisel:lavastone>);
recipes.addShapedMirrored('Chisel Lavastone',
  <chisel:lavastone> * 16,
  [[<ore:stone>, <ore:stone>, <ore:stone>],
    [<minecraft:lava_bucket>, <ore:stone>, <minecraft:lava_bucket>],
    [<ore:stone>, <ore:stone>, <ore:stone>]]);

addVariation('basalt', <quark:basalt:1>);
addVariation('basalt', <quark:basalt>);
addVariation('marble', <quark:marble>);

addVariation('limestone', <quark:limestone>);
addVariation('limestone', <quark:limestone:1>);

addVariation('sootymarble', <astralsorcery:blockblackmarble:0>);
addVariation('sootymarble', <astralsorcery:blockblackmarble:1>);
addVariation('sootymarble', <astralsorcery:blockblackmarble:2>);
addVariation('sootymarble', <astralsorcery:blockblackmarble:3>);
addVariation('sootymarble', <astralsorcery:blockblackmarble:4>);
addVariation('sootymarble', <astralsorcery:blockblackmarble:5>);
addVariation('sootymarble', <astralsorcery:blockblackmarble:6>);

addVariation('castlebrickrune', <twilightforest:castle_rune_brick:0>);
addVariation('castlebrickrune', <twilightforest:castle_rune_brick:1>);
addVariation('castlebrickrune', <twilightforest:castle_rune_brick:2>);
addVariation('castlebrickrune', <twilightforest:castle_rune_brick:3>);

addVariation('castlebrickdoor', <twilightforest:castle_door:0>);
addVariation('castlebrickdoor', <twilightforest:castle_door:1>);
addVariation('castlebrickdoor', <twilightforest:castle_door:2>);
addVariation('castlebrickdoor', <twilightforest:castle_door:3>);

addVariation('soulstone', <mysticalagriculture:soulstone:2>);
addVariation('soulstone', <mysticalagriculture:soulstone:3>);
addVariation('soulstone', <mysticalagriculture:soulstone:4>);
addVariation('soulstone', <mysticalagriculture:soulstone:5>);
addVariation('soulstone', <mysticalagriculture:soulstone:6>);
addVariation('soulstone', <mysticalagriculture:soulstone>);

addVariation('soulstone_slab', <mysticalagriculture:cobbled_soulstone_slab>);
addVariation('soulstone_slab', <mysticalagriculture:soulstone_brick_slab>);
addVariation('soulstone_slab', <mysticalagriculture:soulstone_slab>);

// Sonar Core
addVariation('sonar_dirt', <sonarcore:reinforceddirtblock>);
addVariation('sonar_dirt', <sonarcore:reinforceddirtbrick>);

addVariation('sonar_stone', <sonarcore:reinforcedstoneblock>);
addVariation('sonar_stone', <sonarcore:reinforcedstonebrick>);

addVariation('sonar_normal', <sonarcore:stablestone_normal>);
addVariation('sonar_normal', <sonarcore:stablestonerimmed_normal>);
addVariation('sonar_normal', <sonarcore:stablestoneblackrimmed_normal>);
addVariation('sonar_normal', <sonarcore:stablestone_plain>);
addVariation('sonar_normal', <sonarcore:stablestonerimmed_plain>);
addVariation('sonar_normal', <sonarcore:stablestoneblackrimmed_plain>);

addVariation('glass', <sonarcore:stableglass>);
addVariation('glass', <sonarcore:clearstableglass>);

val sonarColors as string[] = [
  'lightgrey', 'lime', 'blue',
  'cyan', 'magenta', 'pink', 'yellow', 'purple',
  'lightblue', 'green', 'orange', 'red', 'black', 'brown'];

for i in 0 .. 14 {
  val col = sonarColors[i];
  addVariation('sonar_' ~ col, itemUtils.getItem('sonarcore:stablestone_' ~ col));
  addVariation('sonar_' ~ col, itemUtils.getItem('sonarcore:stablestonerimmed_' ~ col));
  addVariation('sonar_' ~ col, itemUtils.getItem('sonarcore:stablestoneblackrimmed_' ~ col));
}

// Rats
addVariation('marbledCheese', <rats:marbled_cheese>);
addVariation('marbledCheese', <rats:marbled_cheese_tile>);
addVariation('marbledCheese', <rats:marbled_cheese_chiseled>);
addVariation('marbledCheese', <rats:marbled_cheese_pillar>);
addVariation('marbledCheese', <rats:marbled_cheese_brick>);
addVariation('marbledCheese', <rats:marbled_cheese_brick_chiseled>);
addVariation('marbledCheese', <rats:marbled_cheese_brick_cracked>);

// Remove clear glass from chisel
mods.chisel.Carving.removeVariation('glass', <tconstruct:clear_glass>);

for glass, col in {
  <tconstruct:clear_stained_glass>   : 'white',
  <tconstruct:clear_stained_glass:1> : 'orange',
  <tconstruct:clear_stained_glass:2> : 'magenta',
  <tconstruct:clear_stained_glass:3> : 'lightblue',
  <tconstruct:clear_stained_glass:4> : 'yellow',
  <tconstruct:clear_stained_glass:5> : 'lime',
  <tconstruct:clear_stained_glass:6> : 'pink',
  <tconstruct:clear_stained_glass:7> : 'gray',
  <tconstruct:clear_stained_glass:8> : 'lightgray',
  <tconstruct:clear_stained_glass:8> : 'silver',
  <tconstruct:clear_stained_glass:9> : 'cyan',
  <tconstruct:clear_stained_glass:10>: 'purple',
  <tconstruct:clear_stained_glass:11>: 'blue',
  <tconstruct:clear_stained_glass:12>: 'brown',
  <tconstruct:clear_stained_glass:13>: 'green',
  <tconstruct:clear_stained_glass:14>: 'red',
  <tconstruct:clear_stained_glass:15>: 'black',
} as string[IItemStack] {
  mods.chisel.Carving.removeVariation('glassdyed' ~ col, glass);
}

// Harder Iron chisel
recipes.remove(<chisel:chisel_iron>);
recipes.addShaped(<chisel:chisel_iron>, [
  [null, <tcomplement:chisel_head>.withTag({ Material: 'iron' }).onlyWithTag({ Material: 'iron' })],
  [<ore:stickTreatedWood>, null]]);

// Harder diamond chisel
recipes.remove(<chisel:chisel_diamond>);
craft.reshapeless(<chisel:chisel_diamond>, 'AAB', { A: <minecraft:diamond>, B: <chisel:chisel_iron> });

// Harder I-Chisel
recipes.remove(<chisel:chisel_hitech>);
recipes.addShapeless(<chisel:chisel_hitech>,
  [<ore:sheetHDPE>, <ore:sheetHDPE>, <chisel:chisel_diamond>]);

// Chests
addVariation('chest', <minecraft:chest>);
addVariation('chest', <quark:custom_chest>);
addVariation('chest', <quark:custom_chest:1>);
addVariation('chest', <quark:custom_chest:2>);
addVariation('chest', <quark:custom_chest:3>);
addVariation('chest', <quark:custom_chest:4>);

addVariation('endstone', <endreborn:block_end_stone_smooth>);
addVariation('endstone', <endreborn:block_end_stone_pillar>);
addVariation('endstone', <endreborn:chiseled_end_bricks>);

addVariation('engineers_sign', <engineersdecor:sign_hotwire>);
addVariation('engineers_sign', <engineersdecor:sign_danger>);
addVariation('engineers_sign', <engineersdecor:sign_defense>);
addVariation('engineers_sign', <engineersdecor:sign_factoryarea>);
addVariation('engineers_sign', <engineersdecor:sign_exit>);
addVariation('engineers_sign', <engineersdecor:sign_radioactive>);
addVariation('engineers_sign', <engineersdecor:sign_laser>);
addVariation('engineers_sign', <engineersdecor:sign_caution>);
addVariation('engineers_sign', <engineersdecor:sign_magichazard>);
addVariation('engineers_sign', <engineersdecor:sign_firehazard>);
addVariation('engineers_sign', <engineersdecor:sign_hotsurface>);
addVariation('engineers_sign', <engineersdecor:sign_magneticfield>);
addVariation('engineers_sign', <engineersdecor:sign_frost>);

val allDoors = [
  <minecraft:wooden_door>,
  <minecraft:spruce_door>,
  <minecraft:birch_door>,
  <minecraft:jungle_door>,
  <minecraft:acacia_door>,
  <minecraft:dark_oak_door>,
  <biomesoplenty:sacred_oak_door>,
  <biomesoplenty:cherry_door>,
  <biomesoplenty:umbran_door>,
  <biomesoplenty:fir_door>,
  <biomesoplenty:magic_door>,
  <biomesoplenty:mangrove_door>,
  <biomesoplenty:palm_door>,
  <biomesoplenty:redwood_door>,
  <biomesoplenty:willow_door>,
  <biomesoplenty:pine_door>,
  <biomesoplenty:hellbark_door>,
  <biomesoplenty:jacaranda_door>,
  <biomesoplenty:mahogany_door>,
  <biomesoplenty:ebony_door>,
  <biomesoplenty:eucalyptus_door>,
  <forestry:doors.larch>,
  <forestry:doors.teak>,
  <forestry:doors.acacia>,
  <forestry:doors.lime>,
  <forestry:doors.chestnut>,
  <forestry:doors.wenge>,
  <forestry:doors.baobab>,
  <forestry:doors.sequoia>,
  <forestry:doors.kapok>,
  <forestry:doors.ebony>,
  <forestry:doors.mahogany>,
  <forestry:doors.balsa>,
  <forestry:doors.willow>,
  <forestry:doors.walnut>,
  <forestry:doors.greenheart>,
  <forestry:doors.cherry>,
  <forestry:doors.mahoe>,
  <forestry:doors.poplar>,
  <forestry:doors.palm>,
  <forestry:doors.papaya>,
  <forestry:doors.pine>,
  <forestry:doors.plum>,
  <forestry:doors.maple>,
  <forestry:doors.citrus>,
  <forestry:doors.giganteum>,
  <forestry:doors.ipe>,
  <forestry:doors.padauk>,
  <forestry:doors.cocobolo>,
  <forestry:doors.zebrawood>,
  <integrateddynamics:menril_door>,
  <rustic:olive_door>,
  <rustic:ironwood_door>,
  // <twilightforest:canopy_door>,
  // <twilightforest:dark_door>,
  // <twilightforest:mangrove_door>,
  // <twilightforest:mine_door>,
  // <twilightforest:sort_door>,
  // <twilightforest:time_door>,
  // <twilightforest:trans_door>,
  // <twilightforest:twilight_oak_door>,
] as IItemStack[];

for door in allDoors {
  addVariation('door', door);
  if (
    door.definition.owner == 'forestry'
    || door.definition.owner == 'integrateddynamics'
  ) continue;
  mods.thermalexpansion.Sawmill.removeRecipe(door);
}

// Unify brownstone between mods
recipes.remove(<chisel:brownstone>);
mods.chisel.Carving.removeGroup('brownstone_tconstruct');
addVariation('brownstone', <tconstruct:brownstone>);
addVariation('brownstone', <tconstruct:brownstone:2>);
addVariation('brownstone', <tconstruct:brownstone:3>);
addVariation('brownstone', <tconstruct:brownstone:4>);
addVariation('brownstone', <tconstruct:brownstone:5>);
addVariation('brownstone', <tconstruct:brownstone:6>);
addVariation('brownstone', <tconstruct:brownstone:7>);
addVariation('brownstone', <tconstruct:brownstone:8>);
addVariation('brownstone', <tconstruct:brownstone:9>);
addVariation('brownstone', <tconstruct:brownstone:10>);
addVariation('brownstone', <tconstruct:brownstone:11>);
addVariation('brownstone_slab', <tconstruct:brownstone_slab>);
addVariation('brownstone_slab', <tconstruct:brownstone_slab:2>);
addVariation('brownstone_slab', <tconstruct:brownstone_slab:3>);
addVariation('brownstone_slab', <tconstruct:brownstone_slab:4>);
addVariation('brownstone_slab', <tconstruct:brownstone_slab:5>);
addVariation('brownstone_slab', <tconstruct:brownstone_slab:6>);
addVariation('brownstone_slab', <tconstruct:brownstone_slab:7>);
addVariation('brownstone_slab', <tconstruct:brownstone_slab2>);
addVariation('brownstone_slab', <tconstruct:brownstone_slab2:1>);
addVariation('brownstone_slab', <tconstruct:brownstone_slab2:2>);
addVariation('brownstone_slab', <tconstruct:brownstone_slab2:3>);
addVariation('brownstone_stairs', <tconstruct:brownstone_stairs_smooth>);
addVariation('brownstone_stairs', <tconstruct:brownstone_stairs_paver>);
addVariation('brownstone_stairs', <tconstruct:brownstone_stairs_brick>);
addVariation('brownstone_stairs', <tconstruct:brownstone_stairs_brick_cracked>);
addVariation('brownstone_stairs', <tconstruct:brownstone_stairs_brick_fancy>);
addVariation('brownstone_stairs', <tconstruct:brownstone_stairs_brick_square>);
addVariation('brownstone_stairs', <tconstruct:brownstone_stairs_brick_triangle>);
addVariation('brownstone_stairs', <tconstruct:brownstone_stairs_brick_small>);
addVariation('brownstone_stairs', <tconstruct:brownstone_stairs_road>);
addVariation('brownstone_stairs', <tconstruct:brownstone_stairs_tile>);
addVariation('brownstone_stairs', <tconstruct:brownstone_stairs_creeper>);
