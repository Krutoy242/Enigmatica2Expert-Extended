/*

Add "diversing" recipe that require many different items
and if you provide more diversity in those items you need less of them

*/

#reloadable
#priority 2000

import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.recipes.ICraftingInfo;
import crafttweaker.util.Math;

function getRecipeFunction(result as IItemStack, charge as int) as function(IItemStack[string],bool)IItemStack {
  return function (ins as IItemStack[string], considerAmount as bool) as IItemStack {
    if (isNull(ins) || isNull(result)) return null;
    val ins0 = ins['0'];

    // Just skip craft if singularity already fully charged
    if (isNull(ins0) || (ins0.tag?.completed?.asShort() ?? 0 as short) == 1 as short) return null;

    val newMap = {} as int[string];
    var length = 0;

    // Add already existing values
    if (!isNull(ins0.tag.singularity) && !isNull(ins0.tag.singularity.asMap())) {
      for fuel, value in ins0.tag.singularity.asMap() {
        newMap[fuel] = value;
        length += 1;
      }
    }

    // Add new values
    var maxIndex = 0;
    for k,v in ins { if (k as int > maxIndex) maxIndex = k as int; }
    for i in 1 .. (maxIndex + 1) {
      val insi = ins[i];
      if (isNull(insi)) continue; // case for manual func usage
      val amount = considerAmount ? insi.amount : 1;
      val key = insi.definition.id ~ ':' ~ insi.damage;
      if (isNull(newMap[key])) {
        newMap[key] = amount;
        length += 1;
      }
      else {
        newMap[key] = newMap[key] as int + amount;
      }
    }

    // Calculate power
    val values = intArrayOf(length, 0);
    var i = 0;
    for _, v in newMap { values[i] = v as int; i += 1; }
    val power = getPower(values);

    val ratio = power / charge;

    if (ratio >= 1.0) return result.updateTag({ completed: 1 as byte });

    // Create new singularity data
    var singularity = !isNull(ins0.tag.singularity) ? ins0.tag.singularity : {};
    for i, v in newMap { singularity += { [i]: v as int } as IData; }

    val ratioTurned = 1.0 - ratio;
    return result
      .updateTag({ singularity: singularity, charge: (ratio * charge) as int })
      .withDamage(max(1, pow(ratioTurned, 4.0) * result.maxDamage));
  } as function(IItemStack[string],bool)IItemStack;
}

function addRecipe(
  recipeName as string,
  empty as IItemStack, // Empty, zero-charged base ingredient
  result as IItemStack, // Result item, fully charged
  all as IIngredient, // All items that may be used as fuel
  charge as int // Charge required
) as function(IItemStack[string],bool)IItemStack {

  result.anyDamage().addAdvancedTooltip(function (item) {
    if (isNull(item)) return null;
    return game.localize((item.tag?.completed?.asShort() ?? 0 as short) == 1 as short
      ? 'e2ee.do.diverse.complete'
      : 'e2ee.do.diverse.incomplete');
  });
  result.anyDamage().addAdvancedTooltip(function (item) { return scripts.do.charge.chargeTooltip(item); });

  val recipeFunction = getRecipeFunction(result, charge);

  // Actual recipe
  recipes.addShaped(recipeName, result.withTag({completed: 1 as byte}), [
    [(empty | result.anyDamage()).marked('0'), all.marked('1'), all.marked('2')],
    [all.marked('3'), all.marked('4'), all.marked('5')],
    [all.marked('6'), all.marked('7'), all.marked('8')],
  ],
  function (out, ins, cInfo) { return recipeFunction(ins, false); }, null);

  return recipeFunction;
}

function getPower(amountArr as int[]) as double {
  var power = 0.0;
  for v in amountArr { power += v; }
  var diversePower = -1.0;
  for v in amountArr {
    diversePower += Math.log((1.0 - 1.0 / 100) + v as double / 100) + 1;
  }
  val diverseMult = pow(1.3, diversePower);
  power *= diverseMult;
  return power;
}

function getMapLength(map as IData) as int {
  var length = 0;
  for _ in map.asMap() { length += 1; }
  return length;
}

function getItemFromString(itemStr as string) as IItemStack {
  val split = itemStr.split(':');
  return itemUtils.getItem(split[0] ~ ':' ~ split[1], split[2] as int);
}

if (utils.DEBUG) {
  print('### scripts.do.diverse power depending on input:');
  for i in 1 .. 40 {
    val power = getPower(intArrayOf(i, i));
    print('~~power '~i~' items of '~i~' types: '~ power as int);
    // if (power > 30000) break;
  }

  for i in 2 .. 40 {
    val power = getPower(intArrayOf(i, 1));
    print('~~power '~1~' items of '~i~' types: '~ power as int);
    // if (power > 30000) break;
  }

  for i in 2 .. 40 {
    val arr = intArrayOf(i, 1);
    for j in 1 .. i {
      arr[j] = j+1;
    }
    val power = getPower(arr);
    print('~~power 1,2,3..'~i~' items of '~i~' types: '~ power as int);
    // if (power > 30000) break;
  }

  for i in 2 .. 40 {
    val arr = intArrayOf(i, 1);
    arr[0] = i*10;
    val power = getPower(arr);
    print('~~power '~1~' items of '~i~' types + '~i*10~' of single item: '~ power as int);
    // if (power > 30000) break;
  }

  for i in 2 .. 40 {
    val arr = intArrayOf(i, 2);
    arr[0] = i*20;
    val power = getPower(arr);
    print('~~power '~2~' items of '~i~' types + '~i*20~' of single item: '~ power as int);
    // if (power > 30000) break;
  }
}
