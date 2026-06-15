#norun // unfinished feature
#modloaded bloodmagic
#reloadable
#priority 500

import mods.zenutils.command.CommandUtils;
import mods.zenutils.command.ZenCommand;
import crafttweaker.data.IData;
import native.WayofTime.bloodmagic.ritual.portal.LocationsHandler;
import native.WayofTime.bloodmagic.teleport.PortalLocation;

function getDimName(dim as int) as string {
  if (dim == 0) return 'Overworld';
  else if (dim == -1) return 'Nether';
  else if (dim == 1) return 'End';
  return `Dim${dim}`;
}

function tpBtn(dim as int, x as double, y as double, z as double, label as string, tooltip as string) as IData {
  return {
    text: label,
    clickEvent: { action: 'run_command', value: `/tpx @p ${x} ${y} ${z} ${dim}` },
    hoverEvent: { action: 'show_text', value: tooltip },
    color: 'dark_aqua',
  };
}

val cmd = ZenCommand.create('bmportals');
cmd.requiredPermissionLevel = 0;
cmd.getCommandUsage = function (sender) {
  return '/bmportals - lists all registered Blood Magic dimensional portals';
};
cmd.execute = function (command, server, sender, args) {
  val player = CommandUtils.getCommandSenderAsPlayer(sender);
  val cache = scripts.do.magic_tp.mixin.shared.Op.portalKeysCache;

  if (isNull(cache) || cache.length == 0) {
    player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData([{
      text: '§e[BM] ',
      extra: [
        { text: '§7No portals in cache. Link a portal first to populate.', color: 'gray' },
        { text: '\n§7Tip: build a BM portal and activate the §fRitual Portal§7 ritual.', color: 'gray' },
      ],
    }]));
    return;
  }

  val handler = LocationsHandler.getLocationsHandler();
  if (isNull(handler)) return;

  var lines = [{
    text: '§e[BM] ',
    extra: [
      { text: `§fRegistered portals (§7${cache.length}§f):`, bold: true },
    ],
  }] as IData;

  for name, _ in cache {
    val linked = handler.getLinkedLocations(name) as [PortalLocation];
    if (isNull(linked)) continue;

    val locCount = linked.length;
    val loc0 = locCount >= 1 ? linked[0] as PortalLocation : null;
    val loc1 = locCount >= 2 ? linked[1] as PortalLocation : null;

    var portalLine = {
      text: `\n§8  §7${name}`,
      hoverEvent: { action: 'show_text', value: locCount == 0 ? '§cNot linked' : `§a${locCount} location(s)` },
    } as IData;

    if (locCount > 0) {
      var locExtra = [
        { text: ` §8- §7${locCount} loc(s)` },
      ] as IData;
      if (!isNull(loc0)) {
        locExtra += [
          { text: `\n§8    [1] ` },
          tpBtn(loc0.getDimension(), loc0.getX() + 0.5, loc0.getY(), loc0.getZ() + 0.5,
            `§7${getDimName(loc0.getDimension())} [${loc0.getX()}, ${loc0.getY()}, ${loc0.getZ()}]`,
            `§8Click to teleport`),
        ] as IData;
      }
      if (!isNull(loc1)) {
        locExtra += [
          { text: `\n§8    [2] ` },
          tpBtn(loc1.getDimension(), loc1.getX() + 0.5, loc1.getY(), loc1.getZ() + 0.5,
            `§7${getDimName(loc1.getDimension())} [${loc1.getX()}, ${loc1.getY()}, ${loc1.getZ()}]`,
            `§8Click to teleport`),
        ] as IData;
      }
      portalLine += { extra: locExtra };
    }

    lines += [portalLine];
  }

  player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData(lines));
};
cmd.register();
