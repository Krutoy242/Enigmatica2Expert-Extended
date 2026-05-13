#modloaded voidislandcontrol
#loader mixin
#sideonly client

import native.net.minecraftforge.client.event.GuiOpenEvent;

#mixin { targets: 'com.bartz24.voidislandcontrol.EventHandler' }
zenClass MixinEventHandlerClient {
  #mixin Overwrite
  function onOpenGui(e as GuiOpenEvent) as void {
    // NO-OP: This disables the auto-selecting of the void world type in the GUI.
  }
}
