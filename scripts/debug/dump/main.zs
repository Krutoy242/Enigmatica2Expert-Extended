#modloaded zenutils
#priority 4000
#reloadable

import crafttweaker.command.ICommandSender;
import mods.zenutils.command.ZenCommand;

static subcommandNames as [string] = [];
static subcommandHandlers as [function(ICommandSender)void] = [];

function registerSubcommand(name as string, handler as function(ICommandSender)void) as void {
  if (!isNull(name) && name != '') {
    subcommandNames.add(name);
    subcommandHandlers.add(handler);
  }
}

val dumpCmd = ZenCommand.create('dump');
dumpCmd.requiredPermissionLevel = 0;
dumpCmd.execute = function (command, server, sender, args) {
  if (args.length == 0) {
    sender.sendMessage('\u00A76========== Dump Commands ==========');
    sender.sendMessage('\u00A7eUsage: /dump <subcommand>');
    sender.sendMessage('\u00A77Available subcommands:');
    val sortedNames = subcommandNames as string[];
    sortedNames.sort();
    for name in sortedNames {
      sender.sendMessage('  \u00A7a- ' ~ name);
    }
    sender.sendMessage('\u00A76==================================');
    return;
  }
  val sub = args[0];
  for i in 0 .. subcommandNames.length {
    if (subcommandNames[i] == sub) {
      subcommandHandlers[i](sender);
      return;
    }
  }
  sender.sendMessage('\u00A7cUnknown subcommand: \u00A7f' ~ sub);
  sender.sendMessage('\u00A77Use \u00A7f/dump\u00A77 to list available subcommands.');
};
dumpCmd.register();
