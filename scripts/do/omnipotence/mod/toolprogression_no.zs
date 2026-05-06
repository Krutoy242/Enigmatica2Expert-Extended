#modloaded zenutils !toolprogression
#reloadable

import scripts.do.omnipotence.op.op;

events.register(function (e as native.net.minecraftforge.event.entity.player.PlayerEvent.HarvestCheck) {
  val player = e.entityPlayer.wrapper;
  if (isNull(player?.world)) return;
  if (!op.isPlayerOmnipotent(player)) return;
  e.setCanHarvest(true);
});
