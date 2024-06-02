#loader contenttweaker
#modloaded ctintegration thaumadditions

import crafttweaker.block.IBlock;
import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityLiving;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.item.IItemStack;
import crafttweaker.item.WeightedItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.contenttweaker.conarm.ArmorTraitBuilder;
import mods.contenttweaker.conarm.ExtendedMaterialBuilder;
import mods.contenttweaker.tconstruct.TraitBuilder;
import mods.contenttweaker.tconstruct.Trait;
import mods.contenttweaker.tconstruct.TraitDataRepresentation;
import mods.tconstruct.traits.CanApplyTogetherTrait;
import mods.ctutils.utils.Math.max;
import mods.ctutils.utils.Math.min;
import mods.ctutils.utils.Math.sqrt;
import mods.ctutils.utils.Math.sin;
import mods.zenutils.Catenation;
import crafttweaker.data.IData;
import mods.zenutils.DataUpdateOperation.OVERWRITE;
import mods.zenutils.DataUpdateOperation.APPEND;
import mods.zenutils.DataUpdateOperation.MERGE;
import mods.zenutils.DataUpdateOperation.REMOVE;
import mods.zenutils.DataUpdateOperation.BUMP;
import crafttweaker.entity.AttributeModifier;

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

/*
███╗   ███╗██╗████████╗██╗  ██╗██████╗ ██╗██╗     ██╗     ██╗██╗   ██╗███╗   ███╗
████╗ ████║██║╚══██╔══╝██║  ██║██╔══██╗██║██║     ██║     ██║██║   ██║████╗ ████║
██╔████╔██║██║   ██║   ███████║██████╔╝██║██║     ██║     ██║██║   ██║██╔████╔██║
██║╚██╔╝██║██║   ██║   ██╔══██║██╔══██╗██║██║     ██║     ██║██║   ██║██║╚██╔╝██║
██║ ╚═╝ ██║██║   ██║   ██║  ██║██║  ██║██║███████╗███████╗██║╚██████╔╝██║ ╚═╝ ██║
╚═╝     ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝     ╚═╝
*/
// Vis Siphon (tools)
/*
_  _ _ ____    ____ _ ___  _  _ ____ _  _    ___ ____ ____ _    ____
|  | | [__     [__  | |__] |__| |  | |\ |     |  |  | |  | |    [__
 \/  | ___]    ___] | |    |  | |__| | \|     |  |__| |__| |___ ___]

*/

val visSiphon_Trait = TraitBuilder.create('vis_siphon');
visSiphon_Trait.color = 2852604;
visSiphon_Trait.localizedName = game.localize('e2ee.tconstruct.material.vis_siphon.name');
visSiphon_Trait.localizedDescription = game.localize('e2ee.tconstruct.material.vis_siphon.description');
visSiphon_Trait.maxLevel = 1;
visSiphon_Trait.onUpdate = function (trait, tool, world, owner, itemSlot, isSelected) {
  if (world.isRemote()) return; // world is remote
  if (!owner instanceof IPlayer) return; // no player
  if (tool.damage == 0) return; // tool max durability
  if (world.getVis(owner.position) < 1.0f) return; // no vis in aura

  tool.mutable().damageItem(-1, owner);
  world.drainVis(owner.position, 0.3f); // that value is actually x3
};
visSiphon_Trait.register();

val visSiphon2_Trait = TraitBuilder.create('vis_siphon2');
visSiphon2_Trait.color = 2852604;
visSiphon2_Trait.localizedName = game.localize('e2ee.tconstruct.material.vis_siphon2.name');
visSiphon2_Trait.localizedDescription = game.localize('e2ee.tconstruct.material.vis_siphon.description');
visSiphon2_Trait.maxLevel = 4;
visSiphon2_Trait.onUpdate = function (trait, tool, world, owner, itemSlot, isSelected) {
  if (world.isRemote()) return; // world is remote
  if (!owner instanceof IPlayer) return; // no player
  if (tool.damage == 0) return; // tool max durability
  tool.mutable();
  val k = trait.getData(tool).level;
  for i in (-1-k) to (2+k){
    for j in (-1-k) to (2+k){
      if (tool.damage == 0) return; // tool max durability
      val pos = owner.position3f;
      pos.x+=16*i;
      pos.z+=16*j; 
      if (world.getVis(pos.asBlockPos()) < 1.0f) continue; // no vis in aura
      tool.damageItem(-1, owner);
      world.drainVis(pos.asBlockPos(), 0.3f); // that value is actually x3
    }
  }
};

visSiphon2_Trait.canApplyTogetherTrait = function(thisTrait, otherTrait){
  if (otherTrait=="vis_siphon") return false;
  return true;
};

