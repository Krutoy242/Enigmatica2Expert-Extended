#modloaded randomtweaker ctintegration crafttweakerutils thaumadditions
#priority -1

import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityLiving;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.entity.IEntityItem;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.item.WeightedItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.block.IBlock;
import crafttweaker.block.IBlockState;
import crafttweaker.world.IBlockAccess;
import crafttweaker.util.Math;
import crafttweaker.world.IFacing;
import crafttweaker.entity.IEntityEquipmentSlot;
import crafttweaker.entity.IEntityXp;
import mods.ctutils.entity.Experience;
import crafttweaker.entity.IEntityArrow;
import crafttweaker.entity.IEntityAnimal;
import crafttweaker.damage.IDamageSource;
import crafttweaker.world.IRayTraceResult;
import crafttweaker.entity.AttributeModifier;
import mods.randomtweaker.botania.IManaItemHandler;
import crafttweaker.liquid.ILiquidDefinition;
import crafttweaker.entity.IEntityThrowable;
import crafttweaker.text.ITextComponent;

/*
"aer"           : C Tornado, pulls nearby enemies (motion)
"alienis"       : E Random teleport
"alkimia"       : E Random potion
"amogus"        : P Scythe walking trace
"aqua"          : S Floowing water
"auram"         : E Gives vis to aura
"aversio"       : E Doubles scythe dmg
"bestia"        : S Spawns webs and mind spider
"caeles"        : O Gives 1000 astral exp
"cognitio"      : O Gives random amount of exp
"desiderium"    : E Disarm entity
"draco"         : E Ender dragon FIRE Ball
"exanimis"      : E Poison effect
"exitium"       : O Boom
"fabrico"       : O Pills recipe
"fluctus"       : C Wave knockback
"gelum"         : E Frost
"herba"         : E Potato drip (Yeah, it's useless i'll add something to it later)
"humanus"       : E Instant zombie villager cure
"ignis"         : E Sets on fire
"imperium"      : E Stuns entity (only works on endermans - prevent teleportation)
"infernum"      : E Vulnerable to fire and fire trace
"instrumentum"  : O Repair player armor and offhand
"lux"           : O Place spectrall illuminator
"machina"       : O Buff golem
"mana"          : P Star projectile
"metallum"      : S Iron cage
"mortuus"       : E Wither effect
"motus"         : O Swap positions
"mythus"        : E Petrifies entity
"ordo"          : O Removes player warp (exept PERM)
"perditio"      : O Gives player warp (exept PERM)
"permutatio"    : O Deflects enemy projectiles
"potentia"      : E Lighting bolt
"praecantatio"  : E Add bonus damage based on player knowledge
"praemunio"     : E Scythe damage ignores armor
"rattus"        : E Nearby entity fight each other
"sanguis"       : E Life steal
"sensus"        : P Scythe seek for other target after hit
"sonus"         : P Scythe split and attack other targets
"spiritus"      : E Haunted potion effect, entity gets random motion effects
"tenebrae"      : E Blinds target
"terra"         : S Creates quicksand under target if it is dirt/grass/sand
"vacuos"        : C Void hole, Pulls nearby enemies (tp)
"ventus"        : C Launches target
"vinculum"      : E Traps entity in place
"visum"         : E Gives glowing to nearby entities
"victus"        : O Breed animals
"volatus"       : E Levitation effect
"vitium"        : E Bonus damage (x5 mult) if there is flux in chunk
"vitreus"       : O Crystallize entity if have bellow hp below scythe damage

Additional types legend:
C - controll type
E - effect type
O - other
P - projectile type
S - spawn type(creates blocks/entities)
*/


function entityEyeHeight(entity as IEntity) as double{
    return entity.y+entity.eyeHeight;
}

function playSound(str as string, target as IEntity) as void{
    val list = target.world.getAllPlayers();
    for player in list {
        if(isNull(player)
        || player.world.dimension!=target.world.dimension
        || player.getDistanceSqToEntity(target)>50) continue;
        player.sendPlaySoundPacket(str, "ambient", target.position, 1.0f, 1.0f);
    }
}

function aerTornado(scythe as IEntity, lvl as int) as void{
    val list = scythe.world.getEntities();

    for entity in list {
        if(isNull(entity)
        || !entity instanceof IEntityLiving
        || !entity.isAlive()
        || scythe.getDistanceSqToEntity(entity)>20+3*lvl
        || entity.y<1) continue;

        val v = [scythe.x-entity.x, scythe.y-entity.y, scythe.z-entity.z] as double[];
        val norm = Math.sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]);
            
        entity.motionX=v[0]/norm;
        entity.motionY=v[1]/norm+1;
        entity.motionZ=v[2]/norm;
    }

    for i in 0 to 200 + lvl*50{
        val xp = scythe.x+(Math.cos(3.14*i/8)*0.03*i);
        val yp = scythe.y+1.0f*i/12;
        val zp = scythe.z+(Math.sin(3.14*i/8)*0.03*i); //smoke
        server.commandManager.executeCommandSilent(server, "/particle spell "~xp~" "~yp~" "~zp~" 0 0 0 0 1");
    }

    playSound("botania:airrod", scythe);

    scythe.setDead();
}

function alienisTeleport(target as IEntityLivingBase) as void{
    target.addPotionEffect(<potion:potioncore:teleport>.makePotionEffect(1, 0));
    server.commandManager.executeCommandSilent(server, "/particle witchMagic "~target.x~" "~target.y~" "~target.z~" .2 1 .2 0 25");
}

function alkimiaPotion(target as IEntityLivingBase, lvl as int) as void{
    target.addPotionEffect(<potion:potioncore:curse>.makePotionEffect(1 + (lvl/2), 0));
}

function amogusVent(scythe as IEntity, target as IEntityLivingBase) as void{
    target.addPotionEffect(<potion:contenttweaker:hatred>.makePotionEffect(200, 1));
    playSound("botania:way",target);
    scythe.setDead();
}

