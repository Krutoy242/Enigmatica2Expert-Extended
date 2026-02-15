#modloaded immersiveengineering tconstruct thermalexpansion

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import scripts.jei.crafting_hints;

// Prevent Core Samples to be placed, saving FPS
events.register(function (e as crafttweaker.event.PlayerInteractBlockEvent) {
  if (<immersiveengineering:coresample> has e.item) e.cancel();
});

recipes.remove(<immersiveengineering:material:1>);
recipes.remove(<immersiveengineering:material:2>);
recipes.remove(<immersiveengineering:material:3>);
Purge(<immersiveengineering:material:24>).ores([<ore:dustSaltpeter>, <ore:dustNiter>]);

// Recipe hint for mineral sampling
crafting_hints.add1to1(<immersiveengineering:metal_device1:7>, <immersiveengineering:coresample>);

// Fix IC2 block
val UI = <ore:ingotUranium>;
recipes.addShapeless(<immersiveengineering:storage:5>, [UI, UI, UI, UI, UI, UI, UI, UI, UI]);

// Removing Recycling recipes that produce IE Iron Nuggets
mods.immersiveengineering.ArcFurnace.removeRecipe(<immersiveengineering:metal:29>);

// Remove buggy silicon recipe (empty input)
mods.immersiveengineering.ArcFurnace.removeRecipe(<ore:ingotSilicon>.firstItem);

// Fix second ingredient not consuming
scripts.process.alloy([<ore:ingotNickel>, <ore:ingotFakeIron> * 2], <thermalfoundation:material:162> * 3, 'strict: ArcFurnace');

// Sheetmetal Chute Smeltery compat
mods.tconstruct.Melting.addRecipe(<liquid:iron> * 72, <immersiveengineering:conveyor>.withTag({ conveyorType: 'immersiveengineering:chute_iron' }));
mods.tconstruct.Melting.addRecipe(<liquid:steel> * 72, <immersiveengineering:conveyor>.withTag({ conveyorType: 'immersiveengineering:chute_steel' }));
mods.tconstruct.Melting.addRecipe(<liquid:aluminum> * 72, <immersiveengineering:conveyor>.withTag({ conveyorType: 'immersiveengineering:chute_aluminum' }));
mods.tconstruct.Melting.addRecipe(<liquid:copper> * 72, <immersiveengineering:conveyor>.withTag({ conveyorType: 'immersiveengineering:chute_copper' }));

// Crude Oil Unification
mods.immersivepetroleum.Distillation.addRecipe(
  [<liquid:lubricant> * 9, <liquid:diesel> * 27,  <liquid:gasoline> * 39],
  [<immersivepetroleum:material>],
  <liquid:crude_oil> * 75,
  4096, 20, [0.07]);

// Coal Coke Unification
recipes.remove(<thermalfoundation:storage_resource:1>);
recipes.addShaped('immersiveengineering_stone_decoration_3_custom', <immersiveengineering:stone_decoration:3>, [[<ore:fuelCoke>, <ore:fuelCoke>, <ore:fuelCoke>], [<ore:fuelCoke>, <ore:fuelCoke>, <ore:fuelCoke>], [<ore:fuelCoke>, <ore:fuelCoke>, <ore:fuelCoke>]]);

Purge(<thermalfoundation:material:802>).ores([<ore:fuelCoke>]);
mods.thermalexpansion.RedstoneFurnace.removePyrolysisRecipe(<minecraft:coal>);
mods.thermalexpansion.RedstoneFurnace.addPyrolysisRecipe(<immersiveengineering:material:6>,
  <minecraft:coal>, 3000, 250);

mods.thermalexpansion.RedstoneFurnace.removePyrolysisRecipe(<minecraft:coal_block>);
mods.thermalexpansion.RedstoneFurnace.addPyrolysisRecipe(<immersiveengineering:stone_decoration:3>,
  <minecraft:coal_block>, 30000, 2500);

