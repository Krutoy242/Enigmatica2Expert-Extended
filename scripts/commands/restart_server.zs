#modloaded zenutils roidtweaker
#reloadable

import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import mods.zenutils.StringList;
import mods.zenutils.command.CommandUtils;
import mods.zenutils.command.ZenCommand;

import scripts.lib.expansions.ftblib.getFTBUPlayerData;
import native.com.feed_the_beast.ftbutilities.FTBUtilitiesConfig;

val voteTime = 600;

static playerPending as StringList = StringList.empty();
static inProcess as string[string] = {};

val cmd as ZenCommand = ZenCommand.create('restart_server');
cmd.getCommandUsage = function (sender) { return 'commands.restart_server.usage'; };

function sendSingle(player as IPlayer, key as string, substr as string = null) as void {
  val langKey = game.localize(`commands.restart_server.${key}`);
  if (isNull(substr)) return player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromTranslation(langKey));
  player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromTranslation(langKey, substr));
}

function send(key as string, mode as string = 'everyone', substr as string = null) as void {
  for player in server.players {
    if (mode == 'pending' && !playerPending.contains(player.uuid)) continue;
    if (mode == 'unpending' && playerPending.contains(player.uuid)) continue;
    sendSingle(player, key, substr);
  }
}

function stopWithDelay(world as IWorld) as void {
  inProcess['restart'] = 'true';
  send('delay');

  world.catenation().sleep(60).then(function (world, ctx) {
    // send('stopping');
    server.commandManager.executeCommandSilent(server, '/say §8[§6ø§8]§r §4Server stopping by vote...');
    server.commandManager.executeCommandSilent(server, '/stop');
  }).start();
}

function isPlayerAFK(player as IPlayer) as bool {
  val data = getFTBUPlayerData(player);
  if (isNull(data)) return false;
  return data.afkTime >= FTBUtilitiesConfig.afk.getNotificationTimer();
}

function getActivePlayerCount() as int {
  var count = 0;
  for p in server.players {
    if (!isPlayerAFK(p)) count += 1;
  }
  return count;
}

function getPlayersList(isVoted as bool = false) as string {
  var list = '';
  for p in server.players {
    if (playerPending.contains(p.uuid) == isVoted) {
      val afkMark = isPlayerAFK(p) ? ' §7[AFK]§r' : '';
      list ~= `${list != '' ? ', ' : ''}§5${p.nickname()}§r${afkMark}`;
    }
  }
  return list;
}

function cancelVoting() as void {
  if (!isNull(inProcess.restart)) return;
  send('failed', 'pending', getPlayersList());
  send('cancelled', 'unpending');
  playerPending.clear();
}

function checkComplete() as bool {
  var hasActiveVoter = false;
  for p in server.players {
    val isAFK = isPlayerAFK(p);
    if (!isAFK) {
      if (!playerPending.contains(p.uuid)) return false;
      hasActiveVoter = true;
    }
  }
  return hasActiveVoter;
}

function notifyActivePlayersAboutQuery(initiator as IPlayer) as void {
  for p in server.players {
    if (!isPlayerAFK(p) && !playerPending.contains(p.uuid) && p.uuid != initiator.uuid) {
      sendSingle(p, 'query', initiator.nickname());
    }
  }
}

cmd.requiredPermissionLevel = 0; // require no permission, everyone can execute the command.
cmd.execute = function (command, server, sender, args) {
  if (!(sender instanceof IPlayer)) {
    if (!isNull(inProcess.restart)) {
      sender.sendMessage(game.localize('commands.restart_server.in_process'));
      return;
    }
    val activeCount = getActivePlayerCount();
    if (activeCount <= 1) {
      stopWithDelay(IWorld.getFromID(0));
      return;
    }
    sender.sendMessage(game.localize('commands.restart_server.usage'));
    return;
  }

  val player = CommandUtils.getCommandSenderAsPlayer(sender);

  // Server already restarting
  if (!isNull(inProcess.restart)) return sendSingle(player, 'in_process');

  val activeCount = getActivePlayerCount();

  // Only one active player (or none) - stop right now
  if (activeCount <= 1) return stopWithDelay(player.world);

  if (playerPending.size() == 0) {
    // We are first player who activated
    playerPending.add(player.uuid);
    sendSingle(player, 'you_want', voteTime / 20);
    notifyActivePlayersAboutQuery(player);

    player.world.catenation().sleep(voteTime).then(function (world, ctx) { cancelVoting(); }).start();
  }
  else if (playerPending.contains(player.uuid)) {
    // We are already waiting for vote
    sendSingle(player, 'already_voted', getPlayersList());
  }
  else {
    playerPending.add(player.uuid);

    // Notify any players who returned from AFK and haven't voted yet
    notifyActivePlayersAboutQuery(player);

    if (checkComplete()) {
      // All active players voted
      stopWithDelay(player.world);
    }
    else {
      // New player added in vote list
      send('awaiting', 'pending', getPlayersList(false));
      send('query', 'unpending', getPlayersList(true));
    }
  }
};
cmd.register();