function aquaSplash(target as IEntityLivingBase, lvl as int) as void{
    val water = <liquid:water>.definition.block.definition.getStateFromMeta(1);
    val x = target.getX()>0 ? ((target.getX() as int) - 0.5f) : ((target.getX() as int) - 1.5f);
    val y = target.getY() as float;
    val z = target.getZ()>0 ? ((target.getZ() as int) - 0.5f) : ((target.getZ() as int) - 1.5f);
    for a in 0 to 2*lvl + 1 {
        for b in 0 to 2{
            for c in 0 to 2*lvl + 1{
                val pos = crafttweaker.util.Position3f.create(x - lvl + a, y + b, z - lvl + c) as IBlockPos;
                val block as IBlock = target.world.getBlock(pos);
                if (!isNull(block)
                && block.definition.id=="minecraft:air") {target.world.setBlockState(water, pos);
                server.commandManager.executeCommandSilent(server, "/particle droplet "~target.x~" "~target.y~" "~target.z~" 1 1 1 .5 100");
                }
            }
        }
    }
    playSound("thaumcraft:bubble", target);
}

function auramVisAdd(scythe as IEntity, lvl as int) as void{
    scythe.world.addVis(scythe.position, 10.0f * lvl);
    val y = scythe.y + 3.0;
    server.commandManager.executeCommandSilent(server, "/particle endRod "~scythe.x~" "~y~" "~scythe.z~" 5 1 5 0 50");
    playSound("botania:blacklotus", scythe);
}

function bestiaHunt(scythe as IEntity, target as IEntityLivingBase) as void{
    if(target.definition.id=="thaumcraft:mindspider") {target.setDead(); return;}
    val web = <item:minecraft:web>.asBlock();
    val x = target.getX()>0 ? ((target.getX() as int) - 0.5f) : ((target.getX() as int) - 1.5f);
    val y = target.getY() as float;
    val z = target.getZ()>0 ? ((target.getZ() as int) - 0.5f) : ((target.getZ() as int) - 1.5f);
    val pos = crafttweaker.util.Position3f.create(x, y + 1, z) as IBlockPos;
    val block as IBlock = target.world.getBlock(pos);
    if (!isNull(block) 
    && block.definition.id=="minecraft:air") target.world.setBlockState(web.definition.defaultState, pos);

    server.commandManager.executeCommandSilent(server, "/particle cloud "~scythe.x~" "~y~" "~scythe.z~" 1 1 1 0 10");
    playSound("entity.spider.ambient", scythe);

    if(target.world.getRandom().nextBoolean()){
        val spider as IEntityLivingBase = <entity:thaumcraft:mindspider>.spawnEntity(target.world, crafttweaker.util.Position3f.create(x, y + 2, z) as IBlockPos);
        target.revengeTarget = spider;
    }
}

function caelesAstralExp(scythe as IEntity, lvl as int) as void{
    if(scythe.nbt.ownerName!=""){
        val player = scythe.world.getPlayerByName(scythe.nbt.ownerName);
        if(isNull(player)) return;
        mods.randomtweaker.astralsorcery.IPlayer.modifyPerkExp(player, 500*lvl);
    }
}

function cognitioExperienceBlessing(scythe as IEntity, target as IEntityLivingBase, lvl as int) as void{
    val exp as IEntityXp = <entity:minecraft:xp_orb>.spawnEntity(target.world, target.position);
    Experience.setXpValue(exp, target.world.getRandom().nextInt(100,1000*lvl));

    playSound("entity.player.levelup", target);
    server.commandManager.executeCommandSilent(server, "/particle totem "~target.x~" "~entityEyeHeight(target)~" "~target.z~" .5 .5 .5 .2 5");
}

function desideriumDisarm(target as IEntityLivingBase) as void{
    val y = entityEyeHeight(target);
    if(target.hasItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.feet())){
        var item = target.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.feet());
        if(!isNull(item)){
            server.commandManager.executeCommandSilent(server, "/particle totem "~target.x~" "~y~" "~target.z~" .5 .5 .5 .2 5");
            if(item.isDamageable) item = item.withDamage(target.world.random.nextInt(item.maxDamage));
            target.world.spawnEntity(item.createEntityItem(target.world, target.position));
            target.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.feet(),null);
        }
    }
    if(target.hasItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.legs())){
        var item = target.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.legs());
        if(!isNull(item)){
            server.commandManager.executeCommandSilent(server, "/particle totem "~target.x~" "~y~" "~target.z~" .5 .5 .5 .2 5");
            if(item.isDamageable) item = item.withDamage(target.world.random.nextInt(item.maxDamage));
            target.world.spawnEntity(item.createEntityItem(target.world, target.position));
            target.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.legs(),null);
        }
    }
    if(target.hasItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.chest())){
        var item = target.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.chest());
        if(!isNull(item)){
            server.commandManager.executeCommandSilent(server, "/particle totem "~target.x~" "~y~" "~target.z~" .5 .5 .5 .2 5");
            if(item.isDamageable) item = item.withDamage(target.world.random.nextInt(item.maxDamage));
            target.world.spawnEntity(item.createEntityItem(target.world, target.position));
            target.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.chest(),null);
        }
    }
    if(target.hasItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.head())){
        var item = target.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.head());
        if(!isNull(item)){
            server.commandManager.executeCommandSilent(server, "/particle totem "~target.x~" "~y~" "~target.z~" .5 .5 .5 .2 5");
            if(item.isDamageable) item = item.withDamage(target.world.random.nextInt(item.maxDamage));
            target.world.spawnEntity(item.createEntityItem(target.world, target.position));
            target.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.head(),null);
        }
    }
    val player = target.world.getClosestPlayerToEntity(target, 40, false);
    if(!isNull(player)) player.sendPlaySoundPacket('thaumcraft:zap', 'ambient', target.position, 1.0f, 1.0f);
}

