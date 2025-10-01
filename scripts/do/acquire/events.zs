#reloadable
#priority -1300
#modloaded zenutils scalinghealth

import crafttweaker.block.IBlock;
import crafttweaker.block.IBlockDefinition;
import crafttweaker.block.IBlockState;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IVector3d;
import crafttweaker.world.IWorld;

import scripts.do.acquire.consequences.onAcquire;

static registry as bool[IItemStack][string] = {} as bool[IItemStack][string];
static blockDefRegistry as bool[IBlockDefinition][string] = {} as bool[IBlockDefinition][string];
static blockDefAliasRegistry as IItemStack[IBlockDefinition] = {} as IItemStack[IBlockDefinition];
static stringRegistry as IItemStack[string] = {} as IItemStack[string];

function pushRegistry(evtName as string, stack as IItemStack) as void {
  if (isNull(registry[evtName])) registry[evtName] = {};
  registry[evtName][stack] = true;
}

function checkAcquire(evtName as string, player as IPlayer, stack as IItemStack) as void {
  if (isNull(player) || player.creative || player.spectator) return;
  if (evtName != 'open' && isNull(registry[evtName])) return;
  val stackAnyAmount = stack.anyAmount();
  if (evtName != 'open' && isNull(registry[evtName][stackAnyAmount])) return;
  onAcquire(evtName, player, stackAnyAmount);
}

function checkAcquireBlock(
  evtName as string,
  player as IPlayer,
  state as IBlockState,
  position as IBlockPos
) as void {
  if (player.world.remote || isNull(player) || isNull(state) || isNull(state.block)) return;
  val blockDef = state.block.definition;
  if (isNull(blockDef) || isNull(blockDefRegistry[evtName]) || isNull(blockDefRegistry[evtName][blockDef])) return;

  var itemBlock = blockDefAliasRegistry[blockDef];
  if (isNull(itemBlock)) itemBlock = state.block.getItem(player.world, position, state);
  if (isNull(itemBlock)) return;

  checkAcquire(evtName, player, itemBlock);
}

////////////////////////////////////////////////////////////////////////////////////////////

events.register(function (e as crafttweaker.event.PlayerCraftedEvent) {
  if (isNull(e.player.world) || e.player.world.remote || isNull(e.output)) return;
  checkAcquire('craft', e.player, e.output);
});

events.register(function (e as crafttweaker.event.PlayerTickEvent) {
  if (e.player.world.remote || e.phase != 'END') return;

  if (e.player.world.provider.worldTime % 10 == 0 && !isNull(e.player.native.openContainer)) {
    checkContainer(e.player, toString(e.player.native.openContainer));
  }

  onHold(e.player);
  onLook(e.player);
});

function onHold(player as IPlayer) as void {
  if (isNull(player.mainHandHeldItem)) return;
  if (isNull(registry.hold)) return;
  checkAcquire('hold', player, player.mainHandHeldItem);
}

function onLook(player as IPlayer) as void {
  if (isNull(registry.look)) return;

  val normal = player.lookingDirection.scale(25);
  val trace = player.getRayTrace(25, 1.0f, false, true, false);
  if (isNull(trace) || trace.isEntity || trace.isMiss || !trace.isBlock) return;

  val blockState = player.world.getBlockState(trace.blockPos);
  checkAcquireBlock('look', player, blockState, trace.blockPos);
}

events.register(function (e as crafttweaker.event.PlayerOpenContainerEvent) {
  if (isNull(e.player.world) || e.player.world.remote) return;

  val serialized = e.container as string;
  utils.log('~~opened container: ' ~ serialized);
  checkContainer(e.player, e.container);
});

function checkContainer(player as IPlayer, containerSerialized as string) as void {
  val class = containerSerialized.split('@')[0];
  val stack = stringRegistry[class];
  if(isNull(stack)) return;
  checkAcquire('open', player, stack);
}

events.register(function (e as crafttweaker.event.PlayerPickupItemEvent) {
  if (isNull(e.player.world) || e.player.world.remote || isNull(e.item) || isNull(e.item.item)) return;
  checkAcquire('pickup', e.player, e.item.item);
});

events.register(function (e as crafttweaker.event.PlayerRightClickItemEvent) {
  if (isNull(e.player.world) || e.player.world.remote || isNull(e.item)) return;
  checkAcquire('use', e.player, e.item);
});

events.register(function (e as crafttweaker.event.BlockPlaceEvent) {
  checkAcquireBlock('place', e.player, e.current, e.position);
});

events.register(function (e as crafttweaker.event.PlayerInteractEvent) {
  checkAcquireBlock('interact', e.player, e.blockState, e.position);
});
