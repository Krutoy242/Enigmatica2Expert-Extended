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
import mixin.CallbackInfoReturnable;

#mixin Mixin
#{targets: "twilightforest.block.BlockTFMagicLogSpecial"}
zenClass MixinBlockTFMagicLogSpecial {
    #mixin ModifyConstant
    #{
    #    method: "doTreeOfTimeEffect",
    #    constant: {intValue: 24}
    #}
    function buffTimewoodClock0(value as int) as int {
        return 48;
    }

    #mixin ModifyConstant
    #{
    #    method: "doTreeOfTimeEffect",
    #    constant: {intValue: 16}
    #}
    function buffTimewoodClock1(value as int) as int {
        return 8;
    }

    #mixin Redirect
    #{
    #    method: "doTreeOfTimeEffect",
    #    at: {
    #    value: "INVOKE",
    #    target: "Lnet/minecraft/block/Block;func_180650_b(Lnet/minecraft/world/World;Lnet/minecraft/util/math/BlockPos;Lnet/minecraft/block/state/IBlockState;Ljava/util/Random;)V"
    #    }
    #}
    function buffTimewoodClock2(block as Block, world as World, pos as BlockPos, state as IBlockState, random as Random) as void {
        for i in 0 .. 8 {
            block.updateTick(world, pos, state, random);
        }
    }

    #mixin Redirect
    #{
    #    method: "doTreeOfTimeEffect",
    #    at: {
    #    value: "INVOKE",
    #    target: "Lnet/minecraft/util/ITickable;func_73660_a()V"
    #    }
    #}
    function buffTimewoodClock3(te as ITickable) as void {
        for i in 0 .. 64 {
            te.update();
        }
    }
}

/*
Add antidupe for [Uncrafting Table]
Now Uncrafting Table mechanic improved - you cant uncraft items that have several recipes with 2+ recipes output with same ID but different tags.
For example, you cant Uncraft Mekanism Tanks or Cubes, since before fix this was allowed to create Creative Tank from Basic one.
*/
#mixin Mixin
#{targets: "twilightforest.inventory.ContainerTFUncrafting"}
zenClass MixinContainerTFUncrafting {
    #mixin Static
    #mixin Inject
    #{
    #    method: "getRecipesFor",
    #    at: {value: "RETURN"},
    #    cancellable: true
    #}
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
