/**
 * @file Give items when player right-click other player
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#modloaded zenutils
#priority 3000
#reloadable

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;

events.onPlayerInteractEntity(function (e as crafttweaker.event.PlayerInteractEntityEvent) {
  val player = e.player;
  if (
    // Event already cancelled by other event handlers
    e.canceled
    // Fake player not allowed
    || player.fake
    // Player must be sneaking
    || !player.isSneaking
    // Player must be holding something
    || !player.hasItemInSlot(mainHand)
    // Player must be targeting another player
    || !(e.target instanceof IPlayer)
  ) {
    return;
  }

  // Cancel original interact event on both sides
  e.cancel();
  // Next only server-side actions
  if (e.world.remote) {
    return;
  }

  val target as IPlayer = e.target;
  val item = player.mainHandHeldItem;
  target.give(item);
  player.setItemToSlot(mainHand, null);

  broadcastMsg('send', player, target, item, 'blue', 'dark_blue');
  broadcastMsg('receive', target, player, item, 'dark_green', 'green');
});

function broadcastMsg(langCode as string, sender as IPlayer, receiver as IPlayer, item as IItemStack, col1 as string, col2 as string) as void {
  sender.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData([{
    translate: 'chat.hand_over_your_items.' ~ langCode,
    color    : col1,
    with     : [tellrawItemObj(item, 'white'), {
      text : receiver.name,
      color: col2,
    }],
  }]));
}

function getTranslationKey(item as IItemStack) as string {
  if (item.definition.owner == 'ic2') return item.native.translationKey as string;
  return item.name ~'.name';
}

function tellrawItem(item as IItemStack, color as string = null, showName as bool = true) as IData {
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
          {extra: [(item.hasDisplayName ? item.tag.display.Name : {translate: getTranslationKey(item)})]}
        )
      ]
    }
    + (color ? {color: color} : {}),
  ] as IData;
  return data;
}

function tellrawItemObj(item as IItemStack, color as string = null, showName as bool = true) as IData {
  return {text: '', extra: tellrawItem(item, color, showName)};
}