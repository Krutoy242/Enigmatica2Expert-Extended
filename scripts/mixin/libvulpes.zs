#modloaded libvulpes
#loader mixin

#mixin { targets: 'zmaster587.libVulpes.LibVulpes' }
zenClass MixinLibVulpes {
  #mixin ModifyConstant { method: '<init>', constant: { floatValue: 1.0, ordinal: 1 } }
  function rebalanceMotor0(value as float) as float { return 4.0f; }

  #mixin ModifyConstant { method: '<init>', constant: { floatValue: 0.6666667 } }
  function rebalanceMotor1(value as float) as float { return 1.0f; }

  #mixin ModifyConstant { method: '<init>', constant: { floatValue: 0.5 } }
  function rebalanceMotor2(value as float) as float { return 0.25f; }

  #mixin ModifyConstant { method: '<init>', constant: { floatValue: 0.25 } }
  function rebalanceMotor3(value as float) as float { return 0.0625f; }
}
