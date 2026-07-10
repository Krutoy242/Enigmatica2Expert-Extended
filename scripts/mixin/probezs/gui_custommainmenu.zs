#modloaded probezs custommainmenu
#loader mixin
#sideonly client

// ── Auto-join a world at boot (Custom Main Menu's replacement screen) ──
// Custom Main Menu swaps GuiMainMenu for its own GuiCustom before the
// vanilla screen's initGui ever runs, so this is the hook that actually
// fires in the shipped modpack. Kept alongside gui.zs's vanilla hook
// (same Op.tryAutoJoinWorld, guarded against firing twice) in case some
// other code path opens a plain GuiMainMenu instead.
#mixin { targets: 'lumien.custommainmenu.gui.GuiCustom' }
zenClass MixinGuiCustomAutoJoin {
  // initGui
  #mixin Inject { method: 'func_73866_w_', at: { value: 'HEAD' } }
  function onInitGui(ci as mixin.CallbackInfo) as void {
    scripts.mixin.probezs.shared.Op.tryAutoJoinWorld();
  }
}
