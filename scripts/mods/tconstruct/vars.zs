#modloaded tconstruct
#priority 2000
#reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

static partCosts as double[string]$orderly = {
  'conarm:armor_plate'          : 3.0,
  'conarm:armor_trim'           : 1.0,
  'conarm:boots_core'           : 4.0,
  'conarm:chest_core'           : 6.0,
  'conarm:helmet_core'          : 4.0,
  'conarm:leggings_core'        : 5.0,
  'conarm:polishing_kit'        : 2.0,
  'plustic:battery_cell'        : 3.0,
  'plustic:laser_medium'        : 3.0,
  'plustic:pipe_piece'          : 4.0,
  'tcomplement:chisel_head'     : 1.0,
  'tcomplement:sledge_head'     : 2.0,
  'tconevo:part_arcane_focus'   : 9.0,
  'tconstruct:arrow_head'       : 2.0,
  'tconstruct:arrow_shaft'      : 2.0,
  'tconstruct:axe_head'         : 2.0,
  'tconstruct:binding'          : 1.0,
  'tconstruct:bow_limb'         : 3.0,
  'tconstruct:bow_string'       : 1.0,
  'tconstruct:broad_axe_head'   : 8.0,
  'tconstruct:cross_guard'      : 1.0,
  'tconstruct:excavator_head'   : 8.0,
  'tconstruct:fletching'        : 2.0,
  'tconstruct:hammer_head'      : 8.0,
  'tconstruct:hand_guard'       : 1.0,
  'tconstruct:kama_head'        : 2.0,
  'tconstruct:knife_blade'      : 1.0,
  'tconstruct:large_plate'      : 8.0,
  'tconstruct:large_sword_blade': 8.0,
  'tconstruct:pan_head'         : 3.0,
  'tconstruct:pick_head'        : 2.0,
  'tconstruct:scythe_head'      : 8.0,
  'tconstruct:shard'            : 0.5,
  'tconstruct:sharpening_kit'   : 2.0,
  'tconstruct:shovel_head'      : 2.0,
  'tconstruct:sign_head'        : 3.0,
  'tconstruct:sword_blade'      : 2.0,
  'tconstruct:tool_rod'         : 1.0,
  'tconstruct:tough_binding'    : 3.0,
  'tconstruct:tough_tool_rod'   : 3.0,
  'tconstruct:wide_guard'       : 1.0,
} as double[string]$orderly;

function getSampleToolPart(baseId as string) as IItemStack {
  val materialName =
        baseId == 'tconstruct:arrow_shaft' ? 'wood'
      : baseId == 'tconstruct:bow_string' ? 'string'
      : baseId == 'tconstruct:fletching' ? 'feather'
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
