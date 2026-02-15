#modloaded extrautils2
#loader mixin

import native.com.rwtema.extrautils2.api.machine.Machine;
import native.com.rwtema.extrautils2.api.machine.MachineRegistry;
import native.com.rwtema.extrautils2.api.machine.XUMachineCrusher;
import native.com.rwtema.extrautils2.network.XUPacketBuffer;

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
