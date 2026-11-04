#modloaded integratedterminals integratedderivative
#loader mixin

import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.inventory.Container;
import native.org.cyclops.integratedterminals.core.terminalstorage.TerminalStorageTabIngredientComponentItemStackCraftingCommon;
import native.org.cyclops.integratedterminals.part.PartTypeTerminalStorage.State;

/*
  Integrated Derivative's Shift-click packet repeats the crafting result update.
  Skip it because coalesceCraft already calculates the next result.
*/
#mixin { targets: 'com.teamdimensional.integratedderivative.network.TerminalPacketShiftClickOutputOptimized' }
zenClass MixinTerminalPacketShiftClickOutputOptimized {
  #mixin WrapWithCondition
  #{
  #  method: 'actionServer',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lorg/cyclops/integratedterminals/core/terminalstorage/TerminalStorageTabIngredientComponentItemStackCraftingCommon;updateCraftingResult(Lnet/minecraft/entity/player/EntityPlayer;Lnet/minecraft/inventory/Container;Lorg/cyclops/integratedterminals/part/PartTypeTerminalStorage$State;)V'
  #  },
  #  require: 1
  #}
  function skipDuplicateResult(tab as TerminalStorageTabIngredientComponentItemStackCraftingCommon, player as EntityPlayer, owner as Container, state as State) as bool {
    return false;
  }
}
