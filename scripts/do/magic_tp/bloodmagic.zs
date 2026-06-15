#norun // unfinished feature
#modloaded bloodmagic zenutils
#reloadable

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.zenutils.command.CommandUtils;
import mods.zenutils.command.ZenCommand;

// Portal scheme: 7 wide x 5 deep x 6 layers
// Layer 5 (last) = ground / MRS level (y=0)
// Row 2 = center row (z=0)
// Column 3 = center column (x=0, MRS position)
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

static SCHEME_WIDTH  as int = 7;
static SCHEME_DEPTH  as int = 5;
static SCHEME_HEIGHT as int = 6;
static MRS_LAYER     as int = SCHEME_HEIGHT - 1;
static TARGET_DIM    as int = 114;

events.onPlayerInteractBlock(function (e as crafttweaker.event.PlayerInteractBlockEvent) {
  if (isNull(e.world) || e.world.remote || isNull(e.player)) return;
  if (isNull(e.item) || e.item.definition.id != 'bloodmagic:activation_crystal') return;

  if (e.world.dimension != 0 && e.world.dimension != 3) return;

  val masterState = e.world.getBlockState(e.position);
  if (isNull(masterState) || masterState.block.definition.id != 'bloodmagic:ritual_controller') return;

  val portalOrient = detectPortal(e.world, e.position);
  if (portalOrient == 0) return;
  if (utils.DEBUG) print('Valid scheme, waiting for dimensional portal...');

  val timeout = e.world.worldInfo.worldTotalTime + 200;
  e.world.catenation()
    .sleepUntil(function (world, context) {
      return world.getBlockState(e.position.up()).block.definition.id == 'bloodmagic:dimensional_portal';
    })
    .stopWhen(function (world, context) {
      return world.worldInfo.worldTotalTime > timeout;
    })
    .then(function (world, ctx) {
      if (utils.DEBUG) print('Portal activated! Building destination...');
      prepareNewPortal(world, e.position);
    })
    .onStop(function (world, ctx) {
      if (world.worldInfo.worldTotalTime > timeout) {
        if (utils.DEBUG) print('Timeout waiting for dimensional portal');
      }
    })
    .start();
});

// Validate full scheme structure around MRS.
// Returns 1 if valid, 0 otherwise. Only NORTH(2)/SOUTH(3) direction.
function detectPortal(w as IWorld, pos as IBlockPos) as int {
  val nbt = w.getBlock(pos).data;
  if (isNull(nbt)) return 0;
  if (isNull(nbt.currentRitual) || nbt.currentRitual != 'portal') return 0;

  val dir = nbt.direction.asInt();
  if (dir != 2 && dir != 3) return 0;

  for layer in 0 .. SCHEME_HEIGHT {
    for row in 0 .. SCHEME_DEPTH {
      for col in 0 .. SCHEME_WIDTH {
        val ch = getSchemeChar(layer, row, col);
        if (isNull(ch) || ch == ' ') continue;
        if (ch == '◘') continue;

        val bx = pos.x + col - (SCHEME_WIDTH / 2);
        val by = pos.y + (MRS_LAYER - layer);
        val bz = pos.z + row - (SCHEME_DEPTH / 2);

        val worldState = w.getBlockState(IBlockPos.create(bx, by, bz));
        if (isNull(worldState)) return 0;

        val expected = map[ch];
        if (isNull(expected)) continue;

        if (worldState.block.definition.id != expected.definition.id) return 0;
        if (worldState.meta != expected.metadata) return 0;
      }
    }
  }
  return 1;
}

function getSchemeChar(layer as int, row as int, col as int) as string {
  if (layer < 0 || layer >= SCHEME_HEIGHT) return ' ';
  if (row < 0 || row >= SCHEME_DEPTH) return ' ';
  val layerArr = scheme[layer];
  if (isNull(layerArr)) return ' ';
  val rowStr = layerArr[row];
  if (isNull(rowStr)) return ' ';
  val charIdx = col * 2;
  return charIdx >= rowStr.length ? ' ' : rowStr[charIdx];
}

