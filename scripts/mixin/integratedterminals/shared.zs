#modloaded integratedterminals
#loader mixin
#priority 3000

import native.org.cyclops.integratedterminals.core.terminalstorage.TerminalStorageTabIngredientComponentItemStackCraftingCommon;

/*
  Track the crafting tab while ingredients are consumed and refilled.
*/
zenClass Op {
  static activeCraftingTab as TerminalStorageTabIngredientComponentItemStackCraftingCommon;
}

