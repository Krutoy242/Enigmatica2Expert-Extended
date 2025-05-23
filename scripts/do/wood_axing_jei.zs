#modloaded jei requious
#priority -2
#ignoreBracketErrors

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

function addForAxes(input as IIngredient, output as IItemStack) as void {
  if (isNull(input) || isNull(output)) return;

  for axe, value in scripts.do.wood_axing.axes {
    scripts.jei.crafting_hints.add1to1(input, output * value, axe);
  }
}

addForAxes(<ore:logWood>, <ore:plankWood>.firstItem);
addForAxes(<ore:blockMagicalWood>, <extrautils2:decorativesolidwood>);

for oreName, output in scripts.do.wood_axing.oreStick {
  addForAxes(oreDict.get(oreName), output);
}