function prepareNewPortal(originalWorld as IWorld, originalPos as IBlockPos) as void {
  val sourceNbt = originalWorld.getBlock(originalPos).data;
  if (isNull(sourceNbt)) { if (utils.DEBUG) print('ERROR: No MRS NBT'); return; }
  if (isNull(sourceNbt.ownerLeast) || isNull(sourceNbt.ownerMost)) { if (utils.DEBUG) print('ERROR: No owner'); return; }
  if (isNull(sourceNbt.currentRitual) || sourceNbt.currentRitual != 'portal') { if (utils.DEBUG) print('ERROR: Wrong ritual'); return; }

  val portalBlock = originalWorld.getBlockState(originalPos.up());
  if (isNull(portalBlock) || portalBlock.block.definition.id != 'bloodmagic:dimensional_portal') {
    if (utils.DEBUG) print('ERROR: No portal block');
    return;
  }

  val destWorld = IWorld.getFromID(TARGET_DIM);
  if (isNull(destWorld)) { if (utils.DEBUG) print('ERROR: Dim ' ~ TARGET_DIM ~ ' not loaded'); return; }
  if (utils.DEBUG) print('Target world loaded: ' ~ TARGET_DIM);

  val center = IBlockPos.create(200, 0, 200);

  // Wait 3 ticks for chunk to settle, then build
  originalWorld.catenation().sleep(3).then(function (world, ctx) {
    val surfaceY = findSurface(destWorld, center);
    if (surfaceY <= 0) { if (utils.DEBUG) print('ERROR: Surface not found'); return; }
    val buildPos = IBlockPos.create(center.x, surfaceY, center.z);
    if (utils.DEBUG) print('Building at Y=' ~ surfaceY);

    // Build platform and structure using IWorld methods (cross-dim safe)
    buildPlatform(destWorld, buildPos);
    buildDecorativeStructure(destWorld, buildPos);
    buildRitualRunes(destWorld, buildPos, sourceNbt.direction.asInt());
    placeAndActivateMRS(destWorld, buildPos, sourceNbt);
    if (utils.DEBUG) print('Destination portal built and ready!');
  }).start();
}

function findSurface(world as IWorld, pos as IBlockPos) as int {
  for y in 0 .. 255 {
    val checkY = 255 - y;
    if (!world.isAirBlock(IBlockPos.create(pos.x, checkY, pos.z)))
      return checkY + 1; // return the first air block above the surface
  }
  return 0;
}

// Build a stone platform at the build position.
function buildPlatform(world as IWorld, buildPos as IBlockPos) as void {
  val stoneState = <blockstate:thaumcraft:stone_arcane>;
  val airState = <blockstate:minecraft:air>;
  val cx = buildPos.x;
  val cy = buildPos.y;
  val cz = buildPos.z;

  val halfW = SCHEME_WIDTH / 2;   // 3
  val halfD = SCHEME_DEPTH / 2;   // 2

  // Clear everything from ground level up to structure top + 2 headroom.
  // Structure spans cy+0 (ground) to cy+MRS_LAYER (top), so clear cy to cy+MRS_LAYER+2.
  for dx in (-(halfW + 1)) .. (halfW + 2) {
    for dy in 0 .. (SCHEME_HEIGHT + 2) {
      for dz in (-(halfD + 1)) .. (halfD + 2) {
        world.setBlockState(airState, IBlockPos.create(cx + dx, cy + dy, cz + dz));
      }
    }
  }
  // Build stone platform below the structure (3 layers deep).
  for dx in (-(halfW + 1)) .. (halfW + 2) {
    for dy in (-3) .. 0 {
      for dz in (-(halfD + 1)) .. (halfD + 2) {
        world.setBlockState(stoneState, IBlockPos.create(cx + dx, cy + dy, cz + dz));
      }
    }
  }
}

// Place decorative blocks from scheme (excluding MRS).
function buildDecorativeStructure(world as IWorld, buildPos as IBlockPos) as void {
  val cx = buildPos.x;
  val cy = buildPos.y;
  val cz = buildPos.z;

  for layer in 0 .. SCHEME_HEIGHT {
    // Layer 0 = top (banners), layer MRS_LAYER = ground/MRS level.
    // Scheme is defined top-to-bottom, so higher layer index -> lower Y.
    val ly = cy + (MRS_LAYER - layer);
    for row in 0 .. SCHEME_DEPTH {
      val lz = cz + row - (SCHEME_DEPTH / 2);
      for col in 0 .. SCHEME_WIDTH {
        val ch = getSchemeChar(layer, row, col);
        if (isNull(ch) || ch == ' ') continue;
        if (ch == '◘') continue;

        val lx = cx + col - (SCHEME_WIDTH / 2);
        val item = map[ch];
        if (isNull(item)) continue;

        val state = utils.getStateFromItem(item);
        world.setBlockState(state, IBlockPos.create(lx, ly, lz));
      }
    }
  }
}

