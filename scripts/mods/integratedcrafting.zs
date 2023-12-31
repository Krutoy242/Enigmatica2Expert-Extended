#modloaded integratedcrafting

// [Crafting Interface] from [Block of Crystalized Menril][+4]
craft.remake(<integratedcrafting:part_interface_crafting_item>, ['pretty',
  '□ ¤ □',
  'O ■ I',
  '□ ¤ □'], {
  '□': <ore:plateLapis>,                            // Lapis Lazuli Plate
  '¤': <ore:gearIronInfinity>,                      // Infinity Bimetal Gear
  'O': <integrateddynamics:variable_transformer>,   // Output Variable Transformer
  '■': <ore:blockMenril>,                           // Block of Crystalized Menril
  'I': <integrateddynamics:variable_transformer:1>, // Input Variable Transformer
});
