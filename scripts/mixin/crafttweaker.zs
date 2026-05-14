#modloaded crafttweaker
#loader mixin

import native.net.minecraft.util.ResourceLocation;
import mixin.CallbackInfoReturnable;

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

/*
Change IData formatting rules:
- DataMap: add spaces after { and before }, use single quotes for keys
- DataString: use single quotes instead of double quotes, escaping \ and '
*/

#mixin { targets: 'crafttweaker.api.data.DataMap' }
zenClass MixinDataMap {
  #mixin Overwrite
  function asString() as string {
    var result = '{ ' as string;
    var first = true as bool;
    for entry in this0.data.entrySet {
      if (!first) result = result ~ ', ';
      first = false;
      result ~= (isValidIdentifier(entry.key) ? entry.key : "'" ~ entry.key ~ "'") ~ ': ' ~ toString(entry.value);
    }
    return result ~ ' }';
  }

  function isValidIdentifier(str as string) as bool {
    return str.matches('^[a-zA-Z_$][a-zA-Z0-9_$]*$');
  }
}

#mixin { targets: 'crafttweaker.api.data.DataString' }
zenClass MixinDataString {
  #mixin Overwrite
  function toString() as string {
    val value = this0.value as string;
    var escaped = '' as string;
    for i in 0 .. value.length {
      val c = value.substring(i, i + 1);
      if (c == '\\' || c == "'") escaped = escaped ~ '\\';
      escaped = escaped ~ c;
    }
    return "'" ~ escaped ~ "'";
  }
}

/*
Replace double quotes around recipe names with single quotes
in toCommandString() outputs for Shaped, Shapeless and Wrapper recipes.

Examples:
  recipes.addShaped("name", ...)  ->  recipes.addShaped('name', ...)
  recipes.addShapeless("name", ...) -> recipes.addShapeless('name', ...)
*/
#mixin
#{
#  targets: [
#    'crafttweaker.mc1120.recipes.MCRecipeShaped',
#    'crafttweaker.mc1120.recipes.MCRecipeShapeless',
#    'crafttweaker.mc1120.recipes.MCRecipeWrapper'
#  ]
#}
zenClass MixinRecipeToCommandString {
  #mixin Inject { method: 'toCommandString', at: { value: 'RETURN' }, cancellable: true }
  function fixRecipeQuotes(cir as CallbackInfoReturnable) as void {
    val original = cir.getReturnValue() as string;
    cir.setReturnValue(original.replace('("', "('").replace('", ', "', "));
  }
}
