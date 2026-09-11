/**
 * @file Client-only crafting recipes that preview how to fill "diverse" singularity.
 *
 * Recipes registered here are fake - they exist only on client to be shown in JEI.
 * Real craft is handled by recipe function from scripts/do/diverse.zs, registered
 * earlier, so it always wins recipe lookup.
 *
 * Preview shows chain of crafts, like if player would fill singularity by himself:
 *   1. Feed as many *different* items as possible to rise exponent
 *   2. Then add +1 of already used items in circles until 100%
 *
 * Singularities that require too many crafts (like Garbage one) are skipped.
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#modloaded contenttweaker
// Lower than scripts/cot/functions.zs, so real recipe is found first
#priority -200
#ignoreBracketErrors
#reloadable
#sideonly client

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDictEntry;

static WILDCARD as int = 32767;

// Real recipe is 3x3 grid with singularity in first slot
static FUELS_PER_CRAFT as int = 8;

// Dont show singularities that need more crafts than this
static MAX_STEPS as int = 32;

function addUnique(list as [IItemStack], seen as bool[string], item as IItemStack) as void {
  if (isNull(item)) return;
  val key = item.definition.id ~ ':' ~ item.damage;
  if (!isNull(seen[key])) return;
  seen[key] = true;
  list.add(item);
}

/*
Every different item ore dictionary entry can provide
*/
function oreItems(ore as IOreDictEntry) as [IItemStack] {
  val list = [] as [IItemStack];
  val seen = {} as bool[string];
  for item in ore.items {
    if (isNull(item)) continue;
    if (item.damage != WILDCARD) {
      addUnique(list, seen, item);
      continue;
    }
    val subs = item.definition.subItems;
    if (isNull(subs) || subs.length == 0) {
      addUnique(list, seen, item.definition.makeStack(0));
      continue;
    }
    for sub in subs { addUnique(list, seen, sub); }
  }
  return list;
}

/*
Amount of each item type required to charge singularity to 100%.
Length of returned array is amount of different items used.
*/
function planCounts(typesAvailable as int, charge as int) as int[] {
  // Only diversity needed - one of each different item is enough
  for types in 1 .. (typesAvailable + 1) {
    if (scripts.do.diverse.getPower(intArrayOf(types, 1)) >= charge) return intArrayOf(types, 1);
  }

  // Diversity exhausted, find how many of each item needed
  var lo = 1; // Not enough
  var hi = 2; // Unknown yet
  while scripts.do.diverse.getPower(intArrayOf(typesAvailable, hi)) < charge {
    lo = hi;
    hi *= 2;
    if (hi >= 1073741824) return intArrayOf(typesAvailable, lo); // Unreachable charge
  }
  while lo + 1 < hi {
    val mid = (lo + hi) / 2;
    if (scripts.do.diverse.getPower(intArrayOf(typesAvailable, mid)) >= charge) hi = mid;
    else lo = mid;
  }

  // Add last items one by one, in circles
  val counts = intArrayOf(typesAvailable, lo);
  for i in 0 .. typesAvailable {
    if (scripts.do.diverse.getPower(counts) >= charge) break;
    counts[i] = counts[i] + 1;
  }
  return counts;
}

/*
Order in which player would insert items:
one of each different first, then same items in circles
*/
function craftOrder(items as [IItemStack], counts as int[]) as [IItemStack] {
  var maxCount = 0;
  for c in counts {
    if (c > maxCount) maxCount = c;
  }

  val order = [] as [IItemStack];
  for round in 0 .. maxCount {
    for i in 0 .. counts.length {
      if (counts[i] > round) order.add(items[i]);
    }
  }
  return order;
}

/*
Run real charging function to get authentic result item.
Crafting grid ignores stack sizes, so every slot count as one item.
*/
function simulateCraft(
  recipeFunction as function(IItemStack[string],bool)IItemStack,
  base as IItemStack,
  fuels as [IItemStack]
) as IItemStack {
  val ins = {} as IItemStack[string];
  ins['0'] = base;
  for i in 0 .. fuels.length {
    ins['' ~ (i + 1)] = fuels[i];
  }
  return recipeFunction(ins, false);
}

function addPreviewRecipe(
  recipeName as string,
  input as IItemStack,
  fuels as [IItemStack],
  output as IItemStack
) as void {
  val grid = arrayOf(9, null as IIngredient);
  grid[0] = input;
  for i in 0 .. fuels.length {
    grid[i + 1] = fuels[i];
  }

  recipes.addShaped(recipeName, output, [
    [grid[0], grid[1], grid[2]],
    [grid[3], grid[4], grid[5]],
    [grid[6], grid[7], grid[8]],
  ] as IIngredient[][]);
}

/*
Whole chain of crafts from empty base to fully charged singularity
*/
function addPreviewChain(
  id as string,
  base as IItemStack,
  singularity as IItemStack,
  ore as IOreDictEntry,
  charge as int
) as void {
  val items = oreItems(ore);
  if (items.length == 0) return;

  val order = craftOrder(items, planCounts(items.length, charge));
  if (order.length > MAX_STEPS * FUELS_PER_CRAFT) return;

  val recipeFunction = scripts.do.diverse.getRecipeFunction(singularity, charge);
  var current = base;
  var step = 0;

  for i in 0 .. order.length {
    if (i % FUELS_PER_CRAFT != 0) continue;

    val fuels = [] as [IItemStack];
    for j in i .. order.length {
      if (j - i >= FUELS_PER_CRAFT) break;
      fuels.add(order[j]);
    }

    val result = simulateCraft(recipeFunction, current, fuels);
    if (isNull(result)) return;
    addPreviewRecipe(`${id}_singularity_preview_${step}`, current, fuels, result);
    current = result;
    step += 1;
  }
}

// -----------------------------------------------------------------------------------
// Simulate charging of every singularity
// -----------------------------------------------------------------------------------
val base = <avaritia:singularity> ?? <minecraft:nether_star>;

for i, id in scripts.cot.def.Op.singularIDs {
  val singularity = <item:contenttweaker:${id}_singularity>;
  val ore = oreDict[scripts.cot.def.Op.singularOres[i]];
  if (isNull(singularity) || isNull(ore) || ore.empty) continue;
  addPreviewChain(id, base, singularity, ore, scripts.cot.def.Op.singularCharges[i]);
}
