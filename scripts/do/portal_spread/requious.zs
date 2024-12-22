/**
 * @file JEI integration with help of mod Requious Fracto
 *
 * To make this file work you need:
 * 1. Install mod Requious Fracto
 * 2. Add `requious:portal_spread` to file `config/jei/itemBlacklist.cfg`
 * 3. Append this JSON object into file `config/requious/assembly.json`:
 *   {"resourceName": "portal_spread", "model": "requious:assembly_block","placeType": "Any","layerType": "Cutout","hasGUI": false,"extraVariants": [],"colors": [{"r": 255,"g": 255,"b": 255,"a": 255}],"hardness": 5.0,"blastResistance": 5.0,"aabb": {"x1": 0.0,"y1": 0.0,"z1": 0.0,"x2": 1.0,"y2": 1.0,"z2": 1.0}}
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#modloaded requious zenutils
#priority -4000

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import scripts.do.portal_spread.utils.stateToItem;

val x = <assembly:portal_spread>;
x.addJEICatalyst(<minecraft:obsidian>);
x.setJEIDurationSlot(1, 0, 'duration', mods.requious.SlotVisual.arrowRight());
x.setJEIItemSlot(0, 0, 'input');
for i in 2 .. 6 {
  x.setJEIItemSlot(i, 0, 'output');
}

val wildcardedNumIds = scripts.do.portal_spread.recipes.spread.wildcardedNumIds;

/**
 * Compare two lists of items to be the same items and same amounts
 */
function isItemListSame(A as IItemStack[], B as IItemStack[]) as bool {
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
      ) input = input.anyDamage();

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

  x.addJEIRecipe(mods.requious.AssemblyRecipe.create(function (c) {
    for output in outputs { c.addItemOutput('output', output); }
  }).requireItem('input', input));

  // var s = 'add portal spread JEI recipe: '~input.commandString~' => [';
  // for i, output in outputs {
  //   s += (i==0?'':', ')~output.commandString;
  // }
  // print(s ~ ']');
}
