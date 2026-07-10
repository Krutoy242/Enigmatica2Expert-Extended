#modloaded zenutils ftbutilities ftblib
#priority 1500
#reloadable

import crafttweaker.data.IData;
import crafttweaker.util.Math.ceil;
import crafttweaker.util.Math.floor;
import crafttweaker.util.Math.min;
import mods.zenutils.command.ZenUtilsCommandSender;
import native.com.feed_the_beast.ftblib.lib.data.ForgeTeam;
import native.com.feed_the_beast.ftbutilities.data.ClaimedChunk;
import native.com.feed_the_beast.ftbutilities.data.ClaimedChunks;
import native.com.feed_the_beast.ftbutilities.data.FTBUtilitiesPlayerData;
import scripts.commands.perf.util.tpMessage;
import scripts.commands.perf.util.button;
import scripts.lib.command.senderAsPlayerOrNull;
import scripts.lib.command.richToPlain;

function show(sender as ZenUtilsCommandSender, pageArg as int = 1) as IData {
  val player = senderAsPlayerOrNull(sender);
  val isConsole = isNull(player);
  val playerY = isNull(player) ? 0 : floor(player.y);
  if (isNull(ClaimedChunks.instance)) {
    return ['§cFTBUtilities chunk claiming is not active.'];
  }

  val teamChunks as [ClaimedChunk][string] = {};
  val teams as ForgeTeam[string] = {};
  val allChunks = ClaimedChunks.instance.allChunks;

  if (isNull(allChunks) || allChunks.size() == 0) {
    return ['§eNo chunks are claimed.'];
  }

  for chunk in allChunks.toArray() as ClaimedChunk[] {
    val team as ForgeTeam = chunk.getTeam();
    if (isNull(team)) continue;

    val teamName = team.getTitle().getUnformattedText();
    if (isNull(teamChunks[teamName])) {
      teamChunks[teamName] = [];
      teams[teamName] = team;
    }
    teamChunks[teamName].add(chunk);
  }

  if (teamChunks.length == 0) {
    return ['§eNo chunks are claimed.'];
  }

  // Create a flat list of all groups with pre-calculated data
  val allGroupsData = [] as [IData];
  val teamNames = teamChunks.keys;
  teamNames.sort();

  for teamName in teamNames {
    val chunks = teamChunks[teamName];
    val chunksByDim as [ClaimedChunk][int] = {};
    for chunk in chunks {
      val dim = chunk.getPos().dim;
      if (isNull(chunksByDim[dim])) {
        chunksByDim[dim] = [];
      }
      chunksByDim[dim].add(chunk);
    }

    for dim, dimChunks in chunksByDim {
      val groupsInDim = [] as [[ClaimedChunk]];
      val chunkMap = {} as ClaimedChunk[string];
      for chunk in dimChunks {
        val pos = chunk.getPos();
        chunkMap[pos.posX ~ ':' ~ pos.posZ] = chunk;
      }

      val chunkKeys = chunkMap.keys;
      for key in chunkKeys {
        val startChunk = chunkMap[key];
        if (isNull(startChunk)) continue;

        val currentGroup = [] as [ClaimedChunk];
        val queue = [] as [ClaimedChunk];

        queue.add(startChunk);
        chunkMap[key] = null;

        var head = 0;
        while head < queue.length {
          val currentChunk = queue[head];
          head += 1;
          currentGroup.add(currentChunk);

          val currentPos = currentChunk.getPos();

          for dx in (-2) .. 3 {
            for dz in (-2) .. 3 {
              if (dx == 0 && dz == 0) continue;
              val neighborX = currentPos.posX + dx;
              val neighborZ = currentPos.posZ + dz;
              val neighborKey = neighborX ~ ':' ~ neighborZ;
              val neighborChunk = chunkMap[neighborKey];
              if (!isNull(neighborChunk)) {
                queue.add(neighborChunk);
                chunkMap[neighborKey] = null;
              }
            }
          }
        }
        groupsInDim.add(currentGroup);
      }

      for group in groupsInDim {
        var totalX = 0.0;
        var totalZ = 0.0;
        for chunkInGroup in group {
          val pos = chunkInGroup.getPos();
          totalX += pos.posX;
          totalZ += pos.posZ;
        }
        allGroupsData.add({
          teamName: teamName,
          dim: dim as int,
          size: group.length,
          centerX: totalX / group.length,
          centerZ: totalZ / group.length,
        } as IData);
      }
    }
  }

  // Paginate the flat list of group data
  val pageSize = 10;
  val totalGroups = allGroupsData.length;
  if (totalGroups == 0) {
    return ['§eNo chunks are claimed.'];
  }

  val totalPages = ceil(totalGroups as float / pageSize) as int;
  val page = pageArg < 1 ? 1 : pageArg > totalPages ? totalPages : pageArg;
  val startIndex = (page - 1) * pageSize;
  val endIndex = min(startIndex + pageSize, totalGroups);
  val pageGroupsData = allGroupsData[startIndex .. endIndex];

  // Group by team for rendering
  val pageGroupsByTeam as [IData][string] = {};
  for groupInfo in pageGroupsData {
    val teamName = groupInfo.teamName as string;
    if (isNull(pageGroupsByTeam[teamName])) {
      pageGroupsByTeam[teamName] = [];
    }
    pageGroupsByTeam[teamName] = pageGroupsByTeam[teamName] + groupInfo;
  }

  // Render
  var result as IData = ['§aList of all claimed chunks (Page ' ~ page ~ '/' ~ totalPages ~ '):'];
  val pageTeamNames = pageGroupsByTeam.keys;
  pageTeamNames.sort();

  for teamName in pageTeamNames {
    val teamGroupsOnPage = pageGroupsByTeam[teamName];
    val totalTeamChunks = teamChunks[teamName].length;
    val team = teams[teamName];

    var membersTooltip = '§7Members:';
    for member in team.members {
      val playerData = FTBUtilitiesPlayerData.get(member);
      val name = !isNull(playerData) && !playerData.nickname.isEmpty()
        ? playerData.nickname
        : member.name;
      membersTooltip += '\n §f- ' ~ name;
    }

    result += [{
      text: '\nTeam: ', color: 'gray', extra: [{
        text: teamName,
        underlined: true,
        hoverEvent: { action: 'show_text', value: membersTooltip },
      }, ' (', { text: totalTeamChunks, color: 'white' }, ' chunks):',
      ] }];

    for groupInfo in teamGroupsOnPage {
      val dim = groupInfo.dim as int;
      val blockX = floor(16.0f * groupInfo.centerX) + 8.5;
      val blockZ = floor(16.0f * groupInfo.centerZ) + 8.5;
      val groupSize = groupInfo.size as int;

      val groupText = `§f${groupSize} §7chunks at Dim §f${dim} §7~[§4${blockX} §2${blockZ}§7]`;

      result += ['\n    '];
      result += tpMessage(dim, blockX, playerY, blockZ, groupText);
    }
  }

  // Footer
  var footer = ['\n'] as IData;
  if (page > 1) {
    footer += [button('§7§n[< Prev]', '/perf claimed ' ~ (page - 1), 'Go to page ' ~ (page - 1)), ' '];
  }

  footer += ['§8[Page §7' ~ page ~ ' §8of §7' ~ totalPages ~ '§8]'];

  if (page < totalPages) {
    footer += [' ', button('§7§n[Next >]', '/perf claimed ' ~ (page + 1), 'Go to page ' ~ (page + 1))];
  }

  result += footer;

  if (isConsole) {
    sender.sendMessage(richToPlain(result));
    return null;
  }
  return result;
}
