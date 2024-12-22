#modloaded ftbquests
#reloadable
#priority -2000

import crafttweaker.player.IPlayer;

function formatPlayTime(player as IPlayer) as string {
  val t = player.readStat(mods.zenutils.PlayerStat.getBasicStat('stat.playOneMinute')) as double;
  val days = t / (20.0 * 60.0 * 60.0 * 24.0);
  val hours = days * 24.0 - (days as int * 24);
  val mins = hours * 60.0 - (hours as int * 60);
  val secs = mins * 60.0 - (mins as int * 60);
  return (
    (days >= 1 ? ' ' ~ days as int ~ 'd' : '')
    ~ (hours >= 1 ? ' ' ~ hours as int ~ 'h' : '')
    ~ (mins >= 1 && days < 1 ? ' ' ~ mins as int ~ 'm' : '')
    ~ (secs >= 1 && hours < 1 ? ' ' ~ secs as int ~ 's' : '')
  ).trim();
}

function notifyEveryone(player as IPlayer, langCode as string, titleCode as string) as string {
  server.commandManager.executeCommandSilent(server,
    // '/tellraw @a [{"translate":"'~langCode~'","with":["'~player.name~'",{"translate":"'~titleCode~'"},"'~formatPlayTime(player)~'"]}]')
    '/say ' ~ mods.zenutils.I18n.format(
      game.localize(langCode),
      player.name,
      titleCode,
      formatPlayTime(player)
    )
  );
}

events.onCustomReward(function (e as mods.zenutils.ftbq.CustomRewardEvent) {
  /**
  * Endorse player with message to whole server as its finished chapter
  */
  if (e.reward.tags has 'chapcomplete') {
    // notifyEveryone(e.player, 'e2ee.chapter_complete', e.reward.quest.chapter.titleText.formattedText);
    server.commandManager.executeCommandSilent(server,
      '/say §l' ~ e.player.name
      ~ '§r has fully completed the §n'
      ~ e.reward.quest.chapter.titleText.formattedText.replaceAll('q\\.(.+)\\.name','$1')
      ~ '§r chapter after §l' ~ formatPlayTime(e.player) ~ '§r of play!§r ```Congrats!```'
    );
  }

  /**
  * Conflux rewards
  */
  for k in 'i ii iii iv'.split(' ') {
    if (e.reward.tags has 'conflux_' ~ k) {
      e.player.addGameStage('conflux_' ~ k);
      server.commandManager.executeCommandSilent(server,
        '/ranks add ' ~ e.player.name ~ ' conflux_' ~ k
      );

      // notifyEveryone(e.player, 'e2ee.player_achieved', e.reward.quest.titleText.formattedText);
      server.commandManager.executeCommandSilent(server,
        '/say §l' ~ e.player.name ~ '§r achieved §nConflux §n' ~ k.toUpperCase() ~ '§r after §l' ~ formatPlayTime(e.player) ~ '§r of play!§r'
      );
    }
  }

  /*
    Regexp to replace all loot chest rewards:

rewards: \[\{\n\s+uid: "(\w+)",\s+type: "item",\s+item: \{\s+id: "ftbquests:lootcrate",\s+tag: \{\s+type: "(\w+)"(?:\s+\}){3}\]

rewards: [{
		uid: "$1",
		type: "custom",
		title: "{e2ee.quest.$2}",
		icon: {
			id: "ftbquests:lootcrate",
			Count: 2,
			tag: {
				type: "$2"
			}
		},
		tags: [
			"loot"
		]
	}]

  */

  /**
  * Give loot crates based on player's difficulty level
  */
  if (e.reward.tags has 'loot') {
    val amount = e.reward.icon.amount;
    val diff = e.player.difficulty;
    e.player.give(e.reward.icon * (
      diff < 1.0 ? amount + 1 // Mostly zero difficulty +1 chest
      : diff > 1000 ? max(1, amount - 1) // max difficulty -1 chest
      : amount
    ));
    if(diff < 1.0) {
      e.player.sendRichTextStatusMessage(
        crafttweaker.text.ITextComponent.fromTranslation('e2ee.quest.loot.additional')
      );
    }
  }
});

events.onCustomTask(function (e as mods.zenutils.ftbq.CustomTaskEvent) {
  if (e.task.hasTag('skyblock')) {
    e.checker = function (player, currentProgress) {
      return player.hasGameStage('skyblock') ? 1 : 0;
    };
  }
  if (e.task.hasTag('crystal_memory_hit')) {
    e.checker = function (player, currentProgress) {
      return isNull(scripts.do.acquire.info.playersCompleted[player.uuid]) ? 0 : 1;
    };
  }
  if (e.task.hasTag('schematica')) {
    e.checkTimer = 10;
    e.checker = function (player, currentProgress) {
      return (
        isNull(player.data.enigmatica)
        || isNull(player.data.enigmatica.usedSchematica)
        || player.data.enigmatica.usedSchematica.asBool() != true
      ) ? 0 : 1;
    };
  }
});

events.onPlayerLoggedIn(function (e as crafttweaker.event.PlayerLoggedInEvent) {
  if (e.player.world.remote) return;

  for k in 'i ii iii iv'.split(' ') {
    val conflux = 'conflux_' ~ k;
    if (e.player.hasGameStage(conflux))
      server.commandManager.executeCommandSilent(server,
        '/ranks add ' ~ e.player.name ~ ' ' ~ conflux
      );
  }
});

// Catch message from client that player opened schematica GUI
mods.zenutils.NetworkHandler.registerClient2ServerMessage(
  'openGuiSchematicLoad',
  function(server, byteBuf, player) {
    player.update({ enigmatica: { usedSchematica: true } });
  }
);
