#modloaded zenutils ftblib ftbutilities
#priority 1000
#reloadable

import crafttweaker.data.IData;
import crafttweaker.server.IServer;
import mods.zenutils.command.ZenCommand;
import mods.zenutils.command.ZenUtilsCommandSender;

import scripts.lib.command.senderAsPlayerOrNull;

val x = scripts.commands.build.Command('perf');
x.prefix = '§6[§e⚡§6] ';
x.cmd.requiredPermissionLevel = 0;

x.addSubCommand(
  'loaders',
  'information about §lchunk loaders',
  function (command as ZenCommand, server as IServer, sender as ZenUtilsCommandSender, args as string[]) as IData {
    return scripts.commands.perf.loaders.show(sender);
  }
);

x.addSubCommand(
  'chunks',
  'information about §lloaded chunks',
  function (command as ZenCommand, server as IServer, sender as ZenUtilsCommandSender, args as string[]) as IData {
    val player = senderAsPlayerOrNull(sender);
    if (isNull(player)) {
      sender.sendMessage('§c/perf chunks requires a player sender (sends a render packet to your client).');
      return null;
    }
    return scripts.commands.perf.chunks.show(player);
  }
);

x.addSubCommand(
  'entities',
  'information about §lloaded entities',
  function (command as ZenCommand, server as IServer, sender as ZenUtilsCommandSender, args as string[]) as IData {
    return scripts.commands.perf.entities.show(sender);
  }
);

x.addSubCommand(
  'claimed',
  'information about §lclaimed chunks',
  function (command as ZenCommand, server as IServer, sender as ZenUtilsCommandSender, args as string[]) as IData {
    var page = 1;
    if (args.length > 1) {
      val pageNum = args[1] as int;
      if (pageNum > 0) {
        page = pageNum;
      }
    }
    return scripts.commands.perf.claimed.show(sender, page);
  }
);

x.register();