visSiphon2_Trait.register();

/*
_  _ _ ____    ____ _ ___  _  _ ____ _  _    ____ ____ _  _ ____ ____
|  | | [__     [__  | |__] |__| |  | |\ |    |__| |__/ |\/| |  | |__/
 \/  | ___]    ___] | |    |  | |__| | \|    |  | |  \ |  | |__| |  \

*/

val visSiphonArmor_Trait = ArmorTraitBuilder.create('vis_siphon');
visSiphonArmor_Trait.color = 2852604;
visSiphonArmor_Trait.localizedName = game.localize('e2ee.tconstruct.material.vis_siphon.name');
visSiphonArmor_Trait.localizedDescription = game.localize('e2ee.tconstruct.material.vis_siphon.description');
visSiphonArmor_Trait.maxLevel = 1;
visSiphonArmor_Trait.onUpdate = function (trait, tool, world, owner, itemSlot, isSelected) {
  if (world.isRemote()) return; // world is remote
  if (!owner instanceof IPlayer) return; // no player
  if (tool.damage == 0) return; // tool max durability
  if (world.getVis(owner.position) < 1.0f) return; // no vis in aura

  tool.mutable().damageItem(-1, owner);
  world.drainVis(owner.position, 0.3f); // that value is actually x3
};
visSiphonArmor_Trait.register();

/*
_  _ _ ____    ____ ____ _  _ _ _    _ ___  ____ _ _  _ _  _    ___ ____ ____ _    ____
|  | | [__     |___ |  | |  | | |    | |__] |__/ | |  | |\/|     |  |  | |  | |    [__
 \/  | ___]    |___ |_\| |__| | |___ | |__] |  \ | |__| |  |     |  |__| |__| |___ ___]

*/

val equilibrium_Trait = TraitBuilder.create('vis_equilibrium');
equilibrium_Trait.color = 2852604;
equilibrium_Trait.localizedName = game.localize('e2ee.tconstruct.material.vis_equilibrium.name');
equilibrium_Trait.localizedDescription = game.localize('e2ee.tconstruct.material.vis_equilibrium.description');

// Bonus mining speed depending on vis in aura
equilibrium_Trait.getMiningSpeed = function (trait, tool, event) {
  if (event.player.world.isRemote()) return; // world is remote
  event.newSpeed = event.newSpeed + (event.originalSpeed * min(2.0f, event.player.world.getVis(event.position) * 0.005f) as float);
};
// Bonus dmg multiplier depending on vis in aura
equilibrium_Trait.calcDamage = function (trait, tool, attacker, target, originalDamage, newDamage, isCritical) {
  if (attacker.world.isRemote()) return newDamage; // world is not remote
  if (!attacker instanceof IPlayer) return newDamage; // not player
  return newDamage * ((1 + min(3.0f, attacker.world.getVis(attacker.position) * 0.01f)) as float);
};
// Relese vis on kill
equilibrium_Trait.afterHit = function(trait, tool, attacker, target, damageDealt, wasCritical, wasHit) {
  if (attacker.world.isRemote()) return; // world is remote
  if (target.health <= 0 && wasHit){
    attacker.world.addVis(attacker.position, (target.maxHealth / 2.0f) as float); // release vis
    server.commandManager.executeCommandSilent(server, "/particle endRod "~target.x~" "~entityEyeHeight(target)~" "~target.z~" 5 1 5 0 50");
    playSound("botania:blacklotus", target);
  } 
};
equilibrium_Trait.register();

/*
_  _ _ ____    ____ ____ _  _ _ _    _ ___  ____ _ _  _ _  _    ____ ____ _  _ ____ ____
|  | | [__     |___ |  | |  | | |    | |__] |__/ | |  | |\/|    |__| |__/ |\/| |  | |__/
 \/  | ___]    |___ |_\| |__| | |___ | |__] |  \ | |__| |  |    |  | |  \ |  | |__| |  \

*/

val equilibriumArmor_Trait = ArmorTraitBuilder.create('vis_equilibrium');
equilibriumArmor_Trait.color = 2852604;
equilibriumArmor_Trait.localizedName = game.localize('e2ee.tconstruct.material.vis_equilibrium.name');
equilibriumArmor_Trait.localizedDescription = game.localize('e2ee.tconstruct.material.vis_equilibrium.description');
equilibriumArmor_Trait.getModifications = function (trait, player, mods, armor, damageSource, damage, index) {
  if (!player.world.isRemote()) {
    mods.effectiveness += max(3.0f, player.world.getVis(player.position) * 0.01f);
  }
  return mods;
};
equilibriumArmor_Trait.register();