function dracoBreath(target as IEntityLivingBase, lvl as int) as void{
    val cloud as IEntity = <entity:minecraft:area_effect_cloud>.spawnEntity(target.world, crafttweaker.util.Position3f.create(target.x, target.y, target.z));
    cloud.updateNBT({
   "Radius":2.5*lvl as float,
   "DurationOnUse":0,
   "Invulnerable":0 as byte,
   "Particle":"flame",
   "FallDistance":0.0 as float,
   "Age":0,
   "Duration":140
    });
    val ball as IEntity = <entity:iceandfire:dragonfirecharge>.spawnEntity(target.world, crafttweaker.util.Position3f.create(target.x, target.y+4, target.z));
    ball.hasNoGravity=true;
    ball.updateNBT({
   "Fire":20 as short,
   "power":[0.0,-0.01,0.0]
   });

    val listAllEntities = target.world.getEntities();

    playSound("iceandfire:firedragon_breath",target);

    for entity in listAllEntities {
        if(isNull(entity)
        || !entity instanceof IEntityLiving
        || !entity.isAlive()
        || cloud.getDistanceSqToEntity(entity)>2.5*lvl
        ) continue;
        val entityLiving as IEntityLivingBase = entity;
        entityLiving.addPotionEffect(<potion:contenttweaker:dragonfire>.makePotionEffect(160, Math.min(lvl - 1,3)));
    }
}

function exanimisPoison(target as IEntityLivingBase, lvl as int) as void{
    target.addPotionEffect(<potion:minecraft:poison>.makePotionEffect(300*lvl, 3));
}

function exitiumExplosion(target as IEntityLivingBase, lvl as int) as void{
    target.addPotionEffect(<potion:potioncore:explode>.makePotionEffect(1, Math.min(lvl - 1,3)));
}

static Pills as IItemStack[string] = {
  'listAllmeatraw'  : <contenttweaker:protein_pill>,
  'listAllfruit'    : <contenttweaker:fruit_pill>,
  'listAllgrain'    : <contenttweaker:grain_pill>,
  'listAllveggie'   : <contenttweaker:vegetable_pill>,
  'foodCheese'      : <contenttweaker:dairy_pill>,
} as IItemStack[string];

function fabricoPill(scythe as IEntity) as void{
    val listAllEntities = scythe.world.getEntityItems();
    for entityItem in listAllEntities {
        
        if(!isNull(entityItem) 
        && scythe.getDistanceSqToEntity(entityItem)<4.0
        ){
            val item = entityItem.item;
            if(isNull(item) || isNull(item.ores)) return;

            for ore in item.ores{
                if(Pills has ore.name){
                    entityItem.world.spawnEntity((Pills[ore.name]*item.amount).createEntityItem(scythe.world, entityItem.position));
                    entityItem.setDead();

                    server.commandManager.executeCommandSilent(server, "/particle sweepAttack "~entityItem.x~" "~entityItem.y~" "~entityItem.z~" 0 0 0 0 1");
                    break;
                } else continue;
            }
        }
    }
    playSound("botania:agricarnation",scythe);
}

function fluctusWave(target as IEntityLivingBase, lvl as int) as void{
    val list = target.world.getEntities();

    for entity in list {
        if(isNull(entity)
        || !entity instanceof IEntityLiving
        || !entity.isAlive()
        || target.getDistanceSqToEntity(entity)>20 + lvl*3
        || target.id==entity.id
        || entity.y<1) continue;
        val v as double [] = [entity.x - target.x, 0.5, entity.z - target.z];
        val div = Math.sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2])/(2.0+0.1*lvl);
        entity.motionX = v[0]/div;
        entity.motionY = v[1]/div;
        entity.motionZ = v[2]/div;
    }
    for i in 0 to 4{
            val mult = pow(1.8,i)*Math.sqrt(lvl);
            for j in 0 to 20*i{
                val xp = target.x+mult*(Math.cos(3.14*j/10));
                val yp = target.y+1;
                val zp = target.z+mult*(Math.sin(3.14*j/10));
                server.commandManager.executeCommandSilent(server, "/particle spell "~xp~" "~yp~" "~zp~" 0 0 0 0 1");
            }
        }

        playSound("botania:airrod",target);
}

function gelumFrezze(target as IEntityLivingBase, lvl as int) as void{
    target.addPotionEffect(<potion:twilightforest:frosted>.makePotionEffect(300*lvl, 3));
    server.commandManager.executeCommandSilent(server, "/particle magicCrit "~target.x~" "~entityEyeHeight(target)~" "~target.z~" .5 .5 .5 .2 10");
    playSound("thaumcraft:ice",target);
}

function herbaTomatos(target as IEntityLivingBase) as void{
    target.addPotionEffect(<potion:rustic:shame>.makePotionEffect(600, 0));
}

function humanusCure(target as IEntityLivingBase, player as IPlayer) as void{
    target.addPotionEffect(<potion:minecraft:weakness>.makePotionEffect(600, 0));
    player.simulateRightClickEntity(target, <minecraft:golden_apple>, crafttweaker.entity.IEntityEquipmentSlot.mainHand());
    server.commandManager.executeCommandSilent(server, "/particle happyVillager "~target.x~" "~entityEyeHeight(target)~" "~target.z~" .5 .5 .5 .2 5");
    target.updateNBT({"ConversionTime":5});
}

function ignisFire(target as IEntityLivingBase, lvl as int) as void{
    target.addPotionEffect(<potion:immersiveengineering:flammable>.makePotionEffect(300*lvl, 3));
    target.setFire(10*lvl);
}

function imperiumStunnedEnderman(target as IEntityLivingBase) as void{
    target.addPotionEffect(<potion:immersiveengineering:stunned>.makePotionEffect(600, 0));
    server.commandManager.executeCommandSilent(server, "/particle fallingdust "~target.x~" "~entityEyeHeight(target)~" "~target.z~" .5 .5 .5 .2 20");
    playSound("entity.elder_guardian.curse",target);
}

function infernumFire(target as IEntityLivingBase, lvl as int) as void{
    target.addPotionEffect(<potion:immersiveengineering:flammable>.makePotionEffect(600*lvl, 3));
    target.addPotionEffect(<potion:rustic:blazing_trail>.makePotionEffect(300*lvl, 0));
}

function calcRepair(player as IPlayer, item as IItemStack, lvl as int) as void{
    if(item.isDamageable && item.isDamaged){
        item.mutable().withDamage(Math.max(0, ((0.95 - 0.01*lvl)*item.damage - 5 - lvl*2) as int));
        playSound("block.anvil.use",player);
    }
    return;
}

function instrumentumRepair(player as IPlayer, lvl as int) as void{
    if(!isNull(player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.head()))) calcRepair(player,player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.head()),lvl);
    if(!isNull(player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.chest()))) calcRepair(player,player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.chest()),lvl);
    if(!isNull(player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.legs()))) calcRepair(player,player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.legs()),lvl);
    if(!isNull(player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.feet()))) calcRepair(player,player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.feet()),lvl);
    if(!isNull(player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.offhand()))) calcRepair(player,player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.offhand()),lvl);
}

function luxLight(target as IEntityLivingBase, player as IPlayer) as void{
    player.simulateRightClickBlock(<randomthings:spectreilluminator>,
    crafttweaker.entity.IEntityEquipmentSlot.mainHand() ,
    crafttweaker.util.Position3f.create(target.x, target.y - 1, target.z) as IBlockPos,
    crafttweaker.world.IFacing.north(),0.5, 0.5, 0.5);
    server.commandManager.executeCommandSilent(server, "/particle endRod "~target.x~" "~entityEyeHeight(target)~" "~target.z~" 5 1 5 0 50");
    playSound("thaumcraft:wand", target);

}

function manaCreateStar(scythe as IEntity, target as IEntityLivingBase) as void {
    val r = 10.0;
    val pi = 3.14/3;
    for i in 0 to 10 {
        for j in 0 to 5{
            val x = (target.x + r*0.7*j*Math.cos(pi*i+pi*j/4));
            val y = (entityEyeHeight(target));
            val z = (target.z + r*0.7*j*Math.sin(pi*i+pi*j/4));

            val newPosition = crafttweaker.util.Position3f.create(x, y, z).asBlockPos();
            val copy = scythe.definition.spawnEntity(scythe.world, newPosition);
            
            val v as double [] = [target.x - x, 0.0, target.z - z];
            val div = Math.sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2])*1.5;
            copy.motionX = v[0]/div;
            copy.motionY = v[1]/div;
            copy.motionZ = v[2]/div;
        }
    }
    scythe.setDead();
}

function metallumPrison(target as IEntityLivingBase) as void{
    val ancientBar = <item:thaumicaugmentation:bars>.asBlock().definition.defaultState;
    val x = target.getX()>0 ? ((target.getX() as int) - 0.5f) : ((target.getX() as int) - 1.5f);
    val y = target.getY() as float;
    val z = target.getZ()>0 ? ((target.getZ() as int) - 0.5f) : ((target.getZ() as int) - 1.5f);
    for a in 0 to 6{
        for b in 0 to 6{
            for c in 0 to 6{
                if(a%5==0||b%5==0||c%5==0){
                    val pos = crafttweaker.util.Position3f.create(x - 2 + a, y - 1 + b, z - 2 + c) as IBlockPos;
                    val block as IBlock = target.world.getBlock(pos);
                    if (!isNull(block) 
                    && target.world.getBlockState(pos).isReplaceable(target.world, pos)) target.world.setBlockState(ancientBar, pos);
                }
            }
        }
    }
    playSound("block.anvil.place",target);
}

function mortuusWither(target as IEntityLivingBase, lvl as int) as void{
    target.addPotionEffect(<potion:minecraft:wither>.makePotionEffect(300*lvl, 3));
    playSound("rats:black_death_die",target);
}

function motusSwap(scythe as IEntity, target as IEntityLivingBase, player as IPlayer) as void{
    playSound("rats:potion_effect_begin",target);

    val pos = player.position;
    server.commandManager.executeCommandSilent(server, "/tp "~scythe.nbt.ownerName~" "~target.x~" "~target.y~" "~target.z~"");
    target.setPosition(pos);

    server.commandManager.executeCommandSilent(server, "/particle cloud "~target.x~" "~entityEyeHeight(target)~" "~target.z~" .5 .5 .5 .01 20");
    server.commandManager.executeCommandSilent(server, "/particle cloud "~player.x~" "~entityEyeHeight(player)~" "~player.z~" .5 .5 .5 .01 20");
}

function mythusPetrification(target as IEntityLivingBase) as void{
    target.updateNBT({"ForgeCaps":{
      "llibrary:extendedentitydatacapability":{
         "Ice And Fire - Stone Property Tracker":{
            "StoneBreakLvl":0,
            "TurnedToStone":1 as byte
         }
      }
   }});
   server.commandManager.executeCommandSilent(server, "/particle blockcrack "~target.x~" "~entityEyeHeight(target)~" "~target.z~" .2 .2 .2 .1 25 force @a 0001");
   playSound("botania:divacharm", target);
}

function ordoWarp(player as IPlayer, lvl as int) as void{
    if(player.world.random.nextInt(10)<lvl && player.warpTemporary!=0){
        player.warpTemporary = player.warpTemporary - 1;
        player.sendPlaySoundPacket('thaumcraft:craftstart', 'voice', player.position, 1.0f, 1.0f);
    } 
    if(player.world.random.nextInt(100)<lvl && player.warpNormal!=0){
        player.warpNormal = player.warpNormal - 1;
        player.sendPlaySoundPacket('thaumcraft:craftstart', 'voice', player.position, 1.0f, 1.0f);
    } 
}

function perditioWarp(player as IPlayer, lvl as int) as void{
    if(player.world.random.nextInt(10)<lvl) {
        player.warpTemporary = Math.min(500,player.warpTemporary + 1);
        player.sendPlaySoundPacket('thaumcraft:wispers', 'voice', player.position, 1.0f, 1.0f);
    }
    if(player.world.random.nextInt(100)<lvl) {
        player.warpNormal = Math.min(500,player.warpNormal + 1);
        player.sendPlaySoundPacket('thaumcraft:whispers', 'voice', player.position, 1.0f, 1.0f);
    }
}

function potentiaLightning(target as IEntityLivingBase, lvl as int) as void{
    target.addPotionEffect(<potion:potioncore:lightning>.makePotionEffect(lvl, 0));
}

function praecantatioBonusDamage(target as IEntityLivingBase, player as IPlayer) as double{
    var bonus = 0.0;

    if(isNull(player)
    || isNull(player.nbt)
    || isNull(player.nbt.ForgeCaps)
    || isNull(player.nbt.ForgeCaps.memberGet("thaumcraft:knowledge"))
    || isNull(player.nbt.ForgeCaps.memberGet("thaumcraft:knowledge").knowledge)) return bonus;

    val playerData = player.nbt.ForgeCaps.memberGet("thaumcraft:knowledge").knowledge;
    if (playerData.length==0) return 0.0;
    for i in 0 to playerData.length{
        bonus+=playerData[i].amount;
    }
    server.commandManager.executeCommandSilent(server, "/particle crit "~target.x~" "~entityEyeHeight(target)~" "~target.z~" .2 .2 .2 .1 5");
    return Math.sqrt(bonus);
}

function rattusInsanity(target as IEntityLivingBase) as void{
    var list as IEntityLivingBase[] = [target];
    val listAllEntities = target.world.getEntities();

    for entity in listAllEntities {
        if(isNull(entity)
        || !entity instanceof IEntityLiving
        || !entity.isAlive()
        || target.id==entity.id
        || target.getDistanceSqToEntity(entity)>20
        || target.isBoss
        || entity.y<1) continue;
        
        val entityAdd as IEntityLivingBase = entity;
        server.commandManager.executeCommandSilent(server, "/particle angryVillager "~entity.x~" "~entityEyeHeight(entity)~" "~entity.z~" 0 0 0 0 1");
        list += entityAdd;

    }

    val l = list.length - 1;
    for i in 0 to l {
        if(i%2!=list.length%2) continue;
        list[i].revengeTarget = list[i+1];
        list[i+1].revengeTarget = list[i];
    }

    playSound("rats:ratlantean_spirit_die",target);
}

function sanguisBonusDamage(target as IEntityLivingBase, player as IPlayer, dmg as double) as double{
    player.health=Math.max(player.health + (dmg+50.0)/10.0, player.maxHealth);
    playSound("rats:potion_effect_end",player);
    server.commandManager.executeCommandSilent(server, "/particle damageIndicator "~target.x~" "~entityEyeHeight(target)~" "~target.z~" .2 .2 .2 .1 5");
    return 50.0;
}

function sensusTarget(scythe as IEntity, target as IEntityLivingBase) as void{
    playSound("botania:manablaster",target);
        val entitiesList = target.world.getEntities();
        val length = entitiesList.length - 1;
        for i in 0 to (entitiesList.length){
            val entity = entitiesList[length-i];
            if(isNull(entity)
            || !entity instanceof IEntityLiving
            || !entity.isAlive()
            || entity.id==target.id
            || target.getDistanceSqToEntity(entity)>20) continue;

            val v = [entity.x-scythe.x, entityEyeHeight(entity)-scythe.y, entity.z-scythe.z] as double[];
            val norm = Math.sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2])/3.0;
            scythe.motionX = v[0]/norm;
            scythe.motionY = v[1]/norm;
            scythe.motionZ = v[2]/norm;
            return;
        }

}

function sonusSplit(scythe as IEntity, target as IEntityLivingBase, lvl as int) as void{
    val entitiesList = target.world.getEntities();

    for entity in entitiesList{
        if(isNull(entity)
        || !entity instanceof IEntityLiving
        || target.getDistanceSqToEntity(entity)>20+lvl*5) continue;

        val scytheCopy = scythe.definition.spawnEntity(target.world, crafttweaker.util.Position3f.create(target.x, entityEyeHeight(target), target.z).asBlockPos());
        val v = [entity.x-target.x, entityEyeHeight(entity)-entityEyeHeight(target), entity.z-target.z] as double[];
        val norm = Math.sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2])/3.0;
        scytheCopy.motionX = v[0]/norm;
        scytheCopy.motionY = v[1]/norm;
        scytheCopy.motionZ = v[2]/norm;
    }

    scythe.setDead();
}

function spiritusHaunted(target as IEntityLivingBase, lvl as int) as void{
    target.addPotionEffect(<potion:contenttweaker:exorcism>.makePotionEffect(100*lvl, Math.min(lvl - 1, 3)));
    playSound("entity.ghast.hurt",target);
}

function tenebraeBlind(target as IEntityLivingBase, lvl as int) as void{
    target.addPotionEffect(<potion:minecraft:blindness>.makePotionEffect(300*lvl, 3));
    server.commandManager.executeCommandSilent(server, "/particle fallingdust "~target.x~" "~entityEyeHeight(target)~" "~target.z~" .5 .5 .5 .1 20");
}

static terraBlocksList as string[] = [
    "minecraft:dirt",
    "biomesoplenty:dirt",
    "chisel:dirt",
    "minecraft:grass",
    "biomesoplenty:grass",
    "minecraft:sand",
    "biomesoplenty:white_sand"
];

function terraQuickSand(target as IEntityLivingBase, lvl as int) as void{
    val quickSand = <liquid:sand>.definition.block.definition.defaultState.withProperty("level", 0);
    val x = target.getX()>0 ? ((target.getX() as int) - 0.5f) : ((target.getX() as int) - 1.5f);
    val y = target.getY() as float;
    val z = target.getZ()>0 ? ((target.getZ() as int) - 0.5f) : ((target.getZ() as int) - 1.5f);
    if(target.y<2) return;
    for a in 0 to 2*lvl + 9{
        for c in 0 to 2*lvl + 9{
            val pos = crafttweaker.util.Position3f.create(x - lvl - 4 + a, y - 1, z - lvl - 4 + c) as IBlockPos;
            val block as IBlock = target.world.getBlock(pos);
            if (!isNull(block) 
            && terraBlocksList has block.definition.id) {
                target.world.setBlockState(quickSand, pos);
                server.commandManager.executeCommandSilent(server, "/particle droplet "~(x - 4 + a)~" "~(y)~" "~(z - 4 + c)~" .2 .2 .2 .1 5");
            }
        }
    }
    playSound("thaumcraft:bubble", target);
}

