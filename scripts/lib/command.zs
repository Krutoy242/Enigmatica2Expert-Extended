#modloaded zenutils
#priority 10000
#reloadable

import crafttweaker.data.IData;
import crafttweaker.player.IPlayer;
import crafttweaker.server.IServer;
import crafttweaker.text.ITextComponent;
import mods.zenutils.command.CommandUtils;
import mods.zenutils.command.ZenUtilsCommandSender;

function senderAsPlayerOrNull(sender as ZenUtilsCommandSender) as IPlayer {
  return sender instanceof IPlayer
    ? CommandUtils.getCommandSenderAsPlayer(sender)
    : null;
}

function resolveTargetPlayer(server as IServer, sender as ZenUtilsCommandSender, args as string[], index as int) as IPlayer {
  if (args.length > index) {
    return CommandUtils.getPlayer(server, sender, args[index]);
  }
  if (sender instanceof IPlayer) {
    return CommandUtils.getCommandSenderAsPlayer(sender);
  }
  return null;
}

function sendRichOrPlain(sender as ZenUtilsCommandSender, richData as IData, plainText as string) as void {
  val player = sender instanceof IPlayer ? CommandUtils.getCommandSenderAsPlayer(sender) : null;
  if (!isNull(player)) {
    player.sendRichTextMessage(ITextComponent.fromData(richData));
  }
  else {
    sender.sendMessage(plainText);
  }
}

function richToPlain(data as IData) as string {
  val list = data.asList();
  if (!isNull(list)) {
    var result = '';
    for element in list {
      result ~= richToPlain(element);
    }
    return result;
  }

  val raw = data.asString();
  if (raw.startsWith('{')) {
    val text = data.memberGet('text');
    if (!isNull(text)) {
      var result = text.asString();
      val extra = data.memberGet('extra');
      if (!isNull(extra)) {
        result ~= richToPlain(extra);
      }
      return result;
    }
  }

  return raw;
}
