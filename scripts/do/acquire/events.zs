#reloadable
#priority -1300
#modloaded zenutils ctintegration scalinghealth

import crafttweaker.block.IBlockDefinition;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IVector3d;

import scripts.do.acquire.consequences.onAcquire;

static registry as bool[IItemStack][string] = {} as bool[IItemStack][string];
static blockDefRegistry as bool[IBlockDefinition][string] = {} as bool[IBlockDefinition][string];
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
  if (isNull(blockDefRegistry.look) || isNull(blockDefRegistry.look[blockState.block.definition])) return;

  val itemBlock = blockState.block.getItem(player.world, trace.blockPos, blockState);
  if (isNull(itemBlock)) return;

  checkAcquire('look', player, itemBlock);
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
  if (e.world.remote || isNull(e.current) || isNull(e.player)) return;
  if (isNull(blockDefRegistry.place) || isNull(blockDefRegistry.place[e.current.block.definition])) return;

  val itemBlock = e.current.block.getItem(e.world, e.position, e.current);
  if (isNull(itemBlock)) return;

  checkAcquire('place', e.player, itemBlock);
});

events.register(function (e as crafttweaker.event.PlayerInteractEvent) {
  if (e.world.remote || isNull(e.player) || isNull(e.block) || isNull(e.block.definition)) return;
  if (isNull(blockDefRegistry.interact) || isNull(blockDefRegistry.interact[e.block.definition])) return;

  val itemBlock = e.block.getItem(e.world, e.position, e.blockState);
  if (isNull(itemBlock)) return;

  checkAcquire('interact', e.player, itemBlock);
});
