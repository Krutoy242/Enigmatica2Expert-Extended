#modloaded jei

// Thanks to the FTB Interactions devs for making me aware of this feature <3
val categoriesToHide as string[] = [
  'minecraft.fuel',
  'actuallyadditions.crushing',
  'thermalexpansion.furnace',
  'xu2_machine_extrautils2:furnace',
  'xu2_machine_extrautils2:generator_survival',
  'xu2_machine_extrautils2:generator',
  'mekanism.energizedsmelter',
];

for category in categoriesToHide {
  mods.jei.JEI.hideCategory(category);
}
