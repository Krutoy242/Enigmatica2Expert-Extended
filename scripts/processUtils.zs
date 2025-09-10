#modloaded mekanism immersiveengineering advancedrocketry
#priority 52
#reloadable

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;

// ////####################################################################
//
// Helpers
//
// ////####################################################################

// Shortcut for itemUtils.getItem (IItemStack only)
function I(id as string, n as int) as IItemStack { return itemUtils.getItem(id, n); }

// Check if exception string contains lookup string, case NOT sensetive
function isException(exceptions as string, machineName as string) as bool {
  if (exceptions == '') return false;
  var exc = exceptions;

  var haveOnly = false;
  val indexOfOnly = exc.indexOf('only:');
  if (indexOfOnly != -1) {
    haveOnly = true;
    exc = exc.substring(indexOfOnly + 5);
  }

  val isHaveName = exc.matches('.*\b'~machineName~'\b.*');

  if (haveOnly) {
    val result = !isHaveName;
    return result;
  }

  var isAfterStrict = false;
  var haveStrict = false;
  val indexOfStrict = exc.indexOf('strict:');
  if (indexOfStrict != -1) {
    haveStrict = true;
    isAfterStrict = exc.substring(indexOfStrict + 7).matches('.*\b'~machineName~'\b.*');
  }

  if (haveStrict) {
    val result = !(isHaveName && isAfterStrict);
    return result;
  }

  return isHaveName;
}

// Check machineName comes after keyword "strict:"
function isStrict(exceptions as string, machineName as string) as bool {
  if (isNull(exceptions)) {
    return false;
  }
  else {
    return exceptions.toLowerCase().matches('.*strict:.*' ~ machineName.toLowerCase() ~ '\b.*');
  }
}

// Safe get for item array
function arrN_item(arr as IItemStack[], n as int = 0) as IItemStack {
  return !isNull(arr) ? (arr.length > n ? arr[n] : null) : null;
}

// Safe get for IIngredient array
function arrN_ingr(arr as IIngredient[], n as int = 0) as IIngredient {
  return !isNull(arr) ? (arr.length > n ? arr[n] : null) : null;
}

// Safe get for IIngredient array
function arrN_liq(arr as ILiquidStack[], n as int = 0) as ILiquidStack {
  return !isNull(arr) ? (arr.length > n ? arr[n] : null) : null;
}

// Safe get for float array
function arrN_float(arr as float[], n as int = 0) as float {
  return !isNull(arr) ? (arr.length > n ? arr[n] : 0) : 0;
}

// Get 0 element of Item Array. If null - return default
function defaultItem0(items as IItemStack[], default as IItemStack) as IItemStack {
  val it = arrN_item(items, 0);
  return !isNull(it) ? it : default;
}

// Get Nth element of float Array. If null or zero - return default
function defaultChanceN(extraChance as float[], n as int, default as float) as float {
  val v = arrN_float(extraChance, n);
  return v != 0 ? v : default;
}

// Get 0 element of float Array. If null or zero - return default
function defaultChance0(extraChance as float[], default as float) as float {
  return defaultChanceN(extraChance, 0, default);
}

// Get 0 element of float Array. If null or zero - return default. Return x100 as int
function defaultChance0_int(extraChance as float[], default as int) as int {
  return (defaultChance0(extraChance, default as float / 100.0f) * 100.0) as int;
}

// Get input/output amount if we have non-whole output amount
function wholesCalc(inputAmount as int, outputAmount as double) as double[string] {
  val whole = outputAmount as int as double;
  val residue = outputAmount - whole;
  val out1 = outputAmount / inputAmount as double;
  if (residue == 0) return { ins: 1.0, outs: whole, out1: out1 };
  val ins = 1.0 / residue;
  val outs = outputAmount * ins;
  return { ins: ins, outs: outs, out1: out1 };
}

// Summ of chances should be equal 1
function normalizeChances(combinedChances as float[]) as float[] {
  var chancesSumm = 0.0f;
  var normalizedChances = [] as float[];
  for ch in combinedChances { chancesSumm += ch; }
  for ch in combinedChances { normalizedChances += ch / chancesSumm; }
  return normalizedChances;
}

// ////####################################################################
//
// Logging functions
//
// ////####################################################################

function warning(machineNameAnyCase as string, inputStr as string, description as string) as string {
  logger.logWarning('process.work: [' ~ machineNameAnyCase ~ '] ' ~ description ~ '  INPUT: ' ~ inputStr);
  return '';
}

function info(machineNameAnyCase as string, inputStr as string, description as string) as string {
  utils.log('process.work: [' ~ machineNameAnyCase ~ '] ' ~ description ~ '  INPUT: ' ~ inputStr);
  return '';
}

// ////####################################################################
//
// Manual recipes
//
// ////####################################################################

function xmlRecipe(filename as string, recipeContent as string) {
  utils.log('Put this recipe in file [' ~ filename ~ '] manually.\n' ~ recipeContent);
}

// ////####################################################################
// EnderIO
// ////####################################################################

function firstDisplayLiq(arr as ILiquidStack[]) as string {
  val it = arrN_liq(arr);
  return isNull(it) ? '' : it.displayName;
}
function firstDisplayItm(arr as IItemStack[]) as string {
  val it = arrN_item(arr);
  return isNull(it) ? '' : it.displayName;
}

function enderioXmlRecipe(
  processName as string,
  inputItems as IIngredient[],
  inputLiquids as ILiquidStack[],
  outputItems as IItemStack[],
  outputLiquids as ILiquidStack[],
  chances as float[]
) as void {
  if (!utils.DEBUG) return;

  val display = (firstDisplayLiq(outputLiquids) ~ firstDisplayItm(outputItems)).replaceAll('"', '');

  var s = '<recipe name="' ~ display ~ '"><' ~ processName ~ ' energy="10000">\n';

  var fl_multiplier = '';
  var it_multiplier = '';

  if (!isNull(arrN_liq(inputLiquids)) && !isNull(arrN_liq(outputLiquids))) {
    val in_f = (arrN_liq(inputLiquids).amount as float) / 1000;
    val out_f = (outputLiquids[0].amount as float) / 1000;
    if (processName == 'fermenting') {
      fl_multiplier = ' multiplier="' ~ in_f / out_f ~ '"';
      it_multiplier = ' multiplier="' ~ in_f / inputItems.length ~ '"';
    }
  }

  if (!isNull(inputItems)) {
    for inIngr in inputItems {
      if (processName == 'fermenting') s ~= '  <inputgroup>\n';
      val eioName = inIngr.commandString.replaceAll('[<>]', '').replaceAll('^ore:| \\* \\d+$', '');
      val amount = (inIngr.amount > 1) ? 'amount="' ~ inIngr.amount ~ '" ' : '';
      s ~= '    <input name="' ~ eioName ~ '" ' ~ amount ~ it_multiplier ~ ' />\n';
      if (processName == 'fermenting') s ~= '  </inputgroup>\n';
    }
  }

  if (!isNull(outputItems)) {
    for ii in outputItems {
      if (ii.items.length > 0) {
        val out_it = ii.items[0];
        val amount = (ii.amount > 1) ? 'amount="' ~ ii.amount ~ '" ' : '';
        s ~= '  <output name="' ~ out_it.definition.id ~ (out_it.damage != 0 ? (':' ~ out_it.damage) : '') ~ '" ' ~ amount ~ '/>\n';
      }
    }
  }

  if (!isNull(arrN_liq(inputLiquids)) && !isNull(arrN_liq(outputLiquids))) {
    s ~= '  <inputfluid name="' ~ inputLiquids[0].name ~ '"' ~ fl_multiplier ~ ' />\n';
    s ~= '  <outputfluid name="' ~ outputLiquids[0].name ~ '" />';
  }

  s ~= '</' ~ processName ~ '></recipe>';

  xmlRecipe('./config/enderio/recipes/user/user_recipes.xml', s);
}

// ////####################################################################
// Advanced Rocketry
// ////####################################################################
static fluidMaxInput as int[string] = {
  PrecisionAssembler: 32000,
} as int[string];

function avdRockXmlRecipeFlatten(
  filename as string,
  output as IItemStack,
  ingredients as IIngredient[][],
  fluidInput as ILiquidStack = null,
  box as IItemStack = null,
  altMaxMult as int = 64
) as void {
  // How much we reduce ingredients count
  val devider = 2.0;

  // Flatten ingredients
  var ingrs = [] as IIngredient[];
  var countRaw = [] as int[];
  var maxStackSize = altMaxMult;

  // Clamp max fluid size to 16 buckets
  if (!isNull(fluidInput)) maxStackSize = min(
    (!isNull(fluidMaxInput[filename]) ? fluidMaxInput[filename] as int : 16000)
    / fluidInput.amount,
    maxStackSize
  );

  // Iterate the grid
  for y, row in ingredients {
    for x, ingr in row {
      if (isNull(ingr)) continue;

      // Merge if we already have same ingredient
      var merged = false;
      for i, exist in ingrs {
        if (merged) continue;
        if ((exist has ingr) && (ingr has exist)) {
          countRaw[i] = countRaw[i] + ingr.amount;
          merged = true;
        }
      }

      // Push new exist entry
      if (!merged) {
        ingrs += ingr;
        countRaw += ingr.amount;

        // Calculate max stack size for ingredient
        var maxSize = 0;
        for item in ingr.items { maxSize = max(maxSize, item.maxStackSize); }
        // If ingredient have no items in it, its probably late-registered oredict
        if (maxSize != 0) maxStackSize = min(maxStackSize, maxSize);
      }
    }
  }

  // Separately add box item
  if (!isNull(box)) {
    ingrs += (box.damage == 32767 ? box.withDamage(0) : box) as IIngredient;
    countRaw += box.amount;
  }

  // Compute discount
  var count = [] as int[];
  for i, amount in countRaw {
    count += max(1, (amount as double / devider + 0.5) as int);
  }

  // Max stack size of every stack in inputs / outputs
  var maxAmount = output.amount;
  for i, amount in count {
    maxAmount = max(maxAmount, amount);
  }

  // Get multiplier - how many times we can make recipe
  // with even input and output
  val multiplier = min(maxStackSize, max(1, (64.0 / maxAmount as double) as int));

  // Reassemble ingredients with another amount
  var trueIngrs = [] as IIngredient[];
  for i, ingr in ingrs {
    var maxSize = 0;
    for item in ingr.itemArray { maxSize = max(maxSize, item.maxStackSize); }
    // Set amount. Note that item amount could not be more than max item stack size
    // This is useful for boxes
    trueIngrs += ingr * min(maxSize == 0 ? 64 : maxSize, count[i] * multiplier);
  }

  val builder = mods.advancedrocketry.RecipeTweaker.forMachine(filename).builder();
  for ingr in trueIngrs { builder.input(ingr); }
  if (!isNull(fluidInput)) builder.input(fluidInput * (fluidInput.amount * multiplier));
  builder.outputs(output * (output.amount * multiplier));
  builder
    .power(20000 * multiplier)
    .timeRequired(5 * multiplier)
    .build();
}
