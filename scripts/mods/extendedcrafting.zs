#modloaded extendedcrafting
import mods.extendedcrafting.TableCrafting.addShaped;

val piston = <minecraft:piston>;
val blackIron = <ore:ingotBlackIron>;

// Black Iron
recipes.remove(blackIron);
recipes.addShapeless('Black Iron From Block',
  <extendedcrafting:material> * 9,
  [<ore:blockBlackIron>]);

recipes.addShaped('Black Iron From Nuggets',
  <extendedcrafting:material>,
  [[<ore:nuggetBlackIron>, <ore:nuggetBlackIron>, <ore:nuggetBlackIron>],
    [<ore:nuggetBlackIron>, <ore:nuggetBlackIron>, <ore:nuggetBlackIron>],
    [<ore:nuggetBlackIron>, <ore:nuggetBlackIron>, <ore:nuggetBlackIron>]]);

mods.thermalexpansion.InductionSmelter.addRecipe
(<extendedcrafting:material> * 3,
  <thermalfoundation:storage_alloy:2>, <immersiveengineering:stone_decoration:3>, 50000);

mods.thermalexpansion.InductionSmelter.addRecipe
(<extendedcrafting:material> * 2,
  <thermalfoundation:storage_alloy:2>, <actuallyadditions:block_misc:2>, 20000);

mods.thermalexpansion.InductionSmelter.addRecipe
(<extendedcrafting:material> * 3,
  <thermalfoundation:storage_alloy:2>, <immersiveengineering:material:19>, 15000);

mods.thermalexpansion.InductionSmelter.addRecipe
(<extendedcrafting:material> * 4,
  <thermalfoundation:storage_alloy:2>, <nuclearcraft:alloy:1>, 20000);

mods.thermalexpansion.InductionSmelter.addRecipe
(<extendedcrafting:material> * 3,
  <thermalfoundation:storage_alloy:2>, <nuclearcraft:alloy:3>, 15000);

mods.thermalexpansion.InductionSmelter.addRecipe
(<extendedcrafting:material> * 3,
  <thermalfoundation:storage_alloy:2>, <nuclearcraft:ingot_block:8>, 15000);

// Crafting Core
recipes.remove(<extendedcrafting:crafting_core>);
scripts.mods.forestry.Carpenter.addRecipe(<extendedcrafting:crafting_core>,
  [[<extendedcrafting:material:18>, <extendedcrafting:material:18>, <extendedcrafting:material:18>],
    [<plustic:osmiridiumingot>, <extendedcrafting:pedestal>, <plustic:osmiridiumingot>],
    [<extendedcrafting:pedestal>, <extendedcrafting:pedestal>, <extendedcrafting:pedestal>]],
  40, <liquid:coal> * 5000, null, 1);

// [Quantum Compressor] from [Elite Compressing Factory][+4]
craft.remake(<extendedcrafting:compressor>, ['pretty',
  'P P P P P',
  'P C A C P',
  'P ■ E ■ P',
  'P C A C P',
  'P P P P P'], {
  'P': <ore:craftingPiston>,           // Piston
  'C': <ic2:te:43>,                    // Compressor
  'A': <excompressum:auto_compressor>, // Auto Compressor
  '■': <ore:blockBlackIron>,           // Block of Black Iron
  'E': <mekanism:tierinstaller:2>,
});

// [Basic Crafting Table] from [End Steel Block][+4]
craft.remake(<extendedcrafting:table_basic>, ['pretty',
  'B a B',
  'w ■ w',
  'B l B'], {
  'B': <extendedcrafting:material:14>, // Basic Component
  'a': <extendedcrafting:material:8>,  // Basic Catalyst
  'w': <ore:workbench>,                // Crafting Station
  '■': <ore:blockEndSteel>,            // End Steel Block
  'l': <extendedcrafting:material:2>,  // Black Iron Slate
});

// [Advanced Crafting Table] from [Block of Luminessence][+4]
recipes.remove(<extendedcrafting:table_advanced>);
mods.extendedcrafting.TableCrafting.addShaped(0, <extendedcrafting:table_advanced>, Grid(['pretty',
  'A d A',
  'B ■ B',
  'A l A'], {
  'A': <extendedcrafting:material:15>, // Advanced Component
  'd': <extendedcrafting:material:9>,  // Advanced Catalyst
  'B': <extendedcrafting:table_basic>, // Basic Crafting Table
  '■': <ore:blockLuminessence>,        // Block of Luminessence
  'l': <extendedcrafting:material:2>,  // Black Iron Slate
}).shaped());

