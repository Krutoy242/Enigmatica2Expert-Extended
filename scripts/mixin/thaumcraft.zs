#modloaded thaumcraft
#loader mixin

import mixin.CallbackInfo;
import mixin.CallbackInfoReturnable;
import native.java.util.ArrayList;
import native.net.minecraft.init.SoundEvents;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.SoundCategory;
import native.net.minecraft.util.NonNullList;
import native.net.minecraft.world.DimensionType;
import native.net.minecraft.world.WorldProvider;
import native.net.minecraftforge.event.world.BlockEvent.HarvestDropsEvent;
import native.thaumcraft.api.golems.parts.GolemMaterial;
import native.thaumcraft.common.lib.enchantment.EnumInfusionEnchantment;
import native.thaumcraft.common.lib.events.ToolEvents;
import native.thaumcraft.common.lib.utils.Utils;
import native.net.minecraftforge.oredict.OreDictionary;
import native.net.minecraft.util.text.TextComponentString;

#mixin {targets: "thaumcraft.common.lib.crafting.ThaumcraftCraftingManager"}
zenClass MixinThaumcraftCraftingManager {
    #mixin Static
    #mixin Inject {method: "generateTagsFromRecipes", at: {value: "HEAD"}, cancellable: true}
    function skipGenerateAspectsFromRecipes(stack as ItemStack, history as ArrayList, cir as CallbackInfoReturnable) as void {
        cir.cancel();
    }
}

#mixin {targets: "thaumcraft.api.golems.parts.GolemMaterial"}
zenClass MixinGolemMaterial {
    #mixin Static
    #mixin Inject {method: "register", at: {value: "HEAD"}}
    function buffStats(material as GolemMaterial, ci as CallbackInfo) as void {
        material.healthMod = material.healthMod * 20;
        material.armor = material.armor * material.armor / 2 + material.armor;
        material.damage = material.damage * material.damage / 2 + material.damage;
    }
}

/*
Buff [Porous Stone] output
Before this change, [Porous Stone] dropped something not [Gravel] with 7% chance. Each `Fortune` level increased this chance for about 1%.
Now, base chance is 20% and each `Fortune` level increasing it for about 20%.

Default beneficial drop formula:
nextInt(15) + fortune > 13
*/
#mixin {targets: "thaumcraft.common.blocks.basic.BlockStonePorous"}
zenClass MixinBlockStonePorous {
    #mixin ModifyConstant {method: "getDrops", constant: {intValue: 15}}
    function modifyDropCount0(value as int) as int {
        return 5;
    }

    #mixin ModifyConstant {method: "getDrops", constant: {intValue: 13}}
    function modifyDropCount1(value as int) as int {
        return 3;
    }
}

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

#mixin {targets: "thaumcraft.common.entities.monster.EntityPech"}
zenClass MixinEntityPech {
    #mixin ModifyConstant {method: "getValue", constant: {intValue: 32}}
    function buffMaxDesireBuyValue0(value as int) as int {
        return 256;
    }

    #mixin ModifyConstant {method: "getValue", constant: {intValue: 2}}
    function buffMaxDesireBuyValue1(value as int) as int {
        return 4;
    }
}

#mixin {targets: "thaumcraft.common.tiles.crafting.TileThaumatoriumTop"}
zenClass MixinTileThaumatoriumTop {
    #mixin Inject {method: "func_191420_l", at: {value: "HEAD"}, cancellable: true}
    function avoidNPE(cir as CallbackInfoReturnable) as void {
        if (isNull(this0.thaumatorium)) {
            cir.setReturnValue(true);
        }
    }
}

#mixin {targets: "thaumcraft.common.tiles.devices.TileLampFertility"}
zenClass MixinTileLampFertility {
    #mixin ModifyConstant {method: "updateAnimals", constant: {intValue: 5}}
    function speedUpFluxSelfCleansing(value as int) as int {
        return 1;
    }
}

#mixin {targets: "thaumcraft.common.tiles.devices.TileMirror"}
zenClass MixinTileMirror {
    #mixin ModifyConstant {method: "checkInstability", constant: {intValue: 100}}
    function speedUpFluxSelfCleansing(value as int) as int {
        return 5;
    }
}

#mixin {targets: "thaumcraft.common.tiles.devices.TileMirrorEssentia"}
zenClass MixinTileMirrorEssentia {
    #mixin ModifyConstant {method: "checkInstability", constant: {intValue: 100}}
    function speedUpFluxSelfCleansing(value as int) as int {
        return 5;
    }
}

#mixin {targets: "thaumcraft.common.tiles.devices.TileVisGenerator"}
zenClass MixinTileVisGenerator {
    #mixin Static
    #mixin ModifyConstant {method: "<init>", constant: [{intValue: 1000}, {intValue: 20}]}
    function buffEnergyHandler(value as int) as int {
        return value * 10;
    }

    #mixin ModifyConstant {method: "func_73660_a", constant: {intValue: 20}}
    function increaseOutputSpeed(value as int) as int {
        return value * 10;
    }

    #mixin ModifyConstant {method: "recharge", constant: {floatValue: 1000}}
    function increaseConversationRatio(value as float) as float {
        return value * 10;
    }
}

/*
Allow Celestial Notes being possible to get in dimension 3 (skyblock in E2EE)
*/
#mixin {targets: "thaumcraft.common.lib.research.ScanSky"}
zenClass MixinScanSky {
    #mixin Redirect
    #{
    #   method: "checkThing",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lnet/minecraft/world/WorldProvider;func_186058_p()Lnet/minecraft/world/DimensionType;"
    #   }
    #}
    function allowDimension3(provider as WorldProvider) as DimensionType {
        if (provider.getDimension() == 3) return DimensionType.OVERWORLD;
        return provider.getDimensionType();
    }
}

#mixin {targets: "thaumcraft.common.lib.events.ToolEvents", priority: 1100}
zenClass MixinToolEvents {
    #mixin Static
    #mixin Inject {method: "doRefining", at: {value: "HEAD"}, cancellable: true}
    function doBuffedRefining(event as HarvestDropsEvent, heldItem as ItemStack, ci as CallbackInfo) as void {
        ci.cancel();

        val level = EnumInfusionEnchantment.getInfusionEnchantmentLevel(heldItem, EnumInfusionEnchantment.REFINING);
        val chance_percent = 40 + 20 * (level - 1) + 10 * event.fortuneLevel;

        val lucky_number = event.world.rand.nextInt(100);
        if (lucky_number >= chance_percent) { // if chance < 1, refining may not trigger at all
            return;
        }

        var dropAmount = chance_percent / 100;
        if (lucky_number < chance_percent % 100) {
            dropAmount += 1;
        }

        var outputMultiplier = 1;
        for oreID in OreDictionary.getOreIDs(ItemStack(event.getState().getBlock())) {
            val newName = OreDictionary.getOreName(oreID);
            if (isNull(newName)) continue;
            
            if (newName.startsWith("oreNether") || newName.startsWith("oreEnd")) {
                outputMultiplier = 2;
                break;
            }
        }

        var newDrops = [] as ItemStack[];
        var replacementItem = heldItem; // idfk why but setting it to null was breaking the call to replacementItem.setCount
        var foundReplacement = false;

        for is in event.drops {
            if (isNull(is) || is.isEmpty()) continue;

            var found = false;
            
            for oreID in OreDictionary.getOreIDs(is) {
                val newName = OreDictionary.getOreName(oreID);
                if (isNull(newName)) continue;
                
                var subLen = 0;
                if (newName.startsWith("oreNether")) {
                    subLen = 9;
                } else if (newName.startsWith("oreEnd")) {
                    subLen = 6;
                } else if (newName.startsWith("ore") || newName.startsWith("gem")) {
                    subLen = 3;
                } else if (newName.startsWith("dust")) {
                    subLen = 4;
                } else {
                    continue;
                }

                val oreName = "cluster" + newName.substring(subLen);
                val list as NonNullList = OreDictionary.getOres(oreName);
                for item in OreDictionary.getOres(oreName) {
                    if (isNull(item)) continue;

                    if (!foundReplacement) {
                        replacementItem = item as ItemStack;
                        foundReplacement = true;
                    }

                    found = true;
                    break;
                }

                if (found) break;
            }

            if (!found) { // not found ore, adding item as it is
                newDrops += is;
            }
        }

        if (!foundReplacement) return;

        replacementItem.setCount(dropAmount * outputMultiplier);
        newDrops += replacementItem;

        event.drops.clear();
        for is in newDrops {
            event.drops.add(is);
        }

        event.world.playSound(null, event.getPos(), SoundEvents.ENTITY_EXPERIENCE_ORB_PICKUP, SoundCategory.PLAYERS, 0.2F, 0.7F + event.world.rand.nextFloat() * 0.2F);
    }
}
