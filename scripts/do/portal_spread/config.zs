#priority 4500
#loader preinit
#modloaded zenutils

import crafttweaker.block.IBlockDefinition;
import crafttweaker.item.IIngredient;

/*
 ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗
██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝
██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
 ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝
*/

zenClass Config {
  // Radius of portal without modifiers.
  // Must be less than maxRadius
  static defaultRadius as int = 16;

  // Number of ticks between block spread event
  // Can also be 0<x<1. In this case 1/spreadDelay blocks would be transformed for the same tick
  static spreadDelay as double = 1.0;

  // Number of blocks that would be checked for replacement
  static lookup as int = 50;

  // Debug mode to output all portal spread actions
  // Could be enabled with command /portal_spread debug
  static debug as bool = false;

  // Stylazed icon of portal '§8[§5░§8] ';
  static prefix as string = '\u00A78[\u00A75\u2591\u00A78] ';

  // -----------------------------------------------
  // Technical private fields
  // -----------------------------------------------
  zenConstructor() {}
  // Default list of blocks and their modifiers
  // Find possible modifiers keys as scripts/do/portal_spread/modifiers.zs
  static modifBlocksKey as string[][int][IBlockDefinition]$orderly = {};
  static modifiersList as string[] = []; // List of ID names of modifiers
  static MODIF as int[string] = {}; // Enum of modifiers
  static blockGroupMap as int[string] = {}; // Map of block "id:meta" and its respected number
  static modifierGroupCount as int = 0; // Number of modifier groups
  // -----------------------------------------------
}

///////////////////////////////////////////////////////////

/**
 * Add or rewrite modifier block
 *
 * @param items - list of blocks in item forms that could be used for configuring portal
 *
 * @param keys - list of modifier keys for this blocks
 *
 */
function setModifier(
  items as IIngredient,
  keys as string[],
  addTooltip as bool = false
) as void {
  // Add tooltips
  if (addTooltip) {
    var tooltip_text = game.localize('portal_spread.modifier.header');
    for key in keys {
      tooltip_text += '\n' + game.localize('portal_spread.modifier.' + key);
    }
    for i, line in tooltip_text.split('\n|<br>') {
      items.addTooltip((i == 0 ? Config.prefix : '') ~ line);
    }
  }

  // Fill all items to array
  for item in items.itemArray {
    val block = item.asBlock();
    if (isNull(block)) {
      logger.logWarning('[Portal Spread]: cannot transform item to block: ' ~ item.commandString);
      continue;
    }
    if (isNull(Config.modifBlocksKey[block.definition])) Config.modifBlocksKey[block.definition] = {};

    // This block already defined
    if (!isNull(Config.modifBlocksKey[block.definition][block.meta])) continue;

    Config.modifBlocksKey[block.definition][block.meta] = [];
    var newKeys = Config.modifBlocksKey[block.definition][block.meta];
    for key in keys {
      newKeys += key;
    }
    Config.modifBlocksKey[block.definition][block.meta] = newKeys;

    // Add this block to group
    Config.blockGroupMap[block.definition.id ~ ':' ~ block.meta] = Config.modifierGroupCount;
  }

  // Add key if new
  for key in keys {
    if (!(Config.modifiersList has key)) {
      Config.modifiersList = Config.modifiersList + key;
      Config.MODIF[key] = Config.modifiersList.length - 1;
    }
  }

  Config.modifierGroupCount += 1;
}