// Sulfur Unification
mods.immersiveengineering.Crusher.removeRecipe(<minecraft:blaze_powder>);
mods.immersiveengineering.Crusher.addRecipe(<minecraft:blaze_powder> * 4, <ore:rodBlaze>, 2048, <thermalfoundation:material:771>, 0.5);

// Nitrate dust fix
mods.immersiveengineering.Crusher.removeRecipesForInput(<minecraft:sandstone>);
mods.immersiveengineering.Crusher.addRecipe(<minecraft:sand> * 2, <ore:sandstone>, 2048, <thermalfoundation:material:772>, 0.5);

mods.immersiveengineering.Crusher.removeRecipe(<libvulpes:productdust:3>);

// Aluminum Scaffolding
recipes.remove(<immersiveengineering:metal_decoration2:8>);
recipes.addShapedMirrored('Aluminum Scaffolding',
  <immersiveengineering:metal_decoration2:8> * 4,
  [[<ore:stickAluminum>, null, null],
    [<ore:scaffoldingAluminium>, <ore:stickAluminum>, null],
    [<ore:scaffoldingAluminium>, <ore:scaffoldingAluminium>, <ore:stickAluminum>]]);

// Steel Scaffolding
recipes.remove(<immersiveengineering:metal_decoration2:7>);
recipes.addShapedMirrored('Steel Scaffolding',
  <immersiveengineering:metal_decoration2:7> * 4,
  [[<ore:stickSteel>, null, null],
    [<ore:scaffoldingSteel>, <ore:stickSteel>, null],
    [<ore:scaffoldingSteel>, <ore:scaffoldingSteel>, <ore:stickSteel>]]);

// Concrete Conversion recipes
recipes.addShapedMirrored('Concrete Panel', <immersiveengineering:stone_device:4>, [[<ore:plateConcrete>, null, null],[<ore:plateConcrete>, null, null], [null, null, null]]);
recipes.addShapedMirrored('Concrete Slab', <immersiveengineering:stone_decoration_slab:5>, [[<immersiveengineering:stone_device:4>, null, null],[<immersiveengineering:stone_device:4>, null, null], [null, null, null]]);

recipes.removeByRecipeName('immersiveengineering:stone_decoration/concrete_slab');
recipes.removeByRecipeName('immersiveengineering:stone_decoration/concrete');
recipes.removeByRecipeName('immersiveengineering:stone_decoration/concrete2');

// Fluid hint
scripts.jei.crafting_hints.addInsOutsCatl([], [
  <immersiveengineering:stone_device:3>,
  <immersiveengineering:stone_device:4>,
  <immersiveengineering:stone_decoration_slab:5>,
], <forge:bucketfilled>.withTag({FluidName: "concrete", Amount: 1000}));
scripts.jei.crafting_hints.addInsOutsCatl([], [
  <immersiveengineering:stone_device:5>,
  <immersiveengineering:stone_decoration:5>,
], <forge:bucketfilled>.withTag({FluidName: "concrete", Amount: 1000}));

// Concrete cutting in half
scripts.process.saw(<immersiveengineering:stone_decoration:5>, <immersiveengineering:stone_decoration_slab:5> * 2, 'only: BlockCutter', null, 0, { hardness: 9 });
scripts.process.saw(<immersiveengineering:stone_decoration_slab:5>, <immersiveengineering:stone_device:4> * 2, 'only: BlockCutter', null, 0, { hardness: 9 });
scripts.process.saw(<immersiveengineering:stone_device:4>, <immersiveengineering:stone_device:3> * 2, 'only: BlockCutter', null, 0, { hardness: 9 });
scripts.process.saw(<immersiveengineering:stone_device:5>, <immersiveengineering:stone_device:4> * 3, 'only: BlockCutter', null, 0, { hardness: 9 });

