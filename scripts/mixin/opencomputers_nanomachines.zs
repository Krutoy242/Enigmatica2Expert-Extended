#modloaded opencomputers
#loader mixin

import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.potion.Potion;
import native.li.cil.oc.Settings;

// Parses nanomachine potion whitelist entries that contain a semicolon.
// Entries like "potioncore:reach;10" mean the Reach effect starts at level 10
// and increases by 10 each step (10, 20, 30...).
zenClass PotionStepData {
  static initialized as bool = false;
  // Map of Potion -> step value (e.g. 10 for "potioncore:reach;10")
  static steps as int[Potion] = {} as int[Potion];

  // Called lazily from mixins below. Parses the whitelist once.
  static init as function()void = function () as void {
    if (initialized) return;
    initialized = true;
    val whitelist = Settings.get().nanomachinePotionWhitelist();
    for i in 0 .. whitelist.size() {
      val entry = toString(whitelist.get(i));
      // Look for entries with a semicolon, e.g. "modid:potion;step"
      if (entry.indexOf(';') >= 0) {
        val parts = entry.split(';');
        if (parts.length == 2) {
          val potionName = parts[0] as string;
          val step = parts[1] as int;
          val potion = Potion.getPotionFromResourceLocation(potionName);
          if (potion != null) {
            steps[potion] = step;
          }
        }
      }
    }
  };
}

// Mixin into the companion object of PotionProvider.
// Makes potions with a custom step value eligible even though the raw
// "modid:potion;step" string would fail the normal registry lookup.
#mixin { targets: 'li.cil.oc.common.nanomachines.provider.PotionProvider$' }
zenClass MixinPotionProvider {
  #mixin ModifyReturnValue { method: 'isPotionEligible', at: { value: 'RETURN' } }
  function modifyIsPotionEligible(original as bool, potion as Potion) as bool {
    PotionStepData.init();
    // If OpenComputers already thinks this potion is eligible, keep it.
    if (original) {
      return true;
    }
    // Otherwise, check if we have a custom step for it.
    val step = PotionStepData.steps[potion];
    if (isNull(step)) return false;
    return step > 0;
  }
}

// Mixin into PotionBehavior.
// Changes the amplifier formula from (inputCount - 1) to:
//   (step - 1) + (inputCount - 1) * step
// For step=10 this gives levels: 9, 19, 29... which are displayed as 10, 20, 30...
#mixin { targets: 'li.cil.oc.common.nanomachines.provider.PotionProvider$PotionBehavior' }
zenClass MixinPotionBehavior {
  #mixin ModifyReturnValue { method: 'amplifier', at: { value: 'RETURN' } }
  function modifyAmplifier(original as int, player as EntityPlayer) as int {
    val step = PotionStepData.steps[this0.potion()];
    // If no custom step is defined, fall back to vanilla behavior.
    if (isNull(step) || step <= 0) {
      return original;
    }
    // New formula: start at (step - 1) and increase by step each level.
    return (step - 1) + original * step;
  }
}
