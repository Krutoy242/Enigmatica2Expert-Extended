#modloaded astralsorcery
#reloadable

import native.hellfirepvp.astralsorcery.common.crafting.altar.AltarRecipeRegistry;
import native.hellfirepvp.astralsorcery.common.crafting.altar.AbstractAltarRecipe;
import native.java.util.Map;
import native.java.util.Map.Entry;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.item.crafting.IRecipe;
import native.net.minecraft.item.crafting.Ingredient;
import crafttweaker.item.IIngredient;

function processASMap(recipeMap as Map, cb as function(IIngredient[],IIngredient[])int) as int {
  for _levelEntry in recipeMap.entrySet() {
    val entry = _levelEntry as Entry;
    val _value = entry.value;
    val recipeList as [AbstractAltarRecipe] = _value;
    for recipe in recipeList {
      val nativeRecipe = recipe.getNativeRecipe();
      if (isNull(nativeRecipe)) continue;

      val iRecipe as IRecipe = nativeRecipe;
      val output = iRecipe.getRecipeOutput();
      if (isNull(output) || output.isEmpty()) continue;

      val ingredients as [Ingredient] = iRecipe.getIngredients();
      val inputs = [] as [IIngredient];
      for ing in ingredients {
        if (isNull(ing)) continue;
        val stacks = ing.getMatchingStacks() as ItemStack[];
        if (stacks.length == 0) continue;
        val stack = stacks[0];
        if (isNull(stack) || stack.isEmpty()) continue;
        inputs.add(stack.wrapper);
      }
      if (inputs.length == 0) continue;

      val ret = cb([output.wrapper], inputs);
      if (ret == scripts.lib.store.recipes.CB_RESULT.STOP_FULL) return scripts.lib.store.recipes.CB_RESULT.STOP_FULL;
      if (ret == scripts.lib.store.recipes.CB_RESULT.STOP_MOD) break;
    }
  }
  return scripts.lib.store.recipes.CB_RESULT.CONTINUE;
}

val asEnum as function(function(IIngredient[],IIngredient[])int)bool = function (cb as function(IIngredient[],IIngredient[])int) as bool {
  var result = processASMap(AltarRecipeRegistry.recipes, cb);
  if (result == scripts.lib.store.recipes.CB_RESULT.STOP_FULL) return false;

  result = processASMap(AltarRecipeRegistry.mtRecipes, cb);
  if (result == scripts.lib.store.recipes.CB_RESULT.STOP_FULL) return false;

  return true;
};
scripts.lib.store.recipes.enuerators.add(asEnum);