// [Elite Crafting Table] from [Basic Crafting Table][+7]
craft.remake(<extendedcrafting:table_elite>, ['pretty',
  '◘ E ◙ E ◘',
  'E ▲ ■ ▲ E',
  'f A B A f',
  'E ▲ ■ ▲ E',
  '◘ E ◙ E ◘'], {
  '◘': <thermalexpansion:frame:129>,      // Hardened Cell Frame
  'E': <extendedcrafting:material:10>,    // Elite Catalyst
  '◙': <thermalexpansion:frame:147>,      // Signalum Cell Frame (Full)
  '▲': <ore:dustMana>,                    // Mana Dust
  '■': <ore:blockOsgloglas>,              // Osgloglas Block
  'f': <thermalfoundation:fertilizer:2>,  // Fluxed Phyto-Gro
  'A': <extendedcrafting:table_advanced>, // Advanced Crafting Table
  'B': <extendedcrafting:table_basic>,    // Basic Crafting Table
});

// [Ultimate Crafting Table] from [Extreme Crafting Table][+14]
craft.remake(<extendedcrafting:table_ultimate>, ['pretty',
  '◘ ■ * d * ■ ◘',
  '■ ▀ U ◙ U n ■',
  '* U A E A U *',
  'd Ϟ I x I Ϟ d',
  '* U A E A U *',
  '■ V U ◙ U ▄ ■',
  '◘ ■ * d * ■ ◘'], {
  '◘': <thermalexpansion:frame:147>,           // Signalum Cell Frame (Full)
  '■': <extendedcrafting:trimmed:4>,           // Block of Black Iron
  '*': <ore:crystalDraconium>,                 // Draconium Crystal
  'd': <advancedrocketry:ic:2>,                // Advanced Circuit
  '▀': <ore:blockAethium>,                     // Aethium
  'U': <extendedcrafting:material:11>,         // Ultimate Catalyst
  '◙': <thermalexpansion:frame:148>,           // Resonant Cell Frame (Full)
  'n': <ore:blockEnderium>,                    // Block of Enderium
  'A': <extendedcrafting:table_advanced>,      // Advanced Crafting Table
  'E': <extendedcrafting:table_elite>,         // Elite Crafting Table
  'Ϟ': <draconicevolution:wyvern_energy_core>, // Wyvern Energy Core
  'I': <ic2:iridium_reflector>,                // Iridium Neutron Reflector
  'x': <avaritia:extreme_crafting_table>,      // Extreme Crafting Table
  'V': <ore:blockVividAlloy>,                  // Vivid Alloy Block
  '▄': <ore:blockMirion>,                      // Mirion Block
});

// Pedestal
recipes.remove(<extendedcrafting:pedestal>);
scripts.mods.forestry.Carpenter.addRecipe(<extendedcrafting:pedestal>,
  [[null, <extendedcrafting:material:2>, null],
    [null, blackIron, null],
    [blackIron, <extendedcrafting:storage>, blackIron]],
  40, <liquid:coal> * 1000);

// Luminiscence made in chemical reactor and drying basin
recipes.removeByRecipeName('extendedcrafting:luminessence');
scripts.process.evaporate(<fluid:liquid_sunshine> * 1000, <extendedcrafting:material:7> * 2, null);

// Insanium from inferium
mods.extendedcrafting.CompressionCrafting.addRecipe(<mysticalagradditions:insanium> * 10,
  <mysticalagriculture:crafting>, 10240, <mysticalagriculture:master_infusion_crystal>, 2000000, 100000);

// Simplify Automating table
recipes.remove(<extendedcrafting:interface>);
recipes.addShaped(<extendedcrafting:interface>, [
  [<ore:ingotBlackIron>, <extendedcrafting:material:10>, <ore:ingotBlackIron>],
  [<extendedcrafting:material:17>, <extendedcrafting:frame>, <extendedcrafting:material:17>],
  [<ore:ingotBlackIron>, <extendedcrafting:material:2>, <ore:ingotBlackIron>]]);

