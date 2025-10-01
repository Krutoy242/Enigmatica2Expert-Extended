#loader contenttweaker
#modloaded thaumcraft

import crafttweaker.block.IBlock;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.item.IItemStack;
import crafttweaker.item.WeightedItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import mods.contenttweaker.conarm.ArmorTraitBuilder;
import mods.contenttweaker.conarm.ExtendedMaterialBuilder;
import mods.contenttweaker.tconstruct.MaterialBuilder;
import mods.contenttweaker.tconstruct.TraitBuilder;
import crafttweaker.util.Math.ceil;
import crafttweaker.util.Math.sqrt;

import scripts.cot.trait.utils.getArmorMatsAmount;
import scripts.cot.trait.utils.getItemMatAmount;

/*
Some taken from: wilderness-minecraft
https://github.com/badmonkey/wilderness-minecraft/blob/f32102d158566de9d346034b35c2f6226d369ff9/forge1.12/wilderness/scripts/content/traits_tcon.zs
*/

//
// blindrage
//
val rage = TraitBuilder.create('blindrage');
rage.color = 0x080808;
rage.localizedName = game.localize('e2ee.tconstruct.material.blindrage.name');
rage.localizedDescription = game.localize('e2ee.tconstruct.material.blindrage.description');
rage.calcDamage = function (trait, tool, attacker, target, originalDamage, newDamage, isCritical) {
  if (attacker.isPotionActive(<potion:minecraft:blindness>)) {
    return newDamage * 2.0;
  }
  else {
    return newDamage;
  }
};
rage.register();

//
// darkness
//
val dark = TraitBuilder.create('darkness');
dark.color = 0x332C3B;
dark.localizedName = game.localize('e2ee.tconstruct.material.darkness.name');
dark.localizedDescription = game.localize('e2ee.tconstruct.material.darkness.description');
dark.calcDamage = function (trait, tool, attacker, target, originalDamage, newDamage, isCritical) {
  val light = attacker.world.getBrightness(attacker.getX(), attacker.getY(), attacker.getZ());
  return newDamage * (2.0f - light as float / 15.0f);
};
dark.register();

//
// dire
//
val dire = TraitBuilder.create('dire');
dire.color = 0x54514A;
dire.localizedName = game.localize('e2ee.tconstruct.material.dire.name');
dire.localizedDescription = game.localize('e2ee.tconstruct.material.dire.description');
dire.calcCrit = function (trait, tool, attacker, target) {
  return attacker.health >= attacker.maxHealth;
};
dire.register();

//
// lifecycle
//
val life = TraitBuilder.create('lifecycle');
life.color = 0xFF2010;
life.localizedName = game.localize('e2ee.tconstruct.material.lifecycle.name');
life.localizedDescription = game.localize('e2ee.tconstruct.material.lifecycle.description');
life.onToolDamage = function (trait, tool, unmodifiedAmount, newAmount, holder) {
  holder.heal(newAmount);
  return newAmount;
};
life.register();

//
// antimagic
//
val antimagic = ArmorTraitBuilder.create('antimagic');
antimagic.color = 0x000000;
antimagic.localizedName = game.localize('e2ee.tconstruct.material.antimagic.name');
antimagic.localizedDescription = game.localize('e2ee.tconstruct.material.antimagic.description');
antimagic.onHurt = function (trait, armor, player, source, damage, newDamage, evt) {
  if (armor.damage < armor.maxDamage && source.isMagicDamage()) {
    evt.cancel();
  }
  return newDamage;
};
antimagic.onArmorTick = function (trait, armor, world, player) {
  if (world.getWorldTime() % 10 == 0) player.clearActivePotions();
};
antimagic.register();

//
// darkside
//
val darkdefense = ArmorTraitBuilder.create('darkside');
darkdefense.color = 0x332C3B;
darkdefense.localizedName = game.localize('e2ee.tconstruct.material.darkside.name');
darkdefense.localizedDescription = game.localize('e2ee.tconstruct.material.darkside.description');
darkdefense.onHurt = function (trait, armor, player, source, damage, newDamage, event) {
  return newDamage * (0.75 + 0.25 * player.world.getBrightness(player.x, player.y, player.z) / 15.0);
};
darkdefense.register();

