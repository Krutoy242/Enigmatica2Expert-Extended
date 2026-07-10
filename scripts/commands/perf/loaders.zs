#modloaded zenutils ftblib ftbutilities
#priority 1600
#reloadable

import crafttweaker.data.IData;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import mods.zenutils.command.ZenUtilsCommandSender;
import native.net.minecraft.tileentity.TileEntity;
import native.net.minecraft.util.ITickable;
import native.net.minecraft.util.math.BlockPos;

import scripts.do.hand_over_your_items.tellrawItemObj;
import scripts.commands.perf.util.message;
import scripts.commands.perf.util.tpMessage;
import scripts.lib.command.senderAsPlayerOrNull;

zenClass Op {
  zenConstructor() {}
  var reportPlayer     as IPlayer = null;
  var reportSender     as ZenUtilsCommandSender = null;
  var firstDimReported as IWorld = null;
  var total            as int = 0;
}
static op as Op = Op();

events.register(function (e as crafttweaker.event.WorldTickEvent) {
  if (e.world.remote || e.phase != 'END') return;
  if (isNull(op.reportPlayer) && isNull(op.reportSender)) return;

  // Iterate first and all other worlds
  if (isNull(op.firstDimReported) || op.firstDimReported.dimension != e.world.dimension) {
    val total = forEachChunkLoader(e.world, function (te as TileEntity) as void {
      report(op.reportPlayer, op.reportSender, e.world, te.getPos());
    });
    op.total += total;
    val line = `§8Dim §7${e.world.dimension}§8 total ticked TileEntities: §7${total}`;
    if (!isNull(op.reportPlayer)) {
      message(op.reportPlayer, [`${line}`]);
    }
    else {
      print(line);
    }
  }

  // This was a first dim in the list, mark it
  if (isNull(op.firstDimReported)) {
    op.firstDimReported = e.world;
  }
  else if (op.firstDimReported.dimension == e.world.dimension) {
    // We made a loop and can output the results
    if (!isNull(op.reportPlayer)) {
      message(op.reportPlayer, [
        '§7(Click §6⚑§7 to teleport)',
        '\n§8Total ticked TileEntities: §7' ~ op.total,
      ]);
    }
    else {
      print('§8Total ticked TileEntities: §7' ~ op.total);
    }
    op.reportPlayer = null;
    op.reportSender = null;
    op.firstDimReported = null;
    op.total = 0;
  }
});

/**
 * Do for each tile entity
 * @return total amount
 */
function forEachChunkLoader(world as IWorld, callback as function(TileEntity)void) as int {
  var total = 0;
  for te in world.native.loadedTileEntityList {
    if (te.isInvalid()) continue;
    if (isChunkLoader(te)) callback(te);
    if (te instanceof ITickable) total += 1;
  }
  return total;
}

function isChunkLoader(te as TileEntity) as bool {
  // TODO: Fix partially modpack mod count
  // We could use stringified classes to avoid NPE on mod removal
  // But this still wont help for pointers
  // val str = toString(te);
  return te instanceof native.ic2.core.block.machine.tileentity.TileEntityChunkloader
    || te instanceof native.com.rwtema.extrautils2.tile.TileChunkLoader
    || te instanceof native.lumien.randomthings.tileentity.TileEntityEnderAnchor
    || (
      te instanceof native.mekanism.common.tile.TileEntityQuantumEntangloporter
      && (te as native.mekanism.common.tile.TileEntityQuantumEntangloporter)
        .upgradeComponent
        .getUpgrades(native.mekanism.common.Upgrade.ANCHOR) > 0)
    || (
      te instanceof native.mekanism.common.tile.TileEntityDigitalMiner
      && (te as native.mekanism.common.tile.TileEntityDigitalMiner)
        .upgradeComponent
        .getUpgrades(native.mekanism.common.Upgrade.ANCHOR) > 0)
    || (
      te instanceof native.mekanism.common.tile.TileEntityTeleporter
      && (te as native.mekanism.common.tile.TileEntityTeleporter)
        .upgradeComponent
        .getUpgrades(native.mekanism.common.Upgrade.ANCHOR) > 0)
    || (
      te instanceof native.hellfirepvp.astralsorcery.common.tile.TileRitualLink
      && !isNull((te as native.hellfirepvp.astralsorcery.common.tile.TileRitualLink)
        .getLinkedTo()))
    || (
      te instanceof native.sonar.fluxnetworks.common.tileentity.TileFluxCore
      && (te as native.sonar.fluxnetworks.common.tileentity.TileFluxCore).isForcedLoading());
}

function show(sender as ZenUtilsCommandSender) as IData {
  val player = senderAsPlayerOrNull(sender);
  op.reportPlayer = player;
  op.reportSender = sender;
  if (!isNull(player) && player.world.remote) return null;
  if (isNull(player)) {
    print('§8Looking for chunk loading TEs... Results will be printed to crafttweaker.log as they arrive over the next few ticks.');
    sender.sendMessage('§8Looking for chunk loading TEs... Results will be printed to crafttweaker.log as they arrive over the next few ticks.');
    return null;
  }
  return ['§8Looking for chunk loading TEs...'];
}

function report(player as IPlayer, sender as ZenUtilsCommandSender, world as IWorld, pos as BlockPos) as void {
  val item = scripts.do.portal_spread.utils.blockPosToItem(world, pos);
  val targetText = `§8Dim §7${world.dimension} §8[§4${pos.x} §3${pos.y} §2${pos.z}§8]`;
  if (!isNull(player)) {
    message(player, tpMessage(
      world.dimension, pos.x, pos.y, pos.z,
      null,
      [' ', tellrawItemObj(item)]
    ));
  }
  else {
    print(`§8Dim §7${world.dimension} §8[§4${pos.x} §3${pos.y} §2${pos.z}§8]`);
  }
}