// Remake ender ingot recipe
recipes.removeByRecipeName('extendedcrafting:ender_ingot');
scripts.process.alloy([<ore:ingotPlatinum>, <ore:dustEnder> * 2], <extendedcrafting:material:36>, "only: kiln ArcFurnace");
scripts.process.alloy([<ore:blockPlatinum>, <ore:dustEnder> * 9], <extendedcrafting:storage:5>, "only: AdvRockArc");
mods.mekanism.infuser.addRecipe('ENDER', 20, <ore:ingotPlatinum>, <extendedcrafting:material:36> * 2);

// See the Draconic Evolution configs for DE compat
// *======= Empowerer Extended Crafting Combination recipes =======*
mods.extendedcrafting.CombinationCrafting.addRecipe(<mekanism:controlcircuit:3>, 2000000, 1000000, <mekanism:controlcircuit:2>, [<mekanism:atomicalloy>, <mekanism:atomicalloy>, <mekanism:atomicalloy>, <mekanism:atomicalloy>]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<thermalexpansion:frame:129>, 10000000, 1000000, <thermalexpansion:frame:128>, [<immersiveengineering:material:2>, <thermalfoundation:material:354>, <thermalfoundation:material:290>, <mekanism:basicblock:8>]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<actuallyadditions:block_crystal_empowered>, 1000000, 1000000, <actuallyadditions:block_crystal>, [<nuclearcraft:gem>, <thermalfoundation:material:513>, <tconstruct:ingots:1>, <quark:biome_cobblestone>]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<actuallyadditions:block_crystal_empowered:1>, 1000000, 1000000, <actuallyadditions:block_crystal:1>, [<tconstruct:ingots>, <ic2:plate:13>, <biomesoplenty:gem:6>, <tconstruct:slime_congealed:1>]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<actuallyadditions:block_crystal_empowered:2>, 2000000, 1000000, <actuallyadditions:block_crystal:2>, [<nuclearcraft:dust:10>, <botania:manaresource:2>, <tconstruct:ingots:2>, <biomesoplenty:gem:5>]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<actuallyadditions:block_crystal_empowered:3>, 10000000, 1000000,  <actuallyadditions:block_crystal:3>, [<randomthings:ingredient:13>, <extendedcrafting:storage>, <contenttweaker:compressed_basalt>, <appliedenergistics2:sky_stone_block>]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<actuallyadditions:block_crystal_empowered:4>, 2000000, 1000000, <actuallyadditions:block_crystal:4>, [<minecraft:experience_bottle>, <actuallyadditions:item_dust:3>, <nuclearcraft:dust:9>, <immersiveengineering:stone_decoration:8>]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<actuallyadditions:block_crystal_empowered:5>, 1000000, 1000000, <actuallyadditions:block_crystal:5>, [<minecraft:quartz_block>, <minecraft:bone_block>, <mekanism:ingot:1>, <nuclearcraft:gem:2>]);
mods.extendedcrafting.CombinationCrafting.addRecipe(<actuallyadditions:item_misc:24>, 100000, 1000000, <actuallyadditions:item_misc:23>, [<actuallyadditions:item_canola_seed>, <actuallyadditions:item_canola_seed>, <actuallyadditions:item_canola_seed>, <actuallyadditions:item_canola_seed>]);

// [Block of Crystaltine] from [Glitch Infused Ingot][+4]
mods.extendedcrafting.TableCrafting.remove(<extendedcrafting:material:24>);
craft.make(<extendedcrafting:storage:3>, ['pretty',
  '             ',
  '■ ▬ ▬ ▬ ▬ ▬ ■',
  '■ - ▄ ▄ ▄ - ■',
  '■ - ▄ § ▄ - ■',
  '■ - ▄ ▄ ▄ - ■',
  '■ ▬ ▬ ▬ ▬ ▬ ■'], {
  '■': <ore:blockDiamond>,                     // Block of Diamond
  '▄': <ore:blockSilver>,                      // Block of Silver
  '§': <deepmoblearning:glitch_infused_ingot>, // Glitch Infused Ingot
  '▬': <ore:ingotMithril>,                     // Mana Infused Ingot
  '-': <ore:ingotEvilMetal>,                   // Evil Infused Iron Ingot
});

