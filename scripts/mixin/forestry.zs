#modloaded forestry
#loader mixin

import native.forestry.api.recipes.ISqueezerManager;
import native.forestry.api.recipes.IFermenterRecipe;
import native.forestry.core.config.Config;
import native.net.minecraft.item.ItemStack;
import mixin.CallbackInfoReturnable;

/*
Remove ~1500 [Squeezer] (forestry) capsule recipes,
when forestry cans and capsules filled/squeezed with every liquid in game.
*/
#mixin { targets: 'forestry.core.ModuleFluids' }
zenClass MixinModuleFluids {
  #mixin Redirect
  #{
  #  method: 'doInit',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lforestry/api/recipes/ISqueezerManager;addContainerRecipe(ILnet/minecraft/item/ItemStack;Lnet/minecraft/item/ItemStack;F)V'
  #  }
  #}
  function removeRecipe(manager as ISqueezerManager, timePerItem as int, emptyContainer as ItemStack, remnants as ItemStack, chance as float) as void {
    // NO-OP
  }
}

/*
Remove default no-fermentated recipe flood
for better performance and less HEI junk.
*/
#mixin { targets: 'forestry.factory.recipes.FermenterRecipeManager' }
zenClass MixinFermenterRecipeManager {
  #mixin Inject
  #{
  #  method: 'addRecipe(Lforestry/api/recipes/IFermenterRecipe;)Z',
  #  at: { value: 'HEAD' },
  #  cancellable: true
  #}
  function removeRecipe(recipe as IFermenterRecipe, cir as CallbackInfoReturnable) as void {
    if (recipe.fermentationValue <= 0) {
      cir.setReturnValue(false);
    }
  }
}

#mixin { targets: 'forestry.factory.tiles.TileRaintank' }
zenClass MixinTileRainTank {
  #mixin Static
  #mixin ModifyConstant { method: '<clinit>', constant: { intValue: 10 } }
  function increaseFluidPerOperation(value as int) as int {
    return 500000;
  }

  #mixin ModifyConstant { method: 'dumpFluidBelow', constant: { intValue: 50 } }
  function dumpBelowPerOperation(value as int) as int {
    return 50000;
  }

  #mixin ModifyConstant { method: 'updateServerSide', constant: { intValue: 20 } }
  function descreaseInterval(value as int) as int {
    return 5;
  }

  #mixin ModifyConstant { method: '<init>', constant: { intValue: 30000 } }
  function increaseCapacity(value as int) as int {
    return 500000000;
  }
}

/*
Blaze Tubes rework
Increase speed and power usage
*/
#mixin { targets: 'forestry.factory.ModuleFactory' }
zenClass MixinModuleFactory {
  #mixin ModifyConstant { method: 'doInit', constant: { doubleValue: 0.125 } }
  function increaseSpeedEmeraldTube(value as double) as double { return 1.0; }

  // #mixin ModifyConstant {method: "doInit", constant: {floatValue: 0.05}}
  // function increasePowerEmeraldTube(value as float) as float { return 0.05f; }

  #mixin ModifyConstant { method: 'doInit', constant: { doubleValue: 0.25 } }
  function increaseSpeedBlazeTube(value as double) as double { return 5.0; }

  // #mixin ModifyConstant {method: "doInit", constant: {floatValue: 0.10}}
  // function increasePowerBlazeTube(value as float) as float { return 0.15f; }
}

/*
Fix JEI wood pile recipe showing hardcoded 9 instead of Config.charcoalAmountBase.
When charcoalAmountBase is increased, JEI still showed 9 + wall bonus.
*/
#mixin { targets: 'forestry.arboriculture.charcoal.jei.CharcoalPileWallWrapper' }
zenClass MixinCharcoalPileWallWrapper {
  #mixin ModifyConstant { method: 'getIngredients', constant: { intValue: 9 } }
  function syncCharcoalAmountWithConfig(value as int) as int {
    return Config.charcoalAmountBase;
  }
}

/*
Loonium butterfly loot override (scoop interaction replacement)
*/
#mixin {targets: "forestry.lepidopterology.entities.EntityButterfly"}
zenClass MixinEntityButterfly {
  #mixin Inject {method: "func_184645_a", at: { value: "HEAD" }, cancellable: true}
  function butterflyLooniumDrop(
    player as native.net.minecraft.entity.player.EntityPlayer,
    hand as native.net.minecraft.util.EnumHand,
    ci as mixin.CallbackInfoReturnable
  ) as void {
    val stack = player.getHeldItem(hand);

    if (!(stack.getItem() instanceof native.forestry.api.core.IToolScoop)) return;

    val entity = this0 as native.net.minecraft.entity.Entity;

    if (entity.getEntityData().hasKey("botania:looniumItemStackToDrop")) {
      val cmp = entity.getEntityData().getCompoundTag("botania:looniumItemStackToDrop");
      val item = ItemStack(cmp);

      entity.world.spawnEntity(native.net.minecraft.entity.item.EntityItem(entity.world, entity.posX, entity.posY, entity.posZ, item));

      entity.setDead();

      ci.setReturnValue(true);
      ci.cancel();
    }
  }
}