function vacuosHole(scythe as IEntity, target as IEntity, lvl as int){
    val list = target.world.getEntities();

    for entity in list {
            if(isNull(entity)
            || !entity instanceof IEntityLiving
            || !entity.isAlive()
            || target.getDistanceSqToEntity(entity)>20+3*lvl
            || entity.y<1) continue;

            entity.posX = target.x;
            entity.posY = target.y;
            entity.posZ = target.z;
        }

    for i in 0 to 20{
        for j in 0 to 10{
            val xp = target.x+2.0*Math.cos(3.14*i/10)*Math.cos(3.14*j/10)*(1+0.5*lvl);
            val yp = target.y+2.0*Math.cos(3.14*i/10)*Math.sin(3.14*j/10)*(1+0.5*lvl);
            val zp = target.z+2.0*Math.sin(3.14*i/10)*(1+0.5*lvl);
            server.commandManager.executeCommandSilent(server, "/particle smoke "~xp~" "~yp~" "~zp~" 0 0 0 0 1");
        }
    }

    playSound("rats:neoratlantean_summon",target);
    scythe.setDead();
}

function ventusLaunch(target as IEntityLivingBase) as void{
    target.addPotionEffect(<potion:potioncore:launch>.makePotionEffect(1, 0));
    playSound("botania:dash",target);
}

function vinculumTrap(target as IEntityLivingBase, lvl as int) as void{
    target.addPotionEffect(<potion:immersiveengineering:sticky>.makePotionEffect(100*lvl, 3));
    playSound("botania:gaiatrap",target);
}

function visumGlow(target as IEntityLivingBase, player as IPlayer) as void{
    val listAllEntities = target.world.getEntities();

    for entity in listAllEntities {
        if(isNull(entity)
        || !entity instanceof IEntityLiving
        || !entity.isAlive()
        || target.getDistanceSqToEntity(entity)>120
        || entity.y<1) continue;
        
        val entityLive as IEntityLivingBase = entity;
        entityLive.addPotionEffect(<potion:minecraft:glowing>.makePotionEffect(600, 0));
    }
    playSound("botania:goldenlaurel",player);
}

function volatusLevitation(target as IEntityLivingBase) as void{
    target.addPotionEffect(<potion:minecraft:levitation>.makePotionEffect(100, 1));
    server.commandManager.executeCommandSilent(server, "/particle cloud "~target.x~" "~entityEyeHeight(target)~" "~target.z~" .5 .5 .5 .1 20");
    playSound("thaumcraft:wind",target);
}

function victusBreeder(scythe as IEntity, target as IEntityLivingBase) as void{
    val player = scythe.world.getPlayerByName(scythe.nbt.ownerName);
    if(!target instanceof IEntityAnimal||isNull(player)) return;

    val listAllEntities = target.world.getEntities();

    for entity in listAllEntities {
        if(isNull(entity)
        || !entity instanceof IEntityAnimal
        || !entity.isAlive()
        || target.getDistanceSqToEntity(entity)>50
        || entity.y<1) continue;
        
        val animal as IEntityAnimal = entity;
        animal.resetInLove();
        animal.setInLove(player);
    }
}

function vitiumStrike(scythe as IEntity, target as IEntityLivingBase) as double{
    val world = target.world;
    if(world.getFlux(target.position)>1.0f){
        world.drainFlux(target.position, 1.0f);
        server.commandManager.executeCommandSilent(server, "/particle witchMagic "~target.x~" "~entityEyeHeight(target)~" "~target.z~" .5 .5 .5 .1 10");
        playSound("thaumcraft:shock",target);
        return 5.0;
    }
    return 1.0;
}

function vitreusCrystalize(scythe as IEntity, target as IEntityLivingBase, dmg as double) as void{
    if(target.health>dmg) return;

    val list as mods.randomtweaker.thaumcraft.IAspectList = mods.randomtweaker.thaumcraft.IEntity.getAspects(target);
    for i in 0 to list.getSize() {
        val name = list.get(i).name.toLowerCase();
        val item = <thaumcraft:crystal_essence>.withTag({Aspects: [{amount: 1, key: name}]})*list.getAmount(list.get(i));
        target.world.spawnEntity(item.createEntityItem(target.world, target.position));
    }
    server.commandManager.executeCommandSilent(server, "/particle explode "~target.x~" "~entityEyeHeight(target)~" "~target.z~" .5 .5 .5 .1 10");
    playSound("thaumcraft:crystal",target);
    target.setDead();
}