// [Basic Component] from [Infinity Bimetal Gear][+3]
craft.remake(<extendedcrafting:material:14>, ['pretty',
  'F ╱ F',
  '# ¤ #',
  'F ╱ F'], {
  'F': <fluxnetworks:flux>,    // Flux
  '╱': <forestry:oak_stick>,   // Impregnated Stick
  '#': <ore:plankTreatedWood>, // Treated Wood Planks
  '¤': <enderio:item_material:20>,
});

// [Basic Catalyst] from [Advanced Alloy][+1]
craft.remake(<extendedcrafting:material:8>, ['pretty',
  '  B  ',
  'B □ B',
  '  B  '], {
  'B': <extendedcrafting:material:14>, // Basic Component
  '□': <ore:plateAdvancedAlloy>, // Advanced Alloy
});

// [Advanced Component] from [Plastic][+4]
craft.remake(<extendedcrafting:material:15>, ['pretty',
  '# A #',
  'M R M',
  '# G #'], {
  '#': <astralsorcery:blockinfusedwood:1>, // Infused Wood Planks
  'A': <ore:alloyAdvanced>, // Enriched Alloy
  'M': <extrautils2:decorativesolidwood>,  // Magical Planks
  'R': <industrialforegoing:plastic>,      // Plastic
  'G': <integrateddynamics:crystalized_menril_chunk>,
});

// [Advanced Catalyst] from [Void Crystal][+2]
craft.remake(<extendedcrafting:material:9>, ['pretty',
  '∩ A ∩',
  'A * A',
  '∩ A ∩'], {
  '∩': <actuallyadditions:item_crystal:3>,
  'A': <extendedcrafting:material:15>, // Advanced Component
  '*': <randomthings:ingredient:5>,
});

// [Elite Component] from [Plutonium-242][+3]
craft.remake(<extendedcrafting:material:16>, ['pretty',
  'L ▲ L',
  '  ▬  ',
  'L P L'], {
  'L': <botania:livingwood:1>,            // Livingwood Planks
  '▲': <ore:dustPsi>,                     // Psidust
  '▬': <ore:ingotPlutonium242All>, // Plutonium-242
  'P': <appliedenergistics2:material:20>, // Printed Silicon
});

// [Elite Catalyst] from [Emerald Gear][+3]
craft.remake(<extendedcrafting:material:10>, ['pretty',
  'E ◘ E',
  '  ¤  ',
  'E l E'], {
  'E': <extendedcrafting:material:16>, // Elite Component
  '◘': <ic2:fluid_cell>.withTag({Fluid: {FluidName: "syngas", Amount: 1000}}), // Universal Fluid Cell
  '¤': <ore:gearEmerald>,              // Emerald Gear
  'l': <rftoolsdim:fake_gravel>,       // levarG
});

# [Ultimate Component] from [Titanium Iridium Alloy Sheet][+5]
craft.remake(<extendedcrafting:material:17>, ["pretty",
  "O L O",
  "B T B",
  "§ m §"], {
  "O": <enderio:item_material:48>,               # Organic Green Dye
  "L": <extendedcrafting:material:7>,            # Luminessence
  "B": <bloodmagic:slate>,                       # Blank Slate
  "T": <ore:sheetTitaniumIridium>,               # Titanium Iridium Alloy Sheet
  "§": <mysticalagriculture:fertilized_essence>, # Fertilized Essence
  "m": <ore:mica>,                               # Mica
});

# [Ultimate Catalyst] from [Draconium Infused Obsidian][+3]
craft.remake(<extendedcrafting:material:11>, ["pretty",
  "U ◊ U",
  "◊ D ◊",
  "U § U"], {
  "U": <extendedcrafting:material:17>,         # Ultimate Component
  "◊": <ore:gemDimensionalShard>,              # Dimensional Shard
  "D": <draconicevolution:infused_obsidian>,   # Draconium Infused Obsidian
  "§": <deepmoblearning:glitch_infused_ingot>, # Glitch Infused Ingot
});

