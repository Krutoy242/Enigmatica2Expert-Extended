/*
Quark is a dependency. See note in client.zs
*/
#modloaded quark
#modloaded rustic
#loader mixin

import scripts.mixin.rustic.shared as Constants;

import mixin.Operation;

import native.java.lang.Boolean;

import native.net.minecraft.item.ItemStack;
import native.net.minecraft.nbt.NBTTagCompound;
import native.rustic.common.tileentity.ContainerVase;
import native.rustic.common.util.ItemStackHandlerRustic;

#mixin {targets: "rustic.common.tileentity.ContainerVase"}
zenClass MixinContainerVase {

    #mixin Expression
    #{
    #    value: "27"
    #}
    #mixin ModifyExpressionValue
    #{
    #    method: "func_82846_b",
    #    at: {
    #       value: "MIXINEXTRAS:EXPRESSION"
    #    }
    #}
    function modifyTransferCondition(original as int) as int {
        return original + Constants.DIFF_SLOTS;
    }

    #mixin Expression
    #{
    #    value: "3"
    #}
    #mixin ModifyExpressionValue
    #{
    #    method: "addOwnSlots",
    #    at: {
    #       value: "MIXINEXTRAS:EXPRESSION"
    #    }
    #}
    function modifyRowCount(original as int) as int {
        return original + Constants.DIFF_ROWS;
    }

    #mixin Expression
    #{
    #    value: "9"
    #}
    #mixin ModifyExpressionValue
    #{
    #    method: "addOwnSlots",
    #    at: {
    #       value: "MIXINEXTRAS:EXPRESSION"
    #    }
    #}
    function modifyColumnCount(original as int) as int {
        return original + Constants.DIFF_COLUMNS;
    }

    #mixin Definition
    #{
    #    id: "col",
    #    local: {
    #        type: "I",
    #        name: "col"
    #    }
    #}
    #mixin Expression
    #{
    #    value: "8 + col * 18"
    #}
    #mixin ModifyExpressionValue
    #{
    #    method: "addOwnSlots",
    #    at: {
    #       value: "MIXINEXTRAS:EXPRESSION"
    #    }
    #}
    function repositionOwnSlotsX(original as int) as int {
        return original + Constants.CENTERED_CONTAINER_OFFSET_X;
    }

    #mixin Definition
    #{
    #    id: "col",
    #    local: [
    #        {
    #            type: "I",
    #            name: "col",
    #            ordinal: 0
    #        },
    #        {
    #            type: "I",
    #            name: "col",
    #            ordinal: 1
    #        }
    #    ]
    #}
    #mixin Expression
    #{
    #    value: "8 + col * 18"
    #}
    #mixin ModifyExpressionValue
    #{
    #    method: "addPlayerSlots",
    #    at: {
    #       value: "MIXINEXTRAS:EXPRESSION"
    #    }
    #}
    function repositionPlayerSlotsX(original as int) as int {
        return original + Constants.PLAYER_INVENTORY_OFFSET_X;
    }

    #mixin Definition
    #{
    #    id: "row",
    #    local: {
    #        type: "I",
    #        name: "row"
    #    }
    #}
    #mixin Expression
    #{
    #    value: [
    #       "row * 18 + 84",
    #       "142"
    #    ]
    #}
    #mixin ModifyExpressionValue
    #{
    #    method: "addPlayerSlots",
    #    at: {
    #       value: "MIXINEXTRAS:EXPRESSION"
    #    }
    #}
    function repositionPlayerSlotsY(original as int) as int {
        return original + Constants.PLAYER_INVENTORY_SLOT_OFFSET_Y;
    }

}

#mixin {targets: "rustic.common.tileentity.TileEntityVase$1"}
zenClass MixinItemStackHandler extends ItemStackHandlerRustic {

    #@Override
    function getSlotLimit(slot as int) as int {
        return super.getSlotLimit(slot) + Constants.DIFF_MAX_STACK_SIZE;
    }

    #@Override
    function deserializeNBT(nbt as NBTTagCompound) as void {
        super.deserializeNBT(nbt);
        if (this0.stacks.length < Constants.SLOTS) this0.setSize(Constants.SLOTS);
    }

}

#mixin {targets: "rustic.common.tileentity.TileEntityVase"}
zenClass MixinTileEntityVase {

    #mixin Shadow
    var itemStackHandler as ItemStackHandlerRustic;

    #mixin Expression
    #{
    #    value: "27"
    #}
    #mixin ModifyExpressionValue
    #{
    #    method: "<init>",
    #    at: {
    #       value: "MIXINEXTRAS:EXPRESSION"
    #    }
    #}
    function modifySlotCount(original as int) as int {
        return original + Constants.DIFF_SLOTS;
    }

    #mixin Expression
    #{
    #    value: "64"
    #}
    #mixin ModifyExpressionValue
    #{
    #    method: "func_70297_j_",
    #    at: {
    #       value: "MIXINEXTRAS:EXPRESSION"
    #    }
    #}
    function modifyMaxStackSize(original as int) as int {
        return original + Constants.DIFF_MAX_STACK_SIZE;
    }

    #mixin Expression
    #{
    #    value: "true"
    #}
    #mixin ModifyExpressionValue
    #{
    #    method: "func_94041_b",
    #    at: {
    #       value: "MIXINEXTRAS:EXPRESSION"
    #    }
    #}
    #mixin Local { parameter: 1, type: "I", argsOnly: true }
    #mixin Local { parameter: 2, type: "Lnet/minecraft/item/ItemStack;", argsOnly: true }
    function preventStackLimitExceedFromAutomation(original as bool, index as int, stack as ItemStack) as bool {
        return original && stack.getCount() + itemStackHandler.getStackInSlot(index).getCount() <= itemStackHandler.getSlotLimit(index);
    }

}
