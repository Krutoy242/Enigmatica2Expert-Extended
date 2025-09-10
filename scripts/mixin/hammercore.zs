#loader mixin
#modloaded hammercore

import native.com.zeitheron.hammercore.utils.java.io.win32.ModSourceAdapter.IllegalSite;
import mixin.CallbackInfo;

// Mixin taken from modpack IsolatedCrystal3
// https://github.com/friendlyhj/IsolatedCrystal3/blob/471f4b8bb163b7fa066d7d6c253f274c51730898/.minecraft/scripts/mixin/hammercore.zs
#mixin {targets: "com.zeitheron.hammercore.utils.java.io.win32.ModSourceAdapter"}
zenClass MixinModSourceAdapter {
  #mixin Shadow
  static ILLEGAL_SITES as [IllegalSite];

  #mixin Static
  #mixin Inject {method: "<clinit>", at: {value: "HEAD"}, cancellable: true}
  function removeWebRequest(ci as CallbackInfo) as void {
    // CurseForge does not require checking mod sources
    // Related: https://github.com/dragon-forge/HammerLib/issues/66
    ILLEGAL_SITES = [] as [IllegalSite];
    ci.cancel();
  }
}