// [Black Iron Frame]*8 from [Quartz Glass][+1]
craft.remake(<extendedcrafting:frame> * 8, ['pretty',
  '‚ ⌃ ‚',
  '⌃   ⌃',
  '‚ ⌃ ‚'], {
  '‚': <ore:nuggetBlackIron>,              // Black Iron Nugget
  '⌃': <appliedenergistics2:quartz_glass>, // Quartz Glass
});

// [Engineering Package Crafter] from [Engineering Table][+4]
recipes.removeByRecipeName("packagedexcrafting:basic_crafter");
craft.make(<packagedexcrafting:basic_crafter>, ['pretty',
  'A M A',
  'B n B',
  'A E A'], {
  'A': <extendedcrafting:material:15>,             // Advanced Component
  'M': <appliedenergistics2:molecular_assembler>,  // Molecular Assembler
  'B': <extendedcrafting:material:2>,              // Black Iron Slate
  'n': <extendedcrafting:table_basic>            , // Engineering Table
  'E': <packagedauto:me_package_component>,        // ME Packaging Component
});

// [ENGINEERING TABLE RECIPES]

// [Redstone Engineering Block] from [Eye of Redstone][+2]
addShaped(0, <immersiveengineering:metal_decoration0:3> * 4, Grid(['pretty',
  '□ ▬ □',
  '▬ e ▬',
  '□ ▬ □'], {
  '□': <ore:plateCopper>,     // Copper Plate
  '▬': <ore:ingotConstantan>, // Constantan Ingot
  'e': <ore:eyeofredstone>,   // Eye of Redstone
}).shaped());

// [Light Engineering Block]*6 from [Aluminium Scaffolding][+2]
addShaped(0, <immersiveengineering:metal_decoration0:4> * 6, Grid(['pretty',
  '□ A □',
  'A l A',
  '□ A □'], {
  '□': <ore:plateConstantan>,     // Constantan Plate
  'A': <ore:alloyAdvanced>,       // Enriched Alloy
  'l': <ore:scaffoldingAluminum>, // Aluminium Scaffolding
}).shaped());

// [Heavy Engineering Block]*8 from [Steel Scaffolding][+3]
addShaped(0, <immersiveengineering:metal_decoration0:5> * 8, Grid(['pretty',
  '□ E □',
  'S t S',
  '□ E □'], {
  '□': <ore:plateUranium>,                // Uranium Plate
  'E': <ore:alloyElite>,                  // Reinforced Alloy
  'S': <immersiveengineering:material:9>, // Steel Mechanical Component
  't': <ore:scaffoldingSteel>,            // Steel Scaffolding
}).shaped());

// [Machine Block]*5 from [Basic Catalyst][+3]
addShaped(0, <extrautils2:machine> * 5, Grid(['pretty',
  'P I P',
  'T B T',
  'P I P'], {
  'P': <extrautils2:decorativesolid:2>,    // Polished Stone
  'I': <forestry:thermionic_tubes:3>,      // Iron Electron Tube
  'T': <immersiveengineering:material:26>, // Vacuum Tube
  'B': <extendedcrafting:material:8>,      // Basic Catalyst
}).shaped());

// [Steel Casing]*3 from [Blast Brick][+3]
addShaped(0, <mekanism:basicblock:8> * 3, Grid(['pretty',
  '▬ B ▬',
  'S l S',
  '▬ B ▬'], {
  '▬': <ore:ingotOsmium>,                         // Osmium Ingot
  'B': <extendedcrafting:material:14>,            // Basic Component
  'S': <immersiveengineering:material:9>,         // Steel Mechanical Component
  'l': <immersiveengineering:stone_decoration:1>, // Blast Brick
}).shaped());

// [Iron Casing]*4 from [Hardened Casing][+2]
addShaped(0, <actuallyadditions:block_misc:9> * 4, Grid(['pretty',
  '□ G □',
  'G ⌂ G',
  '□ G □'], {
  '□': <ore:plateInvar>,              // Invar Plate
  'G': <forestry:thermionic_tubes:4>, // Golden Electron Tube
  '⌂': <forestry:hardened_machine>,   // Hardened Casing
}).shaped());

