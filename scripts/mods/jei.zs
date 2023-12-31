#modloaded jei

// Thanks to the FTB Interactions devs for making me aware of this feature <3
val categoriesToHide as string[] = [
  'minecraft.fuel',
  'thermaldynamics.covers',
  'thermalexpansion.furnace',
  'xu2_machine_extrautils2:furnace',
  'xu2_machine_extrautils2:generator_survival',
  'xu2_machine_extrautils2:generator',
  'mctsmelteryio:casting_machine',
  'mctsmelteryio:fuel_controller',
  'tcomplement:high_oven_melting',
  'mekanism.energizedsmelter',
];

for category in categoriesToHide {
  mods.jei.JEI.hideCategory(category);
}
