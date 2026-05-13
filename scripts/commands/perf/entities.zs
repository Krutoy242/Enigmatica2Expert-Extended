#modloaded zenutils ftblib ftbutilities
#priority 1500
#reloadable

import crafttweaker.data.IData;
import crafttweaker.player.IPlayer;
import crafttweaker.util.Math.floor;
import native.net.minecraft.entity.item.EntityItem;
import native.net.minecraft.world.World;

import scripts.commands.perf.util.tpMessage;

function show(player as IPlayer) as IData {
  var totalEntities = 0;
  var result = [`§8[DimID]: [§3entity count§8]/[§7entity item§8] [█ bad chunks]:`] as IData;
  for i, world in server.native.worlds as World[] {
    val chunkMap = {} as int[string];
    var entitiesInThisWorld = 0;
    var entityItems = 0;
    for entity in world.loadedEntityList {
      entitiesInThisWorld += 1;
      val chunkX = floor(entity.posX / 16);
      val chunkZ = floor(entity.posZ / 16);
      val chunkId = chunkX ~ ':' ~ chunkZ;
      if (isNull(chunkMap[chunkId])) chunkMap[chunkId] = 0;
      chunkMap[chunkId] = chunkMap[chunkId] + 1;
      if (entity instanceof EntityItem) entityItems += 1;
    }
    if (entitiesInThisWorld <= 0) continue;

    totalEntities += entitiesInThisWorld;
    result += [`\n§8Dim ${world.wrapper.dimension}: §3${entitiesInThisWorld}§8/§7${entityItems}`];

    var j = 0;
    var s = [] as IData;
    for chunkId, amount in chunkMap {
      if (amount >= 50) {
        val splitted = chunkId.split(':');
        val x = splitted[0] as int;
        val z = splitted[1] as int;
        s += tpMessage(world.wrapper.dimension,
          8.5 + x * 16, floor(player.y), 8.5 + z * 16, '█', null, `§7Entities in this chunk: ${amount}`);
      }
      j += 1;
    }
    if (s.length > 0) result += [' '] as IData + s;
  }

  result += [`\n§7Total Entities: §3${totalEntities}`];

  return result;
}
