#modloaded ftbquests gamestages
#reloadable
#priority -2000

import crafttweaker.player.IPlayer;
import crafttweaker.data.IData;

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

// function notifyEveryone(player as IPlayer, langCode as string, titleCode as string) as string {
//   server.commandManager.executeCommandSilent(server,
//     // '/tellraw @a [{"translate":"'~langCode~'","with":["'~player.name~'",{"translate":"'~titleCode~'"},"'~formatPlayTime(player)~'"]}]')
//     '/say ' ~ mods.zenutils.I18n.format(
//       langCode,
//       player.name,
//       titleCode,
//       formatPlayTime(player)
//     )
//   );
// }

events.onCustomReward(function (e as mods.zenutils.ftbq.CustomRewardEvent) {
  /**
  * Endorse player with message to whole server as its finished chapter
  */
  if (e.reward.tags has 'chapcomplete') {
    val chapterName = utils.toUpperCamelCase(
      e.reward.quest.chapter.titleText.formattedText.replaceAll('q\\.(.+)\\.name','$1')
    );
    val data as IData = {
      text: "## `", color: "dark_gray", extra: [
        {text: e.player.name, color: "aqua"},
        "` ",
        {text: "has fully completed the", color: "gray"},
        " __**",
        {text: chapterName, underlined: true, color: "yellow"},
        "**__ ",
        {text: "chapter after ", color: "gray"},
        {text: formatPlayTime(e.player), color: "gold"},
        " of play! ```Congrats!```"
    ]};
    server.commandManager.executeCommandSilent(server, '/tellraw @a ' ~ data.toJson());
  }

  /**
  * Conflux rewards
  */
  for k in 'i ii iii iv v'.split(' ') {
    if (e.reward.tags has 'conflux_' ~ k) {
      e.player.addGameStage('conflux_' ~ k);
      server.commandManager.executeCommandSilent(server,
        '/ranks add ' ~ e.player.name ~ ' conflux_' ~ k
      );

      // notifyEveryone(e.player, 'e2ee.player_achieved', e.reward.quest.titleText.formattedText);
      val data as IData = {
        text: "### `", color: "dark_gray", extra: [
          {text: e.player.name, color: "aqua"},
          "` ",
          {text: "achieved", color: "gray"},
          " __",
          {text: 'Conflux ' ~ k.toUpperCase(), underlined: true, color: "gray"},
          "__ ",
          {text: "after ", color: "gray"},
          {text: formatPlayTime(e.player), color: "gold"},
          " of play! ```Congrats!```"
      ]};
      server.commandManager.executeCommandSilent(server, '/tellraw @a ' ~ data.toJson());
    }
  }

/*Inject_js{
globSync('config/ftbquests/normal/chapters/*'+'/*.snbt')
    .forEach((f) => {
      const text = loadText(f)
      const replaced = text.replace(
        /rewards: \[\{\n\s+uid: "(\w+)",\s+type: "item",\s+item: \{\s+id: "ftbquests:lootcrate",\s+tag: \{\s+type: "(\w+)"(?:\s+(?:\},?|count: \d+)){3,4}\]/g,
      `rewards: [{
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
	}]`
      )
      if (text !== replaced) saveText(replaced, f)
    })
return "// Done!"
}*/
// Done!
/**/

  /**
  * Give loot crates based on player's difficulty level
  */
  if (e.reward.tags has 'loot') {
    val amount = e.reward.icon.amount;
    val diff = scripts.lib.mod.scalinghealth.getPlayerDimDifficulty(e.player.getUUID(), e.player.world.dimension);
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
  if (e.task.hasTag('omnipotence')) {
    e.checkTimer = 10;
    e.checker = function (player, currentProgress) {
      return player.difficulty >= 1000 ? 1 : 0;
    };
  }
});

events.onPlayerLoggedIn(function (e as crafttweaker.event.PlayerLoggedInEvent) {
  if (e.player.world.remote) return;

  for k in 'i ii iii iv v'.split(' ') {
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
