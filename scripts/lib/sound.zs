#priority 5
#loader contenttweaker

import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;

function play(str as string, pos as IBlockPos, world as IWorld) as void{
    val list = world.getAllPlayers();
    for player in list {
        if(isNull(player)
        || player.world.dimension!=world.dimension
        || Math.sqrt(pow(player.x - pos.x, 2) * pow(player.y - pos.y, 2) * pow(player.z - pos.z, 2))>50) continue;
        player.sendPlaySoundPacket(str, "ambient", pos, 0.05f, 1.0f);
    }
}
