#modloaded zenutils
#reloadable

import crafttweaker.world.IWorld;

static messageSended as bool[IWorld] = {};

events.onPlayerLoggedIn(function (e as crafttweaker.event.PlayerLoggedInEvent) {
  val world = e.player.world;
  if (world.remote) return;
  if (!isNull(messageSended[world])) return;
  if (world.dimension != 0) return;
  if (world.worldInfo.worldTotalTime > 3000) return; // Skip worlds already generated before

  if (world.worldType == 'voidworld' || world.worldType == 'void_plustweaks') {
    world.catenation().sleep(20 * 10).then(function (world, ctx) {
      if (!isNull(messageSended[world])) return;
      e.player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromTranslation('e2ee.warn.wrong_world_type'));
      messageSended[world] = true;
    }).start();
  }
});
