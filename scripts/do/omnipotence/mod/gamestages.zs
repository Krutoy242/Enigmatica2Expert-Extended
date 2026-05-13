#reloadable
#modloaded zenutils gamestages

import crafttweaker.player.IPlayer;

scripts.do.omnipotence.op.op.onGrant(function (player as IPlayer) as void {
  if (player.world.remote) return;
  player.addGameStage('omnipotence');
});

scripts.do.omnipotence.op.op.onRevoke(function (player as IPlayer) as void {
  if (player.world.remote) return;
  player.removeGameStage('omnipotence');
});

scripts.do.omnipotence.op.op.isOmnipotent(function (player as IPlayer) as bool {
  return player.hasGameStage('omnipotence');
});
