#loader contenttweaker

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.block.IBlockState;
import crafttweaker.event.IBlockEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.entity.IEntity;
import mods.contenttweaker.Color;
import mods.contenttweaker.conarm.ArmorTraitBuilder;
import mods.contenttweaker.conarm.ExtendedMaterialBuilder;
import mods.contenttweaker.tconstruct.TraitBuilder;
import mods.contenttweaker.tconstruct.MaterialBuilder;
import mods.ctutils.utils.Math.max;
import mods.ctutils.utils.Math.min;
import mods.ctutils.utils.Math.sqrt;
import mods.ctutils.utils.Math.ceil;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.block.IBlock;
import crafttweaker.block.IBlockDefinition;
import crafttweaker.util.Position3f;
import crafttweaker.item.IMutableItemStack;
import crafttweaker.event.PlayerBreakSpeedEvent;
import crafttweaker.potions.IPotionEffect;
import crafttweaker.text.ITextComponent;
import crafttweaker.data.IData;

import scripts.cot.utils_tcon_cot.getItemMatAmount;
import scripts.cot.utils_tcon_cot.getArmorMatsAmount;

/* 
Some taken from: wilderness-minecraft
https://github.com/badmonkey/wilderness-minecraft/blob/f32102d158566de9d346034b35c2f6226d369ff9/forge1.12/wilderness/scripts/content/traits_tcon.zs
*/

//
// blindrage
//
val rage = TraitBuilder.create("blindrage");
rage.color = 0x080808;
rage.localizedName = "Blind Rage";
rage.localizedDescription = "§oWho said you needed to see your enemies?\n§rDeal double damage when blinded";
rage.calcDamage = function(trait, tool, attacker, target, originalDamage, newDamage, isCritical)
{
  if(attacker.isPotionActive(<potion:minecraft:blindness>)){
    return newDamage * 2.0;
  } else {
    return newDamage;
  }
};
rage.register();


//
// darkness
//
val dark = TraitBuilder.create("darkness");
dark.color = 0x332c3b;
dark.localizedName = "Eternal Darkness";
dark.localizedDescription = "§oJoin the dark side...\n§rYour tool loves the dark so much; it does more damage in the dark.";
dark.calcDamage = function(trait, tool, attacker, target, originalDamage, newDamage, isCritical)
{
  var light = attacker.world.getBrightness(attacker.getX(), attacker.getY(), attacker.getZ());
  return newDamage * (2.0f - light as float / 15.0f);
};
dark.register();



//
// dire
//
val dire = TraitBuilder.create("dire");
dire.color = 0x54514a;
dire.localizedName = "Dire-Hit";
dire.localizedDescription = "§oIt's super effective!\n§rYour tool will always land critical hits so long as you are at full health!";
dire.calcCrit = function(trait, tool, attacker, target)
{
  return attacker.health >= attacker.maxHealth;
};
dire.register();


//
// lifecycle
//
val life = TraitBuilder.create("lifecycle");
life.color = 0xff2010;
life.localizedName = "Cycle of Life";
life.localizedDescription = "§oFrom one to another.\n§rWhen your tool is damaged, you are healed for the damaged amount.";
life.onToolDamage = function(trait, tool, unmodifiedAmount, newAmount, holder)
{
  holder.heal(newAmount);
  return newAmount;
};
life.register();


//
// antimagic
//
val antimagic = ArmorTraitBuilder.create("antimagic");
antimagic.color = 0x000000;
antimagic.localizedName = "Anti-Magic";
antimagic.localizedDescription = "§oNihilistic!\n§rYour armor doesn't believe in potions, and refuses to be affected by any potion effects; good or bad.";
antimagic.onHurt = function(trait, armor, player, source, damage, newDamage, evt) {
  if(armor.damage < armor.maxDamage && source.isMagicDamage()) {
    evt.cancel();
  }
  return newDamage;
};
antimagic.onArmorTick = function(trait, armor, world, player) {
  if (world.getWorldTime() % 10 == 0) player.clearActivePotions();
};
antimagic.register();


//
// darkside
//
val darkdefense = ArmorTraitBuilder.create("darkside");
darkdefense.color = 0x332c3b;
darkdefense.localizedName = "The Dark Side";
darkdefense.localizedDescription = "§oUnder the cover of darkness!\n§rYour armor loves the dark so much; you take less damage when in darkness.";
darkdefense.onHurt = function(trait, armor, player, source, damage, newDamage, event)
{
  return newDamage * (0.75 + 0.25 * player.world.getBrightness(player.x, player.y, player.z) / 15.0);
};
darkdefense.register();