// Concrete cutting in sheets
for input in [
  <immersiveengineering:stone_decoration:5> * 8,
  <immersiveengineering:stone_device:5> * 6,
  <immersiveengineering:stone_decoration_slab:5> * 4,
  <immersiveengineering:stone_device:4> * 2,
] as IItemStack[] {
  val o = input.anyAmount();
  scripts.process.saw(o, <immersiveengineering:stone_device:3> * input.amount, 'only: AdvRockCutter');
  mods.bloodmagic.AlchemyTable.addRecipe(<immersiveengineering:stone_device:3> * (5 * input.amount), [
    <bloodmagic:cutting_fluid>,
    o, o, o, o, o,
    ], 100, 8, 1);
}

// Coke Dust Compatibility
mods.actuallyadditions.Crusher.addRecipe(<immersiveengineering:material:17>, <thermalfoundation:material:802>);
mods.actuallyadditions.Crusher.addRecipe(<immersiveengineering:material:17>, <immersiveengineering:material:6>);
mods.extrautils2.Crusher.add(<immersiveengineering:material:17>, <thermalfoundation:material:802>);
mods.extrautils2.Crusher.add(<immersiveengineering:material:17>, <immersiveengineering:material:6>);
mods.mekanism.crusher.addRecipe(<thermalfoundation:material:802>, <immersiveengineering:material:17>);
mods.mekanism.crusher.addRecipe(<immersiveengineering:material:6>, <immersiveengineering:material:17>);
mods.thermalexpansion.Pulverizer.addRecipe(<immersiveengineering:material:17>, <thermalfoundation:material:802>, 4000);
mods.thermalexpansion.Pulverizer.addRecipe(<immersiveengineering:material:17>, <immersiveengineering:material:6>, 4000);

// [LV Capacitor] from [Lead Item Casing][+4]
craft.remake(<immersiveengineering:metal_device0>, ['pretty',
  '⌂ □ ⌂',
  '⌂ L ⌂',
  '# ♥ #'], {
  '⌂': <ic2:casing:1>,         // Copper Item Casing
  '□': <ore:plateIron>,        // Iron Plate
  'L': <ic2:casing:4>,         // Lead Item Casing
  '#': <ore:stickTreatedWood>, // Treated Stick
  '♥': <ore:dustRedstone>,     // Redstone
});

// [MV Capacitor] from [LV Capacitor][+4]
craft.remake(<immersiveengineering:metal_device0:1>, ['pretty',
  '⌂ □ ⌂',
  '⌂ L ⌂',
  '# ♥ #'], {
  '⌂': <ic2:casing:3>,                       // Iron Item Casing
  '□': <ore:plateElectrum>,                  // Electrum Plate
  'L': <immersiveengineering:metal_device0>, // LV Capacitor
  '#': <ore:stickTreatedWood>,               // Treated Stick
  '♥': <ore:blockRedstone>,                  // Block of Redstone
});

// [HV Capacitor] from [MV Capacitor][+4]
craft.remake(<immersiveengineering:metal_device0:2>, ['pretty',
  '⌂ □ ⌂',
  '⌂ M ⌂',
  '# ♥ #'], {
  '⌂': <ic2:casing:5>,                         // Steel Item Casing
  '□': <ore:plateDenseLead>,                   // Dense Lead Plate
  'M': <immersiveengineering:metal_device0:1>, // MV Capacitor
  '#': <ore:stickTreatedWood>,                 // Treated Stick
  '♥': <ore:blockRedstone>,                    // Block of Redstone
});

// LV - MV Connectors/Relays
recipes.addShapeless('LV - MV Connector', <immersiveengineering:connector:2>, [<immersiveengineering:connector>, <ore:ingotFakeIron>]);
recipes.addShapeless('LV - MV Relay', <immersiveengineering:connector:3>, [<immersiveengineering:connector:1>, <ore:ingotFakeIron>]);

