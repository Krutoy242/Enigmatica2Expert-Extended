#modloaded botania
#loader mixin

import mixin.CallbackInfo;
import mixin.CallbackInfoReturnable;

#mixin {targets: "vazkii.botania.client.integration.jei.manapool.ManaPoolRecipeWrapper"}
zenClass MixinManaPoolRecipeWrapper {

    #mixin Shadow
    #mixin Final
    var mana as int;

    #mixin Inject {method: "getTooltipStrings", at: {value: "HEAD"}, cancellable: true}
    function showManaNumericalValue(mouseX as int, mouseY as int, cir as CallbackInfoReturnable) as void {
        if (mouseX > 20 && mouseX < 125 && mouseY > 50 && mouseY < 54) {
            cir.setReturnValue([mana ~ " mana"] as [string]);
        }
    }
}

#mixin {targets: "vazkii.botania.client.integration.jei.runicaltar.RunicAltarRecipeWrapper"}
zenClass MixinRunicAltarRecipeWrapper {

    #mixin Shadow
    #mixin Final
    var manaUsage as int;

    function getTooltipStrings(mouseX as int, mouseY as int) as [string] {
        if (mouseX > 6 && mouseX < 111 && mouseY > 98 && mouseY < 102) {
            return [manaUsage ~ " mana"] as [string];
        }
        return [] as [string];
    }
}

#mixin {targets: "vazkii.botania.common.block.subtile.functional.SubTileOrechidIgnem"}
zenClass MixinSubTileOrechidIgnem {
    #mixin Inject {method: "canOperate", at: {value: "HEAD"}, cancellable: true}
    function showManaNumericalValue(cir as CallbackInfoReturnable) as void {
        cir.setReturnValue(true);
    }
}

// Fix crash on fighting Gaia II on server
// https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/344
#mixin {targets: "vazkii.botania.common.entity.EntityDoppleganger"}
zenClass MixinEntityDoppleganger {
    #mixin Inject
    #{
    #    method: "func_70636_d",
    #    at: {
    #       value: "INVOKE",
    #       target: "Lvazkii/botania/common/entity/EntityDoppleganger;func_70106_y()V",
    #       shift: "AFTER"
    #    },
    #    cancellable: true
    #}
    function stopUpdatingEntityWhenNoPlayerNearby(ci as CallbackInfo) as void {
        ci.cancel();
    }
}

#mixin {targets: "vazkii.botania.common.brew.ModBrews"}
zenClass MixinModBrews {
    #mixin Static
    #mixin ModifyConstant {method: "initTC", constant: {intValue: 12000}}
    function increaseDuration(value as int) as int {
        return 1728000;
    } 
}
