/*

Add "diversing" recipe that require many different items
and if you provide more diversity in those items you need less of them

*/

#reloadable
#modloaded ctintegration
#priority 2000

import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

function addRecipe(
  recipeName as string,
  E as IItemStack, // Empty, zero-charged base ingredient
  R as IItemStack, // Result item, fully charged
  A as IIngredient // All items that may be used as fuel
) as void {
  // Actual recipe
  recipes.addShaped(recipeName, R, [
    [(E | R.anyDamage()).marked('0'), A.marked('1'), A.marked('2')],
    [A.marked('3'), A.marked('4'), A.marked('5')],
    [A.marked('6'), A.marked('7'), A.marked('8')],
  ],
  function (out, ins, cInfo) {
    val newMap = {} as int[string];
    var length = 0;

    // Add already existing values
    if (!isNull(ins['0'].tag.singularity) && !isNull(ins['0'].tag.singularity.asMap())) {
      for plank, value in ins['0'].tag.singularity.asMap() {
        newMap[plank] = value;
        length += 1;
      }
    }

    // Add new values
    for i in 1 .. 9 {
      val key = ins[i].definition.id ~ ':' ~ ins[i].damage;
      if (isNull(newMap[key])) {
        newMap[key] = 1;
        length += 1;
      }
      else {
        newMap[key] = newMap[key] as int + 1;
      }
    }

    // Calculate power
    val values = intArrayOf(length, 0);
    var i = 0;
    for _, v in newMap { values[i] = v as int; i += 1; }
    val power = getPower(values);

    val ratio = power / R.maxDamage;

    if (ratio >= 1.0) return out;

    // Create new singularity data
    var singularity = !isNull(ins['0'].tag.singularity) ? ins['0'].tag.singularity : {};
    for i, v in newMap { singularity += { [i]: v as int } as IData; }

    return R
      .updateTag({ singularity: singularity })
      .withDamage((1.0 - ratio) * R.maxDamage);
  }, null);
}


function getPower(amountArr as int[]) as double {
  var power = 0.0;
  for v in amountArr { power += v; print('    '~v);}
  var diversePower = 0.0;
  for v in amountArr { diversePower += mods.ctutils.utils.Math.log10(v) / 2; }
  val diverseMult = pow(2.0, diversePower);
  power *= diverseMult;
  return power;
}

function getMapLength(map as IData) as int {
  var length = 0;
  for _ in map.asMap() { length += 1; }
  return length;
}

function getMedian(values as int[]) as int {
  if (values.length == 0) return 0;
  if (values.length == 1) return values[0];
  mods.ctintegration.util.ArrayUtil.sort(values);
  val mid = values.length / 2;
  if (values.length % 2 == 0) return (values[mid - 1] + values[mid]) / 2;
  else return values[mid];
}

function getItemPower(item as IItemStack) as double {
  if (isNull(item.tag.singularity) || isNull(item.tag.singularity.asMap())) return 0.0;
  val length = getMapLength(item.tag.singularity);
  
  var i = 0;
  val amountArr = intArrayOf(length, 0);
  for _, v in item.tag.singularity.asMap() {
    amountArr[i] = v;
    i += 1;
  }

  return getPower(amountArr);
}

function getItemFromString(itemStr as string) as IItemStack {
  val split = itemStr.split(':');
  return itemUtils.getItem(split[0] ~ ':' ~ split[1], split[2] as int);
}

// -------------------------------------------------------------------

events.onPlayerInteractBlock(function (e as crafttweaker.event.PlayerInteractBlockEvent) {
  if (
    isNull(e)
    || isNull(e.player.world)
    || e.player.world.remote
    || isNull(e.item)
    || e.item.definition.id != 'avaritia:singularity'
    || e.item.damage != 4
    || !e.item.hasTag
    || isNull(e.item.tag.singularity)
    || isNull(e.item.tag.singularity.asMap())
  ) return;

  var itemData = [] as IData;
  var values = [] as int[];
  for itemStr, value in e.item.tag.singularity.asMap() {
    val item = getItemFromString(itemStr);
    if (isNull(item)) continue;
    values += value;
    itemData += [{
      text : '',
      extra: scripts.lib.tellraw.item(item * value, 'white', false) + [' '],
    }];
  }

  if (values.length <= 0) return;

  e.player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData([{
    translate: 'e2ee.do.diverse.info',
    with     : [values.length, getMedian(values), { text: '', extra: itemData }],
  }]));
});
