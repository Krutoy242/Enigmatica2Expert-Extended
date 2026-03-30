#modloaded ftbquests gamestages
#reloadable
#priority -2000

import crafttweaker.data.IData;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.item.IItemDefinition;
import crafttweaker.player.IPlayer;
import mods.zenutils.PlayerStat;

import scripts.do.hand_over_your_items.tellrawItemObj;

import native.com.feed_the_beast.ftblib.lib.data.ForgePlayer;

import native.com.feed_the_beast.ftbquests.net.MessageTogglePinned;
import native.com.feed_the_beast.ftbquests.quest.ServerQuestFile;
import native.com.feed_the_beast.ftbutilities.data.FTBUtilitiesPlayerData;
import native.net.minecraft.entity.player.EntityPlayerMP;
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
  val hours = (t as double) / (20.0 * 60.0 * 60.0);
  val mins = hours * 60.0 - (hours as int * 60);
  val secs = mins * 60.0 - (mins as int * 60);
  return (
    (hours >= 1 ? ' ' ~ hours as int ~ 'h' : '')
    ~ (mins >= 1 ? ' ' ~ mins as int ~ 'm' : '')
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
  'actually additions'     : '🧰Actually Additions',
  'advanced rocketry'      : '🚀Advanced Rocketry',
  'applied energetics'     : '🗃️AE2',
  'astral sorcery'         : '🌠Astral Sorcery',
  'blood magic'            : '🩸Blood Magic',
  'draconic evolution'     : '🐲Draconic Evolution',
  'ender io'               : '🔮Ender Io',
  'environmental tech'     : '⬛Environmental Tech',
  'extra utilities'        : '👜Extra Utilities 2',
  'immersive engineer'     : '🛢️Immersive Engineer',
  'immersive engineering'  : '🛢️Immersive Engineer',
  'industrial foregoing'   : '🏭Industrial Foregoing',
  'nuclearcraft overh'     : '☢️NuclearCraft',
  'nuclearcraft overhauled': '☢️NuclearCraft',
  'thermal expansion'      : '🌡️Thermal Expansion',
  'twilight forest'        : '🌳The Twilight Forest',
  'animals'                : '🐄Animals',
  'botania'                : '🌷Botania',
  'computers'              : '🖥️Computers',
  'forestry'               : '🌴Forestry',
  'industrialcraft'        : '🔌IC2',
  'mekanism'               : '⚙️Mekanism',
  'rftools'                : '🎛️Rftools',
  'thaumcraft'             : '🦯Thaumcraft',
  'utils'                  : '🍎Utilities',
};

function getChapterName(e as mods.zenutils.ftbq.CustomRewardEvent) as string {
  // This text has different values on client and server
  // We need to uniform it on both sides
  val text = e.reward.quest.chapter.titleText.formattedText;
  val chapID = utils.toUpperCamelCase(text.replaceAll('q\\.(.+)\\.name', '$1').replaceAll('§.', ''));
  return chapterNames[chapID.toLowerCase()] ?? chapID;
}

