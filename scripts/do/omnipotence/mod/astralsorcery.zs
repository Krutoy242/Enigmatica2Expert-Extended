#reloadable
#modloaded zenutils astralsorcery

import crafttweaker.player.IPlayer;

scripts.do.omnipotence.op.op.onGrant(function (player as IPlayer) as void {
  if (player.world.remote) return;
  server.commandManager.executeCommandSilent(server, `/astralsorcery research ${player.name} all`);
});
