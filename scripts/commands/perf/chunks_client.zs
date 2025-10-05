#modloaded zenutils ftblib ftbutilities
#priority -1500
#reloadable
#sideonly client

import crafttweaker.data.IData;
import mods.zenutils.NetworkHandler;

import scripts.commands.build.isClose;
import scripts.commands.perf.loaders.message;
import scripts.commands.perf.loaders.tpMessage;
import scripts.commands.perf.util.sortArrayBy;
import scripts.commands.perf.util.naturalInt;

// ⓪➀➁➂➃➄➅➆➇➈➉

NetworkHandler.registerServer2ClientMessage('perf_chunks', function (player, byteBuf) {
  show(byteBuf.readData());
});

static CHUNK_GROUP_DIST as int = 28;

function show(data as IData) as void {
  utils.log(`🌍 received data from server:\n${data}`);

  val messenger = Messenger(data.titles.asList(), data.viewDistance);

  for worldData in data.worlds.asList() {
    if (isNull(worldData)) continue;
    messenger.setWorldData(worldData);

    val chunkArr = worldData.chunks.asIntArray();
    for group in getGroups(chunkArr) {
      if (utils.DEBUG) {
        var s = '';
        for c in group { s ~= `${c} `; }
        print(`🌍 Group: ${s}`);
      }

      val minMax = [2147483647, 2147483647, -2147483646, -2147483646] as int[];

      // Iterate each group element to find boundaries
      for index in group {
        minMaxing(minMax, chunkArr[index * 2], chunkArr[index * 2 + 1]);
      }
      val width = minMax[2] - minMax[0] + 1;
      val height = minMax[3] - minMax[1] + 1;
      utils.log(`🌍 minMax: ${minMax[0]} ${minMax[1]} ${minMax[2]} ${minMax[3]}`);
      utils.log(`🌍 width: ${width} height: ${height}`);

      // Pack closest chunks together in straightened 2d array
      val pack = intArrayOf(width * height, -1);
      for index in group {
        pack[(chunkArr[index * 2] - minMax[0]) + (chunkArr[index * 2 + 1] - minMax[1]) * width] = index;
      }

      // Compose for message
      messenger.pushGroup(pack, width, chunkArr);
    }
  }

  messenger.flush();
}

function getGroups(chunks as int[]) as int[][] {
  // Gather "score" of chunks - how many and how close other chunks are
  val chunkCount = chunks.length / 2;
  val neighbours = intArrayOf(chunkCount, 0);
  for i in 0 .. chunkCount {
    val x1 = chunks[i * 2];
    val z1 = chunks[i * 2 + 1];

    // Summarize scores for each chunk
    for j in 0 .. chunkCount {
      if (i == j) continue;
      val x2 = chunks[j * 2];
      val z2 = chunks[j * 2 + 1];
      if (isClose(x1, z1, x2, z2, CHUNK_GROUP_DIST / 2)) {
        val dist = pow((pow(x2 - x1, 2) + pow(z2 - z1, 2)) as double, 0.5) as int;
        neighbours[i] = neighbours[i] + pow(1.9, CHUNK_GROUP_DIST - dist);
      }
    }
  }

  // Gather score and indexes together to sort them
  val sortedIndexes = sortArrayBy(neighbours, function(count as int, i as int) as string {
    return `${naturalInt(count)} ${naturalInt(1073741823 - chunks[i * 2])}:${naturalInt(1073741823 - chunks[i * 2 + 1])} ${i}`;
  });

  // Group indexes
  var groups = [] as int[][];
  val alreadyAdded = boolArrayOf(sortedIndexes.length, false);
  for i, indexI in sortedIndexes {
    if (alreadyAdded[i]) continue;
    val x1 = chunks[indexI * 2];
    val z1 = chunks[indexI * 2 + 1];
    var newGroup = [indexI] as int[];
    if (i + 1 < sortedIndexes.length) {
      for j in (i + 1) .. sortedIndexes.length {
        val indexJ = sortedIndexes[j];
        if (alreadyAdded[j]) continue;
        val x2 = chunks[indexJ * 2];
        val z2 = chunks[indexJ * 2 + 1];
        if (isClose(x1, z1, x2, z2, CHUNK_GROUP_DIST / 2)) {
          newGroup += indexJ;
          alreadyAdded[j] = true;
        }
      }
    }
    groups += newGroup;
  }

  return groups;
}

function getGroupSize(
  startIndex as int,
  firstChunkIndex as int,
  sortedChunks as string[],
  chunkArr as int[]
) as int {
  val x1 = chunkArr[firstChunkIndex * 2];
  val z1 = chunkArr[firstChunkIndex * 2 + 1];
  val minMax = [x1, z1, x1, z1] as int[];

  var j = startIndex;
  while (true) {
    if (j + 1 >= sortedChunks.length) return j;

    val nextIndex = sortedChunks[j + 1].split(' ')[2] as int;
    val x = chunkArr[nextIndex * 2];
    val z = chunkArr[nextIndex * 2 + 1];
    if (
      !isClose(minMax[0], minMax[1], x, z, CHUNK_GROUP_DIST / 2)
      || !isClose(minMax[2], minMax[3], x, z, CHUNK_GROUP_DIST / 2)
    ) {
      return j;
    }

    minMaxing(minMax, x, z);
    j += 1;
  }
  return j; // never
}

