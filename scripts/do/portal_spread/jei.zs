/**
 * @file JEI integration for Portal Spreading recipes.
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#modloaded randomtweaker zenutils jei
#priority -4000
#reloadable
#sideonly client

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.jei.JEI;
import mods.randomtweaker.jei.IJeiUtils;

import scripts.do.portal_spread.utils.stateToItem;

val SLOT_SIZE = 18;
val ARROW_WIDTH = SLOT_SIZE + 4;

val categoryId = 'portal_spread';
val p = JEI.createJei(categoryId, game.localize('requious.jei.recipe.portal_spread'))
  .setBackground(IJeiUtils.createBackground(5 * SLOT_SIZE + ARROW_WIDTH, SLOT_SIZE))
  .setModid('zenutils')
  .setIcon(<minecraft:obsidian>)
  .addRecipeCatalyst(<minecraft:obsidian>);

p.addSlot(IJeiUtils.createItemSlot('input', 0, 0, true, false));
p.addElement(IJeiUtils.createArrowElement(SLOT_SIZE, 1, 0));
for i in 0 .. 4 {
  p.addSlot(IJeiUtils.createItemSlot(`output${i}`, SLOT_SIZE + ARROW_WIDTH + i * SLOT_SIZE, 0, false, false));
}
p.register();

val wildcardedNumIds = scripts.do.portal_spread.recipes.spread.wildcardedNumIds;

/**
 * Compare two lists of items to be the same items and same amounts
 */
function isItemListSame(A as IItemStack[], B as IItemStack[]) as bool {
  if (A.length != B.length) return false;

  for a in A {
    var match = false;
    for b in B {
      if (a has b || b has a) {
        match = true;
        break;
      }
    }
    if (!match) return false;
  }
  return true;
}

// Group recipes by inputs and outputs
val recipeMap as IItemStack[][IIngredient] = {} as IItemStack[][IIngredient]$orderly;

for dimFrom, dimFromData in scripts.do.portal_spread.recipes.spread.stateRecipes {
  for dimTo, dimToData in dimFromData {
    for stateFrom, statesTo in dimToData {
      // Outputs
      var outputs as IItemStack[] = [];
      for state in statesTo {
        val item = stateToItem(state);
        if (isNull(item)) continue;
        outputs += item;
      }

      // Input
      var input = stateToItem(stateFrom);
      if (isNull(input)) continue;
      if (!isNull(wildcardedNumIds[dimFrom])
        && !isNull(wildcardedNumIds[dimFrom][dimTo])
        && !isNull(wildcardedNumIds[dimFrom][dimTo][stateFrom.block.definition])
      ) {
        input = input.withDamage(32767);
      }

      var merged = false;
      for inp, outs in recipeMap {
        if (isNull(outs)) continue;

        if (!isItemListSame(outs, outputs) || inp has input) continue;

        // Replace inputs
        recipeMap[inp] = null;
        recipeMap[inp | input] = outs;
        merged = true;
        break;
      }

      if (merged) continue;
      recipeMap[input as IIngredient] = outputs;
    }
  }
}

for input, outputs in recipeMap {
  if (isNull(outputs)) continue;

  val recipe = JEI.createJeiRecipe(categoryId).addInput(input);

  for output in outputs {
    recipe.addOutput(output);
  }

  recipe.build();
}
