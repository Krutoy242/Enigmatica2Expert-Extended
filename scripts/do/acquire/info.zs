#priority -1800
#reloadable
#modloaded scalinghealth gamestages

import crafttweaker.block.IBlock;
import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import mods.zenutils.StaticString.format;
import mods.zenutils.StaticString.repeat;
import mods.zenutils.StringList;
import scripts.do.acquire.data.sendAcquireMessage;
import scripts.do.hand_over_your_items.tellrawItemObj;

static MAX_SUGGESTED_ITEMS as int = 20;
static playersCompleted as bool[string] = {} as bool[string];

scripts.lib.tooltip.desc.tooltip(<ic2:crystal_memory>, 'acquire.hit');

function show(player as IPlayer, item as IItemStack, block as IBlock) as bool {
  if (
    isNull(player.world)
    || player.world.remote
    || isNull(block)
    || isNull(block.definition)
    || block.definition.id != 'requious:replicator'
  ) return false;

  val encodedItem = scripts.lib.mod.ic2.getCrystalMemoryContent(item);
  if(isNull(encodedItem)) return false;

  val ownerUUID as string = isNull(block.data)
    || isNull(block.data.variables)
    || isNull(block.data.variables.ownerUUID)
    ? null
    : block.data.variables.ownerUUID.asString();

  val sameOwner = isNull(ownerUUID)
    || ownerUUID == ''
    || ownerUUID == player.uuid;

  val dfclty = sameOwner
    ? player.difficulty
    : scripts.lib.offline.op.get(ownerUUID, 'difficulty', 0, 1000);

  // collect all items that cost more than required one
  val requiredCost = scripts.category.uu.getCost(encodedItem, dfclty);
  var strList = StringList.empty();
  val it = native.ic2.core.uu.UuGraph.iterator();
  while (it.hasNext()) {
    val entry = it.next() as native.java.util.Map.Entry;
    val itemNative = entry.key as native.net.minecraft.item.ItemStack;
    val cost = toString(entry.value) as double as int;
    if (cost > requiredCost)
      strList.add(`${repeat('0', 24 - toString(cost).length())}${cost};${itemNative.wrapper.definition.id};${itemNative.wrapper.damage}`);
  }
  val strArr = strList.toArray();
  strArr.sort();

  // Convert item text into actual items with their text
  var textData = [] as IData;
  var k = 0;
  while textData.asList().length < MAX_SUGGESTED_ITEMS && k < strArr.length {
    val a = strArr[k].split(';');
    val item = itemUtils.getItem(a[1], a[2]);
    k += 1;
    if (!isNull(item)) textData += [tellrawItemObj(item, null, false)];
  }
  val itemsDisplayCount = min(MAX_SUGGESTED_ITEMS, textData.asList().length);

  val prefix = [{ translate: 'e2ee.acquire.prefix' }] as IData;
  sendAcquireMessage(player, [
    !sameOwner ? [ { translate: 'e2ee.acquire.owned', with: [
      isNull(block.data)
      || isNull(block.data.variables)
      || isNull(block.data.variables.owner)
      ? { translate: 'e2ee.acquire.owned.someone' }
      : block.data.variables.owner
    ] }, prefix ] : '',
    itemsDisplayCount <= 0
      ? { translate: 'e2ee.acquire.cannot', with: [
          tellrawItemObj(encodedItem, 'white')
        ] }
      : [
        { translate: 'e2ee.acquire.to_replicate', with: [
          tellrawItemObj(encodedItem, 'aqua'),
          formatDfclty(dfclty),
          scripts.category.uu.formatUUCost(requiredCost),
        ]},
        prefix,
        { translate: 'e2ee.acquire.list', with: [
          itemsDisplayCount,
        ] },
        prefix,
        textData,
      ]
  ]);

  playersCompleted[player.uuid] = true;
  return true;
}

events.register(function (e as crafttweaker.event.PlayerRightClickItemEvent) {
  if(show(e.player, e.item, e.block)) e.cancel();
}, mods.zenutils.EventPriority.low());

events.register(function (e as crafttweaker.event.PlayerLeftClickBlockEvent) {
  if(show(e.player, e.item, e.block)) e.cancel();
}, mods.zenutils.EventPriority.low());

function formatDfclty(dfclty as double) as string {
  return format('§6%,.2f§e✪', dfclty)
    .replace('.00', '')
    .replace('.', '§8.')
    .replaceAll(',', '§8,§6');
}
