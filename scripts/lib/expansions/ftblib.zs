#modloaded ftblib
#priority 5000
#reloadable

import crafttweaker.player.IPlayer;

import native.com.feed_the_beast.ftblib.lib.data.Universe;
import native.com.feed_the_beast.ftbutilities.data.FTBUtilitiesPlayerData;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.entity.player.EntityPlayerMP;

$expand IPlayer$nickname() as string {
  val data = getFTBUPlayerData(this);
  if (isNull(data)) return this.name;

  val nickname = data.nickname;
  return nickname.isEmpty() ? this.name : nickname;
}

$expand IPlayer$nicknameChat() as string {
  val data = getFTBUPlayerData(this);
  if (isNull(data)) return this.name;

  val mcPlayer = this.native as EntityPlayerMP;
  return data.getNameForChat(mcPlayer).unformattedText;
}

function getFTBUPlayerData(player as IPlayer) as FTBUtilitiesPlayerData {
  val mcPlayer as EntityPlayer = player.native;
  // Nickname logic is server-side
  if (mcPlayer.world.isRemote) return null;

  val universe = Universe.get();
  if (isNull(universe)) return null;

  val forgePlayer = universe.getPlayer(mcPlayer);
  if (isNull(forgePlayer)) return null;

  return FTBUtilitiesPlayerData.get(forgePlayer);
}
