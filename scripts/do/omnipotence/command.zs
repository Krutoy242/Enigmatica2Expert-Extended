#reloadable
#modloaded zenutils

val cmd = mods.zenutils.command.ZenCommand.create('omnipotence');
cmd.requiredPermissionLevel = 1;
// §e✪ Omnipotence ✪§r
cmd.getCommandUsage = function (sender) {
  return '§7/omnipotence §8<§7grant§8|§7revoke§8>'
  ~ '\n§7grant§8: grant omnipotence to player'
  ~ '\n§7revoke§8: remove omnipotence from player'
  ;
};

val tabCompletion as mods.zenutils.command.IGetTabCompletion = function (server, sender, pos) {
  return mods.zenutils.StringList.create([
    'revoke',
    'grant',
  ]);
};
cmd.tabCompletionGetters = [tabCompletion];

cmd.execute = function (command, server, sender, args) {
  val player = mods.zenutils.command.CommandUtils.getCommandSenderAsPlayer(sender);

  if (args.length >= 1) {
    if (args[0] == 'revoke') {
      scripts.do.omnipotence.op.op.revoke(player);
      return;
    }
    if (args[0] == 'grant') {
      scripts.do.omnipotence.op.op.grant(player);
      return;
    }
  }

  mods.zenutils.command.CommandUtils.notifyWrongUsage(command, sender);
};
cmd.register();
