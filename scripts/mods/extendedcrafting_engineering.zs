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