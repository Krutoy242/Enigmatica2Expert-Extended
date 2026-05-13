#reloadable
#modloaded zenutils twilightforest

import crafttweaker.player.IPlayer;
import scripts.do.omnipotence.utils.grantAdvancement;

scripts.do.omnipotence.op.op.onGrant(function (player as IPlayer) as void {
  if (player.world.remote) return;

  grantAdvancement(player, 'twilightforest:magic_map');
  grantAdvancement(player, 'twilightforest:progress_castle discover');
  grantAdvancement(player, 'twilightforest:progress_glacier queen');
  grantAdvancement(player, 'twilightforest:progress_hydra hydra');
  grantAdvancement(player, 'twilightforest:progress_knights previous_progression');
  grantAdvancement(player, 'twilightforest:progress_knights structure');
  grantAdvancement(player, 'twilightforest:progress_labyrinth meef');
  grantAdvancement(player, 'twilightforest:progress_lich kill_lich');
  grantAdvancement(player, 'twilightforest:progress_naga naga');
  grantAdvancement(player, 'twilightforest:progress_thorns discover');
  grantAdvancement(player, 'twilightforest:progress_troll');
  grantAdvancement(player, 'twilightforest:progress_ur_ghast ghast');
  grantAdvancement(player, 'twilightforest:progress_yeti yeti');
});
