/**
 * @file Tweaking of FX if special mods are installed
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#modloaded zenutils draconicevolution
#priority -3
#reloadable
#sideonly client

import crafttweaker.world.IVector3d;
import crafttweaker.world.IWorld;

static DE_PARTICLE_TYPES as int[string] = {
  'energyParticle' : 0, // RGB, alpha
  // "energyCore"  : 1,
  'infuser'        : 2,
  'lineIndicator'  : 3, // a(Age), RGB
  'chaosProjectile': 4, // RGB
  'chaosImplosion' : 5, // implosionType
  'portal'         : 6,
  'dragonHeart'    : 7, // RGB, expired
  'axeSelection'   : 8,
  'soulExtraction' : 9, // Size, RGB
  'arrowShockWave' : 10, // Size
  'custom'         : 11, // RGB, alpha, r, a, textureIndex, collideWithBlock(default: false)
};
static IMPLOSIONTYPES as int[string] = {
  'tracer'         : 0, 'orginExpand'    : 1, 'orginContract'  : 2,
  'expandingWave'  : 3, 'contractingWave': 4, 'final'          : 5,
};

// Rewriting function like this will allow this script not erroring if
// randomtweaker or draconicevolution not installed in modpack
scripts.do.portal_spread.fx.FX.particles = function (world as IWorld, x as double, y as double, z as double, vel as IVector3d, amount as int) as void {
  mods.randomtweaker.draconicevolution.IDraconicEvolutionFXHelper.spawnFX(
    DE_PARTICLE_TYPES.soulExtraction as int
    , crafttweaker.world.IVector3d.create(x, y, z)
    , vel
    , amount, 204, 100, 204
  );
};
