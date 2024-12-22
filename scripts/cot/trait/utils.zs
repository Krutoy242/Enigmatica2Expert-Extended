#loader contenttweaker
#priority 100

import crafttweaker.entity.IEntityEquipmentSlot;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;

function getItemMatAmount(item as IItemStack, lookup as string, durabLeft as int = -1) as int {
  if (
    isNull(item)
    || isNull(item.tag)
    || isNull(item.tag.TinkerData)
    || isNull(item.tag.TinkerData.Materials)
    || isNull(item.tag.TinkerData.Materials.asList())
  ) return 0;
  if (item.maxDamage - item.damage <= durabLeft) return 0;

  var level = 0;
  for i, name in item.tag.TinkerData.Materials.asList() {
    if (name == lookup) level += 1;
  }
  return level;
}

static armSlots as IEntityEquipmentSlot[] = [
  head, chest, legs, feet,
] as IEntityEquipmentSlot[];

function getArmorMatsAmount(player as IPlayer, lookup as string, durabLeft as int = -1) as int {
  var level = 0;
  for slot in armSlots {
    level += getItemMatAmount(player.getItemInSlot(slot), lookup, durabLeft);
  }
  return level;
}
