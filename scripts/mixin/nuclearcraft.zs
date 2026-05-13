#modloaded nuclearcraft
#loader mixin

// Makes Molten Tough Alloy match new ingot's colors
#mixin { targets: 'nc.init.NCFluids' }
zenClass MixinNCFluids {
  #mixin Static
  #mixin ModifyConstant { method: 'init', constant: { intValue: 1380129 } }
  function changeToughAlloyColor(value as int) as int {
    return 0x271841;
  }
}

#mixin { targets: 'nc.integration.tconstruct.TConstructMaterials' }
zenClass MixinTConstructMaterials {
  #mixin Static
  #mixin ModifyConstant { method: 'init', constant: { intValue: 1380129 } }
  function changeToughAlloyColor(value as int) as int {
    return 0x271841;
  }
}
