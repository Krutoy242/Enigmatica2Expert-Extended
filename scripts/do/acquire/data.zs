#reloadable
#priority -1100
#modloaded zenutils scalinghealth

import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.data.IData;
import mods.zenutils.NetworkHandler;

import scripts.do.hand_over_your_items.tellrawItemObj;

static values as double[IItemStack] = {} as double[IItemStack]$orderly;
static groups as string[IItemStack] = {} as string[IItemStack]$orderly;

function getStageName(groupName as string, stack as IItemStack) as string {
  return '✪' ~ (
    isNull(groupName)
      ? stack.commandString
      : ('group_' ~ groupName)
  );
}

function getGroupAsMessageData(groupName as string, startPos as int = 0, maxLength as int = 26) as IData {
  var group as IData = [] as IData;
  // Get length of grouped items
  var length = startPos;
  for _, otherGroupName in groups {
    if (otherGroupName == groupName) length += 1;
  }
  val rows = length / maxLength + 1; // max length of items in a line
  val step = (length as double / rows + 0.5) as int;

  // Create array of items for the group
  var i = startPos;
  for stack, otherGroupName in groups {
    if (otherGroupName == groupName) {
      if (group.length != 0 && i % step == 0)
        group += [{ translate: 'e2ee.acquire.prefix' }];
      group += [tellrawItemObj(stack, null, false)];
      i += 1;
    }
  }
  return group;
}

function formatDouble(value as double) as string {
  return (value - value as int) > 0.0
    ? ((value * 100) as int as double / 100) as string
    : value as int as string;
}

// Send message with header and prefixes
function sendAcquireMessage(player as IPlayer, messageData as IData) as void {
  player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData([
    { translate: 'e2ee.acquire.header' },
    { translate: 'e2ee.acquire.prefix' },
    messageData,
    '\n', { translate: 'e2ee.acquire.footer' },
  ]));
}