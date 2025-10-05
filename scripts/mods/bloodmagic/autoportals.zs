// Create automatic portals in other dimensions when player right-click ritual stone

#modloaded bloodmagic
#reloadable
#norun

import crafttweaker.block.IBlock;
import crafttweaker.block.IBlockState;
import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;

static scheme as string[][] = [[
  '             ',
  '             ',
  '∏ □ □ □ □ □ ∏',
  '             ',
  '             ',
], [
  '             ',
  '             ',
  '□ ◙ ◙ ◙ ◙ ◙ □',
  '             ',
  '             ',
], [
  '             ',
  '             ',
  '□ ◙       ◙ □',
  '             ',
  '             ',
], [
  '             ',
  '             ',
  '□ ◙       ◙ □',
  '             ',
  '             ',
], [
  '             ',
  '             ',
  '□ ◙       ◙ □',
  '             ',
  '             ',
], [
  '▬ ▬ ▬ ▬ ▬ ▬ ▬',
  '▬ ▬ ▬ ▒ ▬ ▬ ▬',
  '▬ ◙ ◙ ◘ ◙ ◙ ▬',
  '▬ ▬ ▬ ▒ ▬ ▬ ▬',
  '▬ ▬ ▬ ▬ ▬ ▬ ▬',
]] as string[][];

static map as IItemStack[string] = {
  '∏': <thaumcraft:banner_crimson_cult>,
  '□': <thaumcraft:stone_ancient_glyphed>,
  '◙': <bloodmagic:ritual_stone>,
  '▬': <bloodmagic:decorative_brick:2>,
  '◘': <bloodmagic:ritual_controller>,
  '▒': <thaumadditions:mithminite_block>,
} as IItemStack[string];

function say(text as string) as void {
  server.commandManager.executeCommandSilent(server, '/say §8'~text);
}

events.onPlayerInteractBlock(function (e as crafttweaker.event.PlayerInteractBlockEvent) {
  if (isNull(e.world) || e.world.remote || isNull(e.player)/*  || e.player.isFake() */) return;
  if (isNull(e.item) || e.item.definition.id != 'bloodmagic:activation_crystal') return;
  say('Crystal found. Dimension: '~e.world.dimension);

  // Only works for Overworld and Skyblock dims
  if (e.world.dimension != 0 && e.world.dimension != 3) return;

  // Check clicked block to be ritual stone
  val masterState = e.world.getBlockState(e.position);
  say('block found '~masterState.block.definition.id);
  if (isNull(masterState) || masterState.block.definition.id != 'bloodmagic:ritual_controller') return;

  // Check if portal valid (simplified)
  val portalOrient = detectPortal(e.world, e.position);
  if(portalOrient == 0) return;
  say('Portal valid');

  val catenationTimeout = e.world.time + 100;
  e.world.catenation()
  .sleepUntil(function(world, context) {
    return world.getBlock(e.position.up()).definition.id == 'bloodmagic:dimensional_portal';
  })
  .stopWhen(function(world, context) {
      return world.time > catenationTimeout;
  })
  .then(function (world, ctx) {
    prepareNewPortal(world, e.position, masterState);
  }).start();
});

function prepareNewPortal(originalWorld as IWorld, originalPos as IBlockPos, masterState as IBlockState) as void {
  say('prepareNewPortal()');

  val nbt = originalWorld.getBlock(originalPos).data;
  if (
    isNull(nbt)
    || isNull(nbt.ownerLeast)
    || isNull(nbt.ownerMost)
    || isNull(nbt.currentRitual)
    || nbt.currentRitual != 'portal'
  ) return;

  // Check if actual portal was created
  val portalBlock = originalWorld.getBlock(originalPos.up());
  say('master stone have tags. PortalID: '~portalBlock.definition.id);
  if (isNull(portalBlock) || portalBlock.definition.id != 'bloodmagic:dimensional_portal') return;

  // Get point on other planet
  val stella = IWorld.getFromID(114);
  if (isNull(stella)) return;
  say('Planet found');

  var pos = IBlockPos.create(0, 0, 0);
  val width = 7;
  val deph = 5;

  // Get median height we will build portal on
  val median = getMedianHeight(stella, width, deph, pos);
  say('Median: '~median);

  pos = IBlockPos.create(pos.x, median, pos.z);
  
  // Fill with blocks
  server.commandManager.executeCommandSilent(server,
    '/fill '~(pos.x - width / 2)~' '~(median)~' '~(pos.z - deph / 2)~' '
    ~''~(pos.x + width / 2)~' '~(median+10)~' '~(pos.z + deph / 2)~' air'
  );
  server.commandManager.executeCommandSilent(server,
    '/fill '~(pos.x - width / 2)~' 2 '~(pos.z - deph / 2)~' '
    ~''~(pos.x + width / 2)~' '~(median)~' '~(pos.z + deph / 2)~' thaumcraft:stone_arcane'
  );

  originalWorld.catenation().sleep(1).then(function (world, ctx) {
    buildNewPortal(stella, pos, masterState, world, originalPos);
  }).start();
}

function buildNewPortal(world as IWorld, pos as IBlockPos, masterState as IBlockState, originalWorld as IWorld, originalPos as IBlockPos) as void {
  val nbt = originalWorld.getBlock(originalPos).data;
  say('buildNewPortal(). nbt: '~nbt.toSNBT());
  world.setBlockState(masterState, nbt, pos);
  
  say('all done!');
}

// Check if clicked portal ritual stone is valid, return orientation (1 - NS, 2 - EW)
function detectPortal(w as IWorld, pos as IBlockPos) as int {
  if (isPortalBlock(w, pos.north()) && isPortalBlock(w, pos.south())) return 1;
  if (isPortalBlock(w, pos.east()) && isPortalBlock(w, pos.west())) return 2;
  return 0;
}

// Check if block on this pos is valid portal block
function isPortalBlock(w as IWorld, pos as IBlockPos) as bool {
  return w.getBlockState(pos).block.definition.id == 'thaumadditions:mithminite_block';
}

function getMedianHeight(w as IWorld, width as int, deph as int, pos as IBlockPos) as int {
  val arr = intArrayOf(width * deph);
  var k = 0;
  for z in (pos.z - deph / 2) .. (pos.z + deph / 2 + 1) {
    for x in (pos.x - width / 2) .. (pos.x + width / 2 + 1) {
      for y in 0 .. 255 {
        if (w.isAirBlock(IBlockPos.create(x, 255 - y, z))) continue;
        arr[k] = 255 - y;
        break;
      }
      k += 1;
    }
  }
  arr.sort();
  return arr.length % 2 == 0
    ? (arr[arr.length / 2] + arr[arr.length / 2 + 1]) / 2
    : arr[arr.length / 2];
}