function scytheEffectElemental(scythe as IEntity, target as IEntityLivingBase, player as IPlayer, augments as string[], dmg as double, colorCount as int[] ) as void{
    #CREATION ASPECTS
    if(augments has "aqua")         aquaSplash(target, colorCount[2]);
    if(augments has "bestia")       bestiaHunt(scythe, target);
    if(augments has "metallum")     metallumPrison(target);
    if(augments has "terra")        terraQuickSand(target, colorCount[5]);
    #CONTROL ASPECTS
    if(augments has "fluctus")      fluctusWave(target, colorCount[1]);
    if(augments has "aer")          aerTornado(scythe, colorCount[4]);
    if(augments has "vacuos")       vacuosHole(scythe, target, colorCount[0]);    
    #EFFECT ASPECTS
    if(augments has "amogus")       amogusVent(scythe, target);
    if(augments has "auram")        auramVisAdd(scythe, colorCount[6]);
    if(augments has "caeles")       caelesAstralExp(scythe, colorCount[2]);
    if(augments has "cognitio")     cognitioExperienceBlessing(scythe, target, colorCount[4]);
    if(augments has "desiderium")   desideriumDisarm(target);
    if(augments has "draco")        dracoBreath(target, colorCount[2]);
    if(augments has "exanimis")     exanimisPoison(target, colorCount[5]);
    if(augments has "exitium")      exitiumExplosion(target, colorCount[1]);
    if(augments has "gelum")        gelumFrezze(target,colorCount[0]);
    if(augments has "herba")        herbaTomatos(target);
    if(augments has "ignis")        ignisFire(target, colorCount[3]);
    if(augments has "imperium")     imperiumStunnedEnderman(target);
    if(augments has "infernum")     infernumFire(target, colorCount[3]);
    if(augments has "instrumentum") instrumentumRepair(player, colorCount[2]);
    if(augments has "lux")          luxLight(target, player);
    if(augments has "mortuus")      mortuusWither(target, colorCount[3]);
    if(augments has "ordo")         ordoWarp(player, colorCount[1]);
    if(augments has "perditio")     perditioWarp(player, colorCount[0]);
    if(augments has "potentia")     potentiaLightning(target, colorCount[1]);
    if(augments has "rattus")       rattusInsanity(target);
    if(augments has "tenebrae")     tenebraeBlind(target, colorCount[0]);
    if(augments has "ventus")       ventusLaunch(target);
    if(augments has "vinculum")     vinculumTrap(target, colorCount[4]);
    if(augments has "visum")        visumGlow(target,player);
    if(augments has "volatus")      volatusLevitation(target);
    if(!target.isBoss){
    if(augments has "alienis")      alienisTeleport(target);
    if(augments has "alkimia")      alkimiaPotion(target, colorCount[2]);
    if(augments has "motus")        motusSwap(scythe, target, player);
    if(augments has "mythus")       mythusPetrification(target);
    if(augments has "spiritus")     spiritusHaunted(target, colorCount[1]);
    if(augments has "vitreus")      vitreusCrystalize(scythe, target, dmg);
    }

    #PROJECTILES
    if(augments has "sonus")        sonusSplit(scythe, target, colorCount[4]);
    if(augments has "mana")         {if(augments has "rattus") {scytheCreateChaos(scythe, target);} else {manaCreateStar(scythe, target);}}
    if(augments has "sensus")       sensusTarget(scythe, target);
}

function scytheCreateChaos(scythe as IEntity, target as IEntityLivingBase) as void {
    val r = 10.0;
    val pi = 3.14/3;
    for k in 0 to 2{
        for i in 0 to 6 {
            for j in 0 to 6{
                val x = (target.x + r*Math.cos(pi*i)*Math.cos(pi*j)*(k+1));         //sphere
                val y = (target.y + 2.0 + r*Math.cos(pi*i)*Math.sin(pi*j)*(k+1)/2);
                val z = (target.z + r*Math.sin(pi*i)*(k+1));

                val newPosition = crafttweaker.util.Position3f.create(x, y, z).asBlockPos();
                var scytheCopy = <entity:thaumadditions:mithminite_scythe>.spawnEntity(scythe.world, newPosition);
                scytheCopy.motionX = (target.x - x) / 12;
                scytheCopy.motionY = (entityEyeHeight(target) - y) / 12;
                scytheCopy.motionZ = (target.z - z) / 12;
            }
        }
    }
    scythe.setDead();
}

function getAugments(player as IPlayer) as string[]{
    var result as string[] = [];
    if(isNull(player)
    || isNull(player.mainHandHeldItem)
    || isNull(player.mainHandHeldItem.definition)
    || player.mainHandHeldItem.definition.id!="thaumadditions:mithminite_scythe") return result;
    val scythe = player.mainHandHeldItem;

    if(isNull(scythe.tag)
    || isNull(scythe.tag.display)
    || isNull(scythe.tag.display.Lore)) return result;

    val lore = scythe.tag.display.Lore;

    if(lore.length == 0) return result;

    if(scripts.mods.thaumadditions.haveLoremError(lore)) {
        player.sendRichTextStatusMessage(ITextComponent.fromString("§cYour scythe is too sus! Please check your augments!§r"));
        return result;
    }

    for i in 0 to lore.length {
        result += scripts.mods.thaumadditions.loreUnColor[lore[i]];
    }

    return result;
}

function getSetBonus(player as IPlayer) as int[]{
    if(isNull(player)
    || isNull(player.mainHandHeldItem)
    || isNull(player.mainHandHeldItem.definition)
    || player.mainHandHeldItem.definition.id!="thaumadditions:mithminite_scythe") return [0,0,0,0,0,0,0] as int[];
    val scythe = player.mainHandHeldItem;

    if(isNull(scythe.tag)
    || isNull(scythe.tag.display)
    || isNull(scythe.tag.display.Lore)) return [0,0,0,0,0,0,0] as int[];

    val lore = scythe.tag.display.Lore;
    // Black, White, Blue, Red, Yellow, Green, Pink
    if(lore.length==0) return [0,0,0,0,0,0,0] as int[];

    var a = 0;
    var b = 0;
    var c = 0;
    var d = 0;
    var e = 0;
    var f = 0;
    var g = 0;

    for i in 0 to lore.length {
        val k = lore[i][1];
        if(k == "0" || k == "8") {a+=1; continue;}
        if(k == "7" || k == "f") {b+=1; continue;}
        if(k == "1" || k == "3" || k == "9" || k == "b") {c+=1; continue;}
        if(k == "4" || k == "c") {d+=1; continue;}
        if(k == "6" || k == "e") {e+=1; continue;}
        if(k == "2" || k == "a") {f+=1; continue;}
        if(k == "5" || k == "d") {g+=1; continue;}
    }

    return [a,b,c,d,e,f,g] as int[];
}

events.onEntityJoinWorld(function (e as crafttweaker.event.EntityJoinWorldEvent) {
    val scythe = e.entity;

    if (isNull(scythe)
     || isNull(e.world)
     || e.world.remote
     || !scythe instanceof IEntityThrowable
     || scythe.definition.id!="thaumadditions:mithminite_scythe"
     || isNull(scythe.nbt) 
     || scythe.nbt.ownerName=="" //That's a clone of scythe
    ) return;
    #Primal scythe
    if(getAugments(e.world.getPlayerByName(scythe.nbt.ownerName)) has "fabrico") fabricoPill(scythe);

    scythe.motionX = scythe.motionX*10;
    scythe.motionY = scythe.motionY*10;
    scythe.motionZ = scythe.motionZ*10;
});