/*
_  _ _ ___ _  _ ____ _ _    _    _ _  _ _  _    ___  _  _ _ _    ___
|\/| |  |  |__| |__/ | |    |    | |  | |\/|    |__] |  | | |    |  \
|  | |  |  |  | |  \ | |___ |___ | |__| |  |    |__] |__| | |___ |__/

*/

val mithrillium = ExtendedMaterialBuilder.create('Mithrillium');
mithrillium.color = 2852604;
mithrillium.craftable = false;
mithrillium.liquid = <liquid:mithrillium>;
mithrillium.castable = true;
mithrillium.addItem(<item:thaumadditions:mithrillium_ingot>);
mithrillium.representativeItem = <item:thaumadditions:mithrillium_ingot>;
mithrillium.addHeadMaterialStats(1000, 7.5f, 8.5f, 11);
mithrillium.addHandleMaterialStats(1.5, -100);
mithrillium.addExtraMaterialStats(50);
mithrillium.addBowMaterialStats(1.0f, 3.0f, 1.0f);
mithrillium.addProjectileMaterialStats();

mithrillium.addCoreMaterialStats(9.0, 27.5);
mithrillium.addPlatesMaterialStats(12.3, 12.5, 3.0);
mithrillium.addTrimMaterialStats(5);

mithrillium.itemLocalizer = function (thisMaterial, itemName) {
  return game.localize('e2ee.tconstruct.material.mithrillium.name') + ' ' + itemName;
};
mithrillium.localizedName = game.localize('e2ee.tconstruct.material.mithrillium.name');

mithrillium.addMaterialTrait('vis_siphon');
mithrillium.addMaterialTrait('vis_siphon', 'head');
mithrillium.addMaterialTrait('vis_equilibrium', 'head');

mithrillium.addMaterialTrait('vis_siphon_armor', 'core');
mithrillium.addMaterialTrait('vis_siphon_armor', 'plates');
mithrillium.addMaterialTrait('vis_siphon_armor', 'trim');
mithrillium.addMaterialTrait('vis_equilibrium_armor', 'core');
mithrillium.register();

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/*
 █████╗ ██████╗  █████╗ ███╗   ███╗██╗███╗   ██╗██╗████████╗███████╗
██╔══██╗██╔══██╗██╔══██╗████╗ ████║██║████╗  ██║██║╚══██╔══╝██╔════╝
███████║██║  ██║███████║██╔████╔██║██║██╔██╗ ██║██║   ██║   █████╗
██╔══██║██║  ██║██╔══██║██║╚██╔╝██║██║██║╚██╗██║██║   ██║   ██╔══╝
██║  ██║██████╔╝██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║   ██║   ███████╗
╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚══════╝
*/

/*
____ ____ ____ ___  _ ___  ___  ____ _  _
|___ |  | |__/ |__] | |  \ |  \ |___ |\ |
|    |__| |  \ |__] | |__/ |__/ |___ | \|

*/

// Spin effect on player
function spin(player as IPlayer) as void {
  player.addPotionEffect(<potion:potioncore:spin>.makePotionEffect(7, 1));
  player.sendRichTextStatusMessage(crafttweaker.text.ITextComponent.fromTranslation('warp.sword.warning'));
}

// Striping weared armor
function breakArmor(target as IEntityLivingBase, warp as int, player as IPlayer) as void {
  var broken = false;

  if (target.hasItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.feet())
  && target.world.random.nextInt(1000) > warp) {
    var item = target.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.feet());
    if (!isNull(item) && item.isDamageable) {
      target.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.feet(), null);
      broken = true;
    }
  }
  if (target.hasItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.legs())
  && target.world.random.nextInt(1000) > warp) {
    var item = target.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.legs());
    if (!isNull(item) && item.isDamageable) {
      target.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.legs(), null);
      broken = true;
    }
  }
  if (target.hasItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.chest())
  && target.world.random.nextInt(1000) > warp) {
    var item = target.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.chest());
    if (!isNull(item) && item.isDamageable) {
      target.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.chest(), null);
      broken = true;
    }
  }
  if (target.hasItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.head())
  && target.world.random.nextInt(1000) > warp) {
    var item = target.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.head());
    if (!isNull(item) && item.isDamageable) {
      target.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.head(), null);
      broken = true;
    }
  }
  if(broken) player.sendPlaySoundPacket('minecraft:entity.item.break', 'ambient', target.position, 1.0f, 1.0f);
}

