#modloaded extrautils2 bloodmagic
#loader bloodmagic_potion
#ignoreBracketErrors

import crafttweaker.item.IIngredient;
import crafttweaker.util.Math.max;
import crafttweaker.util.Math.min;
import extrautilities2.Tweaker.IMachineRegistry.getMachine;
import native.WayofTime.bloodmagic.core.registry.AlchemyTableRecipeRegistry;
import native.WayofTime.bloodmagic.recipe.alchemyTable.AlchemyTableRecipe;
import native.WayofTime.bloodmagic.recipe.alchemyTable.AlchemyTablePotionRecipe;
import native.net.minecraft.item.ItemStack;
import mods.ctutils.utils.Math;

function addPGRecipe(item as IIngredient, level as int) as void {
  if (isNull(item)) return;
  val rft = 100 * (level + 1);
  val t = 100 * Math.exp(level as double, 2.0) as int;
  getMachine('extrautils2:generator_potion').addRecipe({ 'input': item }, {}, min(t as long * rft, 2000000000l) as int, t);
  if (utils.DEBUG) print('PG: added Lv' ~ level ~ ' ' ~ rft ~ 'RF/t ' ~ t ~ 't');
}

function calcLevel(ingredientCount as int, lpCost as int, maxDuration as int, maxAmplifier as int, craftTime as int) as int {
  val ingF = max(0, ingredientCount - 1);
  val costF = Math.log(max(1, lpCost / 100) as double, 2.0) as int;
  val durF = Math.log(max(1, maxDuration / 100 + 1) as double, 2.0) as int;
  val ampF = maxAmplifier;
  val timeF = Math.log(max(1, craftTime / 10 + 1) as double, 2.0) as int;
  var level = ingF + costF + durF + ampF + timeF - 5;
  level = max(0, min(8, level));
  return level;
}

if (!isNull(<bloodmagic:potion_flask>)) {
  val recipeList = AlchemyTableRecipeRegistry.recipeList as [AlchemyTableRecipe];
  var flaskCount = 0;

  if (utils.DEBUG) print('PG BM: recipeList has ' ~ recipeList.length ~ ' entries');

  for _r in recipeList {
    val t = typeof(_r);
    if (!t.startsWith('WayofTime.bloodmagic.recipe.alchemyTable.AlchemyTablePotion')) continue;
    val potionRecipe = _r as AlchemyTablePotionRecipe;
    if (isNull(potionRecipe)) continue;

    val lpCost = potionRecipe.lpDrained;
    val ticks = potionRecipe.ticksRequired;
    val inputLen = potionRecipe.input.length;
    var maxDuration = 0;
    var maxAmplifier = 0;
    val output = potionRecipe.getModifiedFlaskForInput(ItemStack.EMPTY);
    if (isNull(output)) continue;
    if (!isNull(output.tagCompound)) {
      val effectsList = output.tagCompound.getTagList('CustomPotionEffects', 10);
      var ei = 0;
      while ei < effectsList.tagCount() {
        val e = effectsList.getCompoundTagAt(ei);
        val dur = e.getInteger('Duration');
        val amp = e.getByte('Amplifier') as int;
        if (dur > maxDuration) maxDuration = dur;
        if (amp > maxAmplifier) maxAmplifier = amp;
        ei = ei + 1;
      }
    }

    val level = calcLevel(inputLen, lpCost, maxDuration, maxAmplifier, ticks);
    addPGRecipe(output.wrapper, level);
    if (utils.DEBUG) print('PG BM: #' ~ flaskCount ~ ' LP=' ~ lpCost ~ ' t=' ~ ticks ~ ' ing=' ~ inputLen ~ ' Lv=' ~ level);
    flaskCount = flaskCount + 1;
  }

  if (utils.DEBUG) print('PG BM: processed ' ~ flaskCount ~ ' potion recipes');
}