// [Basic Plating]*6 from [Graphite Block][+2]
addShaped(0, <nuclearcraft:part> * 6, Grid(['pretty',
  '□ ⌂ □',
  '⌂ ■ ⌂',
  '□ ⌂ □'], {
  '□': <ore:plateLead>,     // Lead Plate
  '⌂': <ic2:casing:5>,      // Steel Item Casing
  '■': <ore:blockGraphite>, // Graphite Block
}).shaped());

// [Advanced Plating]*2 from [Basic Plating][+2]
addShaped(0, <nuclearcraft:part:1> * 2, Grid(['pretty',
  '  ▲  ',
  '▬ □ ▬',
  '  ▲  '], {
  '▲': <ore:dustEnergetic>, // Energetic Blend
  '▬': <ore:ingotTough>,    // Tough Alloy Ingot
  '□': <ore:plateBasic>,    // Basic Plating
}).shaped());

// [DU Plating]*4 from [Advanced Plating][+2]
addShaped(0, <nuclearcraft:part:2> * 4, Grid(['pretty',
  '▲ ▬ ▲',
  '▬ □ ▬',
  '▲ ▬ ▲'], {
  '▲': <ore:dustSulfur>,           // Sulfur
  '▬': <ore:ingotPlutonium242All>, // Plutonium-242
  '□': <ore:plateAdvanced>,        // Advanced Plating
}).shaped());

// [Elite Plating]*2 from [DU Plating][+2]
addShaped(0, <nuclearcraft:part:3> * 2, Grid(['pretty',
  '* ▬ *',
  '▬ □ ▬',
  '* ▬ *'], {
  '*': <ore:dustCrystalBinder>, // Crystal Binder
  '▬': <ore:ingotBoron10>,      // Boron-10
  '□': <ore:plateDU>,           // DU Plating
}).shaped());

// [Electronic Circuit]*2 from [Printed Circuit Board (PCB)][+2]
addShaped(0, <ic2:crafting:1> * 2, Grid(['pretty',
  'C C C',
  '♥ : ♥',
  'C C C'], {
  'C': <ore:itemInsulatedCopperCable>,       // Insulated Copper Cable
  '♥': <ore:dustRedstone>,                   // Redstone
  ':': <ore:oc:materialCircuitBoardPrinted>, // Printed Circuit Board (PCB)
}).shaped());

// [Advanced Circuit]*2 from [Electronic Circuit][+3]
addShaped(0, <ic2:crafting:2> * 2, Grid(['pretty',
  '♥ G ♥',
  '◊ B ◊',
  '♥ G ♥'], {
  '♥': <ore:dustRedstone>,                         // Redstone
  'G': <enderio:block_holier_fog>,                 // Glowstone Nano-Particles
  '◊': <ore:gemLapis>,                             // Lapis Lazuli
  'B': <ore:circuitBasic>,                         // Electronic Circuit
}).shaped());

// [Mixed Metal Ingot]*3 from [Constantan Plate][+2]
addShaped(0, <ic2:ingot> * 3, Grid(['pretty',
  '□ □ □',
  'п п п',
  'A A A'], {
  '□': <ore:plateSteel>,      // Steel Plate
  'п': <ore:plateConstantan>, // Constantan Plate
  'A': <ore:plateAluminum>,   // Aluminum Plate
}).shaped());

// [Energy Laser Relay]*10 from [Advanced Coil][+3]
addShaped(0, <actuallyadditions:block_laser_relay> * 10, Grid(['pretty',
  '▬ * ▬',
  '╳ A ╳',
  '▬ * ▬'], {
  '▬': <ore:ingotRefinedObsidian>,        // Refined Obsidian Ingot
  '*': <actuallyadditions:block_crystal>, // Restonia Crystal Block
  '╳': <ore:crystalRestonia>,             // Restonia Crystal
  'A': <actuallyadditions:item_misc:8>,   // Advanced Coil
}).shaped());

// [Wood Casing]*4 from [Wood Pile][+2]
addShaped(0, <actuallyadditions:block_misc:4> * 4, Grid(['pretty',
  '# ╱ #',
  '╱ ≢ ╱',
  '# ╱ #'], {
  '#': <ore:plankTreatedWood>, // Treated Wood Planks
  '╱': <forestry:oak_stick>,   // Impregnated Stick
  '≢': <forestry:wood_pile>,   // Wood Pile
}).shaped());