//
// mentor
//
val mentor = TraitBuilder.create("mentor");
mentor.color = 0x216e2a;
mentor.localizedName = game.localize("e2ee.tconstruct.material.mentor.name");
mentor.localizedDescription = game.localize("e2ee.tconstruct.material.mentor.description");
mentor.calcDamage = function(trait, tool, attacker, target, originalDamage, newDamage, isCritical) {
  if (! attacker instanceof IPlayer) return newDamage;
  val player as IPlayer = attacker;
  val level = getItemMatAmount(tool, "essence_metal");
  if (level <= 0) return newDamage;
  player.xp = max(0, player.xp - level);
  // player.removeExperience((player.getTotalXP() as float * (0.03f * level as float) + 1.0f) as int);
  return newDamage + sqrt(player.xp * level);
};
mentor.register();

var
trait_armor = ArmorTraitBuilder.create("apprentice");
trait_armor.color = 0x216e2a;
trait_armor.localizedName = game.localize("e2ee.tconstruct.material.apprentice.name");
trait_armor.localizedDescription = game.localize("e2ee.tconstruct.material.apprentice.description");
trait_armor.onHurt = function(trait, armor, victim, source, damage, newDamage, evt) {
  var level = 1;
  if (victim instanceof IPlayer) {
    val player as IPlayer = victim;
    level = getArmorMatsAmount(player, "essence_metal");
    player.addExperience((ceil(newDamage as double / 10.0d) * level as double) as int);
  }
  return newDamage + (newDamage as double * (0.1d * level as double)) as int;
};
trait_armor.register();


//
// difficulty
//
val difficulty = TraitBuilder.create("difficulty");
difficulty.color = 0xd1310d;
difficulty.localizedName = "Difficulty";
difficulty.localizedDescription = "§oScalling Difficulty\n§rMining, attacking and receive damage reduce player difficulty";
difficulty.afterBlockBreak = function(trait, tool, world, blockstate, miner, wasEffective, unknown) {
  if(world.isRemote()) return;
  if(! miner instanceof IPlayer) return;
  val player as IPlayer = miner;
  mods.ctintegration.scalinghealth.DifficultyManager.addDifficulty(player, -0.001);
};
difficulty.onHit = function(trait, tool, attacker, target, damage, isCritical) {
  if(! attacker instanceof IPlayer) return;
  val player as IPlayer = attacker;
  if(player.world.isRemote()) return;
  if(damage <= 0) return;
  mods.ctintegration.scalinghealth.DifficultyManager.addDifficulty(player, -0.001 * damage);
};
difficulty.register();

//
// difficulty_armor
//
val difficulty_armor = ArmorTraitBuilder.create("difficulty");
difficulty_armor.color = 0xd1310d;
difficulty_armor.localizedName = "Difficulty";
difficulty_armor.localizedDescription = "§oScalling Difficulty\n§rMining, attacking and receive damage reduce player difficulty";
difficulty_armor.onDamaged = function(trait, armor, player, source, damage, newDamage, evt) {
  if(player.world.isRemote()) return newDamage;
  if(newDamage <= 0) return newDamage;
  mods.ctintegration.scalinghealth.DifficultyManager.addDifficulty(player, -0.001 * newDamage);
  return newDamage;
};
difficulty_armor.register();


//
// spectre
//
val spectre = ExtendedMaterialBuilder.create("spectre");
spectre.color = 0x9CC1CE;
spectre.craftable = false;
spectre.castable = true;
spectre.representativeItem = <item:randomthings:ingredient:3>;
spectre.liquid = <liquid:spectre>;
spectre.addItem(<ore:ingotSpectre>);
spectre.localizedName = game.localize("e2ee.tconstruct.material.spectre.name");
spectre.addHeadMaterialStats(400, 4.2, 6.0, 7);
spectre.addHandleMaterialStats(1.4, -50);
spectre.addExtraMaterialStats(64);
spectre.addBowMaterialStats(1.0f / 1.5f, 1.0, 2.5);
spectre.addProjectileMaterialStats();
spectre.addCoreMaterialStats(200, 23.3);
spectre.addPlatesMaterialStats(1.6, 100, 2);
spectre.addTrimMaterialStats(70);
spectre.register();

static spectreUpdateTime as int = 80;
static hasPotioncore as bool = loadedMods.contains("potioncore");

