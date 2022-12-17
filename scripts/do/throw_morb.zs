import crafttweaker.events.IEventManager;
import crafttweaker.event.ProjectileImpactThrowableEvent;
import crafttweaker.event.IEventCancelable;
import crafttweaker.event.IEntityEvent;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityItem;
import crafttweaker.block.IBlockState;
import crafttweaker.item.IItemStack;

#loader crafttweaker reloadableevents
   
events.onProjectileImpactThrowable(function(e as crafttweaker.event.ProjectileImpactThrowableEvent){
	
	if (isNull(e.thrower)||
	    !(e.thrower instanceof crafttweaker.player.IPlayer)||
	    isNull(e.rayTrace.entity)||
	    !(e.rayTrace.entity instanceof crafttweaker.entity.IEntityLivingBase)){return;}

	val player as IPlayer = e.thrower;
	if player.creative return;
	
	val projectile=e.entity;
	
	val item=projectile.definition.id==<entity:thermalexpansion:morb>.id && projectile.nbt.EntityData.length==0 ?
	    (projectile.nbt.Type==1 ? <thermalexpansion:morb:1> : <thermalexpansion:morb:0>)
	    : projectile.definition.id==<entity:cyclicmagic:magicnetempty>.id ? <cyclicmagic:magic_net>
	    : null;
	if isNull(item) return;
	
	val pokemon as crafttweaker.entity.IEntityLivingBase=e.rayTrace.entity;
	    
	if (pokemon.maxHealth==0||
	    isNull(pokemon.definition)||
	    isNull(pokemon.definition.name))return;
	    
	val hpPortion=pokemon.health/pokemon.maxHealth;
	if ( hpPortion > 0.3 && pokemon.health > 8){
	    
	    //TODO find correct localized displayName for entity, not pokemon.definition.name
	    val message = crafttweaker.text.ITextComponent.fromTranslation("e2ee.creature_resisted_morb",item.displayName);
	    
	    val x=projectile.position3f.x;
	    val y=projectile.position3f.y;
	    val z=projectile.position3f.z;
	    
	    val pos_string=x~" "~y~" "~z;
		
	    server.commandManager.executeCommandSilent(pokemon, "/particle angryVillager "~pos_string~" 0.2 0.1 0.2 0.1 3 ");

	    player.sendPlaySoundPacket("mekanism:etc.error", "ambient", pokemon.position, 2.0f, 1.5f);
	    
	    if(!player.world.remote){//always true but just in case
		val itemEntity=item.createEntityItem(projectile.world,x,y,z);
		projectile.world.spawnEntity(itemEntity);
	    }
	    
	    player.sendRichTextMessage(message);

	    e.cancel();
	    projectile.setDead();
	}
	
    });

