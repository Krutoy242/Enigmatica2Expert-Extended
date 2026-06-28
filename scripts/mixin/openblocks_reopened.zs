/*
  A Creeper explosion power is 3, the default power of the CreeperTrophy explosion is 2.
  This is not enough to convert the Basic Machine Casing, the Steel Casing, or the
  Advanced Machine Casing to obtain machine parts with the "Exploding Blocks" recipes.
  This increases the power of the CreeperTrophy to 3, which is enough. 
*/

#modloaded openblocks
#loader mixin
#mixin { targets: 'openblocks.trophy.CreeperBehavior' }
zenClass MixinCreeperBehaviorConst {
  #mixin ModifyConstant { method: 'executeActivateBehavior', constant: { floatValue: 2.0 } }
  function changeCreeperExplosionPower(v as float) as float { return 3.0; }
}
