#modloaded zenrecipereloading
#loader mixin

import native.net.minecraft.util.ResourceLocation;

/*
ZenRecipeReload's RecipeAddition.undo() rebuilds the recipe key as
'crafttweaker:' ~ name, but our scripts/mixin/crafttweaker.zs redirect lets a
recipe name carry its own namespace (e.g. 'integrateddynamics:...') so it can
replace a mod's recipe. On /ct reload the undo then looks up a non-existent
'crafttweaker:mod:name' key, getID returns -1, and ForgeRegistry.markDummy
crashes with BitSet.clear(-1). Split the namespace exactly like apply does so
undo targets the real registry entry.
*/
#mixin { targets: 'youyihj.zenrecipereloading.compat.vanilla.CraftingRecipeCallbacks$RecipeAddition' }
zenClass MixinRecipeAdditionUndo {
  #mixin Redirect { method: 'undo', at: { value: 'NEW', target: 'net/minecraft/util/ResourceLocation' } }
  function modifyResourceLocation(namespace as string, path as string) as ResourceLocation {
    if (path.contains(':')) {
      val parts = path.split(':', 2);
      return ResourceLocation(parts[0], parts[1]);
    }
    return ResourceLocation(namespace, path);
  }
}
