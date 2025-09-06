#modloaded jaopca

// Priority should be lower that utils.zs
#priority 3999

import crafttweaker.item.IItemStack;

val getSomething as function(string,string[],int)IItemStack
= function (oreName as string, entryNames as string[], amount as int) as IItemStack {
  if (isNull(oreName)) return null;

  // Find with JAOPCA
  val JOREoutput = mods.jaopca.JAOPCA.getOre(oreName);
  var something as IItemStack = null;
  if (!isNull(JOREoutput)) {
    var k = 0;
    while k < entryNames.length && isNull(something) {
      something = JOREoutput.getItemStack(entryNames[k]);
      k += 1;
    }
  }

  // Find with Oredict
  if (isNull(something)) {
    for str in entryNames {
      val item = utils.oreToItem(str ~ oreName);
      if (isNull(item)) continue;
      something = item;
      break;
    }
  }

  // Find with smelting
  if (isNull(something) && entryNames has 'any') {
    val oreItems = oreDict['ore' ~ oreName].items;
    if (oreItems.length > 0) {
      something = utils.smelt(oreDict['ore' ~ oreName]);
    }
  }

  return isNull(something) ? null : utils.countOutput(something * amount, oreName);
};

utils.getSomething = getSomething;
