#loader contenttweaker
#modloaded tconstruct extrautils2

import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.contenttweaker.tconstruct.TraitBuilder;
import native.com.rwtema.extrautils2.network.NetworkHandler;
import native.com.rwtema.extrautils2.particles.PacketParticleSplineCurve;
import native.net.minecraft.util.SoundCategory;
import native.net.minecraft.util.math.Vec3d;

import scripts.do.portal_spread.sphere.getNextPoint;
import scripts.do.portal_spread.sphere.radiusToIndex;

static VAPORIZER_RADIUS as int = 10;

// Lag-preventing list to delay consecuenced triggers at the same position
static recentClearPoints as [[long]] = [] as [[long]];

events.onWorldTick(function (e as crafttweaker.event.WorldTickEvent) {
  if (e.world.remote || e.world.dimension != 0 || e.phase != 'END' || recentClearPoints.length == 0) return;

  for j in 0 .. recentClearPoints.length {
    val i = recentClearPoints.length - j - 1;
    val data = recentClearPoints[i];
    val time = data[0];
    if (e.world.worldInfo.worldTotalTime - time >= 5) recentClearPoints.remove(i);
  }
});

function clearLiquids(world as IWorld, pos as IBlockPos) as void {
  if (world.remote) return;

  val dim = world.dimension;
  val checkRadiusSq = VAPORIZER_RADIUS * VAPORIZER_RADIUS;

  for pointData in recentClearPoints {
    val pTime = pointData[0];
    val pDim = pointData[1];
    val px = pointData[2];
    val py = pointData[3];
    val pz = pointData[4];
    if (pDim != dim) continue;

    val dx = pos.x - px;
    val dy = pos.y - py;
    val dz = pos.z - pz;

    if ((dx * dx + dy * dy + dz * dz) < checkRadiusSq && world.worldInfo.worldTotalTime - pTime < 5) return;
  }

  recentClearPoints.add([world.worldInfo.worldTotalTime, dim as long, pos.x as long, pos.y as long, pos.z as long] as [long]);

  var currentIndex = 1;
  val maxIndex = radiusToIndex(VAPORIZER_RADIUS);
  var liquidBlocksFound = 0;
  var lastLoggedIndex = 0;

  while currentIndex < maxIndex {
    val pointData = getNextPoint(currentIndex);
    currentIndex = pointData[0];

    if (currentIndex - lastLoggedIndex > 20000)
      lastLoggedIndex = currentIndex;

    val currentPos = pos.add(pointData[1], pointData[2], pointData[3]);
    val state = world.getBlockState(currentPos);

    if (!isNull(state?.block?.fluid)) {
      liquidBlocksFound += 1;

      world.setBlockState(<blockstate:minecraft:air>, currentPos);

      if (world.random.nextInt(liquidBlocksFound) == 0) {
        val startPosVec = Vec3d(0.5 + pos.x, 0.5 + pos.y, 0.5 + pos.z);
        val endPosVec = Vec3d(0.5 + currentPos.x, 0.5 + currentPos.y, 0.5 + currentPos.z);

        val startVel = Vec3d(0, 0.1, 0);
        val endVel = startVel;
        val color = 0xAC3100; // #ac3100ff

        val packet = PacketParticleSplineCurve(startPosVec, endPosVec, startVel, endVel, color);
        NetworkHandler.sendToAllAround(packet, world.dimension, pos.x, pos.y, pos.z, 64.0);
      }
    }
  }

  if (liquidBlocksFound > 0) {
    world.native.playSound(null, pos,
      native.com.lothrazar.cyclicmagic.registry.SoundRegistry.liquid_evaporate,
      SoundCategory.AMBIENT, 1.0f, 1.0f);
  }
}

//
// Vaporizer Trait
//
// Clears a sphere of all liquids.
// Triggered on hitting an entity or breaking a block.
//

val vaporizer = TraitBuilder.create('vaporizer');
vaporizer.color = 0x42A5F5; //42A5F5
vaporizer.localizedName = game.localize('e2ee.tconstruct.trait.vaporizer.name');
vaporizer.localizedDescription = game.localize('e2ee.tconstruct.trait.vaporizer.description');

vaporizer.afterHit = function (trait, tool, attacker, target, damageDealt, wasCritical, wasHit) {
  if (wasHit)
    clearLiquids(target.world, target.position);
};

vaporizer.afterBlockBreak = function (trait, tool, world, blockstate, blockPos, miner, wasEffective) {
  if (wasEffective)
    clearLiquids(world, blockPos);
};

vaporizer.register();
