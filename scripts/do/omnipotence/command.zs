#reloadable
#modloaded zenutils

import mods.zenutils.command.CommandUtils;
import mods.zenutils.command.IGetTabCompletion;
import mods.zenutils.command.ZenCommand;
import mods.zenutils.StringList;

import scripts.lib.command.resolveTargetPlayer;

val cmd = ZenCommand.create('omnipotence');
cmd.requiredPermissionLevel = 1;
cmd.getCommandUsage = function (sender) {
  return '§7/omnipotence §8<§7grant§8|§7revoke§8> §7[<§7player§8>]'
  ~ '\n§7grant§8: grant omnipotence to player'
  ~ '\n§7revoke§8: remove omnipotence from player'
  ;
};

val tabCompletion as IGetTabCompletion = function (server, sender, pos) {
  return StringList.create([
    'revoke',
    'grant',
  ]);
};
cmd.tabCompletionGetters = [tabCompletion];

cmd.execute = function (command, server, sender, args) {
  if (args.length >= 1 && (args[0] == 'grant' || args[0] == 'revoke')) {
    val action = args[0];
    val player = resolveTargetPlayer(server, sender, args, 1);
    if (isNull(player)) {
      if (args.length >= 2) {
        sender.sendMessage('§cPlayer not found: ' ~ args[1]);
      }
      else {
        CommandUtils.notifyWrongUsage(command, sender);
      }
      return;
    }
    if (action == 'grant') {
      scripts.do.omnipotence.op.op.grant(player);
      sender.sendMessage('§aOmnipotence granted.');
    }
    else {
      scripts.do.omnipotence.op.op.revoke(player);
      sender.sendMessage('§aOmnipotence revoked.');
    }
    return;
  }

  CommandUtils.notifyWrongUsage(command, sender);
};
cmd.register();
