/*

Add "diversing" recipe that require many different items
and if you provide more diversity in those items you need less of them

*/

#priority 2000

import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

function addRecipe(
  recipeName as string,
  E as IItemStack, // Empty, zero-charged base ingredient
  F as IItemStack, // Filling, intermediate item, partially charged
  R as IItemStack, // Result item, fully charged
  A as IIngredient, // All items that may be used as fuel
  needPower as double
) as void {
  F.addAdvancedTooltip(function(item) {
    return mods.zenutils.I18n.format(
      game.localize("e2ee.do.diverse.power"),
      utils.formatNum(getFireproofPower(item))
    );
  });

  // Actual recipe
  recipes.addShaped(recipeName, R, [
    [(E | F).marked('0'),A.marked('1'),A.marked('2')],
    [A.marked('3'),A.marked('4'),A.marked('5')],
    [A.marked('6'),A.marked('7'),A.marked('8')],
  ],
  function(out, ins, cInfo) {
    val newMap = {} as int[string];
    var length = 0;

    // Add already existing values
    if(!isNull(ins['0'].tag.singularity) && !isNull(ins['0'].tag.singularity.asMap())) {
      for plank, value in ins['0'].tag.singularity.asMap() {
        newMap[plank] = value;
        length += 1;
      }
    }

    // Add new values
    for i in 1 to 9 {
      val key = ins[i].definition.id ~ ':' ~ ins[i].damage;
      if(isNull(newMap[key])) {
        newMap[key] = 1;
        length += 1;
      } else {
        newMap[key] = newMap[key] as int + 1;
      }
    }

    // Calculate median value
    val values = intArrayOf(length, 0);
    var i = 0;
    for _, v in newMap { values[i] = v as int; i += 1; }
    var median = getMedian(values);

    // Calculate power
    val power = getPower(median, length);

    if(power >= needPower) return out;

    // Create new singularity data
    var singularity = !isNull(ins['0'].tag.singularity) ? ins['0'].tag.singularity : {};
    for i, v in newMap { singularity += {[i]: v as int} as IData; }

    return F.updateTag({singularity: singularity});
  }, null);
}

function getPower(median as double, length as double) as double {
	return (median * pow(2.0, length - 1));
}

function getMapLength(map as IData) as int {
	var length = 0;
	for _ in map.asMap() { length += 1; }
	return length;
}

function getMedian(values as int[]) as int {
	if(values.length == 0) return 0;
	if(values.length == 1) return values[0];
	mods.ctintegration.util.ArrayUtil.sort(values);
  val mid = values.length / 2;
  if (values.length % 2 == 0) return (values[mid - 1] + values[mid]) / 2;
  else return values[mid];
}

function getIntMapMedian(map as IData, length as int) as int {
	if(length <= 0) return 0;
	var i = 0;
	val values = intArrayOf(length, 0);
	for _, value in map.asMap() {
		values[i] = value;
		i += 1;
	}
	return getMedian(values);
}

function getFireproofPower(item as IItemStack) as double {
	if(isNull(item.tag.singularity) || isNull(item.tag.singularity.asMap())) return 0.0;
	val length = getMapLength(item.tag.singularity);
	val median = getIntMapMedian(item.tag.singularity, length);

	return getPower(median, length);
}

// -------------------------------------------------------------------

events.onPlayerInteractBlock(function(e as crafttweaker.event.PlayerInteractBlockEvent) {
  if(
    isNull(e)
    || isNull(e.player.world)
    || e.player.world.remote
    || isNull(e.item)
    || e.item.definition.id != "avaritia:singularity"
		|| e.item.damage != 4
    || !e.item.hasTag
    || isNull(e.item.tag.singularity)
    || isNull(e.item.tag.singularity.asMap())
  ) return;

	var itemData = [] as IData;
	var values = [] as int[];
	for itemStr, value in e.item.tag.singularity.asMap() {
		val split = itemStr.split(':');
		val item = itemUtils.getItem(split[0]~':'~split[1], split[2] as int);
		if (isNull(item)) continue;
		values += value;
		itemData += [{
			text:'',
			extra: scripts.lib.tellraw.item(item * value, 'white', false) + [' ']
		}];
	}

	if(values.length <= 0) return;

	e.player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData([{
    translate: 'e2ee.do.diverse.info',
    with: [values.length, getMedian(values), {text: '', extra: itemData}]
  }]));
});
