#modloaded probezs
#loader mixin
#sideonly client

import native.net.minecraft.client.Minecraft;
import mixin.CallbackInfo;

/*
Auto-join a world at boot, whatever the main menu happens to be.

setWorldAndResolution is the one method every screen goes through on its way to
initGui, so hooking the vanilla base class covers the vanilla GuiMainMenu, Custom
Main Menu's GuiCustom and any other replacement menu alike — no mod-specific
target, and it keeps working on a reduced mod set where the menu mod is disabled.
Injected at RETURN so the menu is fully built before the world load replaces it.

GUI init always runs on the main client thread, so Op.tryAutoJoinWorld() can call
launchIntegratedServer directly; it fires at most once (Op.autoJoinFired).
*/
#mixin { targets: 'net.minecraft.client.gui.GuiScreen' }
zenClass MixinGuiScreenAutoJoin {
  // setWorldAndResolution
  #mixin Inject { method: 'func_146280_a', at: { value: 'RETURN' } }
  function onSetWorldAndResolution(mc as Minecraft, width as int, height as int, ci as CallbackInfo) as void {
    scripts.mixin.probezs.shared.Op.tryAutoJoinWorld();
  }
}
