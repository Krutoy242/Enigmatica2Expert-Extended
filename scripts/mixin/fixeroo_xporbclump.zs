#loader mixin
#modloaded xporbclump
// yes, the modid of 'fixeroo' is not 'fixeroo'

import native.java.lang.Math;

#mixin {targets: "surreal.fixeroo.core.FixerooHooks"}
zenClass MixinFixerooHooks {

  #mixin Static
  #mixin Redirect {method: "RenderXPOrb$getSize", at: {value: "INVOKE", target: "Lnet/minecraft/util/math/MathHelper;func_76129_c(F)F"}}
  function reduceXPOrbSize(xpValue as float) as float {
    // xpValue+1, in case xpValue == 0, where log(xpValue) -> error. This "should" never happen, but just in case
    return Math.log(xpValue + 1) as float;
  }
}
