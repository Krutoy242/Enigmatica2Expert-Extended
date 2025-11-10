#modloaded zenutils
#priority 2000
#reloadable

import crafttweaker.data.IData;
import crafttweaker.server.IServer;
import mods.zenutils.command.ZenCommand;
import mods.zenutils.command.ZenUtilsCommandSender;

zenClass Command {
  var cmd            as ZenCommand;
  var prefix         as string = '';
  var subCommandNames as string[] = [];
  var subCommandExecs as [function(ZenCommand,IServer,ZenUtilsCommandSender,string[])IData]
    = [] as [function(ZenCommand,IServer,ZenUtilsCommandSender,string[])IData];

  var subCommandDescs as string[] = [];

  zenConstructor(name as string) {
    cmd = ZenCommand.create(name);
  }

  function addSubCommand(name as string, description as string, exec as function(ZenCommand,IServer,ZenUtilsCommandSender,string[])IData) as Command {
    subCommandNames += name;
    subCommandDescs += description;
    subCommandExecs += exec;
    return this;
  }

  function register() as void {
    cmd.getCommandUsage = function (sender) {
      var detailed = '';
      for i, key in subCommandNames {
        detailed ~= `\n§7${key}§8: ${subCommandDescs[i]}`;
      }
      val list = mods.zenutils.StaticString.join(subCommandNames, '§8|§7');
      return `${prefix}§7/${cmd.name} §8<§7${list}§8>${detailed}`;
    };

    cmd.tabCompletionGetters = [mods.zenutils.command.IGetTabCompletion.fixedValues(subCommandNames)];

    cmd.execute = function (command, server, sender, args) {
      val player = mods.zenutils.command.CommandUtils.getCommandSenderAsPlayer(sender);

      if (args.length >= 1) {
        for i, name in subCommandNames {
          if (name != args[0]) continue;
          val exec = subCommandExecs[i];
          val result = exec(command, server, sender, args);
          if (!isNull(result)) {
            player.sendRichTextMessage(
              crafttweaker.text.ITextComponent.fromData(
                isNull(prefix) ? result : [prefix] as IData + result
              )
            );
          }
          return;
        }
      }

      mods.zenutils.command.CommandUtils.notifyWrongUsage(command, sender);
    };

    cmd.register();
  }
}

// ---------------------------------------------
// Functions for cross-script reference
// ---------------------------------------------
function isClose(x1 as int, z1 as int, x2 as int, z2 as int, dist as int) as bool {
  return abs(x2 - x1) <= dist
    && abs(z2 - z1) <= dist;
}

function abs(n as int) as int { return n < 0 ? -n : n; } // >
