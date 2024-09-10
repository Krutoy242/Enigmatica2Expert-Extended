#loader mixin

import native.net.minecraftforge.common.capabilities.Capability;
import native.net.minecraft.util.EnumFacing;
import mixin.CallbackInfoReturnable;

#mixin Mixin
#{targets: "requious.tile.TileEntityAssembly"}
zenClass MixinTileEntityAssembly {
    #mixin Inject
    #{
    #    method: "hasCapability",
    #    at: {value: "HEAD"},
    #    cancellable: true
    #}
    function fixCrashOnBreaking(capability as Capability, facing as EnumFacing, cir as CallbackInfoReturnable) as void {
        if (this0.getWorld().isAirBlock(this0.getPos())) {
            cir.setReturnValue(false);
        }
    }
}
