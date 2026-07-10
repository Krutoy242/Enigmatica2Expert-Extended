#modloaded zenutils ftblib ftbutilities
#priority 1500
#reloadable

import crafttweaker.data.IData;
import crafttweaker.util.Math.floor;
import mods.zenutils.command.ZenUtilsCommandSender;
import native.net.minecraft.entity.item.EntityItem;
import native.net.minecraft.world.World;

import scripts.commands.perf.util.tpMessage;
import scripts.lib.command.senderAsPlayerOrNull;
import scripts.lib.command.richToPlain;

function show(sender as ZenUtilsCommandSender) as IData {
  val player = senderAsPlayerOrNull(sender);
  val isConsole = isNull(player);
  val playerY = isNull(player) ? 0 : floor(player.y);
  var totalEntities = 0;
  var result as IData = [`§8[DimID]: [§3entity count§8]/[§7entity item§8] [█ bad chunks]:`];
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
    val dimLine = `\n§8Dim ${world.wrapper.dimension}: §3${entitiesInThisWorld}§8/§7${entityItems}`;
    result += [dimLine];

    var j = 0;
    var s = [] as IData;
    for chunkId, amount in chunkMap {
      if (amount >= 50) {
        val splitted = chunkId.split(':');
        val x = splitted[0] as int;
        val z = splitted[1] as int;
        s += tpMessage(world.wrapper.dimension,
          8.5 + x * 16, playerY, 8.5 + z * 16, '█', null, `§7Entities in this chunk: ${amount}`);
      }
      j += 1;
    }
    if (s.length > 0) result += [' '] as IData + s;
  }

  val totalLine = `\n§7Total Entities: §3${totalEntities}`;
  result += [totalLine];

  if (isConsole) {
    sender.sendMessage(richToPlain(result));
    return null;
  }
  return result;
}
