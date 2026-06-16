#loader mixin
#priority 1000

import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.entity.EntityLivingBase;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;
// Every handler registered into this list (from exnihilo.zs / fallback.zs) has to
// match this signature *exactly* — same native types, same order — otherwise you
// get a ClassCastException at runtime when the mixin invokes it.

// IMPORTANT: Mixins can ONLY takes native types, the function type MUST be native.
zenClass CrumbleOp {
  static handlers as [function(World, BlockPos, IBlockState, EntityLivingBase, ItemStack)bool]
    = [] as [function(World, BlockPos, IBlockState, EntityLivingBase, ItemStack)bool];
}
