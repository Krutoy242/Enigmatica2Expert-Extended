#modloaded requious
#loader mixin

import native.net.minecraftforge.common.capabilities.Capability;
import native.net.minecraft.util.EnumFacing;
import mixin.CallbackInfoReturnable;

#mixin {targets: "requious.tile.TileEntityAssembly"}
zenClass MixinTileEntityAssembly {
    #mixin Inject {method: "hasCapability", at: {value: "HEAD"}, cancellable: true}
    function fixCrashOnBreaking(capability as Capability, facing as EnumFacing, cir as CallbackInfoReturnable) as void {
        if (this0.getWorld().isAirBlock(this0.getPos())) {
            cir.setReturnValue(false);
        }
    }

    #mixin Inject {method: "injectEnergy", at: {value: "HEAD"}, cancellable: true}
    function fixCrashOnAttachPowerlessMachineToIC2Power(facing as EnumFacing, amount as double, voltage as double, cir as CallbackInfoReturnable) as double {
        if (isNull(this0.processor) || isNull(this0.processor.getIC2Handler())) cir.setReturnValue(0.0);
    }
}
