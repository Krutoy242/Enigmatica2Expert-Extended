/**
 * @file Helping functions to store and manipulate Portal Spread saved data
 * 
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#priority 2000

#reloadable
import crafttweaker.data.IData;
import crafttweaker.util.Position3f;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;

import scripts.do.portal_spread.modifiers.getModifiers;
import scripts.do.portal_spread.message.log;

// Convert block position to string
function portalPosToId(blockPos as IBlockPos) as string {
  return blockPos.x~':'~blockPos.y~':'~blockPos.z;
}

// Convert string to block position
function portalIdToPos(portalId as string) as Position3f {
  val p = portalId.split(':');
  return Position3f.create(p[0], p[1], p[2]);
}

/**
 * Set data to specific portal key
 */
function updatePortal(world as IWorld, dimTo as int, pos as IBlockPos, newData as IData = []) as void {
  val portalId = portalPosToId(pos);
  val dimToStr = dimTo as string;
  val oldData = world.getCustomWorldData();
  log('updating protal in dim: §7'~world.dimension~' §8dimTo: §7'~dimTo~' §8portalId: §7'~portalId
    ~'\n§8oldData: §7'~(isNull(oldData.portalSpread) ? '' : oldData.portalSpread.asString())
    ~'\n§8newData: §3'~newData.asString()
  , world);
  world.setCustomWorldData(oldData.deepUpdate({portalSpread: {
    [dimToStr]: {[portalId]: newData}
  }}, mods.zenutils.DataUpdateOperation.MERGE));
}

// Remove portal from CustomWorldData
function removePortal(world as IWorld, dimIdNum as int, portalId as string) as void {
  log('removing portal: §7'~world.dimension~' §8dimIdNum: §7'~dimIdNum~' §8portalId: §7'~portalId, world);
  val dimId = dimIdNum as string;
  val data = world.getCustomWorldData();
  if(isNull(data) || isNull(data.portalSpread) || isNull(data.portalSpread[dimId])) return;
  world.updateCustomWorldData({portalSpread: (
    data.portalSpread - dimId + {[dimId]: data.portalSpread[dimId] - portalId} as IData
  )});
  log('  portal removed.', world);
}

// Get map of {dimTo: { portalId: portalData }}
function getDimsMap(world as IWorld) as IData {
  val data = world.getCustomWorldData();
  if(
    isNull(data)
    || isNull(data.portalSpread)
    || isNull(data.portalSpread.asMap())
  ) return {};
  return data.portalSpread;
}

function getPortalDataMap(dimData as IData) as IData {
  if(isNull(dimData) || isNull(dimData.asMap())) return {};
  return dimData;
}

// Count number of portals in this dimension
function getPortalCount(world as IWorld) as int {
  var portalCount = 0;
  for dimId, dimData in getDimsMap(world).asMap() {
    for portalId, portalData in getPortalDataMap(dimData).asMap() {
      portalCount += 1;
    }
  }
  return portalCount;
}

function serializePortals(world as IWorld) as string {
  var s = '';
  for dimId, dimData in getDimsMap(world).asMap() {
    s += '§7To dim §3'~dimId~'§8:\n';
    for portalId, portalCorners in getPortalDataMap(dimData).asMap() {
      val portalPos = portalIdToPos(portalId);
      val loaded = world.isBlockLoaded(portalPos);
      if(loaded) {
        val portalFullId = world.dimension~':'~portalId;
        val modifiers = getModifiers(world, portalFullId, portalCorners);
        var modStr = '';
        for i in 0 .. modifiers.length {
          if (modifiers[i] > 0) for i in 0 .. modifiers[i] {
            modStr += '§8█';
          }
        }
        s += '§8[§f' ~ portalId.replace(':', '§8:§f') ~ '§8] ' ~ modStr;
      } else {
        s += '§8['~portalId~'] (unloaded)';
      }
      s += '\n';
    }
  }
  return s;
}
