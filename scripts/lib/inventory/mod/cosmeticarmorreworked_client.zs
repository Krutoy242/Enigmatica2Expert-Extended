// Client accessor for scripts/lib/inventory/mod/cosmeticarmorreworked.zs — reads the
// packet-synced client cache. The plain `getCAStacks` would look for the world save
// folder and NPE whenever the world is not hosted by this game instance.
#modloaded cosmeticarmorreworked
#sideonly client
#priority 3800
#reloadable

import native.lain.mods.cos.api.CosArmorAPI;
import native.lain.mods.cos.api.inventory.CAStacksBase;
import native.net.minecraft.entity.player.EntityPlayer;

val clientGetter as function(EntityPlayer)CAStacksBase = function (player as EntityPlayer) as CAStacksBase {
  val uuid = player.getUniqueID();
  if (isNull(uuid)) return null;

  return CosArmorAPI.getCAStacksClient(uuid);
};
scripts.lib.inventory.mod.cosmeticarmorreworked.stacksGetters.add(clientGetter);
