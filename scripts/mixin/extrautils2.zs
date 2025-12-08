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
}
