#modloaded ic2
#priority 1
#reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.item.ITooltipFunction;
import mods.zenutils.StaticString.format;
import crafttweaker.player.IPlayer;
import crafttweaker.util.Math;

// How strong Difficulty effects on resulted cost
static DIFFUCULTY_FACTOR as double = 0.01;

// Minimum item cost multiplier when changed by difficulty
static MIN_COST as double = 0.01;

// Fraction of UU-Matter cost (in mb) that will be added to difficulty
function diffIncrease(uuMbConsumed as double) as double {
  return pow(uuMbConsumed, 0.6) / 1000;
}

/*
Map of difficulty increase with current formula.
Left is amount of mb consumed, right is amount of difficulty added.

new Array(13).fill(0).map((_,i)=>10**(i+1)*0.001).map(v=>`${String(v).replace(/(\...).+/,'$1').padStart(11)} => ${Math.pow(v, 0.6) / 1000}`).join('\n')
       0.01 => 0.00006309573444801933
        0.1 => 0.000251188643150958
          1 => 0.001
         10 => 0.0039810717055349725
        100 => 0.01584893192461113
       1000 => 0.06309573444801932
      10000 => 0.25118864315095796
     100000 => 1
    1000000 => 3.9810717055349714
   10000000 => 15.84893192461113
  100000000 => 63.0957344480193
 1000000000 => 251.1886431509579
10000000000 => 1000

*/

function getCost(item as IItemStack, difficulty as double) as int {
  val cost as double = native.ic2.core.uu.UuGraph.get(item);
  if (cost > 2147483647.0) return 0;
  if (difficulty < 0 || difficulty == 1.0 / DIFFUCULTY_FACTOR) return cost as int;
  return difficultCost(cost, difficulty);
}

function difficultCost(cost as int, difficulty as double) as int {
  return max(1, (Math.max(MIN_COST, DIFFUCULTY_FACTOR * difficulty) * cost) as int);
}

function formatUUCost(cost as int) as string {
  return format('§d%,.2f §dmB UU', 0.01 * cost)
    .replace('.00', '')
    .replace('.', '§5.')
    .replaceAll(',', '§5,§d');
}
