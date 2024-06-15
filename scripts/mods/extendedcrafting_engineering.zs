#modloaded extendedcrafting
import mods.extendedcrafting.TableCrafting.addShaped;

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
  '□': <ore:plateConstantan>, // Constantan Plate
  'A': <ore:alloyAdvanced>, // Enriched Alloy
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
  'P': <extrautils2:decorativesolid:2>, // Polished Stone
  'I': <forestry:thermionic_tubes:3>,   // Iron Electron Tube
  'T': <ore:electronTube>,              // Vacuum Tube
  'B': <extendedcrafting:material:8>,   // Basic Catalyst
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

// [Basic Plating]*4 from [HOP Graphite Ingot][+2]
addShaped(0, <nuclearcraft:part> * 4, Grid(['pretty',
  '⌂ ⌂ ⌂',
  '□ ▬ □',
  '⌂ ⌂ ⌂'], {
  '⌂': <ic2:casing:4>,         // Lead Item Casing
  '□': <ore:plateLead>,        // Lead Plate
  '▬': <ore:ingotHOPGraphite>, // HOP Graphite Ingot
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

// [DU Plating]*2 from [Advanced Plating][+2]
addShaped(0, <nuclearcraft:part:2> * 2, Grid(['pretty',
  '▲ ▬ ▲',
  '▬ □ ▬',
  '▲ ▬ ▲'], {
  '▲': <ore:dustSulfur>, // Sulfur
  '▬': <ore:ingotDepletedLEU235ZA> | <ore:ingotDepletedLEU235Oxide> | <ore:ingotDepletedLEU235Nitride>, // Depleted LEU-235 Fuel Pellet
  '□': <ore:plateAdvanced>,                  // Advanced Plating
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