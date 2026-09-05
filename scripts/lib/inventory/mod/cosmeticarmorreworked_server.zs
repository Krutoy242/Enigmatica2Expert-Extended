// Dedicated-server accessor for scripts/lib/inventory/mod/cosmeticarmorreworked.zs —
// the client-only `getCAStacksClient` does not exist in the server jar, so the
// save-folder backed `getCAStacks` is the one to use here.
#modloaded cosmeticarmorreworked
#sideonly server
#priority 3800
#reloadable

import native.lain.mods.cos.api.CosArmorAPI;
import native.lain.mods.cos.api.inventory.CAStacksBase;
import native.net.minecraft.entity.player.EntityPlayer;

val serverGetter as function(EntityPlayer)CAStacksBase = function (player as EntityPlayer) as CAStacksBase {
  val uuid = player.getUniqueID();
  if (isNull(uuid)) return null;

  return CosArmorAPI.getCAStacks(uuid);
};
scripts.lib.inventory.mod.cosmeticarmorreworked.stacksGetters.add(serverGetter);
