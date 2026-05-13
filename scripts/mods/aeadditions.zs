#modloaded aeadditions

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

// [ME Gas Interface] from [Annihilation Core][+3]
craft.remake(<aeadditions:gas_interface>, ['pretty',
  '▬ d ▬',
  'A   F',
  '▬ d ▬'], {
  'A': <appliedenergistics2:material:44>, // Annihilation Core
  'F': <appliedenergistics2:material:43>, // Formation Core
  'd': <ore:dyeYellow>, // Dandelion Yellow
  '▬': <ore:ingotTungsten>, // Tungsten Ingot
});

// [Certus Quartz Tank] from [Tank][+1]
craft.reshapeless(<aeadditions:certustank>, 'ABB', {
  A: <enderio:block_omni_reservoir>, // Tank
  B: <appliedenergistics2:quartz_glass>, // Quartz Glass
});

function newGasCellRecipe(input as IIngredient, output as IItemStack) {
  recipes.remove(output);
  recipes.addShaped(output,
    [[<appliedenergistics2:quartz_glass>, <appliedenergistics2:material:8>, <appliedenergistics2:quartz_glass>],
      [<appliedenergistics2:material:8>, input, <appliedenergistics2:material:8>],
      [<ore:plateGold>, <ironchest:iron_chest:1>, <ore:plateGold>]]);
  if (!isNull(input)) {
    recipes.addShapeless(output, [<aeadditions:storage.casing:2>, input]);
  }
}

// ---=== Storage Housings ===---

Purge(<aeadditions:storage.casing>);
Purge(<aeadditions:storage.casing:1>);
newGasCellRecipe(null, <aeadditions:storage.casing:2>);

// ---=== Advanced Cells ===---
for i in 0 .. 4 {
  Purge(<aeadditions:storage.component>.definition.makeStack(i));
  Purge(<aeadditions:storage.physical>.definition.makeStack(i));
}

// Fluid storages
Purge(<aeadditions:storage.component:4>);
Purge(<aeadditions:storage.component:5>);
Purge(<aeadditions:storage.component:6>);
Purge(<aeadditions:storage.fluid>);
Purge(<aeadditions:storage.fluid:1>);
Purge(<aeadditions:storage.fluid:2>);

// ---=== Gas Cells ===---
for i in 0 .. 7 {
  newGasCellRecipe(<aeadditions:storage.component>.definition.makeStack(i + 7), <aeadditions:storage.gas>.definition.makeStack(i));
}

// [ME Portable Fluid Storage] from [Charged Certus Quartz Crystal][+3]
craft.remake(<aeadditions:storage.fluid.portable>, ['pretty',
  '  *  ',
  '∩ ⌃ ∩',
  '◊   ◊'], {
  '*': <ic2:energy_crystal>.withTag({ charge: 1000000.0 }), // Energy Crystal
  '∩': <rats:charged_creeper_chunk>, // Charged Creeper Chunk
  '⌃': <appliedenergistics2:material:1>, // Charged Certus Quartz Crystal
  '◊': <ore:gemLapis>, // Lapis Lazuli
});

// [ME Portable Gas Storage] from [Charged Certus Quartz Crystal][+3]
craft.remake(<aeadditions:storage.gas.portable>, ['pretty',
  '  *  ',
  '∩ ⌃ ∩',
  'd   d'], {
  '*': <ic2:energy_crystal>.withTag({ charge: 1000000.0 }), // Energy Crystal
  '∩': <rats:charged_creeper_chunk>, // Charged Creeper Chunk
  '⌃': <appliedenergistics2:material:1>, // Charged Certus Quartz Crystal
  'd': <ore:dyeYellow>, // Dandelion Yellow
});