// Debuff function
function debuffenemy(target as IEntityLivingBase, warp as int, player as IPlayer) as void {
  if (target.world.isRemote()) return;
  target.addPotionEffect(<potion:minecraft:glowing>.makePotionEffect(600, 0));
  target.addPotionEffect(<potion:minecraft:wither>.makePotionEffect(600, min(3, (warp - 50) / 200)));
  if (warp >= 100) {
    target.addPotionEffect(<potion:potioncore:broken_armor>.makePotionEffect(600, min(1, (warp - 100) / 500)));
    if (warp >= 300) {
      target.addPotionEffect(<potion:potioncore:vulnerable>.makePotionEffect(600, min(3, (warp - 300) / 300)));
    }
    stripArmor(target, warp, player);
  }
}

// Trait
val forbidden_Trait = TraitBuilder.create('forbidden');
forbidden_Trait.color = 2852604;
forbidden_Trait.localizedName = game.localize('e2ee.tconstruct.material.forbidden.name');
forbidden_Trait.localizedDescription = game.localize('e2ee.tconstruct.material.forbidden.description');

forbidden_Trait.onHit = function (trait, tool, attacker, target, damage, isCritical) {
  if (attacker.world.isRemote()) return;
  if (!attacker instanceof IPlayer) return;
  val player as IPlayer = attacker;
  val warp as int = player.warpNormal + player.warpTemporary + player.warpPermanent;
  if (warp < 50) {
    spin(player);
  }
  else {
    debuffenemy(target, warp, player);
  }
};
forbidden_Trait.register();

/*
___  ____ ____ ____ ____ ____ ____ ____ ___
|__] |  | [__  [__  |___ [__  [__  |___ |  \
|    |__| ___] ___] |___ ___] ___] |___ |__/

*/

val possessed_Trait = TraitBuilder.create('possessed');
possessed_Trait.color = 2852604;
possessed_Trait.localizedName = game.localize('e2ee.tconstruct.material.possessed.name');
possessed_Trait.localizedDescription = game.localize('e2ee.tconstruct.material.possessed.description');

function checkIfWeapon(tool as IItemStack) as bool {
  if (
    !isNull(tool.tag)
    && !isNull(tool.tag.Special)
    && !isNull(tool.tag.Special.Categories)
    && !isNull(tool.tag.Special.Categories.asList())
  ) {
    for tag in tool.tag.Special.Categories.asList() {
      if (tag == 'weapon') return true;
    }
  }
  return false;
}

// Speak randomly
function speakRandom(player as IPlayer, world as IWorld) as void {
  val k = 'warp.sword.speak.random.';
  val r = world.random.nextInt(9);
  player.sendRichTextStatusMessage(crafttweaker.text.ITextComponent.fromTranslation(k + r));
  player.sendPlaySoundPacket('thaumcraft:brain', 'voice', player.position, 1.0f, 0.5f);
}

possessed_Trait.onUpdate = function (trait, tool, world, owner, itemSlot, isSelected) {
  if (world.isRemote()) return;
  if (!checkIfWeapon(tool)) return;

  if (!owner instanceof IPlayer) return;
  val player as IPlayer = owner;

  if (player.warpNormal + player.warpTemporary + player.warpPermanent >= 100) {
    if (world.random.nextInt(12000) < 1) speakRandom(player, world);
  }
};

// Speak on kill
function speakKill(player as IPlayer, world as IWorld) as void {
  val k = 'warp.sword.speak.kill.';
  val r = world.random.nextInt(8);
  player.sendRichTextStatusMessage(crafttweaker.text.ITextComponent.fromTranslation(k + r));
  if (player.isPlayerMP()) player.sendPlaySoundPacket('thaumcraft:brain', 'voice', player.position, 1.0f, 0.5f);
}

possessed_Trait.onHit = function (trait, tool, attacker, target, damage, isCritical) {
  if (attacker.world.isRemote()) return;
  if (!checkIfWeapon(tool)) return;

  if (!attacker instanceof IPlayer) return;
  val player as IPlayer = attacker;
  val warp as int = player.warpNormal + player.warpTemporary + player.warpPermanent;

  if (warp < 50) return;
  if (target.health - damage < 0) speakKill(player, player.world);
};

possessed_Trait.register();

/*
___  ____ ____ ____ _  _ ____
|__] |  | |__/ |  | |  | [__
|    |__| |  \ |__| |__| ___]

*/

val porous_Trait = ArmorTraitBuilder.create('porous');
porous_Trait.color = 2852604;
porous_Trait.localizedName = game.localize('e2ee.tconstruct.material.porous.name');
porous_Trait.localizedDescription = game.localize('e2ee.tconstruct.material.porous.description');

function porous(player as IPlayer) as void {
  val world as IWorld = player.world;
  val x = player.getX() > 0 ? ((player.getX() as int) - 0.5f) : ((player.getX() as int) - 1.5f);
  val y = player.getY() as float;
  val z = player.getZ() > 0 ? ((player.getZ() as int) - 0.5f) : ((player.getZ() as int) - 1.5f);
  val porousStone = <item:thaumcraft:taint_rock>.asBlock();
  if ((y - 2) > 255 || (y - 2) < 3) return;
  val pos = crafttweaker.util.Position3f.create(x, y - 1, z) as IBlockPos;
  val block as IBlock = world.getBlock(pos);
  if (isNull(block)) return;
  if (block.definition.id != 'minecraft:stone') return;
  world.setBlockState(porousStone.definition.defaultState, pos);
  // utils.spawnParticles(world, 'fireworksSpark', x+i, y+j, z+k, 0.1, 0.1, 0.1, 0.1, 2);
  player.sendPlaySoundPacket('thaumcraft:roots', 'ambient', pos.asPosition3f(), 0.5f, 0.8f);
}

porous_Trait.onArmorTick = function (trait, armor, world, player) {
  if (world.isRemote()) return;
  // if(!checkArmorType) return;
  porous(player);
};
porous_Trait.register();

/*
_  _ ____ _ ___     ____ _  _ ____ _    _
|  | |  | | |  \    [__  |__| |___ |    |
 \/  |__| | |__/    ___] |  | |___ |___ |___

*/

val voidShell_trait = ArmorTraitBuilder.create('void_shell');
voidShell_trait.color = 11141165;
voidShell_trait.localizedName = game.localize('e2ee.tconstruct.material.void_shell.name');
voidShell_trait.localizedDescription = game.localize('e2ee.tconstruct.material.void_shell.description');

voidShell_trait.getModifications = function (trait, player, mods, armor, damageSource, damage, index) {
  val warp = player.warpNormal + player.warpTemporary + player.warpPermanent;
  mods.effectiveness += max(3.0f, (warp as float) * 0.0025f);
  return mods;
};
voidShell_trait.register();

/*
____ _    ___  ____ _ ___ ____ _  _     ____ ____ ___ ____ _ ___  _  _ ___ _ ____ _  _
|___ |    |  \ |__/ |  |  |    |__|     |__/ |___  |  |__/ | |__] |  |  |  | |  | |\ |
|___ |___ |__/ |  \ |  |  |___ |  | ___ |  \ |___  |  |  \ | |__] |__|  |  | |__| | \|

*/

val eldritchRetribution_trait = ArmorTraitBuilder.create('eldritch_retribution');
eldritchRetribution_trait.color = 11141165;
eldritchRetribution_trait.localizedName = game.localize('e2ee.tconstruct.material.eldritch_retribution.name');
eldritchRetribution_trait.localizedDescription = game.localize('e2ee.tconstruct.material.eldritch_retribution.description');

eldritchRetribution_trait.onHurt = function (trait, armor, player, source, damage, newDamage, evt) {
  if (source.trueSource instanceof IEntityLivingBase & !player.world.isRemote() & player.warpNormal + player.warpTemporary + player.warpPermanent >= 100) {
    val mobTrue as IEntityLivingBase = source.trueSource;
    val i = player.world.random.nextInt(4);
    if (i == 0) {
      mobTrue.addPotionEffect(<potion:minecraft:levitation>.makePotionEffect(100, 1));
      return newDamage;
    }
    if (i == 1) {
      mobTrue.addPotionEffect(<potion:minecraft:blindness>.makePotionEffect(100, 0));
      return newDamage;
    }
    if (i == 2) {
      if (mobTrue.hasItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand())) {
        var item = mobTrue.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand());
        if (!isNull(item)) {
          if (item.isDamageable) item = item.withDamage(mobTrue.world.random.nextInt(item.maxDamage));
          mobTrue.world.spawnEntity(item.createEntityItem(mobTrue.world, mobTrue.position));
          mobTrue.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand(), null);
        }
      }
      if (mobTrue.hasItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.offhand())) {
        var item = mobTrue.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.offhand());
        if (!isNull(item)) {
          if (item.isDamageable) item = item.withDamage(mobTrue.world.random.nextInt(item.maxDamage));
          mobTrue.world.spawnEntity(item.createEntityItem(mobTrue.world, mobTrue.position));
          mobTrue.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.offhand(), null);
        }
      }
      return newDamage;
    }
    if (i == 3) {
      mobTrue.knockBack(player, 5.0f, player.x - mobTrue.x, player.z - mobTrue.z);
      return newDamage;
    }
  }
  return newDamage;
};
eldritchRetribution_trait.register();

/*
____ ____ ___  ____
| __ |__|   /  |___
|__] |  |  /__ |___

*/

