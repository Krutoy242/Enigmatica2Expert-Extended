/*
Echinacenko (Echinacea + kenko[health]) - provides nutritions to player
*/

#modloaded botania
#loader contenttweaker

import crafttweaker.data.IData;
import crafttweaker.player.IPlayer;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.SubTileEntityInGame;
import native.net.minecraft.util.EnumParticleTypes;
import native.net.minecraft.world.WorldServer;

static manaCost as int = 100;
static nutritionGain as float = 1.0f;

val echinacenko = VanillaFactory.createSubTileFunctional('echinacenko', 0xFF00FF);
echinacenko.maxMana = 1000;
echinacenko.range = 4;
echinacenko.onUpdate = function (subtile, world, pos) {
  if (world.remote
    || world.worldInfo.worldTotalTime % 100 != 13) {
    return;
  }

  findPlayerAndNutrish(world, pos, subtile);
};
echinacenko.register();

function findPlayerAndNutrish(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void {
  for player in world.getAllPlayers() {
    if (isNull(player)
      || Math.abs(player.x - pos.x - 0.5) > 4
      || Math.abs(player.y - pos.y) > 4
      || Math.abs(player.z - pos.z - 0.5) > 4) {
      continue;
    }
    if (subtile.getMana() < manaCost) return;
    val data = player.nbt.ForgeCaps.memberGet('nutrition:nutrition');
    if (isPlayerMissingNutrient(data, player)) addNutritientToPlayer(data, player, subtile);
  }
}

function isPlayerMissingNutrient(data as IData, player as IPlayer) as bool {
  if (isNull(data) || isNull(data.fruit)) return false;
  return (99.9f > data.fruit || 99.9f > data.protein || 99.9f > data.grain || 99.9f > data.vegetable || 99.9f > data.dairy);
}

function addNutritientToPlayer(data as IData, player as IPlayer, subtile as SubTileEntityInGame) as void {
  subtile.consumeMana(manaCost);
  player.updateNBT({ 'ForgeCaps':
        {'nutrition:nutrition': {
          'fruit'    : Math.min(100.0f, nutritionGain + data.fruit) ,
          'protein'  : Math.min(100.0f, nutritionGain + data.protein),
          'grain'    : Math.min(100.0f, nutritionGain + data.grain),
          'vegetable': Math.min(100.0f, nutritionGain + data.vegetable),
          'dairy'    : Math.min(100.0f, nutritionGain + data.dairy),
        },
        }});
  player.sendPlaySoundPacket('botania:goldenlaurel', 'ambient', player.position, 0.05f, 1.0f);
  (player.world.native as WorldServer).spawnParticle(EnumParticleTypes.VILLAGER_HAPPY , player.x, 1.2f + player.y, 0.5f + player.z, 5, 0.5, 0.5, 0.5, 0, 0);
}
