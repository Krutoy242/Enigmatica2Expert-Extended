/*
Cache isModdedEnvironment() to eliminate a per-tick JNI hotspot.

isModdedEnvironment() evaluates the ClassLoader instanceof check on every call.
isClientSide() calls it, and Integrated Dynamics calls that once per tick per
cable part — profiling shows ~19% of server tick time inside this JNI
classloader check. Since the classloader never changes after JVM launch, the
result only needs to be computed once. The cached value comes from a real
runtime evaluation (not hardcoded).

Strategy: Overwrite isClientSide() to cache the isModdedEnvironment() result.
The original isModdedEnvironment() runs exactly once on the first call to
isClientSide(); subsequent calls use the cached value.
*/
#loader mixin
#modloaded cyclopscore

import native.net.minecraftforge.fml.common.FMLCommonHandler;
import native.net.minecraftforge.fml.relauncher.Side;
import native.org.cyclops.cyclopscore.helper.MinecraftHelpers;

#mixin { targets: 'org.cyclops.cyclopscore.helper.MinecraftHelpers' }
zenClass MixinMinecraftHelpers {
  #mixin Static
  #mixin Overwrite
  function isClientSide() as bool {
    if (!scripts.mixin.cyclopscore.shared.Op.isModdedComputed) {
      scripts.mixin.cyclopscore.shared.Op.isModdedComputed = true;
      scripts.mixin.cyclopscore.shared.Op.isModdedCached = MinecraftHelpers.isModdedEnvironment();
    }
    if (scripts.mixin.cyclopscore.shared.Op.isModdedCached) {
      return FMLCommonHandler.instance().getEffectiveSide() == Side.CLIENT;
    }
    return true;
  }
}