// MV - HV Connectors/Relays
recipes.addShapeless('MV - HV Connector', <immersiveengineering:connector:4>, [<immersiveengineering:connector:2>, <ore:ingotAluminium>]);
recipes.addShapeless('MV - HV Relay', <immersiveengineering:connector:5>, [<immersiveengineering:connector:3>, <ore:ingotAluminium>]);

// Cheaper decorative blocks for building
recipes.removeByRecipeName("immersiveengineering:stone_decoration/hempcrete");
craft.make(<immersiveengineering:stone_decoration:4> * 32, ['pretty',
  'H H H',
  'H D H',
  'H H H'], {
  'H': <ore:fiberHemp>,
  'D': <tconstruct:materials:2>,
});

// [Coke Brick]*3 from [Sandstone][+2]
craft.remake(<immersiveengineering:stone_decoration> * 3, ['pretty',
  'P ▬ P',
  '▬ s ▬',
  'P ▬ P'], {
  'P': <ore:clayPorcelain>, // Porcelain Clay
  '▬': <ore:ingotBrick>,    // Brick
  's': <ore:sandstone>,     // Sandstone
});

// [Coke Brick]*3 from [Sandstone][+2]
craft.remake(<immersiveengineering:stone_decoration> * 3, ['pretty',
  '■ ▬ ■',
  '▬ s ▬',
  '■ ▬ ■'], {
  '■': <ore:blockClay>,  // Clay
  '▬': <ore:ingotBrick>, // Brick
  's': <ore:sandstone>,  // Sandstone
});

// Redstone Engineering Block
scripts.mods.extendedcrafting_engineering.remakeAlted(
  <immersiveengineering:metal_decoration0:3> * 2, ['pretty',
  '□ ▬ □',
  '▬ e ▬',
  '□ ▬ □'], {
  '□': <ore:plateCopper>,
  '▬': <ore:ingotConstantan>,
  'e': <ore:gemRedstone>
}, 4, {
  'e': <ore:ingotSignalum>
});

// Light Engineering Block
scripts.mods.extendedcrafting_engineering.remakeAlted(
  <immersiveengineering:metal_decoration0:4> * 4, ['pretty',
  '□ A □',
  'A l A',
  '□ A □'], {
  '□': <ore:plateBronze>,
  'A': <ore:alloyAdvanced>,
  'l': <ore:scaffoldingAluminum>,
}, 6, {
  '□': <ore:plateConstantan>,
  'A': <ore:ingotRedstoneAlloy>,
});

// Heavy Engineering Block
scripts.mods.extendedcrafting_engineering.remakeAlted(
  <immersiveengineering:metal_decoration0:5> * 4, ['pretty',
  '□ E □',
  'S t S',
  '□ E □'], {
  '□': <ore:plateUranium>,
  'E': <ore:alloyElite>,
  'S': <immersiveengineering:material:8>,
  't': <ore:scaffoldingSteel>,
}, 10, {
  '□': <ore:plateDU>,
  'S': <immersiveengineering:material:9>,
});

// Garden Cloche
recipes.remove(<immersiveengineering:metal_device1:13>);
scripts.mods.forestry.ThermionicFabricator.addCast(<immersiveengineering:metal_device1:13>,
  [[null, <extrautils2:suncrystal>, null],
    [null, <ore:plateConcrete>, null],
    [<ore:plankTreatedWood>, <immersiveengineering:metal_decoration0:5>, <ore:plankTreatedWood>]],
  <liquid:glass> * 4000);

