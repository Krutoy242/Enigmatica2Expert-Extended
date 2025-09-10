#modloaded travelersbackpack tombmanygraves
#loader mixin

import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.world.World;
import native.net.minecraft.util.math.BlockPos;

/*
Use CraftTweaker function to find black for backpack
*/
#mixin {targets: "com.tiviacz.travelersbackpack.util.BackpackUtils"}
zenClass MixinBackpackUtils {
    #mixin Static
    #mixin Overwrite
    function tryPlace(world as World, player as EntityPlayer, itemstack as ItemStack) as bool {
        return scripts.mixin.travelersbackpack.shared.Op.fn(world, player, itemstack);
    }
}

/*
Expose private methods as public
*/
#mixin {targets: "com.m4thg33k.tombmanygraves.events.CommonEvents"}
zenClass MixinCommonEvents {
    function publicFindValidGraveLocation(world as World, pos as BlockPos) as BlockPos {
        return this0.findValidGraveLocation(world, pos);
    }

    function publicAscendFromFluid(world as World, pos as BlockPos) as BlockPos {
        return this0.ascendFromFluid(world, pos);
    }
}
