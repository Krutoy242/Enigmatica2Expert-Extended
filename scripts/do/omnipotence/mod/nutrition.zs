#reloadable
#modloaded zenutils nutrition

import crafttweaker.player.IPlayer;

scripts.do.omnipotence.op.op.onTick(function (player as IPlayer) as void {
  if (player.world.remote) return;
  server.commandManager.executeCommandSilent(server, `/nutrition reset ${player.name}`);
});
