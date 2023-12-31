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

import crafttweaker.block.IBlockState;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

// Replaces for blocks that cant be converted into items
static blockRepresentation as IItemStack[string] = {
  'minecraft:double_stone_slab' : <minecraft:stone_slab>,
  'minecraft:double_wooden_slab': <minecraft:wooden_slab>,
  'minecraft:fire'              : <minecraft:flint_and_steel>,
  'minecraft:lava'              : <minecraft:lava_bucket>,
  'minecraft:water'             : <minecraft:water_bucket>,
  'minecraft:air'               : <mechanics:empty>,
  'biomesoplenty:blood'         : <forge:bucketfilled>.withTag({ FluidName: 'blood', Amount: 1000 }),
};

val x = <assembly:portal_spread>;
x.addJEICatalyst(<minecraft:obsidian>);
x.setJEIDurationSlot(1, 0, 'duration', mods.requious.SlotVisual.arrowRight());
x.setJEIItemSlot(0, 0, 'input');
for i in 2 .. 6 {
  x.setJEIItemSlot(i, 0, 'output');
}

val wildcardedNumIds = scripts.do.portal_spread.recipes.spread.wildcardedNumIds;

function stateToItem(state as IBlockState) as IItemStack {
  if (
    isNull(state)
    || isNull(state.block)
    || isNull(state.block.definition)
  ) return null;

  val defId = state.block.definition.id;
  var item = state.block.getItem(null, null, state);
  if (isNull(item)) item = blockRepresentation[defId];
  if (isNull(item))
    logger.logWarning('Cannot find item representation for block: ' ~ defId);
  return item;
}

// Group recipes by inputs and outputs
val recipeMap as IItemStack[][IIngredient] = {};

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
        && !isNull(wildcardedNumIds[dimFrom][dimTo][stateFrom.block.definition.numericalId])
      ) input = input.anyDamage();

      var merged = false;
      for inp, outs in recipeMap {
        if (isNull(outs)) continue;

        // Find if outputs are the same
        var outsMatch = true;
        for out in outs { if (!(outputs has out)) { outsMatch = false; break; } }
        if (outsMatch) for out in outputs { if (!(outs has out)) { outsMatch = false; break; } }

        if (!outsMatch || inp has input) continue;

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