function spectreMechanic(world as IWorld, player as IPlayer, level as int) as void {
  if (world.isRemote()) return;
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

val spectre_trait = TraitBuilder.create("spectre");
spectre_trait.color = 0x9CC1CE;
spectre_trait.localizedName = game.localize("e2ee.tconstruct.material.spectre.name");
spectre_trait.localizedDescription = game.localize("e2ee.tconstruct.material.spectre.description");
spectre_trait.onUpdate = function(trait, tool, world, owner, itemSlot, isSelected) {
  if (!isSelected) return;
  if (world.getWorldTime() % spectreUpdateTime != 0) return;
  if (! owner instanceof IPlayer) return;
  val player as IPlayer = owner;
  spectreMechanic(world, player, getItemMatAmount(tool, "spectre"));
};
spectre_trait.register();


val spectre_armor = ArmorTraitBuilder.create("spectre");
spectre_armor.color = 0x9CC1CE;
spectre_armor.localizedName = game.localize("e2ee.tconstruct.material.spectre.name");
spectre_armor.localizedDescription = game.localize("e2ee.tconstruct.material.spectre.description");
spectre_armor.onAbility = function(trait, level, world, player) {
  if (world.getWorldTime() % spectreUpdateTime != 0) return;
  spectreMechanic(world, player, getArmorMatsAmount(player, "spectre"));
};
spectre_armor.register();

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
var 
mat = MaterialBuilder.create("spectre_string");
mat.color = 0x90a4ae; 
mat.craftable = true;
mat.castable = false;
mat.representativeItem = <item:randomthings:ingredient:12>;
mat.addItem(<item:randomthings:ingredient:12>);
mat.localizedName = game.localize("e2ee.tconstruct.material.spectre_string.name");
mat.addBowStringMaterialStats(2.2);
mat.register();


/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
mat = MaterialBuilder.create("alpha_fur");
mat.color = 0x2196f3; 
mat.craftable = true;
mat.castable = false;
mat.representativeItem = <item:twilightforest:alpha_fur>;
mat.addItem(<item:twilightforest:alpha_fur>);
mat.localizedName = game.localize("e2ee.tconstruct.material.alpha_fur.name");
mat.addHeadMaterialStats(300, 2.0, 1.0, 1);
mat.addHandleMaterialStats(0.1, 100);
mat.addExtraMaterialStats(80);
mat.addBowMaterialStats(1.0, 0.3, 1.0);
mat.addProjectileMaterialStats();
mat.register();


trait_armor = ArmorTraitBuilder.create("alpha_fur");
trait_armor.color = 0x2196f3;
trait_armor.localizedName = game.localize("e2ee.tconstruct.material.alpha_fur.name");
trait_armor.localizedDescription = game.localize("e2ee.tconstruct.material.alpha_fur.description");
trait_armor.onHurt = function(trait, armor, player, source, damage, newDamage, evt) {
  if (!isNull(source.getTrueSource()) && source.getTrueSource() instanceof IEntityLivingBase) {
    var attacker as IEntityLivingBase = source.getTrueSource();
    attacker.addPotionEffect(<potion:twilightforest:frosted>.makePotionEffect(60, 5));
  }
  return newDamage;
};
trait_armor.register();

var
trait = TraitBuilder.create("alpha_fur");
trait.color = 0x2196f3;
trait.localizedName = game.localize("e2ee.tconstruct.material.alpha_fur.name");
trait.localizedDescription = game.localize("e2ee.tconstruct.material.alpha_fur.description");
trait.afterHit = function(trait, tool, attacker, target, damageDealt, wasCritical, wasHit) {
  target.addPotionEffect(<potion:twilightforest:frosted>.makePotionEffect(60, 4));
};
trait.register();



/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
# -------------------------------
# Grinding Tait
# -------------------------------
val grindingTrait = ArmorTraitBuilder.create("grinding");
grindingTrait.color = 0x444450;
grindingTrait.localizedName = game.localize("e2ee.tconstruct.material.grinding.name");
grindingTrait.localizedDescription = game.localize("e2ee.tconstruct.material.grinding.description");
grindingTrait.onFalling = function(trait, armor, player, event) {
  if(event.entityLivingBase.world.isRemote()) return;
  scripts.cot.trait_grinding.onFalling(armor, player);
};
grindingTrait.onAbility = function(trait, level, world, player) {
  if(world.isRemote()) return;
  scripts.cot.trait_grinding.onAbility(trait, level, world, player);
};
grindingTrait.register();

# -------------------------------
# Tic + Conarm Material
# -------------------------------
val heavy = ExtendedMaterialBuilder.create("heavy");

heavy.liquid = <liquid:heavy_metal>;
heavy.castable = true;
heavy.craftable = false;

heavy.color = 0x444450;
heavy.addItem(<item:mechanics:heavy_ingot>);
heavy.representativeItem = <item:mechanics:heavy_ingot>;
heavy.localizedName = game.localize("e2ee.tconstruct.material.heavy.name");
heavy.itemLocalizer = function(thisMaterial, itemName){
    return game.localize("e2ee.tconstruct.material.heavy.name") + " " + itemName;
};
heavy.addHeadMaterialStats(-200, 0.1, 25.0, 5);
heavy.addExtraMaterialStats(-40);
heavy.addHandleMaterialStats(0.5, -10);
heavy.addBowMaterialStats(0.1, 0.1, 25);
heavy.addArrowShaftMaterialStats(0.2, -10);

heavy.addCoreMaterialStats(10, 2.5);
heavy.addPlatesMaterialStats(0.3, 5, 0);
heavy.addTrimMaterialStats(0.4);

heavy.addMaterialTrait("heavy", "head");
heavy.addMaterialTrait("heavy", "core");
heavy.addMaterialTrait("heavy", "plates");
heavy.addMaterialTrait("grinding_armor");
heavy.addProjectileMaterialStats();
heavy.register();



/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
# -------------------------------
# Axe Tait
# -------------------------------
var t = TraitBuilder.create("axing");
t.color = 0xA3B391;
t.localizedName = game.localize("e2ee.tconstruct.material.axing.name");
t.localizedDescription = game.localize("e2ee.tconstruct.material.axing.description");
t.register();

t = TraitBuilder.create("axing2");
t.color = 0xC4D6AE;
t.localizedName = game.localize("e2ee.tconstruct.material.axing2.name");
t.localizedDescription = game.localize("e2ee.tconstruct.material.axing2.description");
t.register();

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

# -------------------------------
# Mithrillium
# -------------------------------

# Vis Siphon (tools)

val auraTrait = TraitBuilder.create("vis_siphon");
auraTrait.color = 2852604;
auraTrait.localizedName = game.localize("e2ee.tconstruct.material.vis_siphon.name");
auraTrait.localizedDescription = game.localize("e2ee.tconstruct.material.vis_siphon.description");
auraTrait.maxLevel = 1;
auraTrait.onUpdate = function(trait, tool, world, owner, itemSlot, isSelected) {
  
  /*val x = owner.getX() as float;
  val y = owner.getY() as float;
  val z = owner.getZ() as float;
  val pos = crafttweaker.util.Position3f.create( x, y, z) as IBlockPos;*/
  if (tool.damage > 0 & world.getVis(owner.position)>1){ 
    tool.mutable().damageItem(-1, owner);
    world.drainVis(owner.position, 0.3f); #that value is actually x3
  }
};
auraTrait.register();

# Vis Siphon (armor)

val aura2Trait = ArmorTraitBuilder.create("vis_siphon");
aura2Trait.color = 2852604;
aura2Trait.localizedName = game.localize("e2ee.tconstruct.material.vis_siphon.name");
aura2Trait.localizedDescription = game.localize("e2ee.tconstruct.material.vis_siphon.description");
aura2Trait.maxLevel = 1;
aura2Trait.onUpdate = function(trait, tool, world, owner, itemSlot, isSelected) {
  /*val x = owner.getX() as float;
  val y = owner.getY() as float;
  val z = owner.getZ() as float;
  val pos = crafttweaker.util.Position3f.create( x, y, z) as IBlockPos;*/
  if (tool.damage > 0 & world.getVis(owner.position)>1){ 
    tool.mutable().damageItem(-1, owner);
    world.drainVis(owner.position, 0.3f); #that value is actually x3
  }
};
aura2Trait.register();

# Vis Equilibrium (tools)

val equilibriumTrait = TraitBuilder.create("vis_equilibrium");
equilibriumTrait.color = 2852604;
equilibriumTrait.localizedName = game.localize("e2ee.tconstruct.material.vis_equilibrium.name");
equilibriumTrait.localizedDescription = game.localize("e2ee.tconstruct.material.vis_equilibrium.description");
equilibriumTrait.getMiningSpeed = function(trait, tool, event) {
  val bonus = min(3.0f,event.player.world.getVis(event.position)*0.01f) as float;
  event.newSpeed = event.originalSpeed + bonus;
};
equilibriumTrait.calcDamage = function(trait, tool, attacker, target, originalDamage, newDamage, isCritical) {
  /*val x = attacker.getX() as float;
  val y = attacker.getY() as float;
  val z = attacker.getZ() as float;
  val pos = crafttweaker.util.Position3f.create( x, y, z) as IBlockPos;*/
  val mult = 1+min(3.0f,attacker.world.getVis(attacker.position)*0.01f) as float;
	return originalDamage*mult;
};
equilibriumTrait.register();

# Vis Equilibrium (armor)

val equilibrium2Trait = ArmorTraitBuilder.create("vis_equilibrium");
equilibrium2Trait.color = 2852604;
equilibrium2Trait.localizedName = game.localize("e2ee.tconstruct.material.vis_equilibrium.name");
equilibrium2Trait.localizedDescription = game.localize("e2ee.tconstruct.material.vis_equilibrium.description");
equilibrium2Trait.getModifications = function(trait, player, mods, armor, damageSource, damage, index) {
  /*val x = player.getX() as float;
  val y = player.getY() as float;
  val z = player.getZ() as float;
  val pos = crafttweaker.util.Position3f.create( x, y, z) as IBlockPos;*/
  mods.effectiveness += max(3.0f,player.world.getVis(player.position)*0.01f);
  return mods;
};
equilibrium2Trait.register();


val mithrillium = ExtendedMaterialBuilder.create("Mithrillium");
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

mithrillium.addCoreMaterialStats(9.0, 27.5);
mithrillium.addPlatesMaterialStats(12.3, 12.5, 3.0);
mithrillium.addTrimMaterialStats(5);

mithrillium.itemLocalizer = function(thisMaterial, itemName){return "Mithrill " + itemName;};
mithrillium.localizedName = "Mithrillium";

mithrillium.addMaterialTrait("vis_siphon");
mithrillium.addMaterialTrait("vis_siphon","head");
mithrillium.addMaterialTrait("vis_equilibrium","head");
mithrillium.addMaterialTrait("vis_siphon_armor","core");
mithrillium.addMaterialTrait("vis_equilibrium_armor","core");
mithrillium.register();
















/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
# -------------------------------
# Adaminite
# -------------------------------

# Spin effect on player
function spin(player as IPlayer) as void {
  if (player.world.isRemote()) return;
  player.addPotionEffect(<potion:potioncore:spin>.makePotionEffect(7,1));
  player.sendStatusMessage(game.localize("warp.sword.warning"));
  return;
}

# Debuff function
function debuffenemy(target as IEntityLivingBase, warp as int) as void{
  if (target.world.isRemote()) return;
  target.addPotionEffect(<potion:minecraft:glowing>.makePotionEffect(600, 0));
  target.addPotionEffect(<potion:minecraft:wither>.makePotionEffect(600, min(3 , (warp - 50)/200 )));
    if(warp>=100){
      target.addPotionEffect(<potion:potioncore:broken_armor>.makePotionEffect(600, min(1 , (warp - 100)/500 )));
      if(warp>=300){
        target.addPotionEffect(<potion:potioncore:vulnerable>.makePotionEffect(600, min(3 , (warp - 300)/300 )));
  }}else return;

  print("wykonano funkcje deuff enemy");
  return;
}

function speakKill(player as IPlayer, world as IWorld) as void{
  val k = "warp.sword.speak.random";
  val r = world.random.nextInt(4);
  player.sendStatusMessage(game.localize(k+r));
  //player.playSound("thaumcraft:sounds/brain4.ogg", 0.5f, 0.5f);
}

val forbiddenTrait = TraitBuilder.create("forbidden");
forbiddenTrait.color = 2852604;
forbiddenTrait.localizedName = game.localize("e2ee.tconstruct.material.forbidden.name");
forbiddenTrait.localizedDescription = game.localize("e2ee.tconstruct.material.forbidden.description");

forbiddenTrait.onHit = function(trait, tool, attacker, target, damage, isCritical) {
  if(attacker instanceof IPlayer){
  val player as IPlayer = attacker;
  val warp as int = player.warpNormal + player.warpTemporary + player.warpPermanent;
    if(warp<50){
      spin(player);
      print("malo warpu");
    }else{
      debuffenemy(target, warp);
    }

    if(target.health - damage < 0){
      speakKill(player, player.world);
    }
  }
};

# Porous effect
/*
val dirt = <blockstate:thaumcraft:stone_porous>;

function blockMatch(block as IBlockState) as bool{
  val id as string = block.block.definition.id;
  return id == "minecraft:stone" || id == "minecraft:cobblestone";
  
}


function porous(player as IPlayer) as void {
  val world as IWorld = player.world;
  val x = player.getX() as float;
  val y = player.getY() as float;
  val z = player.getZ() as float;
  #val porousStone = <minecraft:dirt>.asBlock();
  for i in 0 to 5 {
    for j in 0 to 5 {
      for k in 0 to 5 {
        if(y+j- 2.0f<255 & y+j- 2.0f>1){
          val pos = crafttweaker.util.Position3f.create( x+i- 2.0f , y+j- 2.0f , z+k- 2.0f ) as IBlockPos;
          val block as IBlockState = world.getBlock(pos);
          if(blockMatch(block)){
            print("co");
            #world.setBlockState(porousStone.definition.defaultState, pos); 
          }
        }
      }
    }
  }
}

forbiddenTrait.onToolDamage = function(trait, tool, unmodifiedAmount, newAmount, holder) {
  if(holder instanceof IPlayer){
  val player as IPlayer = holder;
  porous(player);
  return newAmount;
  } else return newAmount;
};
*/
function speakRandom(player as IPlayer, world as IWorld) as void{
  val k = "warp.sword.speak.";
  val r = world.random.nextInt(4);
  player.sendStatusMessage(game.localize(k+r));
  //player.playSound("thaumcraft:sounds/brain4.ogg", 0.5f, 0.5f);
}

forbiddenTrait.onUpdate = function(trait, tool, world, owner, itemSlot, isSelected) {
  if(owner instanceof IPlayer & world.isRemote()){
    val player as IPlayer = owner;
    if(world.random.nextInt(12000)<1){
      speakRandom(player, world);
    }
  }
};

forbiddenTrait.register();





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

val gaze_trait = ArmorTraitBuilder.create("gaze");
gaze_trait.color = 11141165;
gaze_trait.localizedName = game.localize("e2ee.tconstruct.material.gaze.name");
gaze_trait.localizedDescription = game.localize("e2ee.tconstruct.material.gaze.description");
gaze_trait.onUpdate = function(trait, tool, world, owner, itemSlot, isSelected) {
  if (!isSelected) return;
  if (world.getWorldTime() % gazeUpdateTime != 0) return;
  if (! owner instanceof IPlayer) return;
  val player as IPlayer = owner;
  gazeMechanic(world, player);
};
gaze_trait.register();

val voidShell_trait = ArmorTraitBuilder.create("void_shell");
voidShell_trait.color = 11141165;
voidShell_trait.localizedName = game.localize("e2ee.tconstruct.material.void_shell.name");
voidShell_trait.localizedDescription = game.localize("e2ee.tconstruct.material.void_shell.description");
voidShell_trait.onHurt = function(trait, armor, player, source, damage, newDamage, evt) {
  if(source.trueSource instanceof IEntityLivingBase & !player.world.isRemote() & player.warpNormal + player.warpTemporary + player.warpPermanent>=100){
    val mobTrue as IEntityLivingBase = source.trueSource;
    val i = player.world.random.nextInt(4);
    if(i==0){
      mobTrue.addPotionEffect(<potion:minecraft:levitation>.makePotionEffect(100, 1));
    }
    if(i==1){
      mobTrue.addPotionEffect(<potion:minecraft:blindness>.makePotionEffect(100, 0));
    }
    if(i==2) {
      mobTrue.setInWeb();
    }
    else{
      mobTrue.knockBack(player, 5.0f, player.x-mobTrue.x, player.z-mobTrue.z);
    }
  }
  return newDamage;
};
/*
voidShell_trait.getModifications = function(trait, player, mods, armor, damageSource, damage, index) {
    val warp as float = player.warpNormal + player.warpTemporary + player.warpPermanent; 
    mods.effectiveness += max( 3.0f, warp*0.0025f);
    return mods;
};*/
voidShell_trait.register();






val adaminite = ExtendedMaterialBuilder.create("Adaminite");
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

adaminite.addCoreMaterialStats(6.0, 36.6);
adaminite.addPlatesMaterialStats(16.6, 6.6, 6.6);
adaminite.addTrimMaterialStats(6);

adaminite.itemLocalizer = function(thisMaterial, itemName){return "Adaminite " + itemName;};
adaminite.localizedName = "Adaminite";

adaminite.addMaterialTrait("forbidden","head");
adaminite.addMaterialTrait("gaze_armor","core");
adaminite.addMaterialTrait("void_shell_armor","core");

adaminite.register();









































/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
# -------------------------------
# Mithminite
# -------------------------------


val researcherTrait = TraitBuilder.create("researcher");
researcherTrait.color = 16744631;
researcherTrait.localizedName = game.localize("e2ee.tconstruct.material.researcher.name");
researcherTrait.localizedDescription = game.localize("e2ee.tconstruct.material.researcher.description");

researcherTrait.onHit = function(trait, tool, attacker, target, damage, isCritical) {
  target.addPotionEffect(<potion:potioncore:lightning>.makePotionEffect(10, 0));
  //hit with flux!

  //is Undead? BONUS DAMAGE

  //Add bonus drop
};

researcherTrait.onBlockHarvestDrops = function(trait, tool, event) {
	//DROP BONUS crystalized chunks
};
/*
researcherTrait.onUpdate = function(trait, tool, world, owner, itemSlot, isSelected) {
	//collect and update flux
  if (world.getFlux(owner.position)>1 & !world.isRemote()){
    val data = tool.tag;
    if(data){
      tool.mutable().updateTag({Flux: 0});
    }
    data=data+{Flux: data.Flux+1 };
    world.drainFlux(owner.position, 0.3f);
    tool.mutable().updateTag(data);
  }
};
*/
researcherTrait.register();




val mithminite = ExtendedMaterialBuilder.create("Mithminite");
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

mithminite.addCoreMaterialStats(14.0, 42.0);
mithminite.addPlatesMaterialStats(24.0, 42.0, 0.0);
mithminite.addTrimMaterialStats(42);

mithminite.itemLocalizer = function(thisMaterial, itemName){return "Mithminite " + itemName;};
mithminite.localizedName = "Mithminite";

mithminite.addMaterialTrait("researcher","head");

mithminite.register();

/*
<enderio:item_soul_vial:1>.withTag(
  {entityId: "minecraft:zombie",

  entity: {
    HurtByTimestamp: 0,

    ForgeData: {
      "scalinghealth:difficulty": 252 as short, excompressum: {NoCompress: 1 as byte},
      "Potion Core - Health Fix": 188.51987 as float,
      "Potion Core - Jump Boost Updated": 1 as byte,
      HungerOverhaulCheck: 6
    },

    RelativeAABB: [-0.30000001192092896, 0.0, -0.30000001192092896, 0.30000001192092896, 1.9500000476837158, 0.30000001192092896],

    Attributes: [{Base: -2.0, Modifiers: [{UUIDMost: 2189974539282499591 as long, UUIDLeast: -6477178668949725305 as long, Amount: 1.0, Operation: 0, Name: "normal"}],
      Name: "tc.mobmod"}, {Base: 0.0, Name: "tc.mobmodtaint"}, {Base: 1.0, Name: "potioncore.projectileDamage"},
      {Base: 1.0, Name: "potioncore.magicDamage"},
      {Base: 1.0, Name: "potioncore.jumpHeight"},
      {Base: 1.0, Name: "potioncore.damageResistance"},
      {Base: 0.0, Name: "potioncore.magicShielding"},
      {Base: 0.05, Name: "tconevo.flightSpeed"}, {Base: 1.0, Name: "tconevo.damageTaken"},
      {Base: 1.0, Name: "tconevo.evasionChance"},
      {Base: 20.0, Modifiers: [{UUIDMost: -4557935957806527035 as long, UUIDLeast: -4950522221421205810 as long, Amount: 8.425992965698242, Operation: 1, Name: "ScalingHealth.HealthModifier"}], Name: "generic.maxHealth"},
      {Base: 0.0, Modifiers: [{UUIDMost: 536379819591615452 as long, UUIDLeast: -9190709600305771094 as long, Amount: 0.007420447987122287, Operation: 0, Name: "Random spawn bonus"}], Name: "generic.knockbackResistance"},
      {Base: 0.23000000417232513, Name: "generic.movementSpeed"},
      {Base: 2.0, Name: "generic.armor"},
      {Base: 0.0, Name: "generic.armorToughness"}, {Base: 1.0, Name: "forge.swimSpeed"},
      {Base: 35.0, Modifiers: [{UUIDMost: 186899165940435936 as long, UUIDLeast: -6890417367074505433 as long, Amount: 0.03313183418661442, Operation: 1, Name: "Random spawn bonus"}], Name: "generic.followRange"},
      {Base: 3.0, Modifiers: [{UUIDMost: -3218372695593237220 as long, UUIDLeast: -8743736172551149415 as long, Amount: 3.5494492053985596, Operation: 0, Name: "ScalingHealth.DamageModifier"}], Name: "generic.attackDamage"},
      {Base: 0.0840110647417053, Name: "zombie.spawnReinforcements"}],

    Invulnerable: 0 as byte,
    FallFlying: 0 as byte,
    PortalCooldown: 0,
    AbsorptionAmount: 0.0 as float,
    FallDistance: 0.0 as float,
    DeathTime: 0 as short,
    ForgeCaps: {
      "plethora:disableai": {}, "betterhurttimer:hurt": {ticksToShieldDamage: 0, ticksToArmorDamage: 0},
      "nuclearcraft:capability_entity_rads": {consumed: 0 as byte, radawayBuffer: 0.0, shouldWarn: 0 as byte, radXUsed: 0 as byte, poisonBuffer: 0.0, radXCooldown: 0.0, radXWoreOff: 0 as byte, radawayCooldown: 0.0, recentRadawayAddition: 0.0, maxRads: 1000.0, setMaxRads: 1 as byte, radawayBufferSlow: 0.0, externalRadiationResistance: 0.0, messageCooldownTime: 0, totalRads: 0.015512127633756015, radiationLevel: 1.690571818847032E-5, recentPoisonAddition: 0.0, recentRadXAddition: 0.0, radiationImmunityStage: 0 as byte, giveGuidebook: 0 as byte, internalRadiationResistance: 0.0, radiationImmunityTime: 0.0},
      "tinkertoolleveling:entityxp": [],
      "llibrary:extendedentitydatacapability": {
        "Ice And Fire - Siren Property Tracker": {CharmedBySiren: 0 as byte, SirenID: 0},
        "Ice And Fire - Frozen Property Tracker": {TicksUntilUnfrozen: 0, IsFrozen: 0 as byte},
        "Ice and Fire - Player Property Tracker": {DismountedDragon: 0 as byte, GauntletDamage: 0, DreadPortalZ: 0, DreadPortalY: 0, DreadPortalX: 0},
        "Ice And Fire - Chain Property Tracker": {ConnectedEntities: []},
        "Ice And Fire - Stone Property Tracker": {StoneBreakLvl: 0, TurnedToStone: 0 as byte}
      },
      "twilightforest:cap_shield": {permshields: 0, tempshields: 0},
      "thaumicaugmentation:portal_state": {inPortal: 0 as byte}
    },

    HandDropChances: [0.085 as float, 0.085 as float],
    PersistenceRequired: 0 as byte, id: "minecraft:zombie",
    Motion: [0.0, -0.0784000015258789, 0.0],
    Leashed: 0 as byte,
    UUIDLeast: -9044928370786251929 as long,
    Health: 188.51987 as float,
    LeftHanded: 0 as byte,
    Air: 300 as short,
    OnGround: 1 as byte, Dimension: 0,
    Rotation: [-149.6732 as float, 3.6092982 as float],
    UpdateBlocked: 0 as byte,
    HandItems: [{}, {}],
    ArmorDropChances: [0.085 as float, 0.085 as float, 0.085 as float, 0.085 as float],
    UUIDMost: -1716941176686949392 as long,
    Pos: [-1044.5, 91.0, -1022.168150844842],
    CanBreakDoors: 0 as byte,
    Fire: -1 as short,
    ArmorItems: [{}, {}, {}, {}],
    CanPickUpLoot: 0 as byte,
    HurtTime: 0 as short,
    AABB: [-1044.800000011921, 91.0, -1022.4681508567629, -1044.199999988079, 92.95000004768372, -1021.8681508329211],

    ActiveEffects: [
      {Ambient: 1 as byte, CurativeItems: [], ShowParticles: 1 as byte, Duration: 149, Id: 44, Amplifier: 2 as byte},
      {Ambient: 0 as byte, CurativeItems: [{id: "minecraft:milk_bucket", Count: 1, Damage: 0 as short}], ShowParticles: 1 as byte, Duration: 98, Id: 43, Amplifier: 0 as byte}]
    }
  }
);
*/
