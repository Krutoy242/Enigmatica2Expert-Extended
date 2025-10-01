#modloaded zenutils patchouli
#priority -200
#reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;

static SKY_TP_HEIGHT as double = 257.0;
static requiredItem as IItemStack = <patchouli:guide_book>.withTag({ 'patchouli:book': 'patchouli:e2e_e' });
static playersNoted as bool[IPlayer] = {};

events.onPlayerTick(function (e as crafttweaker.event.PlayerTickEvent) {
  val player = e.player;
  if (
    player.world.remote
    || player.world.time % 2 != 0
  ) return;
  
  if (player.dimension == 0
    && player.posY >= SKY_TP_HEIGHT
  ) return tpToSky(player);

  if (player.dimension == 3
    && player.posY <= -100
  ) return tpFromSky(player);
});

function tpToSky(player as IPlayer) as void {
  // Show warning message if player doesnt hold book but only once per server restart
  if (isNull(player.currentItem) || !(requiredItem has player.currentItem)) {
    if (isNull(playersNoted[player])) {
      playersNoted[player] = true;
      player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData([{
        translate: 'e2ee.skyblock.need_item',
        with     : [
          scripts.lib.tellraw.itemObj(requiredItem, 'gold'),
          SKY_TP_HEIGHT as int,
        ] }]));
    }
    return;
  }

  player.addPotionEffect(<potion:minecraft:levitation>.makePotionEffect(600, 0));
  server.commandManager.executeCommandSilent(server,
    '/tpx ' ~ player.name ~ ' ' ~ player.posX ~ ' ' ~ (SKY_TP_HEIGHT - 255.0) ~ ' ' ~ player.posZ ~ ' 3'
  );

  // Show message about staying in skyblock forever
  player.world.catenation().sleep(60).run(function (world, context) {
    if(isNull(player)) return;
    player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromTranslation('e2ee.skyblock.stay_forever'));
  }).start();
}

function tpFromSky(player as IPlayer) as void {
  if (player.hasGameStage('skyblock')) return;
  player.addPotionEffect(<potion:cyclicmagic:potion.slowfall>.makePotionEffect(60, 0));
  server.commandManager.executeCommandSilent(server,
    '/tpx ' ~ player.name ~ ' ' ~ player.posX ~ ' ' ~ (SKY_TP_HEIGHT + 60) ~ ' ' ~ player.posZ ~ ' 0'
  );
}

events.onCommand(function(e as crafttweaker.event.CommandEvent) {
  if(isNull(e.command)
    || (e.command.name != "island")
    || (e.parameters.length == 0)
    || (e.parameters[0] != "create")
    || !(e.commandSender instanceof IPlayer)) {
    return;
  }

  val player as IPlayer = e.commandSender;
  if (player.hasGameStage('skyblock') || player.dimension != 3) return;

  scripts.skyblock.addGameStage.grant(player);
  player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromTranslation('e2ee.skyblock.now_skyblocker'));
});
