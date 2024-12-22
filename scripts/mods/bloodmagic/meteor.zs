/*

@file Additional features for Blood Magic meteors
- Producing trace of smoke particles when meteor flying
- Constantly spawn new meteors on some planets

*/

#modloaded bloodmagic
#reloadable

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import crafttweaker.event.PlayerLoggedInEvent;
import native.net.minecraft.world.gen.ChunkProviderServer;
import native.net.minecraft.world.chunk.Chunk;

val METEOR_CHANCE = 0.01;

static meteorCatalystForDimension as IItemStack[int] = {
  122: <minecraft:iron_block>,
  123: <jaopca:block_blockdilithium>,
};

// Allow only 1 meteor per tick summoned
events.onWorldTick(function (e as crafttweaker.event.WorldTickEvent) {
  if (
    e.world.remote
    || e.phase != 'END'
    || (e.world.dimension != 122 && e.world.dimension != 123)
    || e.world.time % 40 != 0
  ) return;

  val chunkProvider = e.world.native.getChunkProvider() as ChunkProviderServer;
  val loadedChunks as [Chunk] = chunkProvider.getLoadedChunks();
  val rnd = e.world.random;
  for chunk in loadedChunks {
    if(rnd.nextDouble() > METEOR_CHANCE) continue;
    trySpawnMeteor(e.world, chunk.x * 16, chunk.z * 16);
  }
});

function trySpawnMeteor(world as IWorld, x as int, z as int) as void {
  val meteorCatalyst = meteorCatalystForDimension[world.dimension];
  if (isNull(meteorCatalyst)) return;
  
  val spread = 16;
  val rndPos = IBlockPos.create(
    x + world.random.nextInt(-spread, spread),
    255,
    z + world.random.nextInt(-spread, spread)
  );

  // Skip if random pos out of loaded chunks. Also prevent to spawn meteor on chunks boundaries
  if (
    !world.isBlockLoaded(rndPos)
    || !world.isBlockLoaded(rndPos.east(16))
    || !world.isBlockLoaded(rndPos.west(16))
    || !world.isBlockLoaded(rndPos.north(16))
    || !world.isBlockLoaded(rndPos.south(16))
  ) return;

  spawnMeteor(world, rndPos, meteorCatalyst);

  // server.commandManager.executeCommandSilent(server, '/say §8spawned:['~rndPos.x~':'~rndPos.y~':'~rndPos.z~']');
}

function spawnMeteor(world as IWorld, pos as IBlockPos, stack as IItemStack) as void {
  val meteor = <entity:bloodmagic:meteor>.spawnEntity(world, pos);
  val size = world.random.nextDouble(0.1, 0.5);
  val newData = stack.asData() + {
    noItem                 : null,
    radiusModifier         : size,
    explosionModifier      : size + 1.0,
    fillerChance           : 0.0,
    projectileMaxTicksInAir: 150,
    Motion                 : [
      world.random.nextDouble(-0.2, 0.2),
      world.random.nextDouble(-0.5, -1.5),
      world.random.nextDouble(0.25, 1),
    ],
  } as IData;
  meteor.updateNBT(newData);
}
