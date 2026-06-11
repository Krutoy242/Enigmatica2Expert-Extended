#modloaded thaumcraft
#reloadable

import native.thaumcraft.api.internal.CommonInternals;
import native.thaumcraft.api.crafting.InfusionRecipe;
import native.net.minecraft.item.crafting.IRecipe;
import native.net.minecraft.item.crafting.Ingredient;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.item.Item;
import native.net.minecraft.block.Block;
import native.java.util.Map;
import native.java.util.Map.Entry;
import crafttweaker.item.IIngredient;

val tcEnum as function(function(IIngredient[],IIngredient[])int)bool = function(cb as function(IIngredient[],IIngredient[])int) as bool {
  val tcCatalog as Map = CommonInternals.craftingRecipeCatalog;

  for _entry in tcCatalog.entrySet() {
    val entry = _entry as Entry;
    val _value = entry.value;

    // ── InfusionRecipe ──
    if (_value instanceof InfusionRecipe) {
      val infRecipe = _value as InfusionRecipe;
      val outputObj = infRecipe.getRecipeOutput();
      if (isNull(outputObj)) continue;

      var output as ItemStack = null;
      if (outputObj instanceof ItemStack) {
        output = outputObj as ItemStack;
      } else if (outputObj instanceof Item) {
        output = ItemStack(outputObj as Item);
      } else if (outputObj instanceof Block) {
        output = ItemStack(outputObj as Block);
      } else {
        continue;
      }
      if (isNull(output) || output.isEmpty()) continue;

      val inputs = [] as [IIngredient];

      // Center ingredient
      val centerIng = infRecipe.getRecipeInput();
      if (!isNull(centerIng)) {
        val stacks = centerIng.getMatchingStacks() as ItemStack[];
        if (stacks.length > 0) {
          val stack = stacks[0];
          if (!isNull(stack) && !stack.isEmpty()) inputs.add(stack.wrapper);
        }
      }

      // Components
      val comps = infRecipe.getComponents();
      for _comp in comps {
        val ing = _comp as Ingredient;
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
      continue;
    }

    // ── Check by class name for arcane / misc ──
    val typeStr = toString(_value);
    if (typeStr has 'CrucibleRecipe') continue;
    if (typeStr has 'RecipeMisc') continue;

    // Arcane Workbench (extends IRecipe)
    if (typeStr has 'ShapedArcaneRecipe' || typeStr has 'ShapelessArcaneRecipe') {
      val recipe = _value as IRecipe;
      if (isNull(recipe)) continue;

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
      continue;
    }
  }

  return true;
};
scripts.lib.store.recipes.enuerators.add(tcEnum);
