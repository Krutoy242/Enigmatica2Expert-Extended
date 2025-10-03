#reloadable
#modloaded zenutils

import crafttweaker.player.IPlayer;
import scripts.do.hand_over_your_items.tellrawItemObj;
import crafttweaker.data.IData;

events.register(function(e as crafttweaker.event.CommandEvent) {
  if(isNull(e.command)
    || (e.command.name != "cofh")
    || (e.parameters.length < 6)
    || (e.parameters[0] != "clearblocks")
    || (e.parameters[5] != "inventory")
    || !(e.commandSender instanceof IPlayer)) {
    return;
  }

  val player as IPlayer = e.commandSender;
  var s = '';
  var itemList = [] as IData;
  for i in 0 .. player.inventorySize {
    val it = player.getInventoryStack(i);
    if (isNull(it)) continue;
    val block = it.asBlock();
    if (isNull(block) || block.definition.id == 'minecraft:air') continue;
    s += ' ' ~ block.definition.id;
    itemList += [tellrawItemObj(it.withAmount(1), null, false)];
  }
  e.cancel();

  player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData([
    "Clearing blocks: ", itemList
  ]));

  player.executeCommand(
    e.command.name ~ ' '
    ~ e.parameters[0] ~ ' '
    ~ e.parameters[1] ~ ' '
    ~ e.parameters[2] ~ ' '
    ~ e.parameters[3] ~ ' '
    ~ e.parameters[4] ~ s
  );
});
