#modloaded zenutils ftblib ftbutilities
#priority 1600
#reloadable

import crafttweaker.data.IData;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import native.net.minecraft.tileentity.TileEntity;
import native.net.minecraft.util.ITickable;
import native.net.minecraft.util.math.BlockPos;

import scripts.do.hand_over_your_items.tellrawItemObj;

zenClass Op {
  zenConstructor() {}
  var reportPlayer     as IPlayer = null;
  var firstDimReported as IWorld = null;
  var total            as int = 0;
}
static op as Op = Op();

events.register(function (e as crafttweaker.event.WorldTickEvent) {
  if (e.world.remote || e.phase != 'END') return;
  if (isNull(op.reportPlayer)) return;

  // Iterate first and all other worlds
  if (isNull(op.firstDimReported) || op.firstDimReported.dimension != e.world.dimension) {
    val total = forEachChunkLoader(e.world, function (te as TileEntity) as void {
      report(op.reportPlayer, e.world, te.getPos());
    });
    op.total += total;
    message(op.reportPlayer, [`§8Dim §7${e.world.dimension}§8 total ticked TileEntities: §7${total}`]);
  }

  // This was a first dim in the list, mark it
  if (isNull(op.firstDimReported)) {
    op.firstDimReported = e.world;
  }
  else if (op.firstDimReported.dimension == e.world.dimension) {
    // We made a loop and can output the results
    message(op.reportPlayer, [
      `§7(Click §6⚑§7 to teleport)`,
      `\n§8Total ticked TileEntities: §7${op.total}`,
    ]);
    op.reportPlayer = null;
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
        .upgradeComponent.getUpgrades(native.mekanism.common.Upgrade.ANCHOR) > 0)
    || (
      te instanceof native.mekanism.common.tile.TileEntityDigitalMiner
      && (te as native.mekanism.common.tile.TileEntityDigitalMiner)
        .upgradeComponent.getUpgrades(native.mekanism.common.Upgrade.ANCHOR) > 0)
    || (
      te instanceof native.mekanism.common.tile.TileEntityTeleporter
      && (te as native.mekanism.common.tile.TileEntityTeleporter)
        .upgradeComponent.getUpgrades(native.mekanism.common.Upgrade.ANCHOR) > 0)
    || (
      te instanceof native.hellfirepvp.astralsorcery.common.tile.TileRitualLink
      && !isNull((te as native.hellfirepvp.astralsorcery.common.tile.TileRitualLink)
        .getLinkedTo()))
    || (
      te instanceof native.sonar.fluxnetworks.common.tileentity.TileFluxCore
      && (te as native.sonar.fluxnetworks.common.tileentity.TileFluxCore).isForcedLoading());
}

function show(player as IPlayer) as IData {
  if (player.world.remote) return null;
  op.reportPlayer = player;
  return ['§8Looking for chunk loading TEs...'];
}

function report(player as IPlayer, world as IWorld, pos as BlockPos) as void {
  val item = scripts.do.portal_spread.utils.blockPosToItem(world, pos);
  val targetText = `§8Dim §7${world.dimension} §8[§4${pos.x} §3${pos.y} §2${pos.z}§8]`;
  message(player, tpMessage(
    world.dimension, pos.x, pos.y, pos.z,
    null,
    [' ', tellrawItemObj(item)]
  ));
}

function message(player as IPlayer, msg as IData) as void {
  // val msgStr = msg.asString();
  // val msgStr = msg.toJson();
  // print('~~ sending message ['~msgStr.length~']:\n'~msgStr);
  player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData(msg));
}

function tpText(dim as int, x as double, y as double, z as double) as string {
  return `§6⚑ §8Dim §7${dim} §8[§4${x} §3${y} §2${z}§8]`;
}

function tpMessage(
  dim as int, x as double, y as double, z as double, text as string,
  extra as IData = null, extraTooltip as IData = null
) as IData {
  val posText = tpText(dim, x, y, z);
  val tpToText = `§8TP to ${posText}`;
  var result = {
    text      : isNull(text) ? posText : text,
    hoverEvent: {
      action: 'show_text',
      value : (isNull(extraTooltip) || extraTooltip.length <= 0)
        ? tpToText as IData
        : [`${tpToText}\n`, extraTooltip],
    },
    clickEvent: {
      action: 'run_command',
      value : `/tpx @p ${x} ${y} ${z} ${dim}`,
    },
  } as IData;
  if (!isNull(extra)) result += {extra: extra};

  return [result];
}