val gaze_trait = ArmorTraitBuilder.create('gaze');
gaze_trait.color = 11141165;
gaze_trait.localizedName = game.localize('e2ee.tconstruct.material.gaze.name');
gaze_trait.localizedDescription = game.localize('e2ee.tconstruct.material.gaze.description');

static gazeUpdateTime as int = 80;

function gazeMechanic(world as IWorld, player as IPlayer) as void {
  if (world.isRemote()) return;
  if (isNull(player)) return;
  val newEffect = <potion:thaumcraft:deathgaze>;
  if (!player.isPotionActive(newEffect)) {
    player.addPotionEffect(newEffect.makePotionEffect(gazeUpdateTime, 3));
    return;
  }
  val existEffect = player.getActivePotionEffect(newEffect);
  player.addPotionEffect(newEffect.makePotionEffect(gazeUpdateTime, 3));
}

gaze_trait.onUpdate = function (trait, tool, world, owner, itemSlot, isSelected) {
  if (!isSelected) return;
  if (world.getWorldTime() % gazeUpdateTime != 0) return;
  if (!owner instanceof IPlayer) return;
  val player as IPlayer = owner;
  gazeMechanic(world, player);
};
gaze_trait.register();

/*
____ ___  ____ _  _ _ _  _ _ ___ ____    ___  _  _ _ _    ___
|__| |  \ |__| |\/| | |\ | |  |  |___    |__] |  | | |    |  \
|  | |__/ |  | |  | | | \| |  |  |___    |__] |__| | |___ |__/

*/

val adaminite = ExtendedMaterialBuilder.create('Adaminite');
adaminite.color = 11141165;
adaminite.craftable = false;
adaminite.liquid = <liquid:adaminite>;
adaminite.castable = true;
adaminite.addItem(<item:thaumadditions:adaminite_ingot>);
adaminite.representativeItem = <item:thaumadditions:adaminite_ingot>;
adaminite.addHeadMaterialStats(666, 5.5f, 21.5f, 12);
adaminite.addHandleMaterialStats(0.6, 60);
adaminite.addExtraMaterialStats(666);
adaminite.addBowMaterialStats(1.66f, 1.5f, 6.6f);
adaminite.addProjectileMaterialStats();

adaminite.addCoreMaterialStats(6.0, 36.6);
adaminite.addPlatesMaterialStats(16.6, 6.6, 6.6);
adaminite.addTrimMaterialStats(6);

adaminite.itemLocalizer = function (thisMaterial, itemName) {
  return game.localize('e2ee.tconstruct.material.adaminite.name') + ' ' + itemName;
};
adaminite.localizedName = game.localize('e2ee.tconstruct.material.adaminite.name');

adaminite.addMaterialTrait('forbidden', 'head');
adaminite.addMaterialTrait('forbidden', 'bow');
adaminite.addMaterialTrait('possessed', 'head');
adaminite.addMaterialTrait('possessed');

adaminite.addMaterialTrait('void_shell_armor', 'core');
adaminite.addMaterialTrait('eldritch_retribution_armor', 'core');
adaminite.addMaterialTrait('gaze_armor', 'trim');
adaminite.addMaterialTrait('porous_armor', 'core');
adaminite.addMaterialTrait('porous_armor', 'plates');
adaminite.addMaterialTrait('porous_armor', 'trim');

adaminite.register();

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/*
███╗   ███╗██╗████████╗██╗  ██╗███╗   ███╗██╗███╗   ██╗██╗████████╗███████╗
████╗ ████║██║╚══██╔══╝██║  ██║████╗ ████║██║████╗  ██║██║╚══██╔══╝██╔════╝
██╔████╔██║██║   ██║   ███████║██╔████╔██║██║██╔██╗ ██║██║   ██║   █████╗
██║╚██╔╝██║██║   ██║   ██╔══██║██║╚██╔╝██║██║██║╚██╗██║██║   ██║   ██╔══╝
██║ ╚═╝ ██║██║   ██║   ██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║   ██║   ███████╗
╚═╝     ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚══════╝
*/

/*
____ ____ ____ ____ ____ ____ ____ _  _ ____ ____
|__/ |___ [__  |___ |__| |__/ |    |__| |___ |__/
|  \ |___ ___] |___ |  | |  \ |___ |  | |___ |  \

*/

