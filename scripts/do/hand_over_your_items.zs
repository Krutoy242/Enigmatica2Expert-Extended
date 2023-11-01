/**
 * @file Give items when player right-click other player
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#reloadable

import crafttweaker.player.IPlayer;
import crafttweaker.item.IItemStack;

for lang, entries in {
  en_us: {
    send   : 'You have given %s to %s',
    receive: 'You have been given %s by %s'
  },
  ru_ru: {
    send   : 'Вы передали %s игроку %s',
    receive: 'Вам передали %s от игрока %s'
  },
  zh_cn: {
    send   : '你已经将 %s 交给 %s',
    receive: '你获得了 %s ，来自 %s'
  },
} as string[string][string] {
  for key, value in entries {
    game.setLocalization(lang, 'chat.hand_over_your_items.'~key, value);
  }
}

val MAIN_HAND = crafttweaker.entity.IEntityEquipmentSlot.mainHand();

events.onPlayerInteractEntity(function(event as crafttweaker.event.PlayerInteractEntityEvent){
  var player = event.player;
  if (
    // Fake player not allowed
    player.fake
    // Player must be sneaking
    || !player.isSneaking
    // Player must be holding something
    || !player.hasItemInSlot(MAIN_HAND)
  ) {
    return;
  }
  var target as IPlayer = event.target;
  if (
    // Player must be targeting another player
    !(target instanceof IPlayer)
  ) {
    return;
  }

  // Cancel original interact event on both sides
  event.cancel();

  // Next only server-side actions
  if(event.world.remote) {
    return;
  }

  var item = player.mainHandHeldItem;
  target.give(item);
  player.setItemToSlot(MAIN_HAND, null);

  // Sender message
  utils.tellrawSend(player,
    '{"translate":"chat.hand_over_your_items.send","color":"blue","with":['
      ~utils.tellrawItem(item, 'white')
      ~',{"text":"'~target.name~'","color":"dark_blue"}'
    ~']}'
  );

  // Receiver message
  utils.tellrawSend(target,
    '{"translate":"chat.hand_over_your_items.receive","color":"dark_green","with":['
      ~utils.tellrawItem(item, 'white')
      ~',{"text":"'~player.name~'","color":"green"}'
    ~']}'
  );
});