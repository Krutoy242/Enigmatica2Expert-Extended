#loader mixin

import native.net.minecraft.item.ItemStack;
import native.cofh.thermalexpansion.util.managers.machine.PulverizerManager;
import native.cofh.thermalexpansion.util.managers.machine.SmelterManager;

#mixin Mixin
#{targets: "cofh.thermalexpansion.block.dynamo.TileDynamoNumismatic"}
zenClass MixinTileDynamoNumismatic {
    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "config",
    #    constant: {intValue: 1000}
    #}
    function modifyBaseEnergy0(value as int) as int {
        return 2000;
    }

    #mixin ModifyConstant
    #{
    #    method: "installAugmentToSlot",
    #    constant: {intValue: 4}
    #}
    function modifyBaseEnergy1(value as int) as int {
        return 2;
    }
}

#mixin Mixin
#{targets: "cofh.thermalexpansion.plugins.jei.machine.transposer.TransposerRecipeWrapperContainer"}
zenClass MixinTransposerRecipeWrapperContainer {
    #mixin Redirect
    #{
    #    method: "<init>",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lnet/minecraftforge/fluids/FluidRegistry;getRegisteredFluids()Ljava/util/Map;"
    #    }
    #}
    function removeFluidBucketRecipeEntries() as any[any] {
        return {};
    }
}

#mixin Mixin
#{targets: "cofh.thermalexpansion.util.managers.machine.PulverizerManager"}
zenClass MixinPulverizerManager {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "initialize",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lcofh/thermalexpansion/util/managers/machine/PulverizerManager;addRecycleRecipe(ILnet/minecraft/item/ItemStack;Lnet/minecraft/item/ItemStack;I)V"
    #    }
    #}
    function removeThermalTools(energy as int, item as ItemStack, output as ItemStack, outputSize as int) as void {
        if (!isNull(item) && !item.empty && !isNull(item.item.registryName) && item.item.registryName.namespace == "minecraft") {
            PulverizerManager.addRecycleRecipe(energy, item, output, outputSize);
        }
    }
}

#mixin Mixin
#{targets: "cofh.thermalexpansion.util.managers.machine.SmelterManager"}
zenClass MixinSmelterManager {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "initialize",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lcofh/thermalexpansion/util/managers/machine/SmelterManager;addRecycleRecipe(ILnet/minecraft/item/ItemStack;Lnet/minecraft/item/ItemStack;I)V"
    #    }
    #}
    function removeThermalTools(energy as int, item as ItemStack, output as ItemStack, outputSize as int) as void {
        if (!isNull(item) && !item.empty && !isNull(item.item.registryName) && item.item.registryName.namespace == "minecraft") {
            SmelterManager.addRecycleRecipe(energy, item, output, outputSize);
        }
    }
}