// Crusher Recipes
mods.immersiveengineering.Crusher.addRecipe(<thermalfoundation:material:68> * 4, <ore:oreNetherAluminum>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<thermalfoundation:material:64> * 4, <ore:oreNetherCopper>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<thermalfoundation:material:67> * 4, <ore:oreNetherLead>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<thermalfoundation:material:69> * 4, <ore:oreNetherNickel>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<thermalfoundation:material:70> * 4, <ore:oreNetherPlatinum>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<thermalfoundation:material:66> * 4, <ore:oreNetherSilver>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<appliedenergistics2:material:2> * 4, <ore:oreNetherCertusQuartz>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<appliedenergistics2:material:2> * 4, <ore:oreNetherChargedCertusQuartz>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<mekanism:dust:2> * 4, <ore:oreNetherOsmium>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<immersiveengineering:metal:14> * 4, <ore:oreNetherUranium>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<libvulpes:productgem:0> * 4, <ore:oreNetherDilithium>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<minecraft:coal> * 5, <ore:oreNetherCoal>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<minecraft:diamond> * 5, <ore:oreNetherDiamond>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<minecraft:emerald> * 5, <ore:oreNetherEmerald>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<thermalfoundation:material:1> * 4, <ore:oreNetherGold>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<minecraft:dye:4> * 22, <ore:oreNetherLapis>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<minecraft:redstone> * 14, <ore:oreNetherRedstone>, 6000, <minecraft:netherrack>, 0.15);
mods.immersiveengineering.Crusher.addRecipe(<thermalfoundation:material:892> * 3, <ore:oreClathrateOilShale>, 6000, <minecraft:flint>, 0.50);
mods.immersiveengineering.Crusher.addRecipe(<thermalfoundation:material:892> * 3, <ore:oreClathrateOilSand>, 6000, <thermalfoundation:material:833>, 0.50);
mods.immersiveengineering.Crusher.addRecipe(<thermalfoundation:material:893> * 3, <ore:oreClathrateRedstone>, 6000, <thermalfoundation:material:866>, 0.50);
mods.immersiveengineering.Crusher.addRecipe(<thermalfoundation:material:894> * 3, <ore:oreClathrateGlowstone>, 6000, <thermalfoundation:material:771>, 0.30);
mods.immersiveengineering.Crusher.addRecipe(<thermalfoundation:material:895> * 3, <ore:oreClathrateEnder>, 6000);

// Compressed recipes
mods.immersiveengineering.Crusher.addRecipe(<minecraft:gravel> * 9, <ore:compressedStone1x>, 5000);
mods.immersiveengineering.Crusher.addRecipe(<minecraft:gravel> * 9, <ore:compressed1xCobblestone>, 5000);
mods.immersiveengineering.Crusher.addRecipe(<minecraft:sand> * 9, <ore:compressed1xGravel>, 5000);
mods.immersiveengineering.Crusher.addRecipe(<exnihilocreatio:block_dust> * 9, <ore:compressed1xSand>, 5000);

// Unbreakable Graphite Electrodes
val electrodeTag = { Unbreakable: 1, display: { Lore: ['Reinforced with Titanium Iridium Alloy'], Name: 'Unbreakable Graphite Electrode' } } as crafttweaker.data.IData;
val electrodeItem = <immersiveengineering:graphite_electrode>.withTag(electrodeTag);
mods.thermalexpansion.InductionSmelter.addRecipe(electrodeItem, <immersiveengineering:graphite_electrode>, <advancedrocketry:productingot:1> * 4, 25000);
mods.thermalexpansion.InductionSmelter.addRecipe(electrodeItem, <immersiveengineering:graphite_electrode>.withTag({graphDmg: 0}), <advancedrocketry:productingot:1> * 4, 25000);
mods.jei.JEI.addItem(electrodeItem);
mods.jei.JEI.addDescription(electrodeItem, 'Reinforced Graphite Eletrode. Repaired Graphite Electrodes are insufficient for this process');

// Add missed Quickdry Concrete
mods.jei.JEI.addItem(<immersiveengineering:stone_decoration:9>);

