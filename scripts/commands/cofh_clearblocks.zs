/*

Allow `/cofh clearblocks <x> <y> <z> <radius> <dimension> inventory` command
for easily select blocks to clear from inventory.

*/

#reloadable
#modloaded zenutils

import crafttweaker.player.IPlayer;
import scripts.do.hand_over_your_items.tellrawItemObj;
import crafttweaker.data.IData;

events.register(function (e as crafttweaker.event.CommandEvent) {
  if (isNull(e.command)
    || (e.command.name != 'cofh')
    || (e.parameters.length < 6)
    || (e.parameters[0] != 'clearblocks')
    || !(e.commandSender instanceof IPlayer)) {
    return;
  }

  var inventoryIndex = -1;
  for i in 0 .. e.parameters.length {
    if (e.parameters[i] == 'inventory') {
      inventoryIndex = i;
      break;
    }
  }
  if (inventoryIndex == -1) return;

  val player as IPlayer = e.commandSender;
  var blockList = '';
  var itemList = [] as IData;
  for i in 0 .. player.inventorySize {
    val it = player.getInventoryStack(i);
    if (isNull(it)) continue;
    val block = it.asBlock();
    if (isNull(block) || block.definition.id == 'minecraft:air') continue;
    blockList += ' ' ~ block.definition.id;
    itemList += [tellrawItemObj(it.withAmount(1), null, false)];
  }
  e.cancel();

  player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData([
    'Clearing blocks: ', itemList,
  ]));

  var cmd = e.command.name;
  for i in 0 .. e.parameters.length {
    if (i == inventoryIndex) {
      cmd += blockList;
    }
    else {
      cmd += ' ' ~ e.parameters[i];
    }
  }

  player.executeCommand(cmd);
});