//
// mentor
//
val mentor = TraitBuilder.create('mentor');
mentor.color = 0x216E2A;
mentor.localizedName = game.localize('e2ee.tconstruct.material.mentor.name');
mentor.localizedDescription = game.localize('e2ee.tconstruct.material.mentor.description');
mentor.calcDamage = function (trait, tool, attacker, target, originalDamage, newDamage, isCritical) {
  if (!attacker instanceof IPlayer) return newDamage;
  val player as IPlayer = attacker;
  val level = getItemMatAmount(tool, 'essence_metal');
  if (level <= 0) return newDamage;
  player.xp = max(0, player.xp - level);
  // player.removeExperience((player.getTotalXP() as float * (0.03f * level as float) + 1.0f) as int);
  return newDamage + sqrt(player.xp * level);
};
mentor.register();

var trait_armor = ArmorTraitBuilder.create('apprentice');
trait_armor.color = 0x216E2A;
trait_armor.localizedName = game.localize('e2ee.tconstruct.material.apprentice.name');
trait_armor.localizedDescription = game.localize('e2ee.tconstruct.material.apprentice.description');
trait_armor.onHurt = function (trait, armor, victim, source, damage, newDamage, evt) {
  var level = 1;
  if (victim instanceof IPlayer) {
    val player as IPlayer = victim;
    level = getArmorMatsAmount(player, 'essence_metal');
    player.addExperience((ceil(newDamage as double / 10.0) * level as double) as int);
  }
  return newDamage + (newDamage as double * (0.1 * level as double)) as int;
};
trait_armor.register();

//
// Fireproof Wood
//
val m = ExtendedMaterialBuilder.create('fireproof');
m.color = 0xA64D00;
m.craftable = true;
m.castable = false;
m.representativeItem = <item:contenttweaker:woodweave_singularity>;
m.addItem(<item:contenttweaker:woodweave_singularity>, 1, 144);
m.localizedName = game.localize('e2ee.tconstruct.material.fireproof.name');
m.addHeadMaterialStats(100, 4, 3, 3);
m.addHandleMaterialStats(1.5, 100);
m.addExtraMaterialStats(50);
m.addBowMaterialStats(1.0 / 1.25, 1, 0);
m.addProjectileMaterialStats();
m.addCoreMaterialStats(3, 10);
m.addPlatesMaterialStats(1.0, 20, 1);
m.addTrimMaterialStats(4);
m.register();

//
// spectre
//
val spectre = ExtendedMaterialBuilder.create('spectre');
spectre.color = 0x9CC1CE;
spectre.craftable = false;
spectre.castable = true;
spectre.representativeItem = <item:randomthings:ingredient:3>;
spectre.liquid = <liquid:spectre>;
spectre.addItem(<ore:ingotSpectre>);
spectre.localizedName = game.localize('e2ee.tconstruct.material.spectre.name');
spectre.addHeadMaterialStats(400, 4.2, 6.0, 7);
spectre.addHandleMaterialStats(1.4, -50);
spectre.addExtraMaterialStats(64);
spectre.addBowMaterialStats(1.0f / 1.5f, 1.0, 2.5);
spectre.addProjectileMaterialStats();
spectre.addCoreMaterialStats(200, 23.3);
spectre.addPlatesMaterialStats(1.6, 100, 2);
spectre.addTrimMaterialStats(70);
spectre.register();

static spectreUpdateTime as int = 180;
static hasPotioncore as bool = loadedMods.contains('potioncore');

function spectreMechanic(world as IWorld, player as IPlayer, level as int) as void {
  if (world.remote) return;
  if (isNull(player)) return;
  val levelMult = hasPotioncore ? 1 : 3;
  val newEffect = hasPotioncore ? <potion:potioncore:reach> : <potion:cyclicmagic:magnet>;
  if (!player.isPotionActive(newEffect)) {
    player.addPotionEffect(newEffect.makePotionEffect(spectreUpdateTime, level * levelMult - 1));
    return;
  }
  val existEffect = player.getActivePotionEffect(newEffect);
  player.addPotionEffect(newEffect.makePotionEffect(spectreUpdateTime, existEffect.amplifier + level * levelMult));
}

