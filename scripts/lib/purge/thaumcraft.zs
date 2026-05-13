#modloaded zenutils thaumcraft
#priority 3800
#reloadable

import crafttweaker.item.IItemStack;

scripts.lib.purge.purge.CPurge.purgeAspects = function (item as IItemStack) as void {
  native.thaumcraft.api.ThaumcraftApi.registerObjectTag(item, null);
};
