#modloaded thermalexpansion requious
#priority 950

import crafttweaker.item.IIngredient;
import crafttweaker.liquid.ILiquidStack;
import mods.requious.AssemblyRecipe;
import mods.requious.SlotVisual;

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
val x = <assembly:arboreal_extractor>;
x.addJEICatalyst(<thermalexpansion:device:3>.withTag({ RSControl: 0 as byte, Facing: 3 as byte, Energy: 0, SideCache: [1, 1, 2, 2, 2, 2] as byte[] as byte[] }));
x.setJEIItemSlot(0, 0, 'input0');
x.setJEIItemSlot(1, 0, 'input1');
x.setJEIDurationSlot(2, 0, 'duration', SlotVisual.arrowRight());
x.setJEIFluidSlot(3, 0, 'fluid_out');
function addExtraction(input1 as IIngredient, input2 as IIngredient, output as ILiquidStack) as void {
  <assembly:arboreal_extractor>.addJEIRecipe(AssemblyRecipe.create(function (container) {
    container.addFluidOutput('fluid_out', output);
  })
    .requireItem('input0', input1).requireItem('input1', input2)
  );
}
addExtraction(<minecraft:log:1> * 3, <minecraft:leaves:1> * 4, <fluid:resin> * 100); // spruce
addExtraction(<minecraft:log:2> * 3, <minecraft:leaves:2> * 4, <fluid:resin> * 50); // birch
addExtraction(<minecraft:log:3> * 3, <minecraft:leaves:3> * 4, <fluid:resin> * 50); // jungle
addExtraction(<minecraft:log2> * 3, <minecraft:leaves2> * 4, <fluid:resin> * 50); // acacia
addExtraction(<minecraft:log2:1> * 3, <minecraft:leaves2:1> * 4, <fluid:sap> * 100); // dark oak
addExtraction(<minecraft:log> * 3, <minecraft:leaves> * 4, <fluid:sap> * 50); // oak
addExtraction(<minecraft:red_mushroom_block>, <minecraft:red_mushroom_block>, <fluid:mushroom_stew> * 50);
addExtraction(<minecraft:brown_mushroom_block>, <minecraft:brown_mushroom_block>, <fluid:mushroom_stew> * 50);
