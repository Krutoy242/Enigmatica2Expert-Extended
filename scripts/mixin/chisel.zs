#modloaded chisel
#loader mixin

import mixin.CallbackInfo;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.world.World;
import native.team.chisel.api.IChiselItem;

#mixin {targets: "team.chisel.common.block.TileAutoChisel"}
zenClass MixinTileAutoChisel {

    #mixin Inject { method: "func_73660_a()V", at: {value: "HEAD"}, cancellable: true }
    function checkChiselIsInstance(ci as CallbackInfo) as void {
        if (isNull(this0.world) || this0.world.isRemote) return;

        val chisel = this0.chisel;

        if (!chisel.isEmpty() && !(chisel.item instanceof IChiselItem)) {
            this0.setSourceSlot(-1);
            this0.progress = 0;
            this0.updateClientSlot();
            ci.cancel();
        }
    }
}
