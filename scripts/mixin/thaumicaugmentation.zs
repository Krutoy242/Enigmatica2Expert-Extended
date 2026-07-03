#modloaded thaumicaugmentation
#loader mixin

import native.thecodex6824.thaumicaugmentation.api.block.property.ILightSourceBlock;
import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.world.IBlockAccess;
import native.net.minecraft.util.math.BlockPos;
import mixin.CallbackInfoReturnable;
import mixin.CallbackInfo;

#mixin {targets = "thecodex6824.thaumicaugmentation.common.block.BlockCastedLight"}
zenClass MixinBlockCastedLight {
    #mixin Inject {method: "<init>", at: {value: "TAIL"}}
    function afterInit(ci as CallbackInfo) as void {
        this0.setLightLevel(1.0);
    }
}
