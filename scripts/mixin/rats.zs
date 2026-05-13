#modloaded rats
#loader mixin

import native.com.github.alexthe666.rats.server.items.RatsItemRegistry.RAT_UPGRADE_SPEED;

#mixin { targets: 'com.github.alexthe666.rats.server.entity.EntityRat' }
zenClass MixinEntityRat {
  #mixin ModifyConstant
  #{
  #  method: 'func_70636_d',
  #  constant: [{ intValue: 40 }, { intValue: 99 }]
  #}
  function eatingSpeedUpUpgrade(v as int) as int { return this0.hasUpgrade(RAT_UPGRADE_SPEED) ? v / 20 : v / 4; }

  #mixin ModifyConstant { method: 'tryArcheology', constant: { intValue: 100 } }
  function taskSpeedUpUpgrade0(v as int) as int { return this0.hasUpgrade(RAT_UPGRADE_SPEED) ? v / 20 : v / 4; }

  #mixin ModifyConstant { method: 'tryCooking', constant: { intValue: 100 } }
  function taskSpeedUpUpgrade1(v as int) as int { return this0.hasUpgrade(RAT_UPGRADE_SPEED) ? v / 20 : v / 4; }

  #mixin ModifyConstant { method: 'tryGemcutter', constant: { intValue: 100 } }
  function taskSpeedUpUpgrade2(v as int) as int { return this0.hasUpgrade(RAT_UPGRADE_SPEED) ? v / 20 : v / 4; }

  // #mixin ModifyConstant {method: "tryEnchanting", constant: {intValue: 1000}}
  // function taskSpeedUpUpgrade3(v as int) as int { return this0.hasUpgrade(RAT_UPGRADE_SPEED) ? v/20 : v/4; }
}
