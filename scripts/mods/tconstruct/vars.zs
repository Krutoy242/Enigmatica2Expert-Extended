#modloaded tconstruct
#priority 2000
#reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

function getSampleToolPart(baseId as string) as IItemStack {
  val materialName
    = baseId == 'tconstruct:arrow_shaft'
      ? 'wood'
      : baseId == 'tconstruct:bow_string'
        ? 'string'
        : baseId == 'tconstruct:fletching'
          ? 'feather'
          : 'stone';
  return itemUtils.getItem(baseId).withTag({ Material: materialName });
}

static armors as IIngredient
  = <conarm:helmet:*>
  | <conarm:boots:*>
  | <conarm:chestplate:*>
  | <conarm:leggings:*>
;

static tools as IIngredient
  = <exnihilocreatio:crook_tconstruct:*>
  | <plustic:laser_gun:*>
  | <plustic:katana:*>
  | <tcomplement:chisel:*>
  | <tcomplement:sledge_hammer:*>
  | <tconevo:tool_sceptre:*>
  | <tconstruct:arrow:*>
  | <tconstruct:battlesign:*>
  | <tconstruct:bolt:*>
  | <tconstruct:broadsword:*>
  | <tconstruct:cleaver:*>
  | <tconstruct:crossbow:*>
  | <tconstruct:excavator:*>
  | <tconstruct:frypan:*>
  | <tconstruct:hammer:*>
  | <tconstruct:hatchet:*>
  | <tconstruct:kama:*>
  | <tconstruct:longbow:*>
  | <tconstruct:longsword:*>
  | <tconstruct:lumberaxe:*>
  | <tconstruct:mattock:*>
  | <tconstruct:pickaxe:*>
  | <tconstruct:rapier:*>
  | <tconstruct:scythe:*>
  | <tconstruct:shortbow:*>
  | <tconstruct:shovel:*>
  | <tconstruct:shuriken:*>
;

static allTconEquipment as IIngredient = armors | tools;
