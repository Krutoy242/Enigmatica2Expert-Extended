#loader mixin
#modloaded xnet
#sideonly client

import native.net.minecraft.client.Minecraft;
import native.net.minecraft.util.ResourceLocation;

/*
  XNet passes a language-independent manual path to McJtyLib. Select the
  current language each time the GUI opens; McJtyLib falls back to the
  original manual when the language-specific resource is missing.
*/
#mixin { targets: 'mcjty.xnet.items.manual.GuiXNetManual' }
zenClass MixinGuiXNetManual {
  #mixin ModifyArg
  #{
  #  method: 'func_73866_w_',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lmcjty/lib/gui/widgets/TextPage;setText(Lnet/minecraft/util/ResourceLocation;)Lmcjty/lib/gui/widgets/TextPage;'
  #  },
  #  index: 0,
  #  require: 1
  #}
  function localizeManual(original as ResourceLocation) as ResourceLocation {
    val language = Minecraft.getMinecraft().getLanguageManager().getCurrentLanguage().getLanguageCode();
    return ResourceLocation('xnet', 'text/manual_xnet-' ~ language ~ '.txt');
  }
}
