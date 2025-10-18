#modloaded zenutils
#sideonly client
#reloadable

import native.net.minecraft.client.gui.GuiButton;
import native.net.minecraft.client.gui.GuiLabel;
import native.net.minecraft.client.gui.inventory.GuiContainer;
import native.net.minecraft.inventory.Slot;

/**
 * This whitelist contains regular expression patterns for GUI class names that should always be allowed,
 * even if they would otherwise be blocked by the heuristics below.
 * Use this to add exceptions for menus or informational screens that don't pause the game.
 */
static whitelist as string[] = [
  'net.minecraft.client.gui.Gui(?!Repair).+',
  'net.minecraft.client.gui.Screen.+',
  'net.minecraftforge.fml.client.Gui.+',
  
  '.*scalingguis.*',
  '.*nutrition.*',
  // 'com.feed_the_beast.ftblib.lib.gui.GuiWrapper', // FTB Quests, etc.
];

/*

All known guis:

"appeng.client.gui.implementations.GuiCraftAmount",
"appeng.client.gui.implementations.GuiCraftConfirm",
"appeng.client.gui.implementations.GuiCraftingTerm",
"appeng.client.gui.implementations.GuiDrive",
"appeng.client.gui.implementations.GuiInterfaceTerminal",
"appeng.client.gui.implementations.GuiNetworkStatus",
"appeng.client.gui.implementations.GuiPatternTerm",
"appeng.client.gui.implementations.GuiUpgradeable",
"baubles.client.gui.GuiPlayerExpanded",
"ca.wescook.nutrition.gui.NutritionGui",
"codechicken.enderstorage.client.gui.GuiEnderItemStorage",
"cofh.thermalexpansion.gui.client.machine.GuiCompactor",
"cofh.thermalexpansion.gui.client.machine.GuiCrucible",
"cofh.thermalexpansion.gui.client.storage.GuiCell",
"com.blakebr0.extendedcrafting.client.gui.GuiEliteTable",
"com.brandon3055.draconicevolution.client.gui.GuiDraconiumChest",
"com.buuz135.industrial.api.book.gui.GUIBookPage",
"com.cleanroommc.modularui.screen.GuiScreenWrapper",
"com.feed_the_beast.ftblib.lib.gui.GuiWrapper",
"com.fuzs.gamblingstyle.client.gui.GuiVillager",
"com.github.mrnerdy42.keywizard.gui.GuiKeyWizard",
"com.github.terminatornl.laggoggles.client.gui.GuiProfile",
"com.glodblock.github.client.client.gui.GuiWrapInterface",
"com.invadermonky.omniwand.client.GuiWand",
"com.lothrazar.cyclicmagic.block.anvil.GuiAnvilAuto",
"com.lothrazar.cyclicmagic.block.buildplacer.GuiPlacer",
"com.lothrazar.cyclicmagic.item.storagesack.GuiStorage",
"com.lothrazar.cyclicmagic.playerupgrade.storage.GuiPlayerExtended",
"com.pg85.otg.forge.gui.mainmenu.OTGGuiWorldSelection",
"com.rwtema.extrautils2.gui.backend.DynamicGui",
"com.tiviacz.travelersbackpack.gui.GuiTravelersBackpack",
"com.zeitheron.hammercore.client.gui.impl.GuiCustomizeSkinHC",
"cpw.mods.ironchest.client.gui.chest.GUIChest",
"crazypants.enderio.machines.machine.alloy.GuiAlloySmelter$Normal",
"crazypants.enderio.machines.machine.painter.GuiPainter",
"crazypants.enderio.machines.machine.sagmill.GuiSagMill",
"cyb0124.curvy_pipes.client.BaseScreen",
"de.ellpeck.actuallyadditions.mod.inventory.gui.GuiLaserRelayItemWhitelist",
"dmillerw.menu.gui.GuiRadialMenu",
"ic2.core.block.machine.gui.GuiMatter",
"io.enderdev.endermodpacktweaks.features.keybinds.GuiNewControls",
"io.github.phantamanta44.threng.client.gui.GuiCentrifuge",
"io.github.srdjanv.forkedproxy.client.gui.GuiAccessProxy",
"li.cil.oc.client.gui.Robot",
"lumien.custommainmenu.gui.GuiCustom",
"mcjty.rftools.blocks.teleporter.GuiMatterTransmitter",
"mekanism.client.gui.filter.GuiMFilterSelect",
"mekanism.client.gui.filter.GuiMItemStackFilter",
"mekanism.client.gui.filter.GuiMModIDFilter",
"mekanism.client.gui.filter.GuiMOreDictFilter",
"mekanism.client.gui.GuiDigitalMiner",
"mekanism.client.gui.GuiDigitalMinerConfig",
"mekanism.client.gui.GuiEnergyCube",
"mekanism.client.gui.GuiFactory",
"mekanism.client.gui.GuiFluidTank",
"mezz.jei.gui.recipes.RecipesGui",
"net.bdew.generators.controllers.turbine.GuiTurbine",
"net.minecraft.client.gui.GuiChat",
"net.minecraft.client.gui.GuiConfirmOpenLink",
"net.minecraft.client.gui.GuiHopper",
"net.minecraft.client.gui.GuiIngameMenu",
"net.minecraft.client.gui.GuiOptions",
"net.minecraft.client.gui.GuiRepair",
"net.minecraft.client.gui.GuiScreenWorking",
"net.minecraft.client.gui.GuiSnooper",
"net.minecraft.client.gui.GuiVideoSettings",
"net.minecraft.client.gui.inventory.GuiChest",
"net.minecraft.client.gui.inventory.GuiContainerCreative",
"net.minecraft.client.gui.inventory.GuiInventory",
"net.minecraft.client.gui.inventory.GuiShulkerBox",
"net.minecraft.client.gui.ScreenChatOptions",
"net.minecraftforge.fml.client.config.GuiConfig",
"net.minecraftforge.fml.client.GuiConfirmation",
"net.ndrei.teslacorelib.gui.BasicTeslaGuiContainer",
"org.cyclops.integrateddynamics.client.gui.GuiLogicProgrammerPortable",
"org.dave.compactmachines3.gui.machine.GuiMachine",
"p455w0rd.danknull.client.gui.GuiDankNull",
"slimeknights.tconstruct.tools.common.client.GuiCraftingStation",
"spazley.scalingguis.gui.guiconfig.GuiConfigSG",
"thaumcraft.client.gui.GuiPech",
"thaumcraft.client.gui.GuiResearchBrowser",
"twilightforest.client.GuiTFGoblinCrafting",
"wile.engineersdecor.blocks.BlockDecorLabeledCrate$BGui",
"wolforce.vaultopic.client.GuiVICE",
"xaero.map.gui.GuiMap",
"zmaster587.libVulpes.inventory.GuiModular",
"zone.rong.loliasm.common.crashes.GuiCrashScreen",
*/