// Place ritual stones sourced directly from Blood Magic's native
// RitualPortal.gatherComponents rune layout via RitualHelper.
function buildRitualRunes(world as IWorld, buildPos as IBlockPos, dir as int) as void {
  val nativeWorld = world.native as native.net.minecraft.world.World;
  val nativePos = native.net.minecraft.util.math.BlockPos(buildPos.x, buildPos.y, buildPos.z);
  val portalRitual = native.WayofTime.bloodmagic.BloodMagic.RITUAL_MANAGER.getRitual('portal');
  if (isNull(portalRitual)) { if (utils.DEBUG) print('ERROR: Portal ritual not found'); return; }
  if (dir == 3) {
    native.WayofTime.bloodmagic.util.helper.RitualHelper.createRitual(nativeWorld, nativePos, native.net.minecraft.util.EnumFacing.SOUTH, portalRitual, false);
  }
  else {
    native.WayofTime.bloodmagic.util.helper.RitualHelper.createRitual(nativeWorld, nativePos, native.net.minecraft.util.EnumFacing.NORTH, portalRitual, false);
  }
}

// Place MRS with modified NBT that triggers auto-activation,
// which registers the destination in LocationsHandler via
// RitualPortal.activateRitual().
//
// Key trick: swap isRunning<->isStoned from source NBT values:
//   isRunning = !source.isRunning  (false vs true)  -> triggers redstoned path
//   isStoned  = source.isRunning   (true vs false)  -> MRS auto-activates next tick
function placeAndActivateMRS(world as IWorld, buildPos as IBlockPos, sourceNbt as IData) as void {
  val cx = buildPos.x;
  val cy = buildPos.y;
  val cz = buildPos.z;

  // Build MRS NBT manually, swapping isRunning/isStoned for auto-activation
  val mrsNbt = IData.createEmptyMutableDataMap();
  mrsNbt.memberSet('ownerLeast', sourceNbt.ownerLeast);
  mrsNbt.memberSet('ownerMost', sourceNbt.ownerMost);
  mrsNbt.memberSet('currentRitual', sourceNbt.currentRitual);
  mrsNbt.memberSet('currentRitualTag', sourceNbt.currentRitualTag);
  mrsNbt.memberSet('direction', sourceNbt.direction);

  // Swap: source has isRunning=true, isStoned=false (or absent)
  // Destination needs isRunning=false, isStoned=true to trigger auto-activation
  mrsNbt.memberSet('isRunning', !sourceNbt.isRunning);
  if (!isNull(sourceNbt.isStoned)) {
    mrsNbt.memberSet('isStoned', !sourceNbt.isStoned);
  }
  else {
    mrsNbt.memberSet('isStoned', sourceNbt.isRunning);
  }

  val mrsState = <blockstate:bloodmagic:ritual_controller>;
  world.setBlockState(mrsState, mrsNbt, IBlockPos.create(cx, cy, cz));
  if (utils.DEBUG) print('MRS placed with auto-activation NBT');
}

val buildPortalCmd as ZenCommand = ZenCommand.create('build_auto_portal');
buildPortalCmd.requiredPermissionLevel = 2;
buildPortalCmd.execute = function (command, server, sender, args) {
  val pl = CommandUtils.getCommandSenderAsPlayer(sender);
  if (isNull(pl)) return;
  if (pl.world.remote) return;

  val world = pl.world;
  val pos = pl.position;

  val sourceNbt = IData.createEmptyMutableDataMap();
  sourceNbt.memberSet('ownerLeast', pl.getUUIDObject().getLeastSignificantBits() as long);
  sourceNbt.memberSet('ownerMost', pl.getUUIDObject().getMostSignificantBits() as long);
  sourceNbt.memberSet('currentRitual', 'portal');
  sourceNbt.memberSet('currentRitualTag', IData.createEmptyMutableDataMap());
  sourceNbt.memberSet('direction', 2);
  sourceNbt.memberSet('isRunning', true);
  sourceNbt.memberSet('isStoned', false);

  if (utils.DEBUG) print('buildPlatform...');
  buildPlatform(world, pos);
  if (utils.DEBUG) print('buildDecorativeStructure...');
  buildDecorativeStructure(world, pos);
  if (utils.DEBUG) print('buildRitualRunes...');
  buildRitualRunes(world, pos, sourceNbt.direction.asInt());
  if (utils.DEBUG) print('placeAndActivateMRS...');
  placeAndActivateMRS(world, pos, sourceNbt);

  val timeout = world.worldInfo.worldTotalTime + 200;
  world.catenation()
    .sleepUntil(function (w, ctx) {
      return w.getBlockState(pos.up()).block.definition.id == 'bloodmagic:dimensional_portal';
    })
    .stopWhen(function (w, ctx) {
      return w.worldInfo.worldTotalTime > timeout;
    })
    .then(function (w, ctx) {
      if (utils.DEBUG) print('Portal activated! Building destination...');
      prepareNewPortal(w, pos);
    })
    .onStop(function (w, ctx) {
      if (w.worldInfo.worldTotalTime > timeout) {
        if (utils.DEBUG) print('Timeout waiting for dimensional portal');
      }
    })
    .start();
};
buildPortalCmd.register();
