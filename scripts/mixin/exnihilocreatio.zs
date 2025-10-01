#modloaded exnihilocreatio
#loader mixin

import mixin.CallbackInfoReturnable;
import native.java.lang.Integer;
import native.java.util.List;
import native.net.minecraft.block.state.IBlockState;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.EnumActionResult;
import native.net.minecraft.util.EnumFacing;
import native.net.minecraft.util.EnumHand;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;
import native.net.minecraft.world.WorldProvider;

#mixin {targets: "exnihilocreatio.modules.forestry.registry.HiveRequirements"}
zenClass MixinHiveRequirements {
    #mixin Shadow
    var dimension as Integer;

    #mixin Redirect
    #{
    #   method: "check",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lnet/minecraft/world/WorldProvider;getDimension()I"
    #   }
    #}
    function removeDimCheck(provider as WorldProvider) as int {
        return dimension as int;
    }
}

/*
Fix crash when right-clicking a rubber sapling with a rubber seed.
The crash is caused by attempting to access an empty list of saplings.
This mixin checks if the list is empty before access and returns early.
*/
#mixin {targets: "exnihilocreatio.items.seeds.ItemRubberSeed"}
zenClass MixinItemRubberSeed {
    #mixin Inject
    #{
    #    method: "func_180614_a",
    #    at: {
    #        value: "INVOKE",
    #        target: "Ljava/util/List;size()I"
    #    },
    #    cancellable: true,
    #    locals: "CAPTURE_FAILHARD"
    #}
    function beforeSaplingListGet(player as EntityPlayer, world as World, pos as BlockPos, hand as EnumHand, facing as EnumFacing, hitX as float, hitY as float, hitZ as float, cir as CallbackInfoReturnable, stack as ItemStack, soil as IBlockState, validPlants as [any]) as void {
        if (validPlants.isEmpty()) {
            cir.setReturnValue(EnumActionResult.PASS);
        }
    }
}