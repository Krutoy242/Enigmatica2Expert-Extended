#modloaded twilightforest
#loader mixin

import native.net.minecraft.block.Block;
import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.item.Item;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.item.crafting.IRecipe;
import native.net.minecraft.world.World;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.util.ITickable;
import native.java.util.Random;
import native.net.minecraft.block.BlockLeaves;
import native.net.minecraft.block.BlockLog;
import native.net.minecraft.block.BlockLog.EnumAxis;
import native.net.minecraft.init.Blocks;
import native.net.minecraft.util.EnumParticleTypes;
import native.net.minecraft.world.WorldServer;
import native.twilightforest.block.BlockTFMagicLeaves;
import native.twilightforest.block.BlockTFMagicLog;
import native.twilightforest.block.BlockTFMagicLogSpecial;
import native.twilightforest.enums.MagicWoodVariant;
import mixin.CallbackInfoReturnable;

#mixin {targets: "twilightforest.block.BlockTFMagicLogSpecial"}
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
        for z in -8 .. 9 {
            for y in -8 .. 9 {
                for x in -8 .. 9 {
                    if (x==0 && y==0 && z==0) continue; // Itself

                    val dPos = pos.add(x, y, z);
                    val state = world.getBlockState(dPos);
                    val block = state.getBlock();

                    // print('~ '~toString(block));

                    if (block == Blocks.AIR) {
                        continue;
                    } else if (
                        block instanceof BlockTFMagicLogSpecial
                        && state.getValue(BlockTFMagicLog.VARIANT) == MagicWoodVariant.TIME
                        && state.getValue(BlockLog.LOG_AXIS) == EnumAxis.NONE
                    ) {
                        // Disable other Timewood clocks
                        world.setBlockState(dPos, state.withProperty(BlockLog.LOG_AXIS, EnumAxis.Y));
                        (world as WorldServer).spawnParticle(EnumParticleTypes.SPELL_WITCH,
                            0.5 + dPos.x, 0.5 + dPos.y, 0.5 + dPos.z, 50, 0.25, 0.25, 0.25, 0.02, 0);
                    } else if (
                        -5 < x && x < 5 && -3 < y && y < 7 && -5 < z && z < 5
                        && block instanceof BlockTFMagicLog
                        && state.getValue(BlockTFMagicLog.VARIANT) == MagicWoodVariant.TIME
                    ) {
                        if (state.getValue(BlockLog.LOG_AXIS) == EnumAxis.NONE)
                            logsNaturalCount += 1;
                        else
                            logsOtherCount += 1;
                    } else if (
                        0 < y && y < 9
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
                    } else if (block.getTickRandomly()) {
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
Now Uncrafting Table mechanic improved - you cant uncraft items that have several recipes with 2+ recipes output with same ID but different tags.
For example, you cant Uncraft Mekanism Tanks or Cubes, since before fix this was allowed to create Creative Tank from Basic one.
*/
#mixin {targets: "twilightforest.inventory.ContainerTFUncrafting"}
zenClass MixinContainerTFUncrafting {
    #mixin Static
    #mixin Inject {method: "getRecipesFor", at: {value: "RETURN"}, cancellable: true}
    function filterRecipes(item as ItemStack, cir as CallbackInfoReturnable) as void {
        val recipes as IRecipe[] = cir.getReturnValue() as IRecipe[];
        val recipeMap as [IRecipe][string] = {};
        for recipe in recipes {
            val out = recipe.recipeOutput;
            val registryKey as string = Item.REGISTRY.getNameForObject(out.item).toString() ~ ":" ~ out.metadata;
            if (!(recipeMap has registryKey)) {
                recipeMap[registryKey] = [] as [IRecipe]; 
            }
            var entry as [IRecipe] = recipeMap[registryKey];
            entry += recipe;
        }
        var filterRecipes as [IRecipe] = [] as [IRecipe];
        for key, recipeList in recipeMap {
            if (recipeList.length == 1) {
                filterRecipes += recipeList[0];
                continue;
            }
            val firstOutput = recipeList[0].recipeOutput;
            var allMatch as bool = true;
            for recipe in recipeList {
                val currentOutput = recipe.recipeOutput;
                if (ItemStack.areItemStackTagsEqual(firstOutput, currentOutput)) {
                    continue;
                }
                allMatch = false;
                break;
            }
            if (allMatch) {
                for recipe in recipeList {
                    filterRecipes += recipe;
                }
            }
        }
        cir.setReturnValue(filterRecipes as IRecipe[]);
    }
}
