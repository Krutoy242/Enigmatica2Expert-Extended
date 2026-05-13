#ignoreBracketErrors
#modloaded thaumictweaker requious
#sideonly client

import crafttweaker.item.IItemStack;
import mods.requious.AssemblyRecipe;

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
val x = <assembly:pech_trades>;
x.addJEICatalyst(<entity:thaumcraft:pech>.asStack());
x.setJEIItemSlot(3, 0, 'input0');

// Diamonds
for _y in 0 .. 5 {
  x.setJEIItemSlot(0, _y + 1, 'input1' ~ _y, scripts.jei.requious.getVisSlots(0, 1));
}

// Main outputs
var k = 0;
for _y in 0 .. 5 {
  for _x in 0 .. 6 {
    x.setJEIItemSlot(_x + 1, _y + 1, 'output' ~ _x ~ _y);
    k += 1;
  }
}

val pechRepresentation = {
  MINER : <minecraft:stone_pickaxe>,
  MAGE  : <betterbuilderswands:wandstone>,
  ARCHER: <minecraft:bow>,
  COMMON: <thaumcraft:stone_arcane>,
} as IItemStack[string];

val pechDiamonds = [
  <rats:rat_diamond>,
  <minecraft:diamond>,
  <actuallyadditions:item_crystal:2>,
  <minecraft:diamond_block>,
  <additionalcompression:gemdiamond_compressed:1>,
] as IItemStack[];

for type, levels in scripts.mods.thaumcraft.pech.trades {
  val assRec = AssemblyRecipe.create(function (container) {
    for level, items in levels {
      for i, item in items {
        if (isNull(item)) continue;
        container.addItemOutput('output' ~ i ~ level, item);
      }
    }
  });
  assRec.requireItem('input0', pechRepresentation[type]);
  for j in 0 .. 5 { assRec.requireItem('input1' ~ j, pechDiamonds[j]); }
  x.addJEIRecipe(assRec);
}
