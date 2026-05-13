#modloaded crafttweaker
#loader mixin

import native.net.minecraft.util.ResourceLocation;

/*

Remove restrictions to recipe names content ':'
This would allow to create recipes that replace other ones

*/
#mixin { targets: 'crafttweaker.mc1120.recipes.MCRecipeManager' }
zenClass MixinMCRecipeManager {
  #mixin Static
  #mixin Overwrite
  function cleanRecipeName(s as string) as string {
    val index = s.indexOf(':');
    if (index == -1) return s;
    return s.substring(0, index) ~ ':'
    ~ s.substring(index + 1).replace(':', '_');
  }
}

#mixin { targets: 'crafttweaker.mc1120.recipes.MCRecipeManager$ActionBaseAddRecipe' }
zenClass MixinActionBaseAddRecipe {
  #mixin Redirect { method: 'apply', at: { value: 'NEW', target: 'net/minecraft/util/ResourceLocation' } }
  function modifyResourceLocation(namespace as string, path as string) as ResourceLocation {
    if (path.contains(':')) {
      val parts = path.split(':', 2);
      return ResourceLocation(parts[0], parts[1]);
    }
    return ResourceLocation(namespace, path);
  }
}
