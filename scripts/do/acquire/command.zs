#reloadable
#modloaded zenutils scalinghealth
#priority -1800

import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.data.IData;
import scripts.do.hand_over_your_items.tellrawItemObj;
import scripts.do.acquire.data.formatDouble;
import scripts.do.acquire.data.sendAcquireMessage;

val cmd = mods.zenutils.command.ZenCommand.create('acquire');
cmd.requiredPermissionLevel = 0;

cmd.getCommandUsage = function (sender) {
  return '§6═§e⭐§6═ §7/acquire §8<§7info§8>'
  ~ '\n§7info§8: show actual information'
  ;
};

val tabCompletion as mods.zenutils.command.IGetTabCompletion = function (server, sender, pos) {
  return mods.zenutils.StringList.create([
    'info',
  ]);
};
cmd.tabCompletionGetters = [tabCompletion];

cmd.execute = function (command, server, sender, args) {
  val player = mods.zenutils.command.CommandUtils.getCommandSenderAsPlayer(sender);

  if (args.length >= 1) {
    if (args[0] == 'info') {
      val groupItems = {} as IItemStack[][string];
      for stack, groupName in scripts.do.acquire.data.groups {
        if(isNull(groupItems[groupName])) groupItems[groupName] = [stack] as IItemStack[];
        else groupItems[groupName] = groupItems[groupName] + stack;
      }

      var textData = [] as IData;
      var alreadyAcquiredValue = 0.0;
      val prefix = [{ translate: 'e2ee.acquire.prefix' }] as IData;

      // Single items
      for stack, value in scripts.do.acquire.data.values {
        if (!isNull(scripts.do.acquire.data.groups[stack])) continue;
        if (player.hasGameStage(scripts.do.acquire.data.getStageName(null, stack))) {
          alreadyAcquiredValue += value;
        } else {
          textData += [
            (textData.length == 0 ? '' : '§7, ') ~ '§6+' ~ formatDouble(value) ~ '§7:',
            tellrawItemObj(stack, null, false)
          ];
          if (textData.length / 2 % 10 == 0) textData += prefix;
        }
      }

      // Grouped items
      for groupName, items in groupItems {
        val stack = items[0];
        val value = scripts.do.acquire.data.values[stack] as double;
        if (player.hasGameStage(scripts.do.acquire.data.getStageName(groupName, stack))) {
          alreadyAcquiredValue += value;
        } else {
          if (textData.length > 0) textData += prefix;
          textData += ['§6+' ~ formatDouble(value) ~ '§7:'] as IData
            + scripts.do.acquire.data.getGroupAsMessageData(groupName, 2);
        }
      }

      sendAcquireMessage(player, [
        { translate: 'e2ee.acquire.info', with: [
          alreadyAcquiredValue,
          textData.length > 0
            ? { translate: 'e2ee.acquire.info.other', with: [textData] }
            : { translate: 'e2ee.acquire.info.complete' }
      ]}]);
      return;
    }
  }

  mods.zenutils.command.CommandUtils.notifyWrongUsage(command, sender);
};
cmd.register();
