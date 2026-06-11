#modloaded twilightforest exnihilocreatio
#reloadable

import native.exnihilocreatio.registries.manager.ExNihiloRegistryManager;
import native.exnihilocreatio.registries.types.HammerReward;
import native.net.minecraft.world.World;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.entity.EntityLivingBase;
import native.net.minecraft.item.ItemStack;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.item.IItemStack;

scripts.mixin.twilightforest.crumble.shared.CrumbleOp.handlers += function (
  world as World,
  pos as BlockPos,
  state as IBlockState,
  living as EntityLivingBase,
  stack as ItemStack
) as bool {
  val ctWorld = world as IWorld;
  val ctPos = pos as IBlockPos;

  val registry = ExNihiloRegistryManager.HAMMER_REGISTRY;
  if (!registry.isRegistered(state)) return false;

  val rewards = registry.getRewards(state);
  if (rewards.isEmpty()) return false;

  var first = true;
  var hasDrop = false;
  for reward in rewards {
    val hammerReward = reward as HammerReward;
    val dropStack = hammerReward.stack as IItemStack;
    if (isNull(dropStack) || dropStack.isEmpty) continue;

    hasDrop = true;
    if (first) {
      first = false;
      if (dropStack.isItemBlock) {
        ctWorld.setBlockState(dropStack.asBlock().definition.getStateFromMeta(dropStack.metadata), ctPos);
        return true;
      }
      ctWorld.setBlockState(<blockstate:minecraft:air>, ctPos);
      ctWorld.spawnEntity(dropStack.createEntityItem(ctWorld, ctPos));
    }
    else {
      ctWorld.spawnEntity(dropStack.createEntityItem(ctWorld, ctPos));
    }
  }

  return hasDrop;
};
