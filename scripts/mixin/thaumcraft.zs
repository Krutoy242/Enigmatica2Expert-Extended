#modloaded thaumcraft
#loader mixin

import mixin.CallbackInfo;
import mixin.CallbackInfoReturnable;
import native.java.util.ArrayList;
import native.net.minecraft.init.SoundEvents;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.SoundCategory;
import native.net.minecraftforge.event.world.BlockEvent.HarvestDropsEvent;
import native.thaumcraft.common.lib.enchantment.EnumInfusionEnchantment;
import native.thaumcraft.common.lib.utils.Utils;

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

/*
#mixin {targets: "thaumcraft.common.lib.events.ToolEvents"}
zenClass MixinToolEvents {
    #mixin Static
    #mixin Overwrite
    function doRefining(event as HarvestDropsEvent, heldItem as ItemStack) as void {
        val level = EnumInfusionEnchantment.getInfusionEnchantmentLevel(heldItem, EnumInfusionEnchantment.REFINING);
        val chance = 0.5f * level;
        var b = false;

        for i, is in event.drops {        
            val cluster = Utils.findSpecialMiningResult(is, chance, event.world.rand);
            if (!is.isItemEqual(cluster)) {
                if (level >= 3 && event.world.rand.nextFloat() > 1.0f / (level - 1)) {
                    cluster.count = cluster.count * 2;
                }
                (event.drops as ItemStack[])[i] = cluster;
                b = true;
            }
        }

        if (b) {
            event.world.playSound(null, event.getPos(), SoundEvents.ENTITY_EXPERIENCE_ORB_PICKUP, SoundCategory.PLAYERS, 0.2F, 0.7F + event.world.rand.nextFloat() * 0.2F);
        }
    }
}
*/