// Excavator new veins
mods.immersiveengineering.Excavator.addMineral('Osmium', 50, 0.005, ['oreTin', 'oreOsmium', 'oreSilver'], [0.01, 0.006, 0.003]);
mods.immersiveengineering.Excavator.addMineral('Nuclear Ore', 20, 0.005, ['oreBoron', 'oreThorium'], [0.01, 0.01]);
mods.immersiveengineering.Excavator.addMineral('Black Quartz', 20, 0.005, ['oreQuartzBlack', 'oreCoal'], [0.3, 0.2]);
mods.immersiveengineering.Excavator.getMineral('Coal').removeOre('oreEmerald');
mods.immersiveengineering.Excavator.getMineral('Nickel').removeOre('orePlatinum');
mods.immersiveengineering.Excavator.getMineral('Cinnabar').removeOre('oreRuby');
mods.immersiveengineering.Excavator.removeMineral('Platinum');

// Thermoelectric generator
mods.immersiveengineering.Thermoelectric.addTemperatureSource(<nuclearcraft:supercold_ice>,   50);
mods.immersiveengineering.Thermoelectric.addTemperatureSource(<ore:blockFiery>,         5000);
mods.immersiveengineering.Thermoelectric.addTemperatureSource(<ore:blockVividAlloy>,     9900);

// ----------------------------------------
// Slabs from oredicted resources
for block, slab in {
  <ore:blockCopper>    : <immersiveengineering:storage_slab>,
  <ore:blockAluminum>  : <immersiveengineering:storage_slab:1>,
  <ore:blockLead>      : <immersiveengineering:storage_slab:2>,
  <ore:blockSilver>    : <immersiveengineering:storage_slab:3>,
  <ore:blockNickel>    : <immersiveengineering:storage_slab:4>,
  <ore:blockConstantan>: <immersiveengineering:storage_slab:6>,
  <ore:blockElectrum>  : <immersiveengineering:storage_slab:7>,
  <ore:blockSteel>     : <immersiveengineering:storage_slab:8>,
} as IItemStack[IIngredient] {
  craft.remake(slab * 6, ['AAA'], { A: block });
}

// Bitumen change to oredict
craft.remake(<immersivepetroleum:stone_decoration> * 12, [
  'ABA',
  'CDC',
  'ABA'], {
  A: <ore:itemSlag>,
  B: <ore:bitumen>,
  C: <ore:gravel>,
  D: LiquidIngr('water'),
});
craft.remake(<immersivepetroleum:stone_decoration> * 8, [
  'ABA',
  'CDC',
  'ABA'], {
  A: <ore:sand>,
  B: <ore:bitumen>,
  C: <ore:gravel>,
  D: LiquidIngr('water'),
});

// Forge hammer from IC2 harder to craft, so everyone used IE hammer
// This change will force players to use Forge Hammer for making plates
// [Engineer's_Hammer] from [Iron_Hammer_Head][+1]
craft.remake(<immersiveengineering:tool>, ['pretty',
  '    I',
  '  /  ',
  '/    '], {
  '/': <ore:stickWood>, // Stick
  'I': <tconstruct:hammer_head>.withTag({ Material: 'iron' })
  | <tconstruct:hammer_head>.withTag({ Material: 'construction_alloy' }),
});

// Liquid Concrete alts
scripts.process.solution([<tconstruct:soil>], [<liquid:water> * 250], [<liquid:concrete> * 250], null, 'except: Vat Highoven Mixer');

// Cheaper recipe since Concrete is just building material
mods.immersiveengineering.Mixer.removeRecipe(<fluid:concrete>);
mods.immersiveengineering.Mixer.addRecipe(<fluid:concrete> * 1000, <fluid:water> * 1000, [<tconstruct:soil>], 1024);

recipes.removeByRecipeName('immersiveengineering:conveyors/conveyor_basic_rubber');
recipes.removeByRecipeName('immersiveengineering:conveyors/conveyor_basic');
craft.make(<immersiveengineering:conveyor>.withTag({ conveyorType: 'immersiveengineering:conveyor' }) * 32, ['pretty',
  'l l l',
  '▬ ♥ ▬'], {
  '♥': <ore:dustRedstone>, // Redstone
  'l': <ore:leather>,      // Leather
  '▬': <ore:ingotFakeIron>, // Iron Alloy Ingot
});

