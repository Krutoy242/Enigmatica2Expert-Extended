#modloaded extrautils2
#ignoreBracketErrors
#priority 1

import crafttweaker.item.IIngredient;
import crafttweaker.util.Math.max;
import crafttweaker.util.Math.min;
import extrautilities2.Tweaker.IMachineRegistry.getMachine;
import native.net.minecraft.potion.PotionEffect;
import native.net.minecraft.item.ItemStack;
import native.vazkii.botania.api.BotaniaAPI;
import native.vazkii.botania.api.brew.Brew;
import native.vazkii.botania.api.recipe.RecipeBrew;
import native.rustic.common.crafting.Recipes;
import native.rustic.common.crafting.ICondenserRecipe;
import mods.ctutils.utils.Math;

function calcLevel(ingredientCount as int, manaCost as int, maxDuration as int, maxAmplifier as int, craftTime as int) as int {
  val ingF = max(0, ingredientCount - 2);
  val costF = Math.log(max(1, manaCost / 2000) as double, 2.0) as int;
  val durF = Math.log(max(1, maxDuration / 72000 + 1) as double, 2.0) as int;
  val ampF = Math.log(max(1, maxAmplifier + 1) as double, 2.0) as int;
  val timeF = Math.log(max(1, craftTime / 100) as double, 2.0) as int;
  var level = ingF + costF + durF + ampF + timeF - 3;
  level = max(0, min(8, level));
  return level;
}

function addPGRecipe(item as IIngredient, level as int) as void {
  if (isNull(item)) return;
  val rft = 100 * (level + 1);
  val t = 100 * Math.exp(level as double, 2.0) as int;
  getMachine('extrautils2:generator_potion').addRecipe({ 'input': item }, {}, min(t as long * rft, 2000000000l) as int, t);
  if (utils.DEBUG) print('PG: added Lv' ~ level ~ ' ' ~ rft ~ 'RF/t ' ~ t ~ 't');
}

// ========== Botania brew vials ==========

if (!isNull(<botania:brewvial>)) {
  val brewMap = BotaniaAPI.brewMap as Brew[string];
  val brewRecipes = BotaniaAPI.brewRecipes as [RecipeBrew];
  val baseVial = <botania:brewvial>;
  var brewCount = 0;

  for brewKey_str, brew_item in brewMap {
    val key = brewKey_str as string;
    val brew = brew_item as Brew;
    val manaCost = brew.manaCost;
    val ctStack = baseVial.withTag({ brewKey: key });
    val nativeStack = ctStack.native as ItemStack;
    val effects = brew.getPotionEffects(nativeStack) as [PotionEffect];

    var maxDuration = 0;
    var maxAmplifier = 0;
    for _ef in effects {
      val ef = _ef as PotionEffect;
      if (ef.getDuration() > maxDuration) maxDuration = ef.getDuration();
      if (ef.getAmplifier() > maxAmplifier) maxAmplifier = ef.getAmplifier();
    }

    var ingredientCount = 3;
    for _r in brewRecipes {
      val recipe = _r as RecipeBrew;
      if (recipe.getBrew().getKey() == key) {
        ingredientCount = max(ingredientCount, recipe.getInputs().length);
      }
    }

    val level = calcLevel(ingredientCount, manaCost, maxDuration, maxAmplifier, 20);
    addPGRecipe(ctStack, level);
    if (utils.DEBUG) print('PG Bot: [' ~ key ~ '] mana=' ~ manaCost ~ ' ing=' ~ ingredientCount ~ ' dur=' ~ maxDuration ~ ' amp=' ~ maxAmplifier ~ ' Lv=' ~ level);
    brewCount = brewCount + 1;
  }
  if (utils.DEBUG) print('PG Botania: ' ~ brewCount ~ ' brews registered');
}

// ========== Rustic elixirs ==========

if (!isNull(<rustic:elixir>)) {
  val condRecipes = Recipes.condenserRecipes as [ICondenserRecipe];
  var elixirCount = 0;

  for _c in condRecipes {
    val cond = _c as ICondenserRecipe;
    val output = cond.result;
    val inputCount = cond.inputs.length;
    val craftTime = cond.time;

    if (isNull(output) || isNull(output.tagCompound)) continue;

    var maxDuration = 0;
    var maxAmplifier = 0;
    val effectsList = output.tagCompound.getTagList('ElixirEffects', 10);
    var ei = 0;
    while ei < effectsList.tagCount() {
      val e = effectsList.getCompoundTagAt(ei);
      val dur = e.getInteger('Duration');
      val amp = e.getInteger('Amplifier');
      if (dur > maxDuration) maxDuration = dur;
      if (amp > maxAmplifier) maxAmplifier = amp;
      ei = ei + 1;
    }

    if (maxDuration <= 0) continue;

    val level = calcLevel(inputCount, craftTime * 50, maxDuration, maxAmplifier, craftTime);
    addPGRecipe(output.wrapper, level);
    if (utils.DEBUG) print('PG Rustic: #' ~ elixirCount ~ ' ing=' ~ inputCount ~ ' craftT=' ~ craftTime ~ ' Lv=' ~ level);
    elixirCount = elixirCount + 1;
  }

  if (utils.DEBUG) print('PG Rustic: processed ' ~ elixirCount ~ ' elixir recipes');
}
