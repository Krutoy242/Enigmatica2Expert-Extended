/**
 * @file Touch portal to see its power
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#modloaded zenutils
#priority -1
#reloadable

import crafttweaker.block.IBlock;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;

import scripts.do.portal_spread.data.getDimsMap;
import scripts.do.portal_spread.data.getPortalDataMap;
import scripts.do.portal_spread.data.portalIdToPos;
import scripts.do.portal_spread.message.sendPortalMessage;
import scripts.do.portal_spread.modifiers.getModifiers;
import scripts.do.portal_spread.utils.indexToRadius;
import scripts.do.portal_spread.utils.abs;

// Dump information about portal
events.onPlayerRightClickBlock(function (e as crafttweaker.event.PlayerInteractBlockEvent) {
  val world as IWorld = e.world;
  if (isNull(world) || world.remote || e.hand != 'MAIN_HAND') return;

  val player as IPlayer = e.player;
  if (isNull(player)) return;

  val currentItem = e.item;
  if (!isNull(currentItem)) return;

  val block as IBlock = world.getBlock(e.x, e.y, e.z);
  if (isNull(block) || block.definition.id != 'minecraft:portal') return;

  for dimId, dimData in getDimsMap(world).asMap() {
    for portalId, portalData in getPortalDataMap(dimData).asMap() {
      val p = portalIdToPos(portalId);
      if (abs(p.x - e.x) > 20 || abs(p.y - e.y) > 20 || abs(p.z - e.z) > 20) continue;
      if (!isInsidePortal(world, p, e.position)) continue;

      val fullPortalId = world.dimension ~ ':' ~ portalId;
      val modifiers = getModifiers(world, fullPortalId, portalData);
      val maxSpreadIndex = scripts.do.portal_spread.modifiers.getMaxSpreadIndex(modifiers);
      val trueDelay = scripts.do.portal_spread.modifiers.getTrueDelay(modifiers);
      val trueLookup = scripts.do.portal_spread.modifiers.getTrueLookup(modifiers);

      if (maxSpreadIndex <= 0 || trueDelay <= 0) {
        sendPortalMessage(player, { translate: 'portal_spread.idle' });
      }
      else {
        sendPortalMessage(player, {
          translate: 'portal_spread.info',
          with     : [
            trueDelay <= 20.0 ? (20.0 / trueDelay) as int : 1,
            trueDelay > 20.0 ? (trueDelay / 20) as int : 1,
            trueLookup as int,
            indexToRadius(maxSpreadIndex),
          ],
        });

        // Reset portal index to startspreading again if stuck
        scripts.do.portal_spread.tick.portalIndexes[fullPortalId] = 1;
      }

      scripts.do.portal_spread.fx.FX.particles(world, e.x, e.y, e.z, e.hitVector, 5);

      return;
    }
  }
});

function isInsidePortal(world as IWorld, p1 as IBlockPos, p2 as IBlockPos) as bool {
  for x in min(p1.x, p2.x) .. max(p1.x, p2.x) {
    for y in min(p1.y, p2.y) .. max(p1.y, p2.y) {
      for z in min(p1.z, p2.z) .. max(p1.z, p2.z) {
        val block = world.getBlock(x, y, z);
        if (isNull(block) || block.definition.id != 'minecraft:portal') return false;
      }
    }
  }
  return true;
}
