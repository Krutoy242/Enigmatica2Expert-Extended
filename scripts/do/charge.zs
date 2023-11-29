/*

Add "charging" recipes that require repetative charging
with other items again and again untill treshold reached

*/

#priority 2000

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

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
  F.addAdvancedTooltip(function(item) {
    val charge = isNull(item.tag.charge) ? 0.0 : item.tag.charge.asDouble();
    return mods.zenutils.I18n.format(
      game.localize("e2ee.do.charge"),
      utils.formatNum(charge, '§8,§6')
    );
  });

  val maxBonus = 10.0;
  val factor = pow(1.0 / maxBonus, 1.0 / 28.0) + 0.0000000000000001; // about 0.92

  // Fake recipe
  recipes.addShaped('fake '~recipeName, R, [[(E|F),a,a],[a,a,a],[a,a,a]]);

  // Actual recipe
  recipes.addHiddenShaped('hidden '~recipeName, R, [
    [(E | F).marked('0'),A.marked('1'),A.marked('2')],
    [A.marked('3'),A.marked('4'),A.marked('5')],
    [A.marked('6'),A.marked('7'),A.marked('8')],
  ],
  function(out, ins, cInfo) {
    var total = 0.0d;
    for i in 1 to 9 {
      total += getValue(ins[i]);
    }

    // Calculate bonus.
    var bonus = 1.0d;
    for i in 1 to 8 {
      for j in (i+1) to 9 {
        val a = ins[i];
        val b = ins[j];
        if (getValue(a) == getValue(b)) {
          bonus *= factor;
        }
      }
    }

    // Calculate result
    val charge = D(ins['0'].tag).getDouble('charge', 0.0d) + total * bonus * maxBonus;

    return charge >= needCharge ? R
      : charge > 0
      ? F
        .withLore(["§fLatest efficiency: §b" ~ ((bonus * maxBonus * 100.0) as int) ~ "%"])
        .updateTag({charge: charge})
      : E;
  }, null);
}