craft.make(<immersiveengineering:conveyor>.withTag({ conveyorType: 'immersiveengineering:conveyor' }) * 32, ['pretty',
  'R R R',
  '▬ ♥ ▬'], {
  'R': <ore:itemRubber>, // Plastic
  '♥': <ore:dustRedstone>, // Redstone
  '▬': <ore:ingotFakeIron>, // Iron Alloy Ingot
});

// ---------------------------------------------------------
// Wax cast alternative for Insulating glass

recipes.remove(<immersiveengineering:stone_decoration:8>);

// [Insulating Glass*4] from [Cactus Green][+1]
craft.make(<immersiveengineering:stone_decoration:8>, ['pretty',
  '  □  ',
  '▲ d ▲',
  '  □  '], {
  '□': <ore:blockGlass>, // Glass
  '▲': <ore:dustIron>,   // Pulverized Iron
  'd': <ore:dyeGreen>,   // Cactus Green
});

// [Insulating Glass*4] from [Cactus Green][+1]
scripts.mods.forestry.ThermionicFabricator.addCast(<immersiveengineering:stone_decoration:8> * 8, Grid([
  '▲d▲'], {
  '▲': <ore:dustIron>, // Pulverized Iron
  'd': <ore:dyeGreen>, // Cactus Green
}).shaped(), <liquid:glass> * 1000, <forestry:wax_cast:*>);
// ---------------------------------------------------------

// [Concrete Trapdoor] from [Concrete]
craft.remake(<engineersdoors:trapdoor_concrete> * 2, ['pretty',
  'c c c',
  'c c c'], {
  'c': <immersiveengineering:stone_decoration_slab:5>, // Concrete Slab
});

// Way cheaper cause cool looking and need pumping out to function
// [Fluid Pipe]*32 from [Iron Plate]
craft.remake(<immersiveengineering:metal_device1:6> * 32, ['pretty',
  '□ □ □',
  '     ',
  '□ □ □'], {
  '□': <ore:plateIron>, // Iron Plate
});

// Cheaper because it can hold only 100k RF and cant be tweaked
// [Capacitor Backpack] from [Redstone][+2]
recipes.removeShaped(<immersiveengineering:powerpack>);
craft.make(<immersiveengineering:powerpack>, ['pretty',
  '  ▬  ',
  '# ♥ #'], {
  '#': <ore:plankTreatedWood>, // Treated Wood Planks
  '♥': <ore:dustRedstone>,     // Redstone
  '▬': <ore:ingotLead>,        // Lead Ingot
});

// Add compressed variations
mods.immersiveengineering.CokeOven.addRecipe(<thermalfoundation:storage_resource>, 250 *  9, <additionalcompression:logwood_compressed>, 900 * 9);
mods.immersiveengineering.CokeOven.addRecipe(<additionalcompression:charcoal_compressed:1>, 12000, <additionalcompression:logwood_compressed:1>, 900 * 81);

// [Lantern]*3 from [Glowstone Dust][+2]
craft.remake(<immersiveengineering:metal_decoration2:4> * 3, ['pretty',
  '  □  ',
  'G ▲ G',
  '  □  '], {
  '□': <ore:plateIron>, // Iron Plate
  'G': <ore:paneGlass>, // Glass Pane
  '▲': <ore:dustGlowstone>, // Glowstone Dust
});

// [Powered Lantern]*3 from [Iron Mechanical Component][+2]
craft.remake(<immersiveengineering:metal_device1:4> * 3, ['pretty',
  '  □  ',
  'G I G',
  '  □  '], {
  '□': <ore:plateIron>, // Iron Plate
  'G': <ore:paneGlass>, // Glass Pane
  'I': <immersiveengineering:material:8>, // Iron Mechanical Component
});

