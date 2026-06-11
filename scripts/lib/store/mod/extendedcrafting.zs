#modloaded extendedcrafting
#reloadable

import native.com.blakebr0.extendedcrafting.crafting.table.TableRecipeManager;
import native.com.blakebr0.extendedcrafting.crafting.table.ITieredRecipe;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.item.crafting.Ingredient;
import crafttweaker.item.IIngredient;

val ecEnum as function(function(IIngredient[],IIngredient[])int)bool = function (cb as function(IIngredient[],IIngredient[])int) as bool {
  val manager = TableRecipeManager.getInstance();
  val col = manager.getRecipes();
  val recipes as [ITieredRecipe] = col;

  for recipe in recipes {
    val output = recipe.getRecipeOutput();
    if (isNull(output) || output.isEmpty()) continue;

    val ingredients as [Ingredient] = recipe.getIngredients();
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
    if (ret == scripts.lib.store.recipes.CB_RESULT.STOP_FULL) return false;
    if (ret == scripts.lib.store.recipes.CB_RESULT.STOP_MOD) break;
  }

  return true;
};
scripts.lib.store.recipes.enuerators.add(ecEnum);
