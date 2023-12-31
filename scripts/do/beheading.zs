/*

Copy Beheading enchantment behaviour (Cyclic) for TCon tools.

https://github.com/Lothrazar/Cyclic/blob/trunk/1.12/src/main/java/com/lothrazar/cyclicmagic/enchant/EnchantBeheading.java

*/

#reloadable

import crafttweaker.entity.IEntityDefinition;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.item.IItemStack;

static entityToSkin as string[IEntityDefinition] = {
  <entity:minecraft:blaze>         : 'MHF_Blaze',
  <entity:minecraft:cave_spider>   : 'MHF_CaveSpider',
  <entity:minecraft:chicken>       : 'MHF_Chicken',
  <entity:minecraft:cow>           : 'MHF_Cow',
  <entity:minecraft:elder_guardian>: 'MHF_Guardian',
  <entity:minecraft:enderman>      : 'MHF_Enderman',
  <entity:minecraft:endermite>     : 'MHF_Endermite',
  <entity:minecraft:ghast>         : 'MHF_Ghast',
  <entity:minecraft:guardian>      : 'MHF_Guardian',
  <entity:minecraft:iron_golem>    : 'MHF_Golem',
  <entity:minecraft:magma_cube>    : 'MHF_LavaSlime',
  <entity:minecraft:mooshroom>     : 'MHF_MushroomCow',
  <entity:minecraft:ocelot>        : 'MHF_Ocelot',
  <entity:minecraft:pig>           : 'MHF_Pig',
  <entity:minecraft:pig_zombie>    : 'MHF_PigZombie',
  <entity:minecraft:sheep>         : 'MHF_Sheep',
  <entity:minecraft:silverfish>    : 'MHF_Silverfish',
  <entity:minecraft:slime>         : 'MHF_Slime',
  <entity:minecraft:snowman>       : 'MHF_SnowGolem',
  <entity:minecraft:spider>        : 'MHF_Spider',
  <entity:minecraft:squid>         : 'MHF_Squid',
  <entity:minecraft:villager>      : 'MHF_Villager',
  <entity:minecraft:witch>         : 'MHF_Witch',
  <entity:minecraft:wolf>          : 'MHF_Wolf',
} as string[IEntityDefinition];

static entityToTag as string[][IEntityDefinition] = {
  <entity:minecraft:zombie_villager>: ['Zombie Villager', 'af249a67-e184-4c02-8b72-521fbcd89686', 'eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvY2ZmMDQ4MmZkMzJmYWIyY2U5ZjVmYTJlMmQ5YjRkYzc1NjFkYTQyMjE1MmM5OWZjODA0YjkxMzljYWYyNTZiIn19fQ=='],
  <entity:minecraft:vindicator>     : ['Vindicator'     , '06505ad7-5132-4ba9-a6c1-af81d06be308', 'eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTAwZDNmZmYxNmMyZGNhNTliOWM1OGYwOTY1MjVjODY5NzExNjZkYmFlMTMzYjFiMDUwZTVlZTcxNjQ0MyJ9fX0='],
  <entity:minecraft:evoker>         : ['Evoker'         , '08e26a19-3672-4356-b21d-d9e831145279', 'eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTAwZDNmZmYxNmMyZGNhNTliOWM1OGYwOTY1MjVjODY5NzExNjZkYmFlMTMzYjFiMDUwZTVlZTcxNjQ0MyJ9fX0='],
  <entity:minecraft:shulker>        : ['Shulker'        , '478e38c8-47e5-4d23-b094-b232e7126521', 'eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZDhmYjk2YmY0YTlhMzFiMjU1MzhiNzEyMTdkYThiNjM0ZThjMDVkNGMzNWE2YWI4N2FjYjM3ZjkzYTZmMmMifX19'],
  <entity:minecraft:rabbit>         : ['Rabbit'         , 'e11c58cf-fbcc-4c27-9b8d-90fbb1994e41', 'eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZGM3YTMxN2VjNWMxZWQ3Nzg4Zjg5ZTdmMWE2YWYzZDJlZWI5MmQxZTk4NzljMDUzNDNjNTdmOWQ4NjNkZTEzMCJ9fX0='],
  <entity:minecraft:polarBear>      : ['Polar Bear'     , 'c7ed0da7-c4fb-4cea-97d9-3b21c1716970', 'eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZDQ2ZDIzZjA0ODQ2MzY5ZmEyYTM3MDJjMTBmNzU5MTAxYWY3YmZlODQxOTk2NjQyOTUzM2NkODFhMTFkMmIifX19'],
  <entity:minecraft:wither>         : ['Wither'         , '6e5f307d-0a67-4736-8060-7baa2df1877e', 'eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNGNmMWIzYjNmNTM5ZDJmNjNjMTcyZTk0Y2FjZmFhMzkxZThiMzg1Y2RkNjMzZjNiOTkxYzc0ZTQ0YjI4In19fQ=='],
  <entity:minecraft:llama>          : ['Llama'          , '04eec3c8-a65b-496a-8b20-0fbfe3f352ec', 'eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYzJiMWVjZmY3N2ZmZTNiNTAzYzMwYTU0OGViMjNhMWEwOGZhMjZmZDY3Y2RmZjM4OTg1NWQ3NDkyMTM2OCJ9fX0='],
  <entity:minecraft:bat>            : ['Bat'            , '82224cdb-5c6b-47cd-98a6-f97003db2ed3', 'eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgyZmMzZjcxYjQxNzY5Mzc2YTllOTJmZTNhZGJhYWMzNzcyYjk5OWIyMTljOWQ2YjQ2ODBiYTk5ODNlNTI3In19fQ=='],
  <entity:minecraft:horse>          : ['Horse'          , '1e55cd38-b197-4179-8081-01986f3c50a7', 'eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTk5NjM5OWZmZjljYmNmYjdiYTY3N2RkMGMyZDEwNDIyOWQxY2MyMzA3YTZmMDc1YTg4MmRhNDY5NGVmODBhZSJ9fX0='],
  <entity:minecraft:skeleton_horse> : ['Skeleton Horse' , 'bcbce5bf-86c4-4e62-9fc5-0cc90de94b6d', 'eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNDdlZmZjZTM1MTMyYzg2ZmY3MmJjYWU3N2RmYmIxZDIyNTg3ZTk0ZGYzY2JjMjU3MGVkMTdjZjg5NzNhIn19fQ=='],
  <entity:minecraft:zombie_horse>   : ['Zombie Horse'   , 'ab9ea02c-4fd1-4895-85c9-d2b407d5d6f2', 'eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZDIyOTUwZjJkM2VmZGRiMThkZTg2ZjhmNTVhYzUxOGRjZTczZjEyYTZlMGY4NjM2ZDU1MWQ4ZWI0ODBjZWVjIn19fQ=='],
} as string[][IEntityDefinition];