val spectre_trait = TraitBuilder.create('spectre');
spectre_trait.color = 0x9CC1CE;
spectre_trait.localizedName = game.localize('e2ee.tconstruct.material.spectre.name');
spectre_trait.localizedDescription = game.localize('e2ee.tconstruct.material.spectre.description');
spectre_trait.onUpdate = function (trait, tool, world, owner, itemSlot, isSelected) {
  if (!isSelected) return;
  if (world.getWorldTime() % spectreUpdateTime != 0) return;
  if (!owner instanceof IPlayer) return;
  val player as IPlayer = owner;
  spectreMechanic(world, player, getItemMatAmount(tool, 'spectre'));
};
spectre_trait.register();

val spectre_armor = ArmorTraitBuilder.create('spectre');
spectre_armor.color = 0x9CC1CE;
spectre_armor.localizedName = game.localize('e2ee.tconstruct.material.spectre.name');
spectre_armor.localizedDescription = game.localize('e2ee.tconstruct.material.spectre.description');
spectre_armor.onAbility = function (trait, level, world, player) {
  if (world.getWorldTime() % spectreUpdateTime != 0) return;
  spectreMechanic(world, player, getArmorMatsAmount(player, 'spectre'));
};
spectre_armor.register();

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
var mat = MaterialBuilder.create('spectre_string');
mat.color = 0x90A4AE;
mat.craftable = true;
mat.castable = false;
mat.representativeItem = <item:randomthings:ingredient:12>;
mat.addItem(<item:randomthings:ingredient:12>);
mat.localizedName = game.localize('e2ee.tconstruct.material.spectre_string.name');
mat.addBowStringMaterialStats(2.2);
mat.register();

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
mat = MaterialBuilder.create('alpha_fur');
mat.color = 0x2196F3;
mat.craftable = true;
mat.castable = false;
mat.representativeItem = <item:twilightforest:alpha_fur>;
mat.addItem(<item:twilightforest:alpha_fur>);
mat.localizedName = game.localize('e2ee.tconstruct.material.alpha_fur.name');
mat.addHeadMaterialStats(300, 2.0, 1.0, 1);
mat.addHandleMaterialStats(0.1, 100);
mat.addExtraMaterialStats(80);
mat.addBowMaterialStats(1.0, 0.3, 1.0);
mat.addProjectileMaterialStats();
mat.register();

trait_armor = ArmorTraitBuilder.create('alpha_fur');
trait_armor.color = 0x2196F3;
trait_armor.localizedName = game.localize('e2ee.tconstruct.material.alpha_fur.name');
trait_armor.localizedDescription = game.localize('e2ee.tconstruct.material.alpha_fur.description');
trait_armor.onHurt = function (trait, armor, player, source, damage, newDamage, evt) {
  if (!isNull(source.getTrueSource()) && source.getTrueSource() instanceof IEntityLivingBase) {
    val attacker as IEntityLivingBase = source.getTrueSource();
    attacker.addPotionEffect(<potion:twilightforest:frosted>.makePotionEffect(60, 5));
  }
  return newDamage;
};
trait_armor.register();

val trait = TraitBuilder.create('alpha_fur');
trait.color = 0x2196F3;
trait.localizedName = game.localize('e2ee.tconstruct.material.alpha_fur.name');
trait.localizedDescription = game.localize('e2ee.tconstruct.material.alpha_fur.description');
trait.afterHit = function (trait, tool, attacker, target, damageDealt, wasCritical, wasHit) {
  target.addPotionEffect(<potion:twilightforest:frosted>.makePotionEffect(60, 4));
};
trait.register();

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// -------------------------------
// Axe Tait
// -------------------------------
var t = TraitBuilder.create('axing');
t.color = 0xA3B391;
t.localizedName = game.localize('e2ee.tconstruct.material.axing.name');
t.localizedDescription = game.localize('e2ee.tconstruct.material.axing.description');
t.register();

t = TraitBuilder.create('axing2');
t.color = 0xC4D6AE;
t.localizedName = game.localize('e2ee.tconstruct.material.axing2.name');
t.localizedDescription = game.localize('e2ee.tconstruct.material.axing2.description');
t.register();

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
