#modloaded bedrockores
#loader mixin

import mixin.Operation;
import native.net.minecraft.util.BlockRenderLayer;
import native.net.minecraftforge.fml.common.FMLCommonHandler;

#mixin {targets: "li.cil.bedrockores.common.block.BlockBedrockOre"}
zenClass MixinBlockBedrockOre {
    #mixin WrapOperation
    #{
    #    method: "func_176221_a",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lnet/minecraftforge/client/MinecraftForgeClient;getRenderLayer()Lnet/minecraft/util/BlockRenderLayer;"
    #    }
    #}
    function noRenderLayerOnServer(
        operation as mixin.Operation
    ) as BlockRenderLayer {
        if (FMLCommonHandler.instance().getEffectiveSide().isServer())
            return null;

        return operation.call() as BlockRenderLayer;
    }
}
