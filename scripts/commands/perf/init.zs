#modloaded zenutils ftblib ftbutilities
#priority 1000
#reloadable

import crafttweaker.data.IData;
import crafttweaker.server.IServer;
import mods.zenutils.command.CommandUtils.getCommandSenderAsPlayer;
import mods.zenutils.command.ZenCommand;
import mods.zenutils.command.ZenUtilsCommandSender;

val x = scripts.commands.build.Command('perf');
x.prefix = '§6[§e⚡§6] ';
x.cmd.requiredPermissionLevel = 0;

x.addSubCommand(
  'loaders',
  'information about §lchunk loaders',
  function (command as ZenCommand, server as IServer, sender as ZenUtilsCommandSender, args as string[]) as IData {
    return scripts.commands.perf.loaders.show(getCommandSenderAsPlayer(sender));
  }
);

x.addSubCommand(
  'chunks',
  'information about §lloaded chunks',
  function (command as ZenCommand, server as IServer, sender as ZenUtilsCommandSender, args as string[]) as IData {
    return scripts.commands.perf.chunks.show(getCommandSenderAsPlayer(sender));
  }
);

x.addSubCommand(
  'entities',
  'information about §lloaded entities',
  function (command as ZenCommand, server as IServer, sender as ZenUtilsCommandSender, args as string[]) as IData {
    return scripts.commands.perf.entities.show(getCommandSenderAsPlayer(sender));
  }
);

x.register();
