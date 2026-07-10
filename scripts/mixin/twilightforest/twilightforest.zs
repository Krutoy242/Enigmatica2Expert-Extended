#modloaded twilightforest
#loader mixin

import mixin.CallbackInfo;
import native.java.util.Random;
import native.net.minecraft.block.BlockLeaves;
import native.net.minecraft.block.BlockLog;
import native.net.minecraft.block.BlockLog.EnumAxis;
import native.net.minecraft.init.Blocks;
import native.net.minecraft.inventory.IInventory;
import native.net.minecraft.util.EnumParticleTypes;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.world.World;
import native.net.minecraft.world.WorldServer;
import native.twilightforest.block.BlockTFMagicLeaves;
import native.twilightforest.block.BlockTFMagicLog;
import native.twilightforest.block.BlockTFMagicLogSpecial;
import native.twilightforest.enums.MagicWoodVariant;
import native.twilightforest.inventory.InventoryTFGoblinUncrafting;

#mixin { targets: 'twilightforest.block.BlockTFMagicLogSpecial' }
zenClass MixinBlockTFMagicLogSpecial {
  /*
    Buff Tree of time and change its behavior
    */
  #mixin Overwrite
  function doTreeOfTimeEffect(world as World, pos as BlockPos, rand as Random) as void {
    var leavesCount = 0;
    var logsNaturalCount = 0;
    var logsOtherCount = 0;

    // Loop all blocks around
    for z in (-8) .. 9 {
      for y in (-8) .. 9 {
        for x in (-8) .. 9 {
          if (x == 0 && y == 0 && z == 0) continue; // Itself

          val dPos = pos.add(x, y, z);
          val state = world.getBlockState(dPos);
          val block = state.block;

          // print('~ '~toString(block));

          if (block == Blocks.AIR) {
            continue;
          }
          else if (
            block instanceof BlockTFMagicLogSpecial
            && state.getValue(BlockTFMagicLog.VARIANT) == MagicWoodVariant.TIME
            && state.getValue(BlockLog.LOG_AXIS) == EnumAxis.NONE
          ) {
            // Disable other Timewood clocks
            world.setBlockState(dPos, state.withProperty(BlockLog.LOG_AXIS, EnumAxis.Y));
            (world as WorldServer).spawnParticle(EnumParticleTypes.SPELL_WITCH,
              0.5 + dPos.x, 0.5 + dPos.y, 0.5 + dPos.z, 50, 0.25, 0.25, 0.25, 0.02, 0);
          }
          else if (
            x > -5 && x < 5 && y > -3 && y < 7 && z > -5 && z < 5
            && block instanceof BlockTFMagicLog
            && state.getValue(BlockTFMagicLog.VARIANT) == MagicWoodVariant.TIME
          ) {
            if (state.getValue(BlockLog.LOG_AXIS) == EnumAxis.NONE)
              logsNaturalCount += 1;
            else
              logsOtherCount += 1;
          }
          else if (
            y > 0 && y < 9
            && block instanceof BlockTFMagicLeaves
            && state.getValue(BlockTFMagicLog.VARIANT) == MagicWoodVariant.TIME
            && state.getValue(BlockLeaves.DECAYABLE) == true
          ) {
            leavesCount += 1;
            // Idea: Increase ticks of Forestry leaves and IC2 crops
            // } else if (
            //     block instanceof native.forestry.arboriculture.blocks.BlockForestryLeaves
            //     || block == native.ic2.core.ref.TeBlock.crop
            // ) {
            //     val te = world.getTileEntity(dPos);
            //     if (te instanceof ITickable && !te.isInvalid()) {
            //         val tickable as ITickable = te;
            //         for i in 0 .. 64 {
            //             tickable.update();
            //         }
            //     }
          }
          else if (block.tickRandomly) {
            // Update tickable blocks
            block.updateTick(world, dPos, state, rand);
          }
        }
      }
    }

    // print('~ leavesCount: '~leavesCount~' logsNaturalCount: '~logsNaturalCount~' logsOtherCount: '~logsOtherCount);

    // Too few leaves and logs - destroy clock
    if (leavesCount < 330 || logsNaturalCount < 30 || logsOtherCount < 30) {
      // world.setBlockState(pos, world.getBlockState(pos).withProperty(BlockLog.LOG_AXIS, EnumAxis.Y));
      world.destroyBlock(pos, true);
      (world as WorldServer).spawnParticle(EnumParticleTypes.SPELL_WITCH,
        0.5 + pos.x, 0.5 + pos.y, 0.5 + pos.z, 100, 2.0, 2.0, 2.0, 0.02, 0);
    }
  }
}

/*
Add antidupe for [Uncrafting Table]
Now Uncrafting Table mechanic strictly validates that re-assembling ingredients
gives back the same item (soft NBT check).
For example, you can't get Mekanism Tanks of higher tier from lower ones
via NBT-less recipe mismatch.
*/
#mixin { targets: 'twilightforest.inventory.ContainerTFUncrafting' }
zenClass MixinContainerTFUncrafting {
  #mixin Shadow
  val tinkerInput as IInventory;

  #mixin Shadow
  val uncraftingMatrix as InventoryTFGoblinUncrafting;

  #mixin Inject { method: 'func_75130_a', at: { value: 'RETURN' } }
  function onCraftMatrixChanged(inventory as IInventory, ci as CallbackInfo) as void {
    // Only validate when the uncrafting recipe was just calculated (tinkerInput changed).
    // When the player takes items from the grid, inventory will be uncraftingMatrix
    // or assemblyMatrix — we must NOT re-validate then, or recipes.craft() fails
    // on a partial grid and blocks all remaining ingredients.
    if (inventory != tinkerInput) return;

    val inputStack = tinkerInput.getStackInSlot(0);
    if (inputStack.isEmpty() || uncraftingMatrix.isEmpty()) return;

    val ingredients = [null, null, null, null, null, null, null, null, null] as ItemStack[];
    for i in 0 .. 9 {
      ingredients[i] = uncraftingMatrix.getStackInSlot(i);
    }

    scripts.mixin.twilightforest.shared.Op.validateUncraft(inputStack, ingredients);
  }
}
