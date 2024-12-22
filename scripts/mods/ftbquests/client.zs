#sideonly client
#reloadable

/*
Send server packed that player used Schematica to complete quest
*/
events.register(function(event as native.net.minecraftforge.client.event.GuiOpenEvent) {
  val gui = event.getGui();
  if(isNull(gui)) return;
  val guiClass = typeof(gui);
  if (guiClass == 'com.github.lunatrius.schematica.client.gui.load.GuiSchematicLoad') {
    mods.zenutils.NetworkHandler.sendToServer("openGuiSchematicLoad");
  }
});
