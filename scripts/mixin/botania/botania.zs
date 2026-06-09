#modloaded botania
#loader mixin

import mixin.CallbackInfo;
import mixin.CallbackInfoReturnable;
import mixin.Operation;
import native.net.minecraftforge.event.terraingen.DecorateBiomeEvent.Decorate;
import native.vazkii.botania.api.item.IExoflameHeatable;

#mixin { targets: 'vazkii.botania.client.integration.jei.manapool.ManaPoolRecipeWrapper' }
zenClass MixinManaPoolRecipeWrapper {
  #mixin Shadow
  #mixin Final
  var mana as int;

  #mixin Inject { method: 'getTooltipStrings', at: { value: 'HEAD' }, cancellable: true }
  function showManaNumericalValue(mouseX as int, mouseY as int, cir as CallbackInfoReturnable) as void {
    if (mouseX > 20 && mouseX < 125 && mouseY > 50 && mouseY < 54) {
      cir.setReturnValue([mana ~ ' mana'] as [string]);
    }
  }
}

#mixin { targets: 'vazkii.botania.client.integration.jei.runicaltar.RunicAltarRecipeWrapper' }
zenClass MixinRunicAltarRecipeWrapper {
  #mixin Shadow
  #mixin Final
  var manaUsage as int;

  function getTooltipStrings(mouseX as int, mouseY as int) as [string] {
    if (mouseX > 6 && mouseX < 111 && mouseY > 98 && mouseY < 102) {
      return [manaUsage ~ ' mana'];
    }
    return [];
  }
}

#mixin { targets: 'vazkii.botania.common.block.subtile.functional.SubTileOrechidIgnem' }
zenClass MixinSubTileOrechidIgnem {
  #mixin Inject { method: 'canOperate', at: { value: 'HEAD' }, cancellable: true }
  function showManaNumericalValue(cir as CallbackInfoReturnable) as void {
    cir.setReturnValue(true);
  }
}

// Fix crash on fighting Gaia II on server
// https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/344
#mixin { targets: 'vazkii.botania.common.entity.EntityDoppleganger' }
zenClass MixinEntityDoppleganger {
  #mixin Inject
  #{
  #  method: 'func_70636_d',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lvazkii/botania/common/entity/EntityDoppleganger;func_70106_y()V',
  #    shift: 'AFTER'
  #  },
  #  cancellable: true
  #}
  function stopUpdatingEntityWhenNoPlayerNearby(ci as CallbackInfo) as void {
    ci.cancel();
  }
}

#mixin { targets: 'vazkii.botania.common.brew.ModBrews' }
zenClass MixinModBrews {
  #mixin Static
  #mixin ModifyConstant { method: 'initTC', constant: { intValue: 12000 } }
  function increaseDuration(value as int) as int {
    return 1728000;
  }
}

#mixin { targets: 'vazkii.botania.common.core.handler.BiomeDecorationHandler' }
zenClass MixinBiomeDecorationHandler {
  #mixin Static
  #mixin Inject
  #{
  #  method: 'onWorldDecoration',
  #  at: {
  #    value: 'FIELD',
  #    target: 'Lvazkii/botania/common/core/handler/ConfigHandler;mushroomQuantity:I',
  #    opcode: 178
  #  },
  #  cancellable: true
  #}
  function doNotSpawnMushroomsInNoOrganicDimensions(event as Decorate, ci as CallbackInfo) as void {
    val dim = event.world.provider.dimension as int;
    for d in scripts.lib.dim.Op.tagsMap['NO_ORGANIC'] {
      if (d == dim) {
        ci.cancel();
        return;
      }
    }
  }
}

// Boost Exoflame to 10x speed (5x cookTime increment every 2 ticks)
// priority 1 so this applies AFTER MagicultureIntegrations' mixin
#mixin { targets: 'vazkii.botania.common.block.subtile.functional.SubTileExoflame', priority: 1 }
zenClass MixinSubTileExoflame {
  #mixin WrapOperation
  #{
  #  method: 'onUpdate',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lvazkii/botania/api/item/IExoflameHeatable;boostCookTime()V'
  #  }
  #}
  function buffHeatable(heatable as IExoflameHeatable, op as Operation) as void {
    for i in 0 .. 5 {
      op.call(heatable);
    }
  }

  // Replace all int constant 1 with 5 across every method in this class.
  // This safely covers:
  //   - vanilla furnace cookTime +1 -> +5
  //   - MI IHeatableTile.boostCookTimeHeatable(1) -> (5)
  //   - MI IBoostableTile.boostCookTimeBoostable(1) -> (5)
  //   - boolean true assignments (5 is still true in JVM)
  //   - canFurnaceSmelt() boolean returns (5 is still true)
  #mixin ModifyConstant { method: '*', constant: { intValue: 1 } }
  function buffCookTime(value as int) as int {
    return 5;
  }
}

/*
Allow Customization of Loonium mob spawning mechanic
*/
#mixin { targets: 'vazkii.botania.common.block.subtile.functional.SubTileLoonuim' }
zenClass MixinSubTileLoonuim {
  #mixin Inject { method: 'onUpdate', at: { value: 'INVOKE', target: 'Lnet/minecraft/tileentity/TileEntity;func_145831_w()Lnet/minecraft/world/World;', shift: 'BEFORE' }, cancellable: true }
  function afterSuperUpdate(ci as CallbackInfo) as void {
    scripts.mixin.botania.shared.Op.looniumOnUpdate(this0, this0.supertile, this0.lootTable.toString());
    ci.cancel();
  }
}
