#modloaded extendedcrafting

// [Redstone Engineering Block] from [Eye of Redstone][+2]
mods.extendedcrafting.TableCrafting.addShaped(0, <immersiveengineering:metal_decoration0:3> * 4, Grid(['pretty',
  '□ ▬ □',
  '▬ e ▬',
  '□ ▬ □'], {
  '□': <ore:plateCopper>,     // Copper Plate
  '▬': <ore:ingotConstantan>, // Constantan Ingot
  'e': <ore:eyeofredstone>,   // Eye of Redstone
}).shaped());

// [Light Engineering Block]*6 from [Aluminium Scaffolding][+2]
mods.extendedcrafting.TableCrafting.addShaped(0, <immersiveengineering:metal_decoration0:4> * 6, Grid(['pretty',
  '□ A □',
  'A l A',
  '□ A □'], {
  '□': <ore:plateConstantan>, // Constantan Plate
  'A': <ore:alloyAdvanced> | <ore:itemEnrichedAlloy>, // Enriched Alloy
  'l': <ore:scaffoldingAluminum> | <ore:scaffoldingAluminium>, // Aluminium Scaffolding
}).shaped());

// [Heavy Engineering Block]*8 from [Steel Scaffolding][+3]
mods.extendedcrafting.TableCrafting.addShaped(0, <immersiveengineering:metal_decoration0:5> * 8, Grid(['pretty',
  '□ E □',
  'S t S',
  '□ E □'], {
  '□': <ore:plateUranium>,                // Uranium Plate
  'E': <ore:alloyElite>,                  // Reinforced Alloy
  'S': <immersiveengineering:material:9>, // Steel Mechanical Component
  't': <ore:scaffoldingSteel>,            // Steel Scaffolding
}).shaped());

// [Machine Block]*5 from [Basic Catalyst][+3]
mods.extendedcrafting.TableCrafting.addShaped(0, <extrautils2:machine> * 5, Grid(['pretty',
  'P I P',
  'T B T',
  'P I P'], {
  'P': <extrautils2:decorativesolid:2>, // Polished Stone
  'I': <forestry:thermionic_tubes:3>,   // Iron Electron Tube
  'T': <ore:electronTube>,              // Vacuum Tube
  'B': <extendedcrafting:material:8>,   // Basic Catalyst
}).shaped());

// [Steel Casing]*3 from [Blast Brick][+3]
mods.extendedcrafting.TableCrafting.addShaped(0, <mekanism:basicblock:8> * 3, Grid(['pretty',
  '▬ B ▬',
  'S l S',
  '▬ B ▬'], {
  '▬': <ore:ingotOsmium>,                         // Osmium Ingot
  'B': <extendedcrafting:material:14>,            // Basic Component
  'S': <immersiveengineering:material:9>,         // Steel Mechanical Component
  'l': <immersiveengineering:stone_decoration:1>, // Blast Brick
}).shaped());

// [Iron Casing]*4 from [Hardened Casing][+2]
mods.extendedcrafting.TableCrafting.addShaped(0, <actuallyadditions:block_misc:9> * 4, Grid(['pretty',
  '□ G □',
  'G ⌂ G',
  '□ G □'], {
  '□': <ore:plateInvar>,              // Invar Plate
  'G': <forestry:thermionic_tubes:4>, // Golden Electron Tube
  '⌂': <forestry:hardened_machine>,   // Hardened Casing
}).shaped());