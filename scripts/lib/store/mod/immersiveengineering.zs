#modloaded immersiveengineering
#reloadable

import native.blusunrize.immersiveengineering.api.crafting.BlueprintCraftingRecipe;
import crafttweaker.item.IIngredient;

val ieEnum as function(function(IIngredient[],IIngredient[])int)bool = function (cb as function(IIngredient[],IIngredient[])int) as bool {
  // Iterate all blueprint categories
  for cat in BlueprintCraftingRecipe.blueprintCategories {
    val _recipes = BlueprintCraftingRecipe.findRecipes(cat);
    for recipe in _recipes {
      val output = recipe.output;
      if (isNull(output) || output.isEmpty()) continue;

      val inputsList = [] as [IIngredient];
      for ingr in recipe.inputs {
        if (isNull(ingr)) continue;
        val stack = ingr.stack;
        if (!isNull(stack) && !stack.isEmpty()) {
          inputsList.add(stack.wrapper);
        }
      }
      if (inputsList.length == 0) continue;

      val ret = cb([output.wrapper], inputsList);
      if (ret == scripts.lib.store.recipes.CB_RESULT.STOP_FULL) return false;
      if (ret == scripts.lib.store.recipes.CB_RESULT.STOP_MOD) break;
    }
  }

  return true;
};
scripts.lib.store.recipes.enuerators.add(ieEnum);
