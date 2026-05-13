#reloadable
#priority 1000
#modloaded zenutils scalinghealth

import crafttweaker.player.IPlayer;
import native.net.silentchaos512.scalinghealth.utils.SHPlayerDataHandler;

scripts.do.omnipotence.op.op.isOmnipotent(function (player as IPlayer) as bool {
  val handler = SHPlayerDataHandler.get(player);
  return !isNull(handler) && handler.difficulty >= 1000;
});

scripts.do.omnipotence.op.op.onGrant(function (player as IPlayer) as void {
  if (player.world.remote) return;
  val handler = SHPlayerDataHandler.get(player);
  if (!isNull(handler)) SHPlayerDataHandler.get(player).difficulty = 1000;
});

scripts.do.omnipotence.op.op.onRevoke(function (player as IPlayer) as void {
  if (player.world.remote) return;
  val handler = SHPlayerDataHandler.get(player);
  if (!isNull(handler)) SHPlayerDataHandler.get(player).difficulty = 0;
});
