#modloaded twilightforest exnihilocreatio
#reloadable

import native.exnihilocreatio.registries.manager.ExNihiloRegistryManager;
import native.exnihilocreatio.registries.types.HammerReward;

// --- Native MC types ---
import native.net.minecraft.world.World;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.block.state.IBlockState as NativeBlockState;
import native.net.minecraft.entity.EntityLivingBase;
import native.net.minecraft.item.ItemStack;

// --- Bridge: native -> CraftTweaker wrappers ---
import native.crafttweaker.api.minecraft.CraftTweakerMC;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.block.IBlockState;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.item.IItemStack;

scripts.mixin.twilightforest.crumble.shared.CrumbleOp.handlers += function(
  worldN as World,
  posN as BlockPos,
  stateN as NativeBlockState,
  livingN as EntityLivingBase,
  stackN as ItemStack
) as bool {
  // native to CraftTweaker
  val world as IWorld = CraftTweakerMC.getIWorld(worldN);
  val pos as IBlockPos = CraftTweakerMC.getIBlockPos(posN);
  val state as IBlockState = CraftTweakerMC.getBlockState(stateN);
  // (living/stack are not needed by this handler, so we skip converting them.)

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