events.onProjectileImpactThrowable(function (e as crafttweaker.event.ProjectileImpactThrowableEvent) {
    val scythe = e.entity;
    val rayTrace = e.rayTrace;
    if (isNull(scythe)
    || isNull(scythe.world)
    || scythe.world.remote
    || isNull(rayTrace)
    || !rayTrace.isEntity
    || isNull(rayTrace.entity)
    || !(rayTrace.entity instanceof IEntityLiving)
    || isNull(rayTrace.entity.definition)
    ) return;

    #PERMUTATIO EFFECT
    if(e.rayTrace.entity instanceof IPlayer && scythe.definition.id!="thaumadditions:mithminite_scythe"
    ){
        val player as IPlayer = e.rayTrace.entity;
        if(getAugments(player) has "permutatio") {
            scythe.motionX = -scythe.motionX;
            scythe.motionY = -scythe.motionY;
            scythe.motionZ = -scythe.motionZ;
            e.cancel();
        }
    }

    if(rayTrace.entity instanceof IPlayer
    || scythe.definition.id!="thaumadditions:mithminite_scythe") return;

    val target as IEntityLivingBase = rayTrace.entity;
    val player = scythe.world.getPlayerByName(scythe.nbt.ownerName);
    val augments = getAugments(player);
    val colorCount = getSetBonus(player);

    #MACHINA EFFECT
    if(target.definition.id=="thaumcraft:golem" && augments has "machina"){
        target.setNBT({"ScalingHealth.IsBlight": 1});
        target.getAttribute("generic.attackDamage").setBaseValue(500.0 + 100.0 * colorCount[1]);
        target.getAttribute("generic.armor").setBaseValue(4.0);
        target.getAttribute("generic.armorToughness").setBaseValue(4.0);
        server.commandManager.executeCommandSilent(server, "/particle totem "~target.x~" "~target.y~" "~target.z~" .1 .1 .1 .2 10");
        playSound("thaumcraft:upgrade",target);
        scythe.setDead();
        e.cancel();
        return;
    }

    #VICTUS EFFECT
    if(target instanceof IEntityAnimal && augments has "victus"){
        victusBreeder(scythe, target);
        scythe.setDead();
        e.cancel();
        return;
    }

    #HUMANUS EFFECT
    if(target.definition.id=="minecraft:zombie_villager"
    && augments has "humanus"){
        humanusCure(target, player);
        scythe.setDead();
        e.cancel();
        return;
    }

    # AVERSIO | PRAECANTIATIO | PRAEMUNIO | VITIUM
    var dmg = 100.0;
    if(augments has "praecantatio") dmg += praecantatioBonusDamage(target,player)*(1.0+0.2 * colorCount[6]);
    if(augments has "sanguis") dmg += sanguisBonusDamage(target,player,dmg*colorCount[3]);
    if(augments has "vitium")  dmg *= vitiumStrike(scythe, target) * colorCount[6];
    if(augments has "aversio") dmg *= 2.0 + 0.2 * colorCount[3];

    target.attackEntityFrom(augments has "praemunio" ? 
    crafttweaker.damage.IDamageSource.createIndirectDamage("MITHMINITE_SCYTHE", player, scythe).setDamageBypassesArmor() :
    crafttweaker.damage.IDamageSource.createIndirectDamage("MITHMINITE_SCYTHE", player, scythe)
    , dmg);

    if(isNull(player)) return;
    scytheEffectElemental(scythe, target, player, augments, dmg, colorCount);

});

events.onProjectileImpactFireball(function (e as crafttweaker.event.ProjectileImpactFireballEvent){
    val projectile = e.entity;
    val rayTrace = e.rayTrace;

    if (
    isNull(projectile)
    || isNull(projectile.world)
    || projectile.world.remote
    || isNull(e.rayTrace)
    || !rayTrace.isEntity
    || isNull(rayTrace.entity)) return;

    if(e.rayTrace.entity instanceof IPlayer){
        val player as IPlayer = e.rayTrace.entity;
        if(!isNull(player.mainHandHeldItem) && player.mainHandHeldItem.name=="item.thaumadditions:mithminite_scythe"
        && getAugments(player) has "permutatio" 
        ){
            if(isNull(projectile.nbt) || isNull(projectile.nbt.ForgeData) || isNull(projectile.nbt.ForgeData.Return)){
                projectile.motionX = -projectile.motionX;
                projectile.motionY = -projectile.motionY;
                projectile.motionZ = -projectile.motionZ;
                e.accelerationX = -e.accelerationX;
                e.accelerationY = -e.accelerationY;
                e.accelerationZ = -e.accelerationZ;
                projectile.setNBT({Return: 0});
            }
            e.cancel();
        }
    }
});

events.onProjectileImpactArrow(function (e as crafttweaker.event.ProjectileImpactArrowEvent){
    val projectile = e.entity;
    val rayTrace = e.rayTrace;

    if (
    isNull(projectile)
    || isNull(projectile.world)
    || projectile.world.remote
    || isNull(e.rayTrace)
    || !rayTrace.isEntity
    || isNull(rayTrace.entity)) return;

    if(e.rayTrace.entity instanceof IPlayer){
        val player as IPlayer = e.rayTrace.entity;
        if(!isNull(player.mainHandHeldItem) && player.mainHandHeldItem.name=="item.thaumadditions:mithminite_scythe"
        && getAugments(player) has "permutatio" 
        ){
            if(isNull(projectile.nbt) || isNull(projectile.nbt.ForgeData) || isNull(projectile.nbt.ForgeData.Return)){
                projectile.motionX = -projectile.motionX;
                projectile.motionY = -projectile.motionY;
                projectile.motionZ = -projectile.motionZ;
                projectile.setNBT({Return: 0});
            }
            e.cancel();
        }
    }
});

