#modloaded openblocks
#loader mixin
#mixin { targets: 'openblocks.trophy.CreeperBehavior' }
zenClass MixinCreeperBehaviorConst {
  #mixin ModifyConstant { method: 'executeActivateBehavior', constant: { floatValue: 2.0 } }
  function changeCreeperExplosionPower(v as float) as float { return 3.0; }
}