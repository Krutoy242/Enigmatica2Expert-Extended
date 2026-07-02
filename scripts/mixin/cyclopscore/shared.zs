/*
Bridge for CyclopsCore cache state.

The mixin (mixin.zs) overwrites isClientSide() to cache the
isModdedEnvironment() result in these static booleans. The bridge is needed
so the mixin doesn't require @Unique fields on the target class.
*/
#loader mixin
#priority 3000

zenClass Op {
  static isModdedCached as bool;
  static isModdedComputed as bool;
}
