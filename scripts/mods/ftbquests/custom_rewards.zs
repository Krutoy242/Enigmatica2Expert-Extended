#modloaded ftbquests gamestages
#reloadable
#priority -2000

import crafttweaker.data.IData;
import crafttweaker.player.IPlayer;
import native.com.feed_the_beast.ftblib.lib.data.ForgePlayer;
import native.com.feed_the_beast.ftbquests.quest.ServerQuestFile;
import native.com.feed_the_beast.ftbutilities.data.FTBUtilitiesPlayerData;
import native.net.minecraft.stats.StatList;

/**
 * Counts how many chapters a player has finished.
 */
function getChapterCount(player as IPlayer) as int[] {
  val questFile as ServerQuestFile = ServerQuestFile.INSTANCE;
  if (isNull(questFile)) return [0, 0];

  val playerData = questFile.getData(player);
  if (isNull(playerData)) return [0, 0];

  var totalChapters = 0;
  var completedChapters = 0;
  for chapter in questFile.chapters {
    totalChapters += 1;
    if (chapter.isComplete(playerData)) {
      completedChapters += 1;
    }
  }

  // Reduce 1 chapter for Skyblock that always completed
  return [completedChapters - 1, totalChapters - 1];
}

function getPlayOneMinute(player as ForgePlayer) as int {
  if (isNull(player)) return 0;
  return player.stats().readStat(StatList.PLAY_ONE_MINUTE);
}

function formatPlayTimeFromTicks(t as int) as string {
  val days = (t as double) / (20.0 * 60.0 * 60.0 * 24.0);
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

function formatPlayTime(player as ForgePlayer) as string {
  return formatPlayTimeFromTicks(getPlayOneMinute(player));
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

static chapterNames as string[string] = {
  'actually additions': '🧰Actually Additions',
  'advanced rocketry': '🚀Advanced Rocketry',
  'applied energetics': '🗃️AE2',
  'astral sorcery': '🌠Astral Sorcery',
  'blood magic': '🩸Blood Magic',
  'draconic evolution': '🐲Draconic Evolution',
  'ender io': '🔮Ender Io',
  'environmental tech': '⬛Environmental Tech',
  'extra utilities': '👜Extra Utilities 2',
  'immersive engineer': '🛢️Immersive Engineer',
  'immersive engineering': '🛢️Immersive Engineer',
  'industrial foregoing': '🏭Industrial Foregoing',
  'nuclearcraft overh': '☢️NuclearCraft',
  'nuclearcraft overhauled': '☢️NuclearCraft',
  'thermal expansion': '🌡️Thermal Expansion',
  'twilight forest': '🌳The Twilight Forest',
  animals: '🐄Animals',
  botania: '🌷Botania',
  computers: '🖥️Computers',
  forestry: '🌴Forestry',
  industrialcraft: '🔌IC2',
  mekanism: '⚙️Mekanism',
  rftools: '🎛️Rftools',
  thaumcraft: '🦯Thaumcraft',
  utils: '🍎Utilities',
};

function getChapterName(e as mods.zenutils.ftbq.CustomRewardEvent) as string {
  // This text has different values on client and server
  // We need to uniform it on both sides
  val text = e.reward.quest.chapter.titleText.formattedText;
  val chapID = utils.toUpperCamelCase(text.replaceAll('q\\.(.+)\\.name', '$1').replaceAll('§.', ''));

  print('Chapter name: ' ~ (chapterNames[chapID] ?? chapID));
  return chapterNames[chapID.toLowerCase()] ?? chapID;
}

events.onCustomReward(function (e as mods.zenutils.ftbq.CustomRewardEvent) {
  val universe = ServerQuestFile.INSTANCE.universe;
  val forgePlayer = !isNull(universe) ? universe.getPlayer(e.player.getUUID()) : null;

  /**
  * Endorse player with message to whole server as its finished chapter
  */
  if (e.reward.tags has 'chapstart' || e.reward.tags has 'chapcomplete') {
    val chapterName = getChapterName(e);
    val chaps = getChapterCount(e.player);

    var style_name as string;
    var style_time as string;
    var style_post as string;
    var style_paragraph as string;
    var style_event as string;
    var style_isShort = false;
    var playerList as IData = null;

    if (e.reward.tags has 'chapstart') {
      style_paragraph = '-# `';
      style_event = 'has begun the';
      style_isShort= true;
    } else {
      style_paragraph = '## `';
      style_event = 'has fully completed the';
    }

    if (isNull(forgePlayer) || isNull(forgePlayer.team) || forgePlayer.team.members.length <= 1) {
      // Solo player or team of 1
      style_name = e.player.nickname();
      style_time = formatPlayTime(forgePlayer);
      style_post = 'of play!';
    }
    else {
      // Team with 2+ players
      val team = forgePlayer.team;

      var totalPlayTimeTicks = 1;
      for member in team.members {
        totalPlayTimeTicks += getPlayOneMinute(member);
      }

      // Time + Player name (colored) for sorting
      var playerTimes = [] as [string[]];
      for member in team.members {
        val playerData = FTBUtilitiesPlayerData.get(member);
        val name = playerData.nickname.isEmpty() ? member.name : playerData.nickname;
        playerTimes += [
          getPlayOneMinute(member),
          (member.isOnline() ? '§f' : '§7') ~ name,
        ] as string[];
      }
      playerTimes.sort(function(a as string[], b as string[]) as int {
        return b[0] as int - a[0] as int;
      });

      playerList = [] as IData;
      var first = true;
      for tuple in playerTimes {
        val playTimeMin = tuple[0] as int;
        val name = tuple[1];
        playerList += [{
          text : '', color: 'dark_gray', extra: [
            first ? '`' : ', `', name, '` ',
            {text: formatPlayTimeFromTicks(playTimeMin), color: 'gray'},
          ],
        }] as IData;
        first = false;
      }

      style_name = team.title.unformattedText;
      style_time = formatPlayTimeFromTicks(totalPlayTimeTicks);
      style_post = 'of combined play!';
    }

    server.commandManager.executeCommandSilent(server, '/tellraw @a ' ~ ({
      text : style_paragraph, color: 'dark_gray', extra: [
        {text: style_name, color: 'aqua'}, '` ', {text: style_event, color: 'gray'},
        ' __**', {text: chapterName, underlined: true, color: 'yellow'}, '**__ ',
        {text: style_isShort ? 'questline!' : 'chapter after ', color: 'gray'}]
        + (style_isShort ? [] : [
        {text: style_time, color: 'gold'},
        {text: ' ' ~ style_post ~' ', color: 'gray'}, '[',
        { text: chaps[0], color: 'gray' }, '/', { text: chaps[1], color: 'gray' },
        '] ```Congrats!```',
      ])} as IData).toJson());

    if (!style_isShort && !isNull(playerList))
      server.commandManager.executeCommandSilent(server, '/tellraw @a ' ~ ({
        text : '-# ', color: 'dark_gray', extra: playerList} as IData).toJson());
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
        text : '### `', color: 'dark_gray', extra: [
          {text: e.player.nickname(), color: 'aqua'},
          '` ',
          {text: 'achieved', color: 'gray'},
          ' __',
          {text: 'Conflux ' ~ k.toUpperCase(), underlined: true, color: 'gray'},
          '__ ',
          {text: 'after ', color: 'gray'},
          {text: formatPlayTime(forgePlayer), color: 'gold'},
          ' of play! ```Congrats!```',
        ]};
      server.commandManager.executeCommandSilent(server, '/tellraw @a ' ~ data.toJson());
    }
  }

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
    if (diff < 1.0) {
      e.player.sendRichTextStatusMessage(
        crafttweaker.text.ITextComponent.fromTranslation('e2ee.quest.loot.additional')
      );
    }
  }
});

