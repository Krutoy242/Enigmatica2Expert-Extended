/*

Add "charging" recipes that require repetative charging
with other items again and again untill treshold reached

*/

#modloaded zenutils
#reloadable
#priority 2100

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.recipes.IRecipeFunction;

static CHARGE_EXP as double = 1.5; // Exponent of charge
static CHARGE_RED as double = 20.0; // Reduction of charge

/*

Test script

const showArr = (arr)=>arr.map(r=>r.map(n=>String(n|0).padStart(6)).join(',')).join('\n')
const orig = new Array(8).fill(0).map((v,i)=>i+1).map(v=>new Array(8).fill(v*v*v*100).map((v,j)=>(j+1)*v))
console.log('Original:',showArr(orig))
const f = n => Math.max(0, Math.pow(n, 1.5)/20-n)
const summ = (arr)=>arr.map(a=>a.reduce((r,n)=>r+n))
const origSumm = summ(orig)
console.log('Summ and bonus:', origSumm.map((v,i)=>[String(origSumm[i]).padStart(8), f(v) / v].join(' => ')).join('\n'))

*/

function getBonus(v as double) as double {
  return max(0.0, pow(v, CHARGE_EXP) / CHARGE_RED - v) as double;
}

function getCharge(ins as IItemStack[string], getValue as function(IItemStack)double) as double {
  val values = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0] as double[];
  for i in 1 .. 9 {
    values[i - 1] = getValue(ins[i]);
  }

  for i in 0 .. 7 {
    val a = values[i];
    for j in (i + 1) .. 8 {
      if (a == values[j]) return 0.0; // Forbid same values
    }
  }

  var total = 0.0;
  for v in values {
    total += v;
  }

  return total;
}

function chargeTooltip(item as IItemStack) as string {
  if (isNull(item.tag.charge)) return null;
  val value = item.tag.charge.asDouble();
  return mods.zenutils.I18n.format(
    'e2ee.do.charge',
    mods.zenutils.StaticString.format('%,f', [value]).replaceAll('\\.0+$', '').replaceAll(',', '§8,§6')
  );
}

function addRecipe(
  recipeName as string,
  E as IItemStack, // Empty, zero-charged base ingredient
  F as IItemStack, // Filling, intermediate item, partially charged
  R as IItemStack, // Result item, fully charged
  A as IIngredient, // All items that may be used as fuel
  needCharge as double,
  a as IIngredient, // Fake ingredient
  getValue as function(IItemStack)double
) as void {

  F.addAdvancedTooltip(function (item) { return chargeTooltip(item); });

  F.addAdvancedTooltip(function (item) {
    val value = isNull(item.tag.bonus) ? 0.0 : item.tag.bonus.asDouble();
    val s = (value as string).split('\\.');
    return mods.zenutils.I18n.format(
      'e2ee.do.charge.bonus',
      s[0] ~ '§8.' ~ (s.length <= 1 ? '' : s[1].length > 2 ? s[1].substring(0, 2) : s[1])
    );
  });

  // Fake recipe
  recipes.addShaped('fake ' ~ recipeName, R, [[(E | F), a, a], [a, a, a], [a, a, a]]);

  // Actual recipe
  recipes.addHiddenShaped('hidden ' ~ recipeName, R, [
    [(E | F).marked(0), A.marked(1), A.marked(2)],
    [A.marked(3), A.marked(4), A.marked(5)],
    [A.marked(6), A.marked(7), A.marked(8)],
  ],
  function (out, ins, cInfo) {
    return chargeRecipeFunction(ins, F, R, needCharge, getValue);
  }, null);
}

function chargeRecipeFunction(
  ins as IItemStack[string],
  F as IItemStack,
  R as IItemStack,
  needCharge as double,
  getValue as function(IItemStack)double
) as IItemStack {
  val total = getCharge(ins, getValue);
  if (total == 0.0) return null;

  val bonus = getBonus(total);

  // Calculate result
  val charge = D(ins['0'].tag).getDouble('charge', 0.0) + total + bonus;

  return charge >= needCharge ? R :F.updateTag({ charge: charge, bonus: bonus / total });
}
