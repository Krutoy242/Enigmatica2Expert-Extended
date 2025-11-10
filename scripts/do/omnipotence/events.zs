#reloadable
#modloaded zenutils

import crafttweaker.event.PlayerTickEvent;
import crafttweaker.event.PlayerBreakSpeedEvent;
import crafttweaker.event.BlockHarvestDropsEvent;
import crafttweaker.event.PlayerCloneEvent;

val op as scripts.do.omnipotence.op.Op = scripts.do.omnipotence.op.op;

events.register(function (e as PlayerTickEvent) {
  if (e.phase != 'END') return;
  if (e.player.world.provider.worldTime % 10 != 0) return;

  val player = e.player;
  if (op.isPendingOmnipotentce(player))
    op.grant(player);
  else if (op.isPlayerOmnipotent(player))
    op.tick(player);
});

events.register(function (e as PlayerCloneEvent) {
  val player = e.player;
  if (isNull(player) || isNull(player.world) || !op.isPlayerOmnipotent(player)) return;
  op.applyAttributes(player);
});

// ⚡⏱ Speedup block mining
events.register(function (e as PlayerBreakSpeedEvent) {
  val player = e.player;
  if (isNull(player) || isNull(player.world) || isNull(e.block) || isNull(e.block.definition)) return;
  if (!op.isPlayerOmnipotent(player)) return;
  val hardness = e.blockState.getBlockHardness(player.world, e.position);
  e.newSpeed = crafttweaker.util.Math.max(e.originalSpeed, 12.0f * hardness + 1.0);
}, mods.zenutils.EventPriority.low());

// Deprecated:
// Silk touch caused several bugs related to blocks with special drop functions.
// Also it break hand gathering of plants.
//
// // Silk touch on bare hand
// events.register(function (e as BlockHarvestDropsEvent) {
//   val player = e.player;
//   if (
//     isNull(player)
//     || isNull(player.world)
//     || player.world.remote
//     || e.silkTouch
//     || !op.isPlayerOmnipotent(player)
//     || !player.isSneaking
//   ) return;
//
//   if (isNull(player.currentItem)) {
//     // Don't silk touch tile entities with bare hands, it can cause issues.
//     if (e.block.native.hasTileEntity()) return;
//
//     // Silk touch
//     val silkDrop = e.block.native.getSilkTouchDrop(e.blockState);
//     if (!isNull(silkDrop)) {
//       e.drops = [silkDrop.wrapper];
//       e.dropChance = 1;
//     }
//   } else {
//     // TODO: Luck IV for non-empty hand
//   }
// });