// [Machine Frame]*4 from [Machine Case][+5]
addShaped(0, <rftools:machine_frame> * 4, Grid(['pretty',
  'H ¤ H',
  'D M D',
  '▬ A ▬'], {
  'H': <ic2:heat_vent>.anyDamage(),               // Heat Vent
  '¤': <ore:gearLumium>,                          // Lumium Gear
  'D': <industrialforegoing:dryrubber>,           // Dry Rubber
  'M': <teslacorelib:machine_case>,               // Machine Case
  '▬': <ore:ingotPinkMetal>,                      // Pink Slime Ingot
  'A': <ore:ingotMeat>,                           // Cooked Meat Ingot
}).shaped());

// [Advanced Control Circuit]*4 from [Electronic Circuit][+2]
addShaped(0, <mekanism:controlcircuit:1> * 4, Grid(['pretty',
  '* A *',
  'A B A',
  '* A *'], {
  '*': <actuallyadditions:item_crystal_empowered>, // Empowered Restonia Crystal
  'A': <ore:alloyAdvanced> | <ore:itemEnrichedAlloy>, // Enriched Alloy
  'B': <ore:circuitBasic>,                         // Electronic Circuit
}).shaped());

// [Elite Control Circuit]*4 from [Advanced Control Circuit][+2]
addShaped(0, <mekanism:controlcircuit:2> * 4, Grid(['pretty',
  '* E *',
  'E A E',
  '* E *'], {
  '*': <actuallyadditions:item_crystal_empowered:1>, // Empowered Palis Crystal
  'E': <ore:alloyElite>,      // Reinforced Alloy
  'A': <ore:circuitAdvanced>, // Advanced Control Circuit
}).shaped());

// [Sturdy Casing]*4 from [Constantan Gear][+2]
addShaped(0, <forestry:sturdy_machine> * 4, Grid(['pretty',
  '☼ ▬ ☼',
  '▬   ▬',
  '¤ ▬ ¤'], {
  '☼': <ore:gearConstantan>, // Constantan Gear
  '▬': <ore:ingotBrass>,     // Alchemical Brass Ingot
  '¤': <ore:gearBronze>,     // Bronze Gear
}).shaped());

// [Advanced Machine Casing]*2 from [Basic Machine Casing][+3]
addShaped(0, <ic2:resource:13> * 2, Grid(['pretty',
  '▬ - ▬',
  '□ ■ □',
  '▬ - ▬'], {
  '▬': <ore:ingotTough>,         // Tough Alloy Ingot
  '-': <ore:ingotHardCarbon>,    // Hard Carbon Alloy Ingot
  '□': <ore:plateAdvancedAlloy>, // Advanced Alloy
  '■': <ore:machineBlock> | <ore:machineBlockCasing>, // Basic Machine Casing
}).shaped());

// [Machine Chassis]*2 from [Black Iron Ingot][+2]
addShaped(0, <nuclearcraft:part:10> * 2, Grid(['pretty',
  '▬ - ▬',
  '- _ -',
  '▬ - ▬'], {
  '▬': <ore:ingotSteel>,     // Steel Ingot
  '-': <ore:ingotLead>,      // Lead Ingot
  '_': <ore:ingotBlackIron>, // Black Iron Ingot
}).shaped());

// [Servomechanism]*2 from [Copper Ingot][+3]
addShaped(0, <nuclearcraft:part:7> * 2, Grid(['pretty',
  '-   -',
  '* ▬ *',
  '▬ _ ▬'], {
  '-': <ore:ingotFerroboron>, // Ferroboron Alloy Ingot
  '*': <ore:crystalRestonia>, // Restonia Crystal
  '▬': <ore:ingotDarkSteel>,  // Dark Steel Ingot
  '_': <ore:ingotCopper>,     // Copper Ingot
}).shaped());

// [Electric Motor]*2 from [Electrum Nugget][+2]
addShaped(0, <nuclearcraft:part:8> * 2, Grid(['pretty',
  '▬ ▬  ',
  'C C ‚',
  '▬ ▬  '], {
  '▬': <ore:ingotElectricalSteel>, // Electrical Steel Ingot
  'C': <ore:solenoidCopper>,       // Copper Solenoid
  '‚': <ore:nuggetElectrum>,       // Electrum Nugget
}).shaped());
