#modloaded appliedenergistics2 qmd
#reloadable
#priority 2000

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.recipes.IRecipeFunction;

static reagents as [IIngredient] = [
  <appliedenergistics2:material:47>,
  <ore:dustProtactinium231>,
  <ore:ingotBeryllium7>,
  <ore:ingotSodium22>,
  <ore:ingotCalcium48>,
];

static result as [IItemStack] = [];

var ingr = reagents[0] as IIngredient;
for i, reagent in reagents { if (i > 0) ingr |= reagent; }

static gridWidth as int = 2;
static gridVolume as int = pow(gridWidth, 2);

val recipeFunction as IRecipeFunction = function (out, ins, cInfo) {
  if (!hasMorphite(ins)) return null;

  val arr = intArrayOf(gridVolume, 0);
  for i in 0 .. gridVolume {
    val tier = ingredientTier(ins[i]);
    arr[i] = tier;
  }

  val score = scripts.do.morphite.util.array_with_1_to_index(arr);
  return result[score % result.length];
};

function ingredientTier(item as IItemStack) as int {
  if (isNull(item)) return 0;
  for j, reagent in reagents {
    if (!(reagent has item.definition.makeStack(item.damage))) continue;
    return j + 1;
  }
  return 0;
}

function hasMorphite(ins as IItemStack[string]) as bool {
  for i in 0 .. gridVolume {
    val item = ins[i];
    if (!isNull(ins[i]) && reagents[0] has item.definition.makeStack(item.damage))
      return true;
  }
  return false;
}

var recipeIndex = 0;
for morphCount in 1 .. (gridVolume + 1) {
  for slotMask in 0 .. pow(gridVolume, 2) {
    if (bitCount(slotMask) != morphCount) continue;

    val grid as IIngredient[] = arrayOf(gridVolume, null as IIngredient);

    for i in 0 .. 4 {
      if (hasBit(slotMask, i)) {
        grid[i] = ingr.marked(i);
      }
    }

    recipes.addHiddenShaped('morphite_' ~ recipeIndex ~ '_' ~
        ((isNull(grid[0]) ? '.' : 'o') ~ (isNull(grid[1]) ? '.' : 'o') ~ '/'
        ~ (isNull(grid[2]) ? '.' : 'o') ~ (isNull(grid[3]) ? '.' : 'o')),
      <minecraft:stone>.withDamage(recipeIndex),
      [[grid[0], grid[1]], [grid[2], grid[3]]],
      recipeFunction,
      null
    );
    recipeIndex += 1;
  }
}

function bitCount(value as int) as int {
  var c = 0;
  for i in 0 .. 4 {
    if (hasBit(value, i)) {
      c += 1;
    }
  }
  return c;
}

function hasBit(value as int, bit as int) as bool {
  return (value & pow(2, bit)) != 0;
}