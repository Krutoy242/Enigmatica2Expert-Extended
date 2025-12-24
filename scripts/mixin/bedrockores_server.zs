#modloaded bedrockores
#loader mixin
#sideonly server

import mixin.Operation;
import native.net.minecraft.util.BlockRenderLayer;

#mixin {targets: "li.cil.bedrockores.common.block.BlockBedrockOre"}
zenClass MixinBlockBedrockOre {

    /*
    When the block accessor isn't a world Bedrock Ores will try to get the BlockRenderLayer,
    even if not on the client. Prevent crashing by returning null instead of invoking non-existent method.
    https://github.com/jbredwards/Fluidlogged-API/issues/276
    */
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
        return null;
    }
}

