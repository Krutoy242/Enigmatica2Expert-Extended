#reloadable
#modloaded zenutils scalinghealth roidtweaker gamestages
#priority -1800

import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import mods.zenutils.command.CommandUtils;
import mods.zenutils.command.ZenCommand;
import mods.zenutils.StringList;

import scripts.lib.command.resolveTargetPlayer;
import scripts.lib.command.senderAsPlayerOrNull;
import scripts.do.hand_over_your_items.tellrawItemObj;
import scripts.do.acquire.data.formatDouble;
import scripts.do.acquire.data.sendAcquireMessage;

val cmd = ZenCommand.create('acquire');
cmd.requiredPermissionLevel = 0;

cmd.getCommandUsage = function (sender) {
  return '§6═§e⭐§6═ §7/acquire §8<§7info§8> §7[<§7player§8>]'
  ~ '\n§7info§8: show actual information'
  ;
};

val tabCompletion as mods.zenutils.command.IGetTabCompletion = function (server, sender, pos) {
  return StringList.create(['info']);
};
cmd.tabCompletionGetters = [tabCompletion, mods.zenutils.command.IGetTabCompletion.player()];

cmd.execute = function (command, server, sender, args) {
  if (args.length >= 1) {
    if (args[0] == 'info') {
      val player = resolveTargetPlayer(server, sender, args, 1);
      if (isNull(player)) {
        CommandUtils.notifyWrongUsage(command, sender);
        return;
      }

      if (isNull(senderAsPlayerOrNull(sender))) {
        var alreadyAcquiredValue = 0.0;
        var plainLines = '' as string;

        for stack, value in scripts.do.acquire.data.values {
          if (!isNull(scripts.do.acquire.data.groups[stack])) continue;
          if (player.hasGameStage(scripts.do.acquire.data.getStageName(null, stack))) {
            alreadyAcquiredValue += value;
          }
          else {
            plainLines ~= (plainLines == '' ? '' : '\n') ~ '§6+' ~ formatDouble(value) ~ '§7: ' ~ stack.displayName;
          }
        }

        val header = '§6═══ §e⭐ §6═══ §7Acquire Info';
        val footer = '§6═══ §e⭐ §6═══';
        val acquiredLine = '§7Already acquired: §6' ~ formatDouble(alreadyAcquiredValue);
        val itemsLine = plainLines == '' ? '§aAll items acquired!' : '§7Remaining items:\n' ~ plainLines;
        sender.sendMessage(header ~ '\n' ~ acquiredLine ~ '\n' ~ itemsLine ~ '\n' ~ footer);
        return;
      }

      val groupItems = {} as IItemStack[][string];
      for stack, groupName in scripts.do.acquire.data.groups {
        if (isNull(groupItems[groupName])) groupItems[groupName] = [stack] as IItemStack[];
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
        }
        else {
          textData += [
            (textData.length == 0 ? '' : '§7, ') ~ '§6+' ~ formatDouble(value) ~ '§7:',
            tellrawItemObj(stack, null, false),
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
        }
        else {
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
            : { translate: 'e2ee.acquire.info.complete' },
        ] }]);
      return;
    }
  }

  CommandUtils.notifyWrongUsage(command, sender);
};
cmd.register();
