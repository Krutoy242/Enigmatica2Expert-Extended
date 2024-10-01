/*
Echinacenko (Echinacea + kenko[health]) - provides nutritions to player
*/
#loader contenttweaker

import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import crafttweaker.util.Math;
import crafttweaker.player.IPlayer;
import mods.randomtweaker.cote.SubTileEntityInGame;
import mods.contenttweaker.VanillaFactory;
import crafttweaker.data.IData;
import mods.randomtweaker.cote.ISubTileEntity;
import mods.randomtweaker.cote.BlockAdded;
import mods.randomtweaker.cote.ISubTileEntityFunctional;
import mods.contenttweaker.Color;

static manaCost as int = 100;
static nutritionGain as float = 1.0f;

var echinacenko = VanillaFactory.createSubTileFunctional("echinacenko", 0xff00ff);
echinacenko.maxMana = 1000;
echinacenko.range = 4;
echinacenko.onUpdate = function(subtile, world, pos) {
    if(world.isRemote()
    || world.time%100!=13) return;

    findPlayerAndNutrish(world, pos, subtile);
    return;
};
echinacenko.register();

function findPlayerAndNutrish(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void{
    for player in world.getAllPlayers() {
        if(isNull(player)
        || Math.abs(player.x - pos.x - 0.5) > 4
        || Math.abs(player.y - pos.y) > 4
        || Math.abs(player.z - pos.z - 0.5) > 4 ) continue;
        if(subtile.getMana() < manaCost) return;
        val data = player.nbt.ForgeCaps.memberGet('nutrition:nutrition');
        if(isPlayerMissingNutrient(data, player)) addNutritientToPlayer(data, player, subtile);
    }
}

function isPlayerMissingNutrient(data as IData, player as IPlayer) as bool{
    if(isNull(data) || isNull(data.fruit)) return false;
    return (data.fruit as float < 99.9f||data.protein as float < 99.9f||data.grain as float < 99.9f||data.vegetable as float < 99.9f||data.dairy as float < 99.9f);
}

function addNutritientToPlayer(data as IData, player as IPlayer, subtile as SubTileEntityInGame) as void{
    subtile.consumeMana(manaCost);
    player.updateNBT({ 'ForgeCaps':
        {'nutrition:nutrition':{
         'fruit': Math.min(100.0f, nutritionGain + data.fruit) ,
         'protein': Math.min(100.0f, nutritionGain + data.protein),
         'grain': Math.min(100.0f, nutritionGain + data.grain),
         'vegetable': Math.min(100.0f, nutritionGain + data.vegetable),
         'dairy': Math.min(100.0f, nutritionGain + data.dairy),
      }
    }});
    player.sendPlaySoundPacket("botania:goldenlaurel", "ambient", player.position, 0.05f, 1.0f);
    server.commandManager.executeCommandSilent(server, "/particle happyVillager "~player.x~" "~(1.2f + player.y)~" "~player.z~" "~".5 .5 .5 0 5");
}
