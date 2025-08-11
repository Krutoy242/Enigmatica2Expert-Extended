/*

ZenUtils allow to use CT functions inside mixin classes by using this "bridge".

- Native java code can reference static fields of this class inside `#loader mixin`.
- Then inside default `#loader` we can assign new values for the references, using
  more common calls and bracket captures

*/

#loader mixin
#priority 3000
#reloadable

import native.com.mojang.authlib.GameProfile;
import native.net.minecraft.item.ItemStack;

zenClass Op {
  static casesGotItemMsg as function(GameProfile,ItemStack)void;
}
