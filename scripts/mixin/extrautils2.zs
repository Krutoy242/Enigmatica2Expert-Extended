#modloaded extrautils2
#loader mixin

import mixin.CallbackInfoReturnable;
import mixin.Operation;
import mixin.CallbackInfo;
import native.com.rwtema.extrautils2.api.machine.IMachineRecipe;
import native.com.rwtema.extrautils2.api.machine.Machine;
import native.com.rwtema.extrautils2.api.machine.MachineRecipeRegistry;
import native.com.rwtema.extrautils2.api.machine.MachineRegistry;
import native.com.rwtema.extrautils2.api.machine.XUMachineCrusher;
import native.com.rwtema.extrautils2.api.machine.XUMachineGenerators;
import native.com.rwtema.extrautils2.machine.EnergyBaseRecipe;
import native.com.rwtema.extrautils2.network.XUPacketBuffer;
import native.com.rwtema.extrautils2.tile.TileCreativeHarvest;
import native.com.rwtema.extrautils2.blocks.BlockCreativeHarvest;
import native.com.rwtema.extrautils2.transfernodes.Upgrade;
import native.com.rwtema.extrautils2.itemhandler.SingleStackHandler;
import native.net.minecraftforge.items.IItemHandler;
import native.net.minecraftforge.items.ItemHandlerHelper;
import native.java.lang.Integer;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.EnumActionResult;

#mixin {targets: "com.rwtema.extrautils2.tile.TileTerraformer$ContainerTerraformer$3"}
zenClass MixinTileTerraformerContainerTextArea {
    #mixin ModifyConstant {method: "constructText", constant: {stringValue: "/"}}
    function modifyTFTooltipMiddle(value as string) as string {
      return '';
    }

    #mixin Redirect {method: "constructText", at: {value: "INVOKE", target: "com/rwtema/extrautils2/network/XUPacketBuffer.readInt()I", ordinal: 4}}
    function processTFSuccess(packet as XUPacketBuffer) as int {
      val cur = packet.readInt();
      val max = packet.readInt();
      if (cur < max){
        return 0;
      } else {
        return 1;
      }
    }

    #mixin Redirect {method: "constructText", at: {value: "INVOKE", target: "com/rwtema/extrautils2/network/XUPacketBuffer.readInt()I", ordinal: 5}}
    function negateSecondTFCall(packet as XUPacketBuffer) as int {
      return 0;
    }

    #mixin Redirect {method: "constructText", at: {value: "INVOKE", target: "com/rwtema/extrautils2/utils/helpers/StringHelper.format(I)Ljava/lang/String;", ordinal: 0}}
    function outputSuccessTxt(value as int) as string {
      if (value == 0){
        return 'ᚷ';
      } else {
        return '✔';
      }
    }

    #mixin Redirect {method: "constructText", at: {value: "INVOKE", target: "com/rwtema/extrautils2/utils/helpers/StringHelper.format(I)Ljava/lang/String;", ordinal: 1}}
    function negateSecondStringFormatAppend(value as int) as string {
      return '';
    }
}

