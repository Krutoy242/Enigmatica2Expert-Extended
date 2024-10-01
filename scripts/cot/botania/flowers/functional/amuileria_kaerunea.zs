/*
Amuileria kaerunea (Aquilegia caerulea + Kaminari[thunder]) - crafting with lightning
*/

#loader contenttweaker

import crafttweaker.damage.IDamageSource;
import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.contenttweaker.Color;
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.BlockAdded;
import mods.randomtweaker.cote.ISubTileEntity;
import mods.randomtweaker.cote.ISubTileEntityFunctional;
import mods.randomtweaker.cote.SubTileEntityInGame;

static recipesLigthningFlower as IItemStack[string] = {
'item.appliedenergistics2.material.certus_quartz_crystal': <item:appliedenergistics2:material:1>,
'item.appliedenergistics2.material.purified_certus_quartz_crystal': <item:appliedenergistics2:material:1>,
'item.appliedenergistics2.material.certus_quartz_crystal_charged': <item:appliedenergistics2:material:1>,
} as IItemStack[string];

static manaCostPerLightning as int = 1000;

var amuileria_kaerunea = VanillaFactory.createSubTileFunctional("amuileria_kaerunea", 0xffff);
amuileria_kaerunea.maxMana = 5000;
amuileria_kaerunea.range = 1;
amuileria_kaerunea.onUpdate = function(subtile, world, pos) {
    if(!world.worldInfo.isThundering()) return;
    if(world.isRemote()) return;
    if(world.time%100 == 17) charge(world, pos, subtile); 
    return;
};
amuileria_kaerunea.register();

events.onEntityItemDeath(function (e as mods.zenutils.event.EntityItemDeathEvent) {
    val world = e.item.world;
    if (world.isRemote()) return;
    val damageSource = e.damageSource;
    if(isNull(damageSource)) return;
    if(damageSource.damageType != 'lightningBolt') return;
    val item = e.item;
    if(isNull(item)) return;
    //if(isNull(item.nbt.amuileria)) return;
    if(!(recipesLigthningFlower has item.item.name)) return;
    val newEntity = recipesLigthningFlower[item.item.name].withAmount(item.item.amount).createEntityItem(world, item.x as float, item.y as float, item.z as float);
    world.spawnEntity(newEntity);
    //newEntity.updateNBT({amuileria: 1});
    return;
});

function charge(world as IWorld, pos as IBlockPos, subtile as SubTileEntityInGame) as void{
    if(isNull(subtile.data.charge)) subtile.setCustomData({charge: 0});
    if(subtile.data.charge < 4){
        subtile.setCustomData({charge: (subtile.data.charge as int + 1)});
        return;
    }

    var makeThunder = false;
    if(subtile.getMana() < manaCostPerLightning) return;
    for item in world.getEntityItems(){
        if(isNull(item)
        || isNull(item.item)
        || Math.abs(item.x - pos.x - 0.5 ) > 2
        || Math.abs(item.y - pos.y ) > 1
        || Math.abs(item.z - pos.z - 0.5) > 2
        || !item.alive
        || !(recipesLigthningFlower has item.item.name)) continue;
        item.updateNBT({amuileria: 1});
        makeThunder = true;
        continue;
    }

    if(makeThunder) {
        server.commandManager.executeCommandSilent(server, '/summon minecraft:lightning_bolt '~pos.x~' '~pos.y~' '~pos.z );
        subtile.setCustomData({charge: 0});
    } else{
        server.commandManager.executeCommandSilent(server, "/particle magicCrit "~pos.x~" "~(1.2f + pos.y)~" "~pos.z~" .4 .4 .4 0 5");
    }
    return;
}

/* 
function registerThunderRecipe(item as IItemStack, result as IItemStack) as void{
    if(recipesLigthningFlower has item.definition.id){
        print("[ERROR] "~item.definition.id~" is already registered!");
        return;
    }
    recipesLigthningFlower[item.definition.id] = result;
    if(!(recipesLigthningFlower has result.definition.id)) recipesLigthningFlower[result.definition.id] = result;
    return;
}

val lightningRecipes = {
  <item:appliedenergistics2:material:2>: <item:appliedenergistics2:material:1>,
  <item:appliedenergistics2:material:0>: <item:appliedenergistics2:material:1>,
} as IItemStack[IItemStack];

for item, result in lightningRecipes {
  registerThunderRecipe(item, result);
} */
