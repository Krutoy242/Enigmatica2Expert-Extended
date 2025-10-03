#priority 4000
#reloadable
#modloaded zenutils

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;

function item(item as IItemStack, color as string = null, showName as bool = true) as IData {
  val data = [
    {
      text: item.amount > 1 ? item.amount ~'x' : '',
      hoverEvent: {
        action: 'show_item',
        value: item.toSNBT(),
      },
      extra: [
        {
          // The major part of `iconQuark` is actually 3 spaces, which are reserved for Quark item rendering
          // So you needs Quark to get the icon
          text: '§f   '
        } + (!showName ? {} :
          {extra: [(item.hasDisplayName ? item.tag.display.Name : {translate: item.name ~'.name'})]}
        )
      ]
    }
    + (color ? {color: color} : {}),
  ] as IData;
  return data;
}

function itemObj(item as IItemStack, color as string = null, showName as bool = true) as IData {
  return {text: '', extra: scripts.lib.tellraw.item(item, color, showName)};
}
