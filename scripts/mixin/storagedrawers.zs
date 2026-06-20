#modloaded storagedrawers
#loader mixin

import mixin.CallbackInfoReturnable;
import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.world.World;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.util.math.RayTraceResult;
import native.net.minecraftforge.common.ForgeHooks;

#mixin { targets: "com.jaquadro.minecraft.storagedrawers.block.BlockDrawers" }
zenClass MixinBlockDrawers {

    // This mixin is for preventing drawers from being broken at the FACE SIDE
    // Taken from Storage Drawers sources, but it was prevented only for creative mode
    //
    // Note: It's additional, the problem of Compacting Drawer disappearing is fixed
    // by the event check in /mods/storagedrawers.zs:156
    // Event checks only the Compacting Drawer. Mixin covers all of the drawers

    #mixin Inject { method: "removedByPlayer", at: { value: "HEAD" }, cancellable: true }
    function onRemove(state as IBlockState, world as World, pos as BlockPos,
                        player as EntityPlayer, willHarvest as bool,
                        cir as CallbackInfoReturnable) as void {
        if (player.capabilities.isCreativeMode) return;

        val rtr = ForgeHooks.rayTraceEyes(player, 6.0);
        if (isNull(rtr)) return;

        if (this0.getDirection(world, pos).getIndex() == rtr.sideHit.getIndex()) {
            cir.setReturnValue(false);
            return;
        }
    }
}

