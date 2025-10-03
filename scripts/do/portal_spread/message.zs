/**
 * @file Send messages about portal spread working
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#priority 2500
#reloadable
#modloaded zenutils

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.util.Position3f;
import crafttweaker.world.IWorld;

import scripts.do.portal_spread.config.Config;
import scripts.do.portal_spread.utils.abs;

// Stylazed icon of portal
// static prefix as string = '§8[§5░§8] ';
static prefix as string = '\u00A78[\u00A75\u2591\u00A78] ';

// Cube radius for messages send
static payerNotifyDistance as int = 40;

function notifyPlayers(world as IWorld, p as Position3f, messageType as string) as void {
  for pl in world.getAllPlayers() {
    if (
      abs(pl.x - p.x) > payerNotifyDistance
      || abs(pl.y - p.y) > payerNotifyDistance
      || abs(pl.z - p.z) > payerNotifyDistance
    ) continue;
    playerMessage(pl, messageType);
  }
}

function getModifierBlock(modifKey as string = null, amount as int = 1) as IItemStack {
  for blockDef, blockMetas in Config.modifBlocksKey {
    for meta, keys in blockMetas {
      for key in keys {
        if (!isNull(modifKey) && key != modifKey) continue;
        val item = itemUtils.getItem(blockDef.id, meta);
        return isNull(item) ? null : item * amount;
      }
    }
  }
  return null;
}

function playerMessage(player as IPlayer, messageType as string) as void {
  var payload as IData = [];

  if (messageType == 'created') {
    // TODO: message about actual modified radius

    payload = [
      Config.defaultRadius,
      tellrawItemObj(getModifierBlock(null, 4), 'gold'),
    ];
  }
  else {
    /* Modifiers can be messaged without blocks
    val modifierKey = messageType.split('_')[0];
    if (Config.modifiersList has modifierKey) {
      payload = [{
        text: '',
        extra: tellrawItem(getModifierBlock(modifierKey), 'gold')
      }];
    } */
  }

  sendPortalMessage(player, {
    translate: 'portal_spread.' ~ messageType,
    with     : payload,
  });
}

function sendPortalMessage(player as IPlayer, rawData as IData) as void {
  player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData([prefix, rawData]));
}

function log(s as string, world as IWorld = null) as void {
  if (!Config.debug) return;
  val msg = prefix ~ (isNull(s) ? '' : s);
  print(msg);

  if (isNull(world)) return;
  for pl in world.getAllPlayers() {
    if (!pl.creative) continue;
    pl.sendMessage(msg);
  }
}

function tellrawItem(item as IItemStack, color as string = null, showName as bool = true) as IData {
  val data = [
    {
      text: item.amount > 1 ? item.amount ~'x' : '',
      hoverEvent: {
        action: 'show_item',
        value: '{id:"' ~ item.definition.id ~ '",Count:1,Damage:' ~ item.damage ~ 's}', // item.toSNBT(),
      },
      extra: [
        {
          // The major part of `iconQuark` is actually 3 spaces, which are reserved for Quark item rendering
          // So you needs Quark to get the icon
          text: '§f   '
        } + (!showName ? {} :
          {extra: [(item.hasDisplayName ? item.tag.display.Name : {translate: item.name ~'.name'})]}
        )
      ]
    }
    + (color ? {color: color} : {}),
  ] as IData;
  return data;
}

function tellrawItemObj(item as IItemStack, color as string = null, showName as bool = true) as IData {
  return {text: '', extra: tellrawItem(item, color, showName)};
}