events.register(function(event as native.net.minecraftforge.client.event.GuiOpenEvent) {
  if (!client.player.hasGameStage('nogui')) return;

  val gui = event.getGui();
  if(isNull(gui)) return;
  val guiClass = typeof(gui);

  ////////////////////////////////////////////////////////////////////
  utils.log('~~~ gui: '~guiClass);
  utils.log('  toString: ' ~ gui.toString());
  utils.log('  width: ' ~ gui.width);
  utils.log('  height: ' ~ gui.height);
  utils.log('  allowUserInput: ' ~ gui.allowUserInput);
  utils.log('  doesGuiPauseGame: ' ~ gui.doesGuiPauseGame());
  utils.log('  zLevel: ' ~ gui.zLevel);
  
  if(!isNull(gui.buttonList)) {
    val list as [GuiButton] = gui.buttonList;
    utils.log('  buttonList (' ~ list.length ~ '):');
    for button in list {
      if(isNull(button)) continue;
      utils.log('    id: ' ~ button.id ~ ', text: "' ~ button.displayString ~ '", enabled: ' ~ button.enabled ~ ', visible: ' ~ button.visible ~ ', x: ' ~ button.x ~ ', y: ' ~ button.y ~ ', width: ' ~ button.width ~ ', height: ' ~ button.height);
    }
  }

  if(!isNull(gui.labelList)) {
    val list as [GuiLabel] = gui.labelList;
    utils.log('  labelList (' ~ list.length ~ '):');
    for label in list {
      if(isNull(label)) continue;
      utils.log('    visible: ' ~ label.visible ~ ', x: ' ~ label.x ~ ', y: ' ~ label.y ~ ', centered: ' ~ label.centered);
    }
  }

  if(!isNull(gui.selectedButton)) {
    utils.log('  selectedButton: ' ~ gui.selectedButton.displayString);
  }
  
  var containerGuiLog as GuiContainer = null;
  if (gui instanceof GuiContainer) {
    containerGuiLog = gui;
  }
  
  if (!isNull(containerGuiLog)) {
    val container = containerGuiLog.inventorySlots;
    if (!isNull(container)) {
      utils.log('  Container windowId: ' ~ container.windowId);
      if (!isNull(container.inventorySlots)) {
        val slots as [Slot] = container.inventorySlots;
        utils.log('  Container slots (' ~ slots.length ~ '):');
      }
    }
  }
  ////////////////////////////////////////////////////////////////////

  // 1. Whitelist Check: If the GUI class matches any pattern in the whitelist, always allow it.
  for pattern in whitelist {
    if (guiClass.matches(pattern)) {
      return;
    }
  }

  // 2. Heuristic Check: Block GUIs that are containers OR don't pause the game.
  // This effectively targets gameplay-related GUIs (chests, machines, etc.).
  var containerGui as GuiContainer = null;
  if (gui instanceof GuiContainer) {
    containerGui = gui;
  }

  if (!gui.doesGuiPauseGame() || !isNull(containerGui)) {
    utils.log('NoGUI: Blocked ' ~ guiClass);
    event.setGui(null);
  }
});
