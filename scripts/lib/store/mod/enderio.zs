#modloaded enderio
#reloadable

import native.crazypants.enderio.base.recipe.slicensplice.SliceAndSpliceRecipeManager;
import native.crazypants.enderio.base.recipe.IManyToOneRecipe;
import crafttweaker.item.IIngredient;

val eioEnum as function(function(IIngredient[],IIngredient[])int)bool = function (cb as function(IIngredient[],IIngredient[])int) as bool {
  val manager = SliceAndSpliceRecipeManager.getInstance();
  val col = manager.getRecipes();
  val recipes as [IManyToOneRecipe] = col;

  for recipe in recipes {
    val output = recipe.getOutput();
    if (isNull(output) || output.isEmpty()) continue;

    val rawInputs = recipe.getInputs();
    val inputs = [] as [IIngredient];
    for rawInput in rawInputs {
      if (isNull(rawInput)) continue;
      val stack = rawInput.getInput();
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
scripts.lib.store.recipes.enuerators.add(eioEnum);