val researcherTrait = TraitBuilder.create('researcher');
researcherTrait.color = 16744631;
researcherTrait.localizedName = game.localize('e2ee.tconstruct.material.researcher.name');
researcherTrait.localizedDescription = game.localize('e2ee.tconstruct.material.researcher.description');
researcherTrait.calcDamage = function (trait, tool, attacker, target, originalDamage, newDamage, isCritical) {
  if (target.world.isRemote()) return newDamage;

  if (!attacker instanceof IPlayer) return newDamage;
  val player as IPlayer = attacker;
  var dmg as float = originalDamage;

  if (player.thaumcraftKnowledge.isResearchComplete('FLUX_STRIKE')) {
    if (tool.tag.flux > 0) {
      tool.mutable().updateTag({ flux: tool.tag.flux - 1 });
      dmg = dmg * 2.0f;
    }
  }
  if (player.thaumcraftKnowledge.isResearchComplete('PURE_SMITE')) {
    if (target.isUndead) {
      dmg += 20.0f;
    }
  }
  return dmg as float;
};

researcherTrait.onHit = function (trait, tool, attacker, target, damage, isCritical) {
  if (target.world.isRemote()) return;

  if (!attacker instanceof IPlayer) return;
  val player as IPlayer = attacker;

  if (!player.thaumcraftKnowledge.isResearchComplete('GOD_WRAITH')) return;

  target.addPotionEffect(<potion:potioncore:lightning>.makePotionEffect(10, 0));
};

/*
____ _    _  _ _  _    ____ ___ ____ _ _  _ ____    ___ ____ ____    _  _ ___  ___  ____ ___ ____
|___ |    |  |  \/     [__   |  |__/ | |_/  |___     |  |__| | __    |  | |__] |  \ |__|  |  |___
|    |___ |__| _/\_    ___]  |  |  \ | | \_ |___     |  |  | |__]    |__| |    |__/ |  |  |  |___

*/

researcherTrait.onUpdate = function (trait, tool, world, owner, itemSlot, isSelected) {
  if (world.isRemote()) return;
  if (!owner instanceof IPlayer) return;

  if (isNull(tool.tag)) return; // all tinkers tools should have tags
  if (isNull(tool.tag.flux)) {
    tool.mutable().updateTag({ flux: 0 });
    return;
  }

  if (tool.tag.flux >= 100) return;
  if (world.getFlux(owner.position) <= 1.0f) return;
  world.drainFlux(owner.position, 1.0f);
  tool.mutable().updateTag({ flux: tool.tag.flux + 1 });
};

/*
____ ____ ____    ___  _  _ ____ _ ____ _ ____ ____
|  | |__/ |___    |__] |  | |__/ | |___ | |___ |__/
|__| |  \ |___    |    |__| |  \ | |    | |___ |  \

*/

function checkTool(tool as IItemStack) as bool {
  if (
    !isNull(tool.tag)
    && !isNull(tool.tag.TinkerData)
    && !isNull(tool.tag.Traits)
    && !isNull(tool.tag.Traits.asList())
  ) {
    for trait in tool.tag.Traits.asList() {
      if (trait != 'researcher') continue;
      return true;
    }
  }
  return false;
}

function checkRefineEnchant(tool as IItemStack) as int {
  if (
    !isNull(tool.tag)
    && !isNull(tool.tag.infench)
    && !isNull(tool.tag.infench.asList())
  ) {
    for tag in tool.tag.infench.asList() {
      if ((tag.id as int) == 4) return (tag.lvl as int);
    }
  }
  return 0;
}

researcherTrait.onBlockHarvestDrops = function (trait, tool, event) {
  // DROP BONUS crystalized chunks
  if (event.player.world.isRemote()) return; // world is remote

  if (!event.isPlayer) return; // no player
  // if(event.silkTouch) return; // silk touch
  if (!event.player.thaumcraftKnowledge.isResearchComplete('ORE_PURIFIER')) return; // player don't have finished research

  if (!checkTool(tool)) return;
  val lvl = checkRefineEnchant(tool);

  var newDrops = [] as WeightedItemStack[];
  var dropChanged = false;
  for weightedItem in event.drops {
    if (isNull(weightedItem)) continue;

    var oreName = '';
    var found = false;

    for ore in weightedItem.stack.ores { // checking if it's wanted ore
      if (lvl == 0 && ore.name.startsWith('ore')) {
        oreName = ore.name.substring(3);
      }

      if (ore.name.startsWith('cluster')) {
        oreName = ore.name.substring(7);
      }
      if (!(oreDict has ('cluster' ~ oreName))) continue;
      if (!(oreDict has ('shard' ~ oreName))) continue;
      found = true;
      break;
    }

    if (!found) { // not found ore, adding item as it is
      if (!isNull(weightedItem)) newDrops += weightedItem;
      continue;
    }

    dropChanged = true;

    if (lvl == 0) { // it's ore! add matching cluster/shard
      val item = oreDict['cluster' ~ oreName].firstItem;
      newDrops += (!isNull(item) && event.player.world.getRandom().nextInt(2) == 1) ? item % weightedItem.percent : weightedItem;
    }
    else if (lvl == 1) {
      val item = oreDict[(event.player.world.getRandom().nextInt(2) == 0 ? 'cluster' : 'crystalShard') ~ oreName].firstItem;
      newDrops += !isNull(item) ? item % weightedItem.percent : weightedItem;
    }
    else {
      val item = oreDict['crystalShard' ~ oreName].firstItem;
      if (isNull(item)) {
        newDrops += weightedItem;
      }
      else {
        newDrops += item % weightedItem.percent;
        if (lvl > 2) newDrops += item % ((lvl - 1) * 25);
      }
    }
  }

  if (!dropChanged) return;
  event.drops = newDrops;
};
researcherTrait.register();