/*
Remove Crusher since its whole functionality copied with other crusher
*/
#mixin {targets: "com.rwtema.extrautils2.machine.MachineInit"}
zenClass MixinMachineInit {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "init",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lcom/rwtema/extrautils2/api/machine/MachineRegistry;register(Lcom/rwtema/extrautils2/api/machine/Machine;)Lcom/rwtema/extrautils2/api/machine/Machine;"
    #    }
    #}
    function disableCrusher(machine as Machine) as Machine {
        if (machine != XUMachineCrusher.INSTANCE) {
            MachineRegistry.register(machine);
        }
        return machine;
    }

    /*

    Slice positions:

    0 Enchanter
    1 FURNACE
    2 SURVIVALIST
    3 CULINARY
    4 POTION
    5 TNT
    6 LAVA
    7 PINK
    8 NETHERSTAR
    9 ENDER
    10 REDSTONE
    11 OVERCLOCK
    12 DRAGON
    13 ICE
    14 DEATH
    15 ENCHANT
    16 SLIME

    */

    #mixin Static
    #mixin ModifyConstant
    #{
    #    method: "init",
    #    constant: [
    #       {intValue: 100},
    #       {intValue: 1000},
    #       {intValue: 1600},
    #       {intValue: 4000},
    #       {intValue: 8000},
    #       {intValue: 100000},
    #       {intValue: 400000},
    #       {intValue: 1000000}
    #    ],
    #    slice: {
    #        from: {
    #            value: "NEW",
    #            target: "com/rwtema/extrautils2/api/machine/Machine",
    #            ordinal: 2,
    #            shift: "BEFORE"
    #        }
    #    }
    #}
    function buffMachineCapacityAndTransfer(value as int) as int {
        return min(2000000000 / 64, value * 300);
    }

    /*
      Remove all Pink Generator recipes to rewrite them completely to custom
    */
    #mixin Static
    #mixin WrapOperation
    #{
    #    method: "addMachineRecipes",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lcom/rwtema/extrautils2/api/machine/MachineRecipeRegistry;addRecipe(Lcom/rwtema/extrautils2/api/machine/IMachineRecipe;)V"
    #    }
    #}
    function removePinkGenRecipes(registry as MachineRecipeRegistry, recipe as IMachineRecipe, original as Operation) as void {
        if (!isNull(XUMachineGenerators.PINK_GENERATOR) && registry == XUMachineGenerators.PINK_GENERATOR.recipes_registry) {
            return;
        }
        original.call(registry, recipe);
    }
}

/*
Make Screen not consume power
*/
#mixin {targets: "com.rwtema.extrautils2.tile.TileScreen"}
zenClass MixinTileScreen {
    #mixin ModifyConstant {method: "getPower", constant: {floatValue: 1.0}}
    function setPowerToZero(value as float) as float {
        return 0.0f;
    }
}

/*
Allow Transfer Node to generate Creative Harvest drop with Upgrade Mining
*/
#mixin {targets: "com.rwtema.extrautils2.transfernodes.TransferNodeItem"}
zenClass MixinTransferNodeItem {
    #mixin Shadow
    var stack as SingleStackHandler;

    #mixin Inject {method: "processBuffer", at: {value: "HEAD"}}
    function creativeHarvestMining(attached as IItemHandler, ci as CallbackInfo) as void {
        if (!isNull(attached)) return;
        val upgradeLevel = this0.getUpgradeLevel(Upgrade.MINING);
        if (upgradeLevel <= 0) return;
        if (stack.isFull()) return;

        val world = this0.holder.getWorld();
        val offset = this0.holder.getPos().offset(this0.side);
        val state = world.getBlockState(offset);
        if (!(state.getBlock() instanceof BlockCreativeHarvest)) return;

        val te = world.getTileEntity(offset);
        if (!(te instanceof TileCreativeHarvest)) return;
        val harvest = te as TileCreativeHarvest;
        if (isNull(harvest.mimicState.value)) return;

        val mimicState = harvest.mimicState.value;
        val drops = mimicState.getBlock().getDrops(world, offset, mimicState, 0);
        if (drops.isEmpty()) return;

        for drop in drops {
            val b = drop.copy();
            b.setCount(upgradeLevel);
            if (!stack.isEmpty() && !ItemHandlerHelper.canItemStacksStack(stack.getStack(), b)) continue;
            stack.insertItem(0, b, false);
            break;
        }
    }
}

#mixin {targets: "com.rwtema.extrautils2.machine.BrewingEnergyRecipe"}
zenClass MixinBrewingEnergyRecipe extends EnergyBaseRecipe {

    /*
      Only keep high-tier potions in the generator
    */
    #mixin Inject {method: "getInputValues", at: {value: "RETURN"}, cancellable: true}
    function filterInputValues(cir as CallbackInfoReturnable) as void {
        val original as [ItemStack] = cir.getReturnValue();
        var filtered = [] as [ItemStack];
        for stack in original {
            if (this.getEnergyOutput(stack) >= 409600 * 30) {
                filtered.add(stack);
            }
        }
        cir.setReturnValue(filtered);
    }

    /*
      Multiply energy output
    */
    #mixin Inject {method: "getEnergyOutput", at: {value: "RETURN"}, cancellable: true}
    function multiplyEnergyOutput(stack as ItemStack, cir as CallbackInfoReturnable) as void {
        val originalEnergy = cir.getReturnValue() as Integer as int;
        cir.setReturnValue(originalEnergy * 30);
    }
}