// [Floodlight]*3 from [Iron Mechanical Component][+3]
craft.remake(<immersiveengineering:metal_device1:9> * 3, ['pretty',
  '  H  ',
  'G I G',
  '  L  '], {
  'H': <ore:fabricHemp>, // Tough Fabric
  'G': <ore:paneGlass>, // Glass Pane
  'I': <immersiveengineering:material:8>, // Iron Mechanical Component
  'L': <immersiveengineering:wirecoil>, // LV Wire Coil
});

// Ethanol alt
mods.immersiveengineering.Fermenter.addRecipe(null, <liquid:ethanol> * 800, <ore:itemBioFuel>, 800);

// Fix empty output recipe
mods.immersiveengineering.Squeezer.removeByInput(<immersiveengineering:material:17> * 8);
mods.immersiveengineering.Squeezer.addRecipe(<immersiveengineering:material:18>, <fluid:creosote> * 250, <ore:dustCoke> * 8, 3000);

// Oredicting cheaper recipe
// [Engineer's Workbench] from [Crafting Table][+2]
craft.remake(<immersiveengineering:wooden_device0:2>, ['pretty',
  '# # #',
  'w   ≢'], {
  '#': <ore:plankTreatedWood>, // Treated Wood Planks
  'w': <ore:workbench>, 			 // Crafting Table
  '≢': <ore:fenceTreatedWood>, // Treated Wood Fence
});

// Additional Refinery compat recipes
mods.immersiveengineering.Refinery.addRecipe(<fluid:biodiesel> * 24, <fluid:biomass> * 8, <fluid:ethanol> * 16, 400);
mods.immersiveengineering.Refinery.addRecipe(<fluid:biodiesel> * 20, <fluid:ic2biomass> * 12, <fluid:ethanol> * 8, 200);
mods.immersiveengineering.Refinery.addRecipe(<fluid:biodiesel> * 88, <fluid:biocrude> * 8, <fluid:ethanol> * 80, 1600);

// Add missed Insolator recipe
scripts.process.grow(<immersiveengineering:seed>, <immersiveengineering:material:4>, null, <immersiveengineering:seed>, 1);

// IC2 Creosote alt
// [Insulated MV Wire Coil]*4 from [ic2.creosote Bucket][+2]
craft.make(<immersiveengineering:wirecoil:7> * 4, ['pretty',
  'H M H',
  'M ~ M',
  'H M H'], {
  'H': <ore:fabricHemp>,                  // Tough Fabric
  'M': <immersiveengineering:wirecoil:1>, // MV Wire Coil
  '~': LiquidIngr("ic2creosote"), // ic2.creosote Bucket
});

// Refactored Sheetmetal Recipes
val sheetmetalRecipes = {
  Copper: <immersiveengineering:sheetmetal:0>,
  Aluminum: <immersiveengineering:sheetmetal:1>,
  Lead: <immersiveengineering:sheetmetal:2>,
  Silver: <immersiveengineering:sheetmetal:3>,
  Nickel: <immersiveengineering:sheetmetal:4>,
  Uranium: <immersiveengineering:sheetmetal:5>,
  Constantan: <immersiveengineering:sheetmetal:6>,
  Electrum: <immersiveengineering:sheetmetal:7>,
  Steel: <immersiveengineering:sheetmetal:8>,
  Iron: <immersiveengineering:sheetmetal:9>,
  Gold: <immersiveengineering:sheetmetal:10>,
} as IItemStack[string];

// Iterate and remove old recipes, then add new ones with x64 output
for typeName, output in sheetmetalRecipes {
  recipes.removeByRecipeName(`immersiveengineering:sheetmetal/${typeName.toLowerCase()}_sheetmetal`);
  val plate = oreDict[`plate${typeName}`];
  recipes.addShaped(`sheets${typeName}`, output * 32, [
    [null, plate, null],
    [plate, null, plate],
    [null, plate, null],
  ]);
}
