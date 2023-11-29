
#priority 4500
#reloadable
#modloaded zenutils

import crafttweaker.block.IBlock;
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
  // Maximum radius of portal with all modifiers. Must be less that 256
  // Consume maxRadius³ RAM memory
  static maxRadius as int = 64;

  // Radius of portal without modifiers.
  // Must be less than maxRadius
  static defaultRadius as int = 16;

  // Number of ticks between block spread event
  // Can also be 0<x<1. In this case 1/spreadDelay blocks would be transformed for the same tick
  static spreadDelay as double = 1.0;

  // Number of blocks that would be checked for replacement
  static lookup as int = 50;

  // Debug mode to output all portal spread actions
  static debug as bool = false;

  //-----------------------------------------------
  // Technical private fields
  //-----------------------------------------------
	zenConstructor() {}
  // Default list of blocks and their modifiers
  // Find possible modifiers keys as scripts/do/portal_spread/modifiers.zs
  static modifBlocksKey as string[][int][IBlockDefinition]$orderly = {};
  static modifiersList as string[] = []; // List of ID names of modifiers
  static MODIF as int[string] = {}; // Enum of modifiers
  static blockGroupMap as int[string] = {}; // Map of block "id:meta" and its respected number
  static modifierGroupCount as int = 0; // Number of modifier groups
  //-----------------------------------------------
}

///////////////////////////////////////////////////////////
// Localisation
///////////////////////////////////////////////////////////
function addLocales(langEntries as string[string][string], prefix as string = '') as void {
  for lang, entries in langEntries {
    for k, v in entries {
      game.setLocalization(lang, 'portal_spread.'~prefix~k, v);
    }
  }
}

addLocales({
  en_us: {
    created : '§7The corrupted energy from the portal will slowly spread to §6%s§7 blocks around, unless %s §7are placed in the corners.'
              ~'\n§8(Touch the portal to feel its power.)',
    broken  : '§7With the nether portal broken, no more corrupted energy is spreading.',
    info    : '§7The portal emits §3energy waves§7, converting nearby blocks.'
           ~'\n§7■ Waves are emitted §6%s§7 time(s) per §6%s§7 second(s).'
           ~'\n§7■ Each wave searches up to §6%s§7 blocks until conversion.'
           ~'\n§7■ The portal has a reach of up to §6%s§7 blocks in radius.',
    idle    : '§7This portal halted and can\'t spread its energy.',
  },
  zh_cn: {
    created : '§7来自下界传送门的腐化能量会缓慢扩散到传送门附近 §6%s§7 格的范围内，除非把 %s §7放置在传送门的四个角落。'
             ~'\n§8(触摸传送门，感受它的力量。)',
    broken  : '§7下界传送门已被破坏，腐化能量不再扩散。',
    info    : '§7这个传送门发射能量的§3波浪§7，将其周围的方块转化。'
             ~'§7■ 每§6%s§7秒发射§6%s§7次波动。'
             ~'§7■ 每个波浪搜索最多§6%s§7个方块，直到至少一个被转化。'
             ~'§7■ 该传送门的影响范围可达§6%s§7个方块的半径。',
    idle    : '§7这个传送门停止了，无法传播能量。',
  },
});
///////////////////////////////////////////////////////////

/**
 * Add or rewrite modifier block
 * 
 * @param items - list of blocks in item forms that could be used for configuring portal
 * 
 * @param keys - list of modifier keys for this blocks
 * 
 * @param langEntries - List of messages that
 *   players will receive when changing portal setup.
 * Must content this fields:
 * {
 *   add: "Message that player get when placed one of listed blocks"
 *   red: "Message when one of blocks removed"
 *   max: "Message when all 4 blocks of this group placed"
 * }
 * 
 */
function setModifier(
  items as IIngredient,
  keys as string[],
  langEntries as string[string][string] = null
) as void {

  // Fill all items to array
  for item in items.itemArray {
    val block = item.asBlock();
    if(isNull(block)) {
      logger.logWarning('[Portal Spread]: cannot transform item to block: '~item.commandString);
      continue;
    }
    if(isNull(Config.modifBlocksKey[block.definition])) Config.modifBlocksKey[block.definition] = {};

    // This block already defined
    if(!isNull(Config.modifBlocksKey[block.definition][block.meta])) continue;

    Config.modifBlocksKey[block.definition][block.meta] = [];
    var newKeys = Config.modifBlocksKey[block.definition][block.meta];
    for key in keys {
      newKeys += key;
    }
    Config.modifBlocksKey[block.definition][block.meta] = newKeys;

    // Add this block to group
    Config.blockGroupMap[block.definition.id~':'~block.meta] = Config.modifierGroupCount;
  }

  // Add key if new
  for key in keys {
    if(!(Config.modifiersList has key)) {
      Config.modifiersList = Config.modifiersList + key;
      Config.MODIF[key] = Config.modifiersList.length - 1;
    }
  }

  // Add localisation if exist
  if(!isNull(langEntries)) addLocales(langEntries, Config.modifierGroupCount~'_');
  Config.modifierGroupCount += 1;
}

///////////////////////////////////////////////////////////
// Default Modifiers
///////////////////////////////////////////////////////////

// Very first item of first modifier here will be proposed to stop portal from spreading

setModifier(
  <minecraft:coal_block> | <ore:blockCoal>, ['slow', 'weak', 'small'], {
    en_us: {
      add: '§7You feel the portal energy becoming §3weaker§7.',
      red: '§7You feel the portal energy becoming §6stronger§7.',
      max: '§7Portal completely stopped spreading.',
    },
    zh_cn: {
      add: '§7你感到下界传送门扩散的速度正在减缓。',
      red: '§7你感到下界传送门扩散的速度正在加快。',
      max: '§7传送门完全停止了扩散。',
    }
});

setModifier(
  <contenttweaker:conglomerate_of_coal>, ['fast', 'potent', 'large'], {
    en_us: {
      add: '§7You feel the portal energy becoming §6stronger§7.',
      red: '§7You feel the portal energy becoming §3weaker§7.',
      max: '§7Portal reached maximum spreading speed.',
    },
});