/*Inject_js{
globSync('config/ftbquests/normal/chapters/*'+'/*.snbt')
    .forEach((f) => {
      const text = loadText(f)
      const replaced = text.replace(
        /rewards: \[\{\n\s+uid: "(?<uid>\w+)",\s+type: "item",(?<auto>\n\s+auto: "[^"]+",)?\s+item: \{\s+id: "ftbquests:lootcrate",(?:\n\s+Count: (?<count>\d+),)?\s+tag: \{\s+type: "(?<type>\w+)"(?:\s+\},?){2}\n\s+\}(?<tail>\])?/gi,
  (m, ...args) => {
  const {uid, auto, type, count, tail} = args.pop()
  return `rewards: [{
		uid: "${uid}",
		type: "custom",
		title: "{e2ee.quest.${type}}",
		icon: {
			id: "ftbquests:lootcrate",${count ? `\n\t\t\tCount: ${count},` : ''}
			tag: {
				type: "${type}"
			}
		},
		tags: [
			"loot"
		]
	}${tail || ''}`
})
  if (text !== replaced) saveText(replaced, f)
})
return "// Done!"
}*/
// Done!
/**/

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
      return isNull(player.data.enigmatica)
        || isNull(player.data.enigmatica.usedSchematica)
        || player.data.enigmatica.usedSchematica.asBool() != true
        ? 0
        : 1;
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
    if (e.player.hasGameStage(conflux)) {
      server.commandManager.executeCommandSilent(server,
        '/ranks add ' ~ e.player.name ~ ' ' ~ conflux
      );
    }
  }
});

// Catch message from client that player opened schematica GUI
mods.zenutils.NetworkHandler.registerClient2ServerMessage(
  'openGuiSchematicLoad',
  function (server, byteBuf, player) {
    player.update({ enigmatica: { usedSchematica: true } });
  }
);