events.onCustomReward(function (e as mods.zenutils.ftbq.CustomRewardEvent) {
  val universe = ServerQuestFile.INSTANCE.universe;
  val forgePlayer = !isNull(universe) ? universe.getPlayer(e.player.getUUID()) : null;

  /**
  * Determine conflux level tag
  */
  var confluxKey = '';
  var confluxLevel = 0;
  for i, k in 'i ii iii iv v'.split(' ') {
    if (e.reward.tags has 'conflux_' ~ k) {
      confluxLevel = i;
      confluxKey = k;
      break;
    }
  }

  /**
  * Endorse player with message to whole server as its finished chapter
  */
  if (e.reward.tags has 'chapstart' || e.reward.tags has 'chapcomplete' || e.reward.tags has 'packcomplete' || (confluxLevel > 0 && e.reward.tags has 'team')) {
    val chapterName as IData = e.reward.tags has 'packcomplete'
      ? [' __***', { text: 'Enigmatica 2: Expert - Extended', underlined: true, color: 'yellow' }, '***__ ']
      : confluxLevel > 0
        ? [' __', { text: 'Conflux ' ~ confluxKey.toUpperCase(), underlined: true, color: 'gold' }, '__ ']
        : [' __**', { text: getChapterName(e), underlined: true, color: 'yellow' }, '**__ '];
    val chaps = getChapterCount(e.player);

    var style_name as string;
    var style_time as string;
    var style_post as string;
    var style_paragraph as string;
    var style_event as string;
    var style_tail as string;
    var style_showTime as bool;
    var style_showChapters as bool;
    var playerList as IData = null;

    if (e.reward.tags has 'chapstart') {
      style_paragraph = '-# `';
      style_event = 'has begun the';
      style_tail = 'questline!';
      style_showTime = false;
      style_showChapters = false;
    }
    else if (e.reward.tags has 'packcomplete') {
      style_paragraph = '# `';
      style_event = 'has completed';
      style_tail = 'after ';
      style_showTime = true;
      style_showChapters = false;
    }
    else if (confluxLevel > 0) {
      style_paragraph = '### `';
      style_event = 'achieved';
      style_tail = 'after ';
      style_showTime = true;
      style_showChapters = false;
    }
    else { // chapcomplete
      style_paragraph = '## `';
      style_event = 'has fully completed the';
      style_tail = 'chapter after ';
      style_showTime = true;
      style_showChapters = true;
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
      playerTimes.sort(function (a as string[], b as string[]) as int {
        return b[0] as int - a[0];
      });

      playerList = [] as IData;
      var first = true;
      for tuple in playerTimes {
        val playTimeMin = tuple[0] as int;
        val name = tuple[1];
        playerList += [{
          text : '', color: 'dark_gray', extra: [
            first ? '`' : ', `', name, '` ',
            { text: formatPlayTimeFromTicks(playTimeMin), color: 'gray' },
          ],
        }] as IData;
        first = false;
      }

      style_name = team.title.unformattedText;
      style_time = formatPlayTimeFromTicks(totalPlayTimeTicks);
      style_post = 'of combined play!';
    }

    val base_extra = [
      { text: style_name, color: 'aqua' }, '` ',
      { text: style_event, color: 'gray' }
      ] as IData + chapterName + [
      { text: style_tail, color: 'gray' }
    ] as IData;

    var details_extra = [] as IData;
    if (style_showTime) {
      details_extra = [
        { text: style_time, color: 'gold' },
        { text: ' ' ~ style_post, color: 'gray' },
      ] as IData;

      if (style_showChapters) {
        details_extra += [' [', { text: chaps[0], color: 'gray' }, '/', { text: chaps[1], color: 'gray' }, ']'];
      }

      details_extra += [' ```Congrats!```'];
    }

    tellraw({ text : style_paragraph, color: 'dark_gray', extra: base_extra + details_extra });

    if (style_showTime && !isNull(playerList)) {
      tellraw({ text: '-# ', color: 'dark_gray', extra: playerList });
    }
  }

  /**
  * Show modpack finishing stats (per player)
  */
  if (e.reward.tags has 'show_stats') {
    showPackCompleteStatDelayed(e.player);
  }

  /**
  * Conflux rewards
  */
  if (confluxLevel > 0 && e.reward.tags has 'personal') {
    e.player.addGameStage('conflux_' ~ confluxKey);
    server.commandManager.executeCommandSilent(server,
      '/ranks add ' ~ e.player.name ~ ' conflux_' ~ confluxKey
    );
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

  /**
  * Pin other quest
  */
  if (e.reward.tags has 'pin_another_quest') {
    val what_is_this_quest_id = 81914138;
    MessageTogglePinned(what_is_this_quest_id).onMessage(e.player.native as EntityPlayerMP);
  }
});

function tellraw(data as IData) as void {
  server.commandManager.executeCommandSilent(server, '/tellraw @a ' ~ data.toJson());
}

function showPackCompleteStatDelayed(player as IPlayer) as void {
  player.world.catenation().sleep(10).then(function (world, ctx) {
    var statList = [] as IData;

    // ---------------------------------------
    // Most crafted item
    // ---------------------------------------
    val maxCraft = getMaxItemStat(player, function(item as IItemDefinition) as PlayerStat {
      return PlayerStat.getCraftStats(item);
    });

    if (!isNull(maxCraft)) statList = addStatListRow(statList,
      'gold', 'Most crafted item: ', tellrawItemObj(maxCraft.item.defaultInstance * maxCraft.count, 'white')
    );

    // ---------------------------------------
    // Most used item
    // ---------------------------------------
    val maxUsed = getMaxItemStat(player, function(item as IItemDefinition) as PlayerStat {
      return PlayerStat.getObjectUseStats(item);
    });

    if (!isNull(maxUsed)) statList = addStatListRow(statList,
      'dark_aqua', 'Most used item: ', tellrawItemObj(maxUsed.item.defaultInstance * maxUsed.count, 'white')
    );

    // ---------------------------------------
    // Most picked up item
    // ---------------------------------------
    val maxPickedUp = getMaxItemStat(player, function(item as IItemDefinition) as PlayerStat {
      return PlayerStat.getObjectsPickedUpStats(item);
    });

    if (!isNull(maxPickedUp)) statList = addStatListRow(statList,
      'dark_green', 'Most picked up item: ', tellrawItemObj(maxPickedUp.item.defaultInstance * maxPickedUp.count, 'white')
    );

    // // ---------------------------------------
    // // Most killed by entity
    // // ---------------------------------------
    // val maxKilledBy = getMaxEntityStat(player, function(entity as IEntityDefinition) as PlayerStat {
    //   return PlayerStat.getKilledByEntityStats(entity);
    // });

    // if (!isNull(maxKilledBy)) statList = addStatListRow(statList,
    //   'dark_red', 'Most killed by: ', tellrawItemObj(maxKilledBy.entity.asSoul(), 'white')
    // ) + [{ text: ' ' ~ maxKilledBy.count, color: 'white' }, ' times'] as IData;

    // ---------------------------------------
    // Other stats
    // ---------------------------------------
    statList = addBasicStat(player, 'stat.jump', statList, 'yellow');
    statList = addBasicStat(player, 'stat.deaths', statList, 'red');

    tellraw([{
      text : '> Some `', color: 'gray', extra: [
        { text: player.nickname(), color: 'aqua' }, '` stats:\n'
      ] + statList }]);
  }).start();
}

function addStatListRow(statList as IData, bulletColor as string, tip as string, object as IData) as IData {
  return statList + [
    (statList.asList().length > 0 ? '\n> ' : '> '), { text: '• ', color: bulletColor }, tip, object,
  ] as IData;
}

function addBasicStat(player as IPlayer, statID as string, statList as IData, bulletColor as string) as IData {
  val stat = PlayerStat.getBasicStat(statID);
  val value = player.readStat(stat);
  if (value <= 0) return statList;
  return addStatListRow(statList, bulletColor, stat.name.unformattedText ~ ': ', {
    text: mods.zenutils.StaticString.format('%,d', [value]), color: 'white'
  });
}

zenClass ItemStat {
  var item as IItemDefinition;
  var count as int;
  zenConstructor(_item as IItemDefinition, _count as int) {
    item = _item;
    count = _count;
  }
}

zenClass EntityStat {
  var entity as IEntityDefinition;
  var count as int;
  zenConstructor(_entity as IEntityDefinition, _count as int) {
    entity = _entity;
    count = _count;
  }
}

function getMaxItemStat(player as IPlayer, getStat as function(IItemDefinition)PlayerStat) as ItemStat {
  var maxValueItem as IItemDefinition = null;
  var maxValue = 0;
  for item in game.items {
    val stat = getStat(item);
    if (isNull(stat)) continue;
    val value = player.readStat(stat);
    if (value > maxValue) {
      maxValue = value;
      maxValueItem = item;
    }
  }

  if (!isNull(maxValueItem)) return ItemStat(maxValueItem, maxValue);
  return null;
}

function getMaxEntityStat(player as IPlayer, getStat as function(IEntityDefinition)PlayerStat) as EntityStat {
  var maxValueEntity as IEntityDefinition = null;
  var maxValue = 0;
  for entityDef in game.entities {
    val entity = entityDef.createEntity(player.world);
    if (!entity instanceof crafttweaker.entity.IEntityLivingBase) continue;

    val stat = getStat(entityDef);
    if (isNull(stat)) continue;
    val value = player.readStat(stat);
    if (value > maxValue) {
      maxValue = value;
      maxValueEntity = entityDef;
    }
  }

  if (!isNull(maxValueEntity)) return EntityStat(maxValueEntity, maxValue);
  return null;
}

/*Inject_js{
globSync('config/ftbquests/normal/chapters/*'+'/*.snbt')
    .forEach((f) => {
      const text = loadText(f)
      const replaced = text.replace(
        /(?<head>rewards: \[\{(\n.+)+?)uid: "(?<uid>\w+)",\s+type: "item",(?<auto>\n\s+auto: "[^"]+",)?\s+item: \{\s+id: "ftbquests:lootcrate",(?:\n\s+Count: (?<count>\d+),)?\s+tag: \{\s+type: "(?<type>\w+)"(?:\s+\},?){2}\n\s+\}(?<tail>\])?/gi,
  (m, ...args) => {
  const {head, uid, auto, type, count, tail} = args.pop()
  return `${head}uid: "${uid}",
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
