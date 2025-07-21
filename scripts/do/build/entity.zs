/**
 * @file API for adding Golem-like mob spawning mechanics bu building structures
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

// Zenutils required to run late CoT function and use <cotBlock:> bracket handlers
#modloaded zenutils requious

// Need to be set between Utils and build_mob.add() users
#priority 950
#reloadable

import crafttweaker.block.IBlockState;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Position3f;
import crafttweaker.block.IBlock;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import native.net.minecraft.util.EnumParticleTypes;

import scripts.jei.entity_drop.getEntityDropTable;

zenClass MobBuild {
  // Static data
  var entity  as IEntityDefinition;
  var volume  as string[][];
  var map     as IItemStack[string];
  var shiftX  as float = 0.0f;
  var shiftY  as float =-0.5f;
  var shiftZ  as float = 0.0f;
  var spawnFnc as function(IWorld,Position3f)void;
  var isMirrored as bool = false;

  // Computed fields
  var core  as IItemStack;
  var coreX as int = 0;
  var coreY as int = 0;
  var coreZ as int = 0;
  var center as Position3f;

  zenConstructor() { }

  // ----------------------------------------------------------
  // Public functions
  // ----------------------------------------------------------
  // Make model mirrored to all sides
  function mirrored() as MobBuild {
    isMirrored = true;
    return this;
  }

  // When entity spawning, move it this distance
  function shift(x as float, y as float, z as float) as MobBuild {
    shiftX = x;
    shiftY = y;
    shiftZ = z;
    return this;
  }
  // ----------------------------------------------------------

  function getCore() as IItemStack {
    if (!isNull(core)) return core;

    for y, yLayer in volume {
      if (!isNull(core)) break;

      for x, zLine in yLayer {
        if (!isNull(core)) break;

        for z in 0 .. zLine.length() {
          val c = zLine[z];
          if (c == ' ') continue;
          val block = map[c];
          if (isNull(block)) {
            logger.logWarning('Wrong item map for char "' ~ c ~ '" in MobBuild ' ~ entity.name);
            continue;
          }
          if (c != 'x') continue;
          core = block;
          coreX = x;
          coreY = volume.length - 1 - y;
          coreZ = z;
          break;
        }
      }
    }

    if (isNull(core)) {
      logger.logWarning('Cannot find core (letter "x") for MobBuild ' ~ entity.name);
    }
    return core;
  }

  function iterVolume(pos as IBlockPos, face as int, func as function(IItemStack,IBlockPos)bool) as bool {
    for y, yLayer in volume {
      for x, zLine in yLayer {
        for z in 0 .. zLine.length() {
          val c = zLine[z];
          if (c == ' ') continue;
          val r = rotate(face, x - coreX, z - coreZ);
          val p = IBlockPos.create(
            pos.x + r[0],
            pos.y + volume.length - 1 - coreY - y,
            pos.z + r[1]
          );
          val isBlockMatch = func(map[c], p);
          if (isBlockMatch) continue;
          return false;
        }
      }
    }
    return true;
  }

  function make(world as IWorld, pos as IBlockPos) as bool {
    val offset = getCenter();
    for face in 0 .. (isMirrored ? 1 : 4) {
      // Check if we have all blocks on place
      if (!iterVolume(pos, face, function (need as IItemStack, p as IBlockPos) as bool {
        val state = world.getBlockState(p);
        if (isNull(state)) return false;
        val id = state.block.definition.id;

        // Exception for block that for some reason causing crash
        if (id == 'buildinggadgets:effectblock') return false;

        val haveItem = state.block.getItem(world, p, state);
        return need has haveItem;
      })) continue;

      // Break blocks and spawn entity
      iterVolume(pos, face, function (need as IItemStack, p as IBlockPos) as bool {
        world.destroyBlock(p, false);
        (world.native as native.net.minecraft.world.WorldServer)
          .spawnParticle(EnumParticleTypes.SNOWBALL, 0.5 + p.x, 0.5 + p.y, 0.5 + p.z, 10, 0.5, 0.5, 0.5, 0.0, 0);
        return true;
      });

      val r = rotate(face, offset.x, offset.z);
      val truePos = Position3f.create(r[0] + pos.x + shiftX, offset.y + pos.y + shiftY, r[1] + pos.z + shiftZ);

      if ((world.getWorldInfo().difficulty == "PEACEFUL") && (utils.isHostile(world, entity.id))) {
        // Peaceful handling of hostile mobs
        for item in getEntityDropTable(entity) {
          val remainder = item.amount % 100;
          var spawnAmount = item.amount;
          if (remainder != 0) { spawnAmount -= remainder >= world.random.nextInt(100) ? remainder - 100 : remainder; }
          spawnAmount /= 100;
          if spawnAmount == 0 continue;
          val entItem = (item * spawnAmount).createEntityItem(world, truePos.x, truePos.y, truePos.z);
          world.spawnEntity(entItem);
        }
      } else {
        // Peaceful non-hostile and non-peaceful handling
        utils.spawnGenericCreature(world, entity.id, truePos.x, truePos.y, truePos.z - 0.1, face);
      }

      spawnFnc(world, truePos);

      return true;
    }
    return false;
  }

  function getCenter() as Position3f {
    if (isNull(center)) center = Position3f.create(
      0.5f * volume[0].length - coreX,
      0.5f * volume.length - 1 - coreY,
      0.5f * volume[0][0].length() - coreZ
    );

    return center;
  }

  function rotate(face as int, x as float, z as float) as float[] {
    return [
      face == 0 ? x : face == 1 ? -z : face == 2 ? -x : z,
      face == 0 ? z : face == 1 ? x : face == 2 ? -z : -x,
    ];
  }
}

static builds as MobBuild[] = [] as MobBuild[];

function add(entity as IEntityDefinition, volume as string[][], map as IItemStack[string], spawnFnc as function(IWorld,Position3f)void = null) as MobBuild {
  val m =  MobBuild();

  if (isNull(entity)) return m;

  m.entity = entity;
  m.volume = volume;
  m.map = map;
  m.spawnFnc = spawnFnc;
  builds += m;

  if (utils.DEBUG) {
    var s = '';
    s ~= '\n"input-types": {\n';
    var k = 0;
    for c, item in map {
      if (isNull(item)) continue;
      val block = item.asBlock();
      s ~= (k == 0 ? '' : ',\n') ~ '  "' ~ c ~ '": { "id": "' ~ block.definition.id ~ '", "ignore-meta": true }';
      k += 1;
    }
    s ~= '\n},\n"shape": [';
    for i, plane in volume {
      s ~= (i == 0 ? '' : '\n  ],') ~ '\n  [\n';
      for j, line in plane {
        val l = line.replaceAll(' ', '_').replaceAll('.', '"$0", ');
        s ~= (j == 0 ? '' : ',\n') ~ '    [' ~ l.substring(0, l.length() - 2) ~ ']';
      }
    }
    s ~= '\n  ]\n]';

    var fileName = getFreeFileName(entity.id.replaceAll(':', '_'));
    utils.log('Save this into file "config/compactmachines3/recipes/' ~ fileName ~ '.json"'
    ~ '\n{'
    ~ '\n  "name": "compactmachines3:' ~ fileName ~ '",'
    ~ '\n'
    ~ '\n  "target-item": "minecraft:spawn_egg",'
    ~ '\n  "target-nbt": "{EntityTag:{id:\\"' ~ entity.id ~ '\\"}}",'
    ~ '\n'
    ~ '\n  "catalyst": "engineersdecor:sign_caution",'
    ~ '\n  "catalyst-nbt": "{display:{LocName:\\"tooltips.lang.not_compact_recipe\\"}}",'
    ~ '\n'
    ~ s.replaceAll('\n(.)', '\n  $1')
    ~ '\n}\n'
    );
  }

  return m;
}

static existingFileNames as bool[string] = {} as bool[string];
function getFreeFileName(fileName as string) as string {
  var i = 0;
  var newName = fileName;
  while true {
    if (!(existingFileNames has newName)) {
      existingFileNames[newName] = true;
      return newName;
    }
    newName = fileName ~ '_' ~ i;
    i += 1;
  }
}

function build(world as IWorld, pos as IBlockPos, state as IBlockState) as void {
  for index, build in builds {
    if (!(state.block has build.getCore())) continue;

    if (build.make(world, pos)) return;
  }
}