function minMaxing(minMax as int[], x as int, z as int) as void {
  if (x < minMax[0]) minMax[0] = x;
  if (z < minMax[1]) minMax[1] = z;
  if (x > minMax[2]) minMax[2] = x;
  if (z > minMax[3]) minMax[3] = z;
}

zenClass Messenger {
  val maxChatWidth as int = 34;
  var grid as IData[][] = [];

  var worldData as IData = null;
  var titles as [IData] = null;
  var viewDistance as int = 16;

  zenConstructor(titles as [IData], viewDistance as int) {
    this.titles = titles;
    this.viewDistance = viewDistance;
  }

  function setWorldData(worldData as IData) as void {
    this.worldData = worldData;
  }

  function chunkCell(index as int, x as int, z as int) as IData {
    val claimedIndex = worldData.claims[index] as int;
    val isClaimed = claimedIndex > 0;
    val isLoadedByPlayer = isInclude(worldData.players, x, z, viewDistance);
    val isAnchored = isInclude(worldData.anchors, x, z);
    val isForced = isClaimed && claimedIndex % 2 == 0;

    val color =
      isForced && isLoadedByPlayer ? '§e'
      : isForced ? '§6'
      : isClaimed && isLoadedByPlayer ? '§b'
      : isClaimed ? '§3'
      : isLoadedByPlayer ? '§f'
      : '§7';

    val symbol = isAnchored ? '▓' : '█';

    var tooltip = [] as IData;
    if (isClaimed) tooltip += [`§8⚀ §7Claimed: §3${titles[(claimedIndex - 1) / 2]}`];
    if (isForced)
      tooltip += [`${tooltip.length > 0 ? '\n' : ''}§8⚄ §6FTBU force loaded`];
    if (isAnchored)
      tooltip += [`${tooltip.length > 0 ? '\n' : ''}§8⚓ §2With chunk loader`];
    if (isLoadedByPlayer)
      tooltip += [`${tooltip.length > 0 ? '\n' : ''}§8☺ §fLoaded by player`];

    return tpMessage(
      worldData.dim,
      8.5 + x * 16,
      200,
      8.5 + z * 16,
      color ~ symbol,
      null,
      tooltip
    );
  }

  function isInclude(chunkPosArr as int[], x as int, z as int, dist as int = 0) as bool {
    for k in 0 .. chunkPosArr.length / 2 {
      if (isClose(
        x, z,
        chunkPosArr[k * 2],
        chunkPosArr[k * 2 + 1],
        dist
      )) return true;
    }
    return false;
  }

  function pushGroup(group as int[], width as int, chunkArr as int[]) as void {
    val height = group.length / width;

    var y1 = fit(width, height);
    if (y1 < 0) {
      flush();
      y1 = 0;
    }
    val x1 = line(y1).length;

    for y in 0 .. height {
      val v = y + y1;

      val prefix
        = height == 1
          ? '▐'
          : y == 0
            ? '╔'
            : (y == height - 1)
                ? '╚'
                : '╟';
      push(`${prefix}`, x1, v);
      for x in 0 .. width {
        val u = x + x1;
        val i = group[y * width + x];
        if (i < 0) {
          push('▒', u, v);
          continue;
        }

        val symbol = chunkCell(i, chunkArr[i * 2], chunkArr[i * 2 + 1]);
        push(symbol, u, v);
      }
    }
  }

  function line(y as int) as IData[] {
    while (grid.length <= y) grid += [] as IData[];
    return grid[y];
  }

  function push(char as IData, u as int, v as int) as void {
    line(v);
    while (grid[v].length <= u - 1) grid[v] = grid[v] + '▔';
    grid[v] = grid[v] + char;
  }

  function fit(width as int, height as int) as int {
    for y, line in grid {
      if (line.length + width > maxChatWidth) continue;
      if (grid.length != 0 && y + height > grid.length) return -1;

      var found = true;
      for v in y .. grid.length {
        if (grid[v].length > line.length) {
          found = false;
          break;
        }
      }
      if (found) return y;
    }
    return -1;
  }

  function flush() as void {
    var merged = [] as IData;
    for i, line in grid {
      var plainString = '';
      if (i != 0) merged += ['\n'] as IData;
      for char in line {
        if (isNull(char.asList())) {
          plainString += char.asString();
        }
        else {
          if (plainString != '') {
            merged += [plainString];
            plainString = '';
          }
          merged += [char] as IData;
        }
      }
      if (plainString != '') merged += [plainString];
    }
    if (merged.asList().length > 0) {
      message(client.player, [{
        text : '',
        color: 'dark_gray',
        extra: merged,
      }]);
    }
    grid = [];
  }
}
