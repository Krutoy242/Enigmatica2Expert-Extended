#modloaded forestry
#reloadable

import native.forestry.api.recipes.RecipeManagers;
import native.forestry.api.recipes.ICarpenterRecipe;
import native.forestry.api.recipes.IFabricatorRecipe;
import native.forestry.api.recipes.IDescriptiveRecipe;
import native.net.minecraft.item.ItemStack;
import crafttweaker.item.IIngredient;

val forestryEnum as function(function(IIngredient[],IIngredient[])int)bool = function(cb as function(IIngredient[],IIngredient[])int) as bool {
  // ── Carpenter ──
  val carpCol = RecipeManagers.carpenterManager.recipes();
  val carpRecipes as [ICarpenterRecipe] = carpCol;
  for recipe in carpRecipes {
    val descRecipe = recipe.getCraftingGridRecipe() as IDescriptiveRecipe;
    val output = descRecipe.getOutput() as ItemStack;
    if (isNull(output) || output.isEmpty()) continue;

    val rawIngredients = descRecipe.getRawIngredients();
    val inputs = [] as [IIngredient];
    for _slot in rawIngredients {
      if (_slot.length == 0) continue;
      val stack = _slot[0] as ItemStack;
      if (isNull(stack) || stack.isEmpty()) continue;
      inputs.add(stack.wrapper);
    }
    if (inputs.length == 0) continue;

    val ret = cb([output.wrapper], inputs);
    if (ret == scripts.lib.store.recipes.CB_RESULT.STOP_FULL) return false;
    if (ret == scripts.lib.store.recipes.CB_RESULT.STOP_MOD) break;
  }

  // ── Fabricator ──
  val fabCol = RecipeManagers.fabricatorManager.recipes();
  val fabRecipes as [IFabricatorRecipe] = fabCol;
  for recipe in fabRecipes {
    val output = recipe.getRecipeOutput() as ItemStack;
    if (isNull(output) || output.isEmpty()) continue;

    val ingredients = recipe.getIngredients();
    val inputs = [] as [IIngredient];
    for _slot in ingredients {
      if (_slot.length == 0) continue;
      val stack = _slot[0] as ItemStack;
      if (isNull(stack) || stack.isEmpty()) continue;
      inputs.add(stack.wrapper);
    }
    if (inputs.length == 0) continue;

    val ret = cb([output.wrapper], inputs);
    if (ret == scripts.lib.store.recipes.CB_RESULT.STOP_FULL) return false;
    if (ret == scripts.lib.store.recipes.CB_RESULT.STOP_MOD) break;
  }

  return true;
};
scripts.lib.store.recipes.enuerators.add(forestryEnum);
