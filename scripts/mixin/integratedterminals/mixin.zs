#modloaded integratedterminals
#loader mixin

import mixin.CallbackInfo;
import mixin.Operation;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.inventory.Container;
import native.net.minecraft.item.ItemStack;
import native.org.cyclops.integratedterminals.core.terminalstorage.TerminalStorageTabIngredientComponentItemStackCraftingCommon;
import native.org.cyclops.integratedterminals.inventory.container.ContainerTerminalStorage;
import native.org.cyclops.integratedterminals.part.PartTypeTerminalStorage.State;

/*
  Auto-refill recalculates the recipe and synchronizes the container for each
  ingredient. Update once after consumption and refill finish.
*/
#mixin { targets: 'org.cyclops.integratedterminals.inventory.SlotCraftingAutoRefill' }
zenClass MixinSlotCraftingAutoRefill {
  #mixin Shadow
  #mixin Final
  var tabCommon as TerminalStorageTabIngredientComponentItemStackCraftingCommon;

  #mixin Shadow
  #mixin Final
  var container as ContainerTerminalStorage;

  #mixin WrapMethod { method: 'func_190901_a', require: 1 }
  function coalesceCraft(player as EntityPlayer, stack as ItemStack, original as Operation) as ItemStack {
    if (player.field_70170_p.field_72995_K) return original.call(player, stack);
    val previous = scripts.mixin.integratedterminals.shared.Op.activeCraftingTab;
    scripts.mixin.integratedterminals.shared.Op.activeCraftingTab = tabCommon;
    val result = original.call(player, stack) as ItemStack;
    scripts.mixin.integratedterminals.shared.Op.activeCraftingTab = previous;
    tabCommon.updateCraftingResult(player, container, container.partState);
    container.detectAndSendChanges();
    return result;
  }

  #mixin Redirect
  #{
  #  method: 'func_190901_a',
  #  at: { value: 'INVOKE', target: 'Lnet/minecraft/inventory/Container;func_75142_b()V' },
  #  require: 1
  #}
  function deferContainerSync(owner as Container) as void {
    // NO-OP: synchronize after refill in coalesceCraft.
  }
}

/*
  Refilling the grid triggers recipe updates for intermediate slot states.
  Recalculate after the complete craft; manual grid edits still update immediately.
*/
#mixin { targets: 'org.cyclops.integratedterminals.core.terminalstorage.TerminalStorageTabIngredientComponentItemStackCraftingCommon' }
zenClass MixinTerminalStorageTabIngredientComponentItemStackCraftingCommon {
  #mixin WrapWithCondition
  #{
  #  method: 'lambda$loadSlots$0',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lorg/cyclops/integratedterminals/core/terminalstorage/TerminalStorageTabIngredientComponentItemStackCraftingCommon;updateCraftingResult(Lnet/minecraft/entity/player/EntityPlayer;Lnet/minecraft/inventory/Container;Lorg/cyclops/integratedterminals/part/PartTypeTerminalStorage$State;)V'
  #  },
  #  require: 1
  #}
  function updateOnlyOutsideCraft(tab as TerminalStorageTabIngredientComponentItemStackCraftingCommon, player as EntityPlayer, owner as Container, state as State) as bool {
    return scripts.mixin.integratedterminals.shared.Op.activeCraftingTab != tab;
  }
}

/*
  Clear the crafting marker so a failed craft cannot suppress later recipe updates.
*/
#mixin { targets: 'org.cyclops.integratedterminals.inventory.container.ContainerTerminalStorage' }
zenClass MixinContainerTerminalStorage {
  #mixin Inject { method: 'func_75142_b', at: { value: 'HEAD' }, require: 1 }
  function clearStaleCraftScope(ci as CallbackInfo) as void {
    scripts.mixin.integratedterminals.shared.Op.activeCraftingTab = null;
  }
}

/*
  The Shift-click handler recalculates a result already updated by onTake.
  Skip the duplicate calculation.
*/
#mixin { targets: 'org.cyclops.integratedterminals.network.packet.TerminalStorageIngredientItemStackCraftingGridShiftClickOutput' }
zenClass MixinTerminalStorageIngredientItemStackCraftingGridShiftClickOutput {
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
