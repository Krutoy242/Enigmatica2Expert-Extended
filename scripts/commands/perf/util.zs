#modloaded zenutils ftblib
#priority 3000
#reloadable

import mods.zenutils.StringList;
import mods.zenutils.StaticString;

/**
 * Naturally sort integer array using serializing function
 * @param fnc must return space-separated string, when last word would be result value
 */
function sortArrayBy(arr as int[], fnc as function(int,int)string) as int[] {
  val list = StringList.empty();
  for i, count in arr {
    list.add(fnc(count, i));
  }
  return sortStrListBy(list, fnc);
}

function sortStrListBy(list as StringList, fnc as function(int,int)string) as int[] {
  val sortedData = list.toArray();
  sortedData.sort();
  sortedData.reverse();

  val result = intArrayOf(sortedData.length, 0);
  for i, line in sortedData {
    val splitted = line.split(' ');
    result[i] = splitted[splitted.length - 1] as int;
  }
  return result;
}

function naturalInt(n as int) as string {
  return StaticString.repeat(0, 10 - (`${n}`).length) ~ n;
}
