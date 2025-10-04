#reloadable
#priority -1200
#modloaded zenutils scalinghealth

import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.data.IData;
import mods.zenutils.NetworkHandler;
import crafttweaker.util.Math;

import scripts.do.hand_over_your_items.tellrawItemObj;
import scripts.do.acquire.data.getStageName;
import scripts.do.acquire.data.getGroupAsMessageData;
import scripts.do.acquire.data.formatDouble;
import scripts.do.acquire.data.sendAcquireMessage;

function onAcquire(acquireType as string, player as IPlayer, stack as IItemStack) as void {
  val value_ = scripts.do.acquire.data.values[stack];
  if (isNull(value_)) return; // No value for a stack
  val value = value_ as double;

  val actualValue as double = Math.max(Math.min(value, 1000.0 - player.difficulty), 0.0);

  // Find items in group
  val groupName = scripts.do.acquire.data.groups[stack];

  val stage = getStageName(groupName, stack);
  if (player.hasGameStage(stage)) return; // Already acquired
  player.addGameStage(stage);
  player.difficulty += actualValue;

  val newLine = { translate: 'e2ee.acquire.prefix' } as IData;

  sendAcquireMessage(player, [{
      translate: isNull(groupName) ? 'e2ee.acquire.single' : 'e2ee.acquire.group',
      with     : [
        isNull(groupName) ? tellrawItemObj(stack, 'aqua') : getGroupAsMessageData(groupName),
      ],
    },
    newLine,
    { translate: 'e2ee.acquire.on.' ~ acquireType },
    newLine,
    actualValue <= 0
      ? { translate: 'e2ee.acquire.max_already' } as IData
      : { translate: 'e2ee.acquire.difficulty', with: [
        { text: formatDouble(actualValue) },
        { text: formatDouble(player.difficulty) },
      ] },
    newLine,
    {
      translate: 'e2ee.acquire.more',
      hoverEvent:{
        action: 'show_text',
        value: 'execute "/acquire info"'
      },
      clickEvent: {
        action: 'run_command',
        value: '/acquire info',
      },
  }]);

  NetworkHandler.sendToAllAround('acquire', player.x, player.y, player.z, 30, player.world.getDimension(), function(b){
    b.writeData({
      x: player.x, y: player.y + player.eyeHeight / 2, z:player.z,
      value: actualValue
    });
  });
}
