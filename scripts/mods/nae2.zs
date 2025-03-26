#modloaded nae2

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

// ---=== Advanced Cells ===---
for i, storage in [
  <nae2:storage_cell_256k>,
  <nae2:storage_cell_1024k>,
  <nae2:storage_cell_4096k>,
  <nae2:storage_cell_16384k>,
] as IItemStack[] {
  craft.remake(storage, ["pretty",
    "⌃ ▲ ⌃",
    "▲ 2 ▲",
    "D D D"], {
    "⌃": <appliedenergistics2:quartz_glass>, # Quartz Glass
    "▲": <ore:dustFluix>, # Fluix Dust
    "2": <nae2:material>.definition.makeStack(i + 1),
    "D": <ironchest:iron_chest:2>, # Diamond Chest
  });
}

# [Reconstruction Chamber] from [Empowered Emeradic Crystal][+2]
craft.remake(<nae2:reconstruction_chamber>, ["pretty",
  "▬ ⌃ ▬",
  "⌃ * ⌃",
  "▬ ⌃ ▬"], {
  "▬": <ore:ingotElectricalSteel>,         # Electrical Steel Ingot
  "⌃": <appliedenergistics2:quartz_glass>, # Quartz Glass
  "*": <actuallyadditions:item_crystal_empowered:4>, # Empowered Emeradic Crystal
});

craft.reshapeless(<nae2:upgrade:1>, 'AB', {
  A: <appliedenergistics2:material:53>,
  B: <thermalfoundation:material:23>,
});
