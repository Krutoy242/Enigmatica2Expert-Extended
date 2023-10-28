/**
 * @file Send messages about portal spread working
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#priority 2500
#reloadable

import crafttweaker.player.IPlayer;
import crafttweaker.text.ITextComponent.fromTranslation;
import crafttweaker.text.ITextComponent.fromString;
import crafttweaker.util.Position3f;
import crafttweaker.world.IWorld;
import mods.ctutils.utils.Math.abs;

// Stylazed icon of portal
// static prefix as string = '§8[§5░§8] ';
static prefix as string = '\u00A78[\u00A75\u2591\u00A78] ';

// Cube radius for messages send
static payerNotifyDistance as int = 40;

////////////////////////////////////////////////////////////////////////////
// Localisation
////////////////////////////////////////////////////////////////////////////
for lang, entries in {
  en_us: {
    created_1: '§7The corrupted energy from the portal will slowly spread to §6%s§7 blocks around, unless ',
    created_2:          '§7 are placed in the corners.',
    broken   : '§7With the nether portal broken, no more corrupted energy is spreading.',
    slow_red : '§7With §6%s§7 removed, you feel the portal spreading faster.',
    slow_add : '§7With §6%s§7 placed, you feel the portal spreading slower.',
    slow_max : '§7Portal completely stopped spreading.',
  },
  zh_cn: {
    created_1: '§7来自下界传送门的腐化能量会缓慢扩散到传送门附近 §6%s§7 格的范围内，除非把 ',
    created_2:          '§7 放置在传送门的四个角落。',
    broken   : '§7下界传送门已被破坏，腐化能量不再扩散。',
    slow_red : '§7有 §6%s§7 被移除了，你感到下界传送门扩散的速度正在加快。',
    slow_add : '§7有 §6%s§7 被放置了，你感到下界传送门扩散的速度正在减缓。',
    slow_max : '§7传送门完全停止了扩散。',
  },
} as string[string][string] {
  for k, v in entries {
    game.setLocalization(lang, 'portal_spread.'~k, v);
  }
}
////////////////////////////////////////////////////////////////////////////

function notifyPlayers(world as IWorld, p as Position3f, messageType as string) as void {
  for pl in world.getAllPlayers() {
    if(
      abs(pl.x - p.x) > payerNotifyDistance ||
      abs(pl.y - p.y) > payerNotifyDistance ||
      abs(pl.z - p.z) > payerNotifyDistance
    ) continue;
    playerMessage(pl, messageType);
  }
}

function playerMessage(player as IPlayer, messageType as string) as void {
  val msgLang = 'portal_spread.'~messageType;

  if (messageType == 'created') {
    utils.tellrawSend(player,
      '{"text":"'~prefix~'"}'
      ~',{"translate":"'~msgLang~'_1","with":["'~scripts.do.portal_spread.utils.MAX_R~'"]}'
      // TODO: Make 'minecraft:coal_block' there dynamic, not static
      ~','~utils.tellrawItem(itemUtils.getItem('minecraft:coal_block'), 'gold')
      ~',{"translate":"'~msgLang~'_2"}'
    );
  } else {
    player.sendRichTextMessage(fromString(prefix) + fromTranslation(msgLang));
  }
}
