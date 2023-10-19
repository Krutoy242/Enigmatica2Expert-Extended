/**
 * @file Give items when player right-click other player
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#reloadable

import crafttweaker.player.IPlayer;
import crafttweaker.item.IItemStack;

game.setLocalization('en_us', 'chat.handitem.you_have_given'     , 'You have given');
game.setLocalization('en_us', 'chat.handitem.to'                 , 'to');
game.setLocalization('en_us', 'chat.handitem.you_have_been_given', 'You have been given');
game.setLocalization('en_us', 'chat.handitem.by'                 , 'by');

game.setLocalization('ru_ru', 'chat.handitem.you_have_given'     , 'Вы передали');
game.setLocalization('ru_ru', 'chat.handitem.to'                 , 'игроку');
game.setLocalization('ru_ru', 'chat.handitem.you_have_been_given', 'Вам передали');
game.setLocalization('ru_ru', 'chat.handitem.by'                 , 'от игрока');

game.setLocalization('zh_cn', 'chat.handitem.you_have_given'     , '你已经将');
game.setLocalization('zh_cn', 'chat.handitem.to'                 , '交给');
game.setLocalization('zh_cn', 'chat.handitem.you_have_been_given', '你获得了');
game.setLocalization('zh_cn', 'chat.handitem.by'                 , '，来自');

val mainHand = crafttweaker.entity.IEntityEquipmentSlot.mainHand();

events.onPlayerInteractEntity(function(e as crafttweaker.event.PlayerInteractEntityEvent){
  if(
    # Player must be sneaking
    !e.player.isSneaking
    # Player must be targeting another player
    || !e.target instanceof IPlayer
    # Fix https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/280
    || e.player.uuid == "41C82C87-7AfB-4024-BB57-13D2C99CAE77" 
    # See https://github.com/CyclopsMC/IntegratedTunnels/blob/800584c534a7c6a00cd3bc8bc3cf8cb33d7d529e/src/main/java/org/cyclops/integratedtunnels/core/ExtendedFakePlayer.java#L16C2-L16C2
    # Also https://github.com/rwtema/Extra-Utilities-2-Source/blob/9e478a1f48b559c404747c663cbb29bd8acf93d9/1.10.2/src/main/java/com/rwtema/extrautils2/fakeplayer/XUFakePlayer.java#L22
    # But I cannot find Cyclic's UUID for FakePlayer, maybe it uses different apporaches. 
  ) return;

  val item = e.player.getItemInSlot(mainHand);
  if(isNull(item)) return;

  // Cancel event on both sides
  e.cancel();

  // Next only server-side actions
  if(e.world.remote) return;

  e.player.setItemToSlot(mainHand, null);

  val targetPlayer as IPlayer = e.target;
  targetPlayer.give(item);
  // val targetPlayer = e.player;

  // Sender message
  utils.tellrawSend(e.player,
     '{"translate":"chat.handitem.you_have_given","color":"blue"},{"text":" "}'
    ~','~utils.tellrawItem(item, 'white')
    ~',{"text":" "},{"translate":"chat.handitem.to","color":"blue"},{"text":" "}'
    ~',{"text":"'~targetPlayer.name~'","color":"dark_blue"}'
  );

  // Receiver message
  utils.tellrawSend(targetPlayer,
     '{"translate":"chat.handitem.you_have_been_given","color":"dark_green"},{"text":" "}'
    ~','~utils.tellrawItem(item, 'white')
    ~',{"text":" "},{"translate":"chat.handitem.by","color":"dark_green"},{"text":" "}'
    ~',{"text":"'~e.player.name~'","color":"green"}'
  );
});
