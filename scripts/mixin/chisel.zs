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
        val world as World = this0.getWorld();

        if (world == null || world.isRemote) {
            return;
        }

        val chisel = this0.getChisel();

        if (!chisel.isEmpty() && !(chisel.getItem() instanceof IChiselItem)) {
            this0.setSourceSlot(-1);
            this0.progress = 0;
            this0.updateClientSlot();
            ci.cancel();
        }
    }
}