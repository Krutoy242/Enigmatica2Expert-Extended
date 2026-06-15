#norun // unfinished feature
#modloaded bloodmagic
#reloadable
#priority 2000

import crafttweaker.player.IPlayer;
import crafttweaker.data.IData;
import native.net.minecraft.entity.Entity;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.util.text.TextComponentString;
import native.net.minecraft.world.World;
import native.WayofTime.bloodmagic.ritual.portal.LocationsHandler;
import native.WayofTime.bloodmagic.teleport.PortalLocation;
import native.WayofTime.bloodmagic.tile.TileDimensionalPortal;

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

scripts.do.magic_tp.mixin.shared.Op.sendPortalMsg
  = function (player as EntityPlayer, msg as string) as void {
    player.sendMessage(TextComponentString('\u00A7e[BM] ' ~ msg));
  };

scripts.do.magic_tp.mixin.shared.Op.cachePortalKey
  = function (name as string) as void {
    val cache = scripts.do.magic_tp.mixin.shared.Op.portalKeysCache;
    if (!isNull(cache) && !(cache has name)) {
      cache[name] = name;
    }
  };

scripts.do.magic_tp.mixin.shared.Op.onPortalCollide
  = function (world as World, pos as BlockPos, entity as Entity) as void {
    if (!(entity instanceof EntityPlayer) || world.isRemote) return;
    val player = entity as EntityPlayer;
    val tile = world.getTileEntity(pos);
    if (!(tile instanceof TileDimensionalPortal)) return;

    val portalTile = tile as TileDimensionalPortal;
    val portalID = portalTile.portalID;
    if (isNull(portalID)) return;

    val handler = LocationsHandler.getLocationsHandler();
    if (isNull(handler)) return;

    val linked = handler.getLinkedLocations(portalID) as [PortalLocation];
    if (isNull(linked)) return;

    val dim = world.provider.dimension;
    val locCount = linked.length;
    val loc0 = locCount >= 1 ? linked[0] as PortalLocation : null;
    val loc1 = locCount >= 2 ? linked[1] as PortalLocation : null;

    val now = world.worldInfo.worldTotalTime;
    val uuid = player.getUniqueID().toString();
    val last = scripts.do.magic_tp.mixin.shared.Op.lastPortalFail[uuid];
    if (isNull(last) || now - last > 100) {
      scripts.do.magic_tp.mixin.shared.Op.lastPortalFail[uuid] = now;

      val active = !isNull(portalID) && portalID.length > 0;
      var extra = [
        { text: `§fPortal ` },
        { text: `§7${portalID}`, color: 'dark_aqua', underlined: true,
          hoverEvent: { action: 'show_text', value: locCount <= 1 ? '§cNo destination' : '§aLinked' } },
        { text: `§f in ` },
        { text: `§7${getDimName(dim)}` },
        { text: `§f, active=§${active ? 'a' : 'c'}${active}§f, linked=§${locCount > 0 ? 'a' : 'c'}${locCount}` },
      ] as IData;

      if (!isNull(loc0)) {
        extra += [
          { text: `\n§8  [1] ` },
          tpBtn(loc0.getDimension(), loc0.getX() + 0.5, loc0.getY(), loc0.getZ() + 0.5,
            `§7${getDimName(loc0.getDimension())} [${loc0.getX()}, ${loc0.getY()}, ${loc0.getZ()}]`,
            `§8Linked portal location`),
        ] as IData;
      }

      if (!isNull(loc1)) {
        extra += [
          { text: `\n§8  [2] ` },
          tpBtn(loc1.getDimension(), loc1.getX() + 0.5, loc1.getY(), loc1.getZ() + 0.5,
            `§7${getDimName(loc1.getDimension())} [${loc1.getX()}, ${loc1.getY()}, ${loc1.getZ()}]`,
            `§8Linked portal location`),
        ] as IData;
      }

      if (locCount <= 1) {
        extra += [
          { text: `\n§8  ! §7no destination found`, color: 'red' },
        ] as IData;
      }

      val iPlayer = player as IPlayer;
      iPlayer.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData([{
        text: '§e[BM] ', extra: extra,
      }]));
    }
  };

scripts.do.magic_tp.mixin.shared.Op.onPortalLinked
  = function (name as string) as void {
    val handler = LocationsHandler.getLocationsHandler();
    if (isNull(handler)) return;

    val linked = handler.getLinkedLocations(name) as [PortalLocation];
    if (isNull(linked) || linked.length != 2) return;

    val player = scripts.do.magic_tp.mixin.shared.Op.currentActivatingPlayer;
    if (isNull(player)) return;

    val loc0 = linked[0] as PortalLocation;
    val loc1 = linked[1] as PortalLocation;
    if (isNull(loc0) || isNull(loc1)) return;

    val iPlayer = player as IPlayer;
    val extra = [
      { text: `§fOther side is ready at:` },
      { text: `\n§8  [Source] ` },
      tpBtn(loc0.getDimension(), loc0.getX() + 0.5, loc0.getY(), loc0.getZ() + 0.5,
        `§7${getDimName(loc0.getDimension())} [${loc0.getX()}, ${loc0.getY()}, ${loc0.getZ()}]`,
        `§8Click to teleport`),
      { text: `\n§8  [Target] ` },
      tpBtn(loc1.getDimension(), loc1.getX() + 0.5, loc1.getY(), loc1.getZ() + 0.5,
        `§7${getDimName(loc1.getDimension())} [${loc1.getX()}, ${loc1.getY()}, ${loc1.getZ()}]`,
        `§8Click to teleport`),
    ] as IData;

    iPlayer.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData([{
      text: '§e[BM] ', extra: extra,
    }]));
  };
