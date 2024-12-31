#modloaded extendedcrafting
#priority 10

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

function remakeAlted(
  output as IItemStack,
  gridStr as string[],
  options as IIngredient[string],
  altOutputAmount as int,
  altMapReplacements as IIngredient[string]
) as void {
  craft.remake(output, gridStr, options);
  add(output * altOutputAmount, gridStr, merge(options, altMapReplacements));
}

function makeAlted(
  output as IItemStack,
  gridStr as string[],
  options as IIngredient[string],
  altOutputAmount as int,
  altMapReplacements as IIngredient[string]
) as void {
  craft.make(output, gridStr, options);
  add(output * altOutputAmount, gridStr, merge(options, altMapReplacements));
}

function add(output as IItemStack, gridStr as string[], options as IIngredient[string]) as void {
  mods.extendedcrafting.TableCrafting.addShaped(0, output, Grid(gridStr, options).shaped());
}

// Overwrate values of one map over another
function merge(a as IIngredient[string], b as IIngredient[string]) as IIngredient[string] {
  for key, value in b {
    a[key] = value;
  }
  return a;
}
