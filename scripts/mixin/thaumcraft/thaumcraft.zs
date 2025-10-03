#modloaded thaumcraft
#loader mixin

import mixin.CallbackInfo;
import mixin.CallbackInfoReturnable;
import native.java.util.ArrayList;
import native.net.minecraft.item.ItemStack;
import native.net.minecraftforge.event.world.BlockEvent.HarvestDropsEvent;

#mixin {targets: "thaumcraft.common.blocks.misc.BlockFluidDeath"}
zenClass MixinBlockFluidDeath {
    #mixin ModifyArg
    #{
    #    method: "func_180634_a",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lnet/minecraft/entity/Entity;func_70097_a(Lnet/minecraft/util/DamageSource;F)Z"
    #    }
    #}
    function increaseDamage(value as float) as float {
        return value * 5.0f + 15.0f;
    }
}

#mixin {targets: "thaumcraft.common.tiles.devices.TileLampFertility"}
zenClass MixinTileLampFertility {
    #mixin ModifyConstant {method: "updateAnimals", constant: {intValue: 5}}
    function speedUpFluxSelfCleansing(value as int) as int {
        return 1;
    }
}

#mixin {targets: "thaumcraft.common.lib.events.ToolEvents", priority: 1100}
zenClass MixinToolEvents {
    #mixin Static
    #mixin Inject {method: "doRefining", at: {value: "HEAD"}, cancellable: true}
    function doBuffedRefining(event as HarvestDropsEvent, heldItem as ItemStack, ci as CallbackInfo) as void {
        scripts.mixin.thaumcraft.shared.Op.doRefining(event, heldItem);
        ci.cancel();
    }
}