/*
____ _ ____ ____ ___    ____ ___ ____ _  _ ___
|___ | |__/ [__   |     [__   |  |__| |\ | |  \
|    | |  \ ___]  |     ___]  |  |  | | \| |__/

*/

val firstStand_trait = ArmorTraitBuilder.create('first_stand');
firstStand_trait.color = 11141165;
firstStand_trait.localizedName = game.localize('e2ee.tconstruct.material.first_stand.name');
firstStand_trait.localizedDescription = game.localize('e2ee.tconstruct.material.first_stand.description');

function calcLevel(exp as int) as int {
  if (exp >= 1508) {
    return (81.0 / 10.0 + sqrt(2.0 / 5.0 * (exp - 7839.0 / 40.0))) as int;
  }
  if (exp >= 353) {
    return (325.0 / 18.0 + sqrt(2.0 / 9.0 * (exp - 54215.0 / 72.0))) as int;
  }
  return (sqrt(exp + 9.0) - 3.0) as int;
}

function calcExpTotalForLevel(level as int) as int {
  if (level >= 32) {
    return ((9 * level * level + 325 * level + 4440) / 2) as int;
  }
  if (level >= 17) {
    return ((5 * level * level + 81 * level + 720) / 2);
  }
  else {
    return level * (level + 6);
  }
}

function calculateExpDrain(player as IPlayer, damage as float) as bool {
  val exp as int = player.getTotalXP();
  val expRemove as int = (damage * 2.0f) as int;
  if (exp < expRemove) return false; // if player have enought exp

  // if in range of the level: (doesn't makes sound)
  if (calcExpTotalForLevel(player.xp) < exp) {
    player.removeExperience(expRemove);
  }
  // if out of the range of the level (makes sound)
  player.removeExperience(exp);
  player.xp = 0;
  player.addExperience(exp - expRemove);
  return true;
}

firstStand_trait.onHurt = function (trait, armor, player, source, damage, newDamage, evt) {
  if (newDamage <= 0.0f) return newDamage;
  if (player.thaumcraftKnowledge.isResearchComplete('FIRST_STAND') && calculateExpDrain(player, newDamage)) {
    evt.cancel();
    return -0.1f;
  }
  return newDamage;
};
firstStand_trait.register();

/*
_  _ _ ___ _  _ _  _ _ _  _ _ ___ ____    ___  _  _ _ _    ___
|\/| |  |  |__| |\/| | |\ | |  |  |___    |__] |  | | |    |  \
|  | |  |  |  | |  | | | \| |  |  |___    |__] |__| | |___ |__/

*/

val mithminite = ExtendedMaterialBuilder.create('Mithminite');
mithminite.color = 16744631;
mithminite.craftable = false;
mithminite.liquid = <liquid:mithminite>;
mithminite.castable = true;
mithminite.addItem(<item:thaumadditions:mithminite_ingot>);
mithminite.representativeItem = <item:thaumadditions:mithminite_ingot>;
mithminite.addHeadMaterialStats(1420, 9.5f, 12.5f, 12);
mithminite.addHandleMaterialStats(2.1, 0);
mithminite.addExtraMaterialStats(420);
mithminite.addBowMaterialStats(2.40f, 3.0f, 4.2f);
mithminite.addProjectileMaterialStats();

mithminite.addCoreMaterialStats(14.0, 42.0);
mithminite.addPlatesMaterialStats(24.0, 42.0, 0.0);
mithminite.addTrimMaterialStats(42);

mithminite.itemLocalizer = function (thisMaterial, itemName) {
  return game.localize('e2ee.tconstruct.material.mithminite.name') + ' ' + itemName;
};
mithminite.localizedName = game.localize('e2ee.tconstruct.material.mithminite.name');

mithminite.addMaterialTrait('researcher', 'head');

mithminite.addMaterialTrait('first_stand_armor', 'core');

mithminite.register();
