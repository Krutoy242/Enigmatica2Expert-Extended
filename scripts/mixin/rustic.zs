#modloaded rustic
#loader mixin

import native.net.minecraft.item.ItemStack;

#mixin {targets: "rustic.common.tileentity.TileEntityBrewingBarrel"}
zenClass MixinTileEntityBrewingBarrel {
    #mixin ModifyVariable
    #{
    #    method: "func_73660_a",
    #    at: {value: "STORE", ordinal: 0},
    #    slice: {from: {value: "NEW", target: "(Lnet/minecraft/item/Item;)Lnet/minecraft/item/ItemStack;", ordinal: 1}},
    #    index: 5
    #}
    function redirectToInputItemCopy0(item as ItemStack) as ItemStack {
        val input = this0.internalStackHandler.getStackInSlot(0);
        val output = input.copy();
        output.count = 1;
        return output;
    }

    #mixin ModifyVariable
    #{
    #    method: "func_73660_a",
    #    at: {value: "STORE", ordinal: 0},
    #    slice: {from: {value: "NEW", target: "(Lnet/minecraft/item/Item;)Lnet/minecraft/item/ItemStack;", ordinal: 3}},
    #    index: 5
    #}
    function redirectToInputItemCopy1(item as ItemStack) as ItemStack {
        val input = this0.internalStackHandler.getStackInSlot(0);
        val output = input.copy();
        output.count = 1;
        return output;
    }

    #mixin ModifyVariable
    #{
    #    method: "func_73660_a",
    #    at: {value: "STORE", ordinal: 0},
    #    slice: {from: {value: "NEW", target: "(Lnet/minecraft/item/Item;)Lnet/minecraft/item/ItemStack;", ordinal: 4}},
    #    index: 5
    #}
    function redirectToInputItemCopy2(item as ItemStack) as ItemStack {
        val input = this0.internalStackHandler.getStackInSlot(1);
        val output = input.copy();
        output.count = 1;
        return output;
    }

    #mixin ModifyVariable
    #{
    #    method: "func_73660_a",
    #    at: {value: "STORE", ordinal: 0},
    #    slice: {from: {value: "NEW", target: "(Lnet/minecraft/item/Item;)Lnet/minecraft/item/ItemStack;", ordinal: 7}},
    #    index: 5
    #}
    function redirectToInputItemCopy3(item as ItemStack) as ItemStack {
        val input = this0.internalStackHandler.getStackInSlot(2);
        val output = input.copy();
        output.count = 1;
        return output;
    }

    #mixin ModifyVariable
    #{
    #    method: "func_73660_a",
    #    at: {value: "STORE", ordinal: 0},
    #    slice: {from: {value: "NEW", target: "(Lnet/minecraft/item/Item;)Lnet/minecraft/item/ItemStack;", ordinal: 9}},
    #    index: 5
    #}
    function redirectToInputItemCopy4(item as ItemStack) as ItemStack {
        val input = this0.internalStackHandler.getStackInSlot(2);
        val output = input.copy();
        output.count = 1;
        return output;
    }
}
