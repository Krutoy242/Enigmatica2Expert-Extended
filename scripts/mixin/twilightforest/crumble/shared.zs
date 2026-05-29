#loader mixin
#priority 1000

import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.entity.EntityLivingBase;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;

zenClass CrumbleOp {
  static handlers as [function(World, BlockPos, IBlockState, EntityLivingBase, ItemStack)bool]
    = [] as [function(World, BlockPos, IBlockState, EntityLivingBase, ItemStack)bool];
}
