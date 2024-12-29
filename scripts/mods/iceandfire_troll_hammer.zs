#modloaded iceandfire harvestcraft
#reloadable

import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.item.IItemDefinition;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Position3f;
import crafttweaker.world.IWorld;
import native.net.minecraft.init.SoundEvents;
import native.net.minecraft.util.SoundCategory;

static groundOutputMultiply as double = 4.0;

static groundRecipes as IItemStack[IItemStack] = {
  <minecraft:beef>              : <harvestcraft:groundbeefitem>,
  <minecraft:chicken>           : <harvestcraft:groundchickenitem>,
  <harvestcraft:duckrawitem>    : <harvestcraft:groundduckitem>,
  <minecraft:fish>              : <harvestcraft:groundfishitem>,
  <minecraft:mutton>            : <harvestcraft:groundmuttonitem>,
  <minecraft:porkchop>          : <harvestcraft:groundporkitem>,
  <minecraft:rabbit>            : <harvestcraft:groundrabbititem>,
  <harvestcraft:turkeyrawitem>  : <harvestcraft:groundturkeyitem>,
  <harvestcraft:venisonrawitem> : <harvestcraft:groundvenisonitem>,
  <twilightforest:raw_venison>  : <harvestcraft:groundvenisonitem>,
  <betteranimalsplus:venisonraw>: <harvestcraft:groundvenisonitem>,
} as IItemStack[IItemStack];

static groundTools as IItemDefinition[] = [
  <iceandfire:troll_weapon.axe>.definition,
  <iceandfire:troll_weapon.column>.definition,
  <iceandfire:troll_weapon.column_forest>.definition,
  <iceandfire:troll_weapon.column_frost>.definition,
  <iceandfire:troll_weapon.hammer>.definition,
  <iceandfire:troll_weapon.trunk>.definition,
  <iceandfire:troll_weapon.trunk_frost>.definition,
] as IItemDefinition[];

function squash(world as IWorld, pos as Position3f) as void {
  world.native.playSound(null, pos.asBlockPos(), SoundEvents.ENTITY_SLIME_JUMP, SoundCategory.AMBIENT, 2.0, 1.0);

  val worldServer = world.native as native.net.minecraft.world.WorldServer;
  worldServer.spawnParticle(
    native.net.minecraft.util.EnumParticleTypes.ITEM_CRACK,
    pos.x as double, pos.y as double + 0.5, pos.z as double,
    20, 0.3, 0.3, 0.3, 0.04, 214
  );
}

events.register(function (e as crafttweaker.event.EntityLivingDeathDropsEvent) {
  if (e.entity.world.remote || !(e.entity instanceof IEntityLivingBase)) return;
  val entity as IEntityLivingBase = e.entity;
  if (isNull(entity.definition)) return;
  val world = entity.world;
  val position = entity.position3f;

  // Check if killer have tools
  if (
    isNull(e.damageSource.trueSource)
    || isNull(e.damageSource.trueSource.heldEquipment)
    || e.damageSource.trueSource.heldEquipment.length <= 0
  ) {
    return;
  }

  // Check if tools matched list
  var matched = false;
  for i, tool in e.damageSource.trueSource.heldEquipment {
    if (isNull(tool)) continue;
    val toolPure = tool.definition.makeStack(0);
    if (groundTools has tool.definition) {
      matched = true;
      break;
    }
  }
  if (!matched) return;

  // Check if drops have one of the recipe items
  matched = false;
  for item in e.drops {
    if (!isNull(groundRecipes[item.item.anyAmount()])) {
      matched = true;
      break;
    }
  }
  if (!matched) return;

  // Replace drops based on recipes
  matched = false;
  for i, item in e.drops {
    val replace = groundRecipes[item.item.anyAmount()];
    if (isNull(replace)) continue;
    item.setItem(replace * (item.item.amount * groundOutputMultiply));
    matched = true;
  }

  if (matched) {
    squash(world, position);
    world.catenation()
      .sleep(1).then(function (world, ctx) { squash(world, position); })
      .sleep(1).then(function (world, ctx) { squash(world, position); })
      .start();
  }
});
