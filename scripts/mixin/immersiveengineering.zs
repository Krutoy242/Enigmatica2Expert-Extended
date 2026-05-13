#modloaded immersiveengineering
#loader mixin

import native.net.minecraft.entity.IMerchant;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.village.MerchantRecipeList;
import native.java.util.Map;
import native.java.util.Random;
import mixin.CallbackInfo;

#mixin { targets: 'blusunrize.immersiveengineering.common.blocks.metal.TileEntitySilo' }
zenClass MixinTileEntitySilo {
  #mixin Static
  #mixin ModifyConstant { method: '<clinit>', constant: { intValue: 41472 } }
  function buffStorage(value as int) as int {
    return 2000000000;
  }
}

/*
Adding core sample trades consume 1-3 seconds load time.
*/
#mixin { targets: 'blusunrize.immersiveengineering.common.util.IEVillagerHandler$OreveinMapForEmeralds' }
zenClass MixinIEVillagerHandler {
  #mixin Inject { method: 'func_190888_a', at: { value: 'HEAD' }, cancellable: true }
  function skipCoreSampleTrades(merchant as IMerchant, recipeList as MerchantRecipeList, random as Random, ci as CallbackInfo) as void {
    ci.cancel();
  }
}

/*
Attempt to make Liquid Concrete hardening slower.
Not working for some reason.
*/
// #mixin {targets: "blusunrize.immersiveengineering.common.blocks.BlockIEFluidConcrete"}
// zenClass MixinBlockIEFluidConcrete {
//     #mixin ModifyConstant
//     #{
//     #    method: "func_180650_b",
//     #    constant: {intValue: 14, ordinal: 0}
//     #}
//     function slowerHardening(value as int) as int {
//         return value * 2;
//     }
// }

/*
Disable Arc Furnace recycling recipe generation.
In large modpacks IE iterates every tool/armor recipe at init to compute reclaimable
ingots, which takes several seconds and scales with mod count.
By no-op'ing the thread's run() and finishUp() we skip the profiling entirely.
*/
#mixin { targets: 'blusunrize.immersiveengineering.common.crafting.ArcRecyclingThreadHandler' }
zenClass MixinArcRecyclingThreadHandler {
  #mixin Overwrite
  function run() as void {
    // NO-OP: skip expensive recipe profiling
  }

  #mixin Overwrite
  function finishUp() as void {
    // NO-OP: do not inject recycling recipes
  }
}

/*
Expose RecyclingCalculation fields so the debug dump script can read them
without needing access transformers.
*/
#mixin { targets: 'blusunrize.immersiveengineering.common.crafting.ArcRecyclingThreadHandler$RecyclingCalculation' }
zenClass MixinRecyclingCalculation {
  function getOutputs() as Map {
    return this0.outputs;
  }

  function getStack() as ItemStack {
    return this0.stack;
  }
}