function getSkullByName(skinName as string) as IItemStack {
  return <minecraft:skull:3>.withTag({ SkullOwner: skinName });
}

function getSkullByTag(skinTags as string[]) as IItemStack {
  if (skinTags.length < 3) return null;
  return <minecraft:skull:3>.withTag({
    display   : { Name: (skinTags[0] + ' Head') },
    SkullOwner: {
      Id        : skinTags[1],
      Properties: { textures: [{ Value: skinTags[2] }] },
    } });
}

// Seems like, adding mob heads causing HEI to freeze for several seconds to download heads
// for entityDef, skinName in entityToSkin { mods.jei.JEI.addItem(getSkullByName(skinName)); }
// for entityDef, skinTags in entityToTag { mods.jei.JEI.addItem(getSkullByTag(skinTags)); }

events.onEntityLivingDeathDrops(function (e as crafttweaker.event.EntityLivingDeathDropsEvent) {
  if (e.entity.world.remote) return;

  // Check if this entity is living
  if (!(e.entity instanceof IEntityLivingBase)) return;
  val entity as IEntityLivingBase = e.entity;
  if (isNull(entity.definition)) return;

  // Check if killer have tools
  if (
    isNull(e.damageSource.trueSource)
    || isNull(e.damageSource.trueSource.heldEquipment)
    || e.damageSource.trueSource.heldEquipment.length <= 0
  ) return;
  val equipmentList = e.damageSource.trueSource.heldEquipment;

  // Check if dead entity is in list
  val skinName = entityToSkin[entity.definition];
  var skinTags as string[] = null;
  if (isNull(skinName)) skinTags = entityToTag[entity.definition];
  if (isNull(skinName) && isNull(skinTags)) return;

  // Compute beheading level
  var beheadingLevel = 0;
  for i, tool in equipmentList {
    if (isNull(tool)) continue;
    if (
      tool.definition.owner != 'tconstruct'
      || isNull(tool.tag)
      || isNull(tool.tag.Modifiers)
    ) continue;

    for i, modifier in tool.tag.Modifiers.asList() {
      if (
        isNull(modifier.identifier)
        || isNull(modifier.level)
        || (modifier.identifier.asString() != 'beheading'
        && modifier.identifier.asString() != 'beheading_cleaver')
      ) continue;
      beheadingLevel += modifier.level.asInt();
    }
  }

  // Roll random
  if (beheadingLevel <= 0) return;
  if (e.entity.world.random.nextInt(10) > beheadingLevel) return;

  // Add head to drop list
  if (!isNull(skinName)) {
    e.addItem(getSkullByName(skinName));
  }
  else {
    e.addItem(getSkullByTag(skinTags));
  }
});
