#modloaded twilightforest exnihilocreatio
#reloadable

import native.exnihilocreatio.registries.manager.ExNihiloRegistryManager;
import native.exnihilocreatio.registries.types.HammerReward;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.block.IBlockState;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.item.IItemStack;

scripts.mixin.twilightforest.crumble.shared.CrumbleOp.handlers += function(
  world as IWorld,
  pos as IBlockPos,
  state as IBlockState,
  living as IEntityLivingBase,
  stack as IItemStack
) as bool {
  val registry = ExNihiloRegistryManager.HAMMER_REGISTRY;
  if (!registry.isRegistered(state)) return false;

  val rewards = registry.getRewards(state);
  if (rewards.isEmpty()) return false;

  var first = true;
  var hasDrop = false;
  var dropBlockState as IBlockState = null;
  for reward in rewards {
    val hammerReward = reward as HammerReward;
    val dropStack = hammerReward.stack as IItemStack;
    if (isNull(dropStack) || dropStack.isEmpty) continue;

    hasDrop = true;
    if (first) {
      first = false;
      if (dropStack.isItemBlock) {
        dropBlockState = dropStack.asBlock().definition.getStateFromMeta(dropStack.metadata);
      }
      if (!isNull(dropBlockState)) {
        world.setBlockState(dropBlockState, pos);
        return true;
      }
      world.setBlockState(<blockstate:minecraft:air>, pos);
      world.spawnEntity(dropStack.createEntityItem(world, pos));
    } else {
      world.spawnEntity(dropStack.createEntityItem(world, pos));
    }
  }

  return hasDrop;
};
