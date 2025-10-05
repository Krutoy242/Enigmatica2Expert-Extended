#modloaded zentoolforge
#reloadable

import crafttweaker.data.IData;
import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityEquipmentSlot;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.item.IItemDefinition;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IWorld;
import crafttweaker.util.Math.abs;
import crafttweaker.util.Math.max;
import crafttweaker.util.Math.min;
import mods.zentoolforge.Toolforge;
import modtweaker.tconstruct.ITICMaterial;
import native.net.silentchaos512.scalinghealth.config.Config.Difficulty;

static DEFAULT_EQUIP_CHANCE as double = 0.8; // Chance that mob will have at least 1 item
static OVERWORLD_EQUIP_CHANCE as double = 0.8; // Chance modifier for Overworld
static NEXT_EQUIP_CHANCE as double = 0.35; // Reroll addition for next equipment slot

// Prepare materials for usage
static normDefs as IData[string] = {
  armor: [],
  tool : [],
} as IData[string];

static blacklistedMaterials as string[] = [
  'paper',
  'chocolate',
  'ma.superium',
  'ma.supremium',
  'spectre',
  'draconic_metal',
  'neutronium',
  'aethium',
  'chaotic_metal',
  'infinity_metal',
];

function normalizeDefaultList(list as int[string], field as string) as void {
  for matName, _ in list {
    if (blacklistedMaterials has matName) continue;
    if (isNull(Toolforge.getMaterialFromID(matName))) continue;
    normDefs[field] = normDefs[field] + [matName] as IData;
  }
}

normalizeDefaultList(scripts.equipment.equipData.defaultArmorMats, 'armor');
normalizeDefaultList(scripts.equipment.equipData.defaultWeaponMats, 'tool');

// -------------------------------
// SLOTS
// -------------------------------
static slots as IEntityEquipmentSlot[] = [
  head,
  chest,
  legs,
  feet,
  mainHand,
  offhand,
] as IEntityEquipmentSlot[];

function rnd_qubic(w as IWorld) as double { val a as double = w.random.nextDouble(); return a * a * a; }
function dataOrData(a as IData, b as IData) as IData { return isNull(a) ? b : a; }
function pick_qubic(list as IData, w as IWorld) as string { return list[(rnd_qubic(w) * list.length) as int].asString(); }
function pick_qubic_adv(list as IData, d as double, w as IWorld) as string {
  // val _min = max(0, min(list.length - 4, list.length * pow(d, 2.0d)) - shift);
  // val index = (abs(a*a*a) * (list.length - _min) + _min) as int;
  val a = w.random.nextDouble();
  val b = abs(pow(a, 4.0 * pow(1.1 - d, 2)));
  val index = (min(0.9999, max(0.0, b)) * list.length) as int;
  return list[index].asString();
}

function rndToolPart(_mats as IData, d as double, forWeapon as bool, w as IWorld) as ITICMaterial {
  val defaults = forWeapon
    ? normDefs.tool
    : normDefs.armor;
  var i = 0;
  val mats = dataOrData(_mats, defaults);
  var matName = pick_qubic_adv(mats, d, w);
  if (!isNull(_mats)) {
    while i < 20 && !(defaults has matName) {
      matName = pick_qubic_adv(mats, d, w);
      i += 1;
    }
  }

  var mat = Toolforge.getMaterialFromID(matName);
  while i < 100 && isNull(mat) {
    matName = pick_qubic_adv(mats, d, w);
    mat = Toolforge.getMaterialFromID(matName);
    i += 1;
  }
  return mat;
}

function getFourRandomTicMats(listTicmats as IData, difficulty as double, forWeapon as bool, w as IWorld) as ITICMaterial[] {
  return [
    rndToolPart(listTicmats, difficulty, forWeapon, w),
    rndToolPart(listTicmats, difficulty, forWeapon, w),
    rndToolPart(listTicmats, difficulty, forWeapon, w),
    rndToolPart(listTicmats, difficulty, forWeapon, w),
  ] as ITICMaterial[];
}

// Create random equipment
function buildTiCTool(matList as ITICMaterial[], def as IItemDefinition) as IItemStack {
  if (!isNull(matList[0]) && !isNull(matList[1]) && !isNull(matList[2]) && !isNull(matList[3])) {
    val len = scripts.equipment.equipData.getMatsRequired(def.id);
    return len == 2
      ? Toolforge.buildTool(def, matList[0], matList[1])
      : len == 3
        ? Toolforge.buildTool(def, matList[0], matList[1], matList[2])
        : Toolforge.buildTool(def, matList[0], matList[1], matList[2], matList[3])
    ;
  }
  return null;
}

function getWeightedGroup(entry as IData, w as IWorld) as IData {
  if (isNull(entry.groups.asList())) return entry.groups;
  if (entry.groups.length == 1) return entry.groups[0];

  val norm = scripts.equipment.equipData.normalizedWeights[entry];
  val rnd = w.random.nextDouble();
  for i, pos in norm {
    if (rnd < pos) return entry.groups[i];
  }
  return entry.groups[0];
}

function getEquipCount(isOverworld as bool, difficulty as double, w as IWorld) as int {
  // Calculate probabilities
  // bigger number - less chance
  // ~30% more armor in other dimensions than Overworld
  val tolerance = DEFAULT_EQUIP_CHANCE * (isOverworld ? 1.0 : OVERWORLD_EQUIP_CHANCE) / (1.0 + pow(difficulty, 2) * 4.0);
  var currProb = w.random.nextDouble();
  var maxEquips = 0;
  for i in 0 .. 6 {
    if (currProb < tolerance) break;
    currProb *= min(w.random.nextDouble() + NEXT_EQUIP_CHANCE, 1.0);
    maxEquips += 1;
  }
  return maxEquips;
}

function addRandomModifiers(item as IItemStack, isArmor as bool, w as IWorld) as IItemStack {
  var picked = [] as string[];
  var equip = item;
  for i in 0 .. ((rnd_qubic(w) * 5.0 + 1.0) as int) {
    var mod as string = null;
    var antiloop = 0;
    while picked has mod && antiloop < 100 {
      mod = pick_qubic(isArmor
        ? scripts.equipment.utils_tcon.allArmorModifiers
        : scripts.equipment.utils_tcon.allToolModifiers,
      w);
      antiloop += 1;
    }
    picked += mod;
    equip = scripts.equipment.utils_tcon.addModifier(equip, mod);
  }
  return equip;
}

function getDifficulty(entity as IEntity) as double {
  val area = Difficulty.AREA_DIFFICULTY_MODE.getAreaDifficulty(entity.world, entity.position);
  return area / Difficulty.maxValue;
}

// Generate equipmnts
function equipEntity(iGroup as IData, entity as IEntityLivingBase, world as IWorld) as void {
  val difficulty = getDifficulty(entity);

  val maxEquips = getEquipCount(world.dimension == 0, difficulty, world);
  if (maxEquips < 1) return;

  // Pick tier
  val currGroup = getWeightedGroup(iGroup, world);
  val randTicMatsWeapn = getFourRandomTicMats(currGroup.ticMats, difficulty, true, world);
  val randTicMatsArmor = maxEquips > 1 ? getFourRandomTicMats(currGroup.ticMats, difficulty, false, world) : null;

  val equipSequence = [4, 1, 2, 3, 0, 5] as int[];
  for j in 0 .. maxEquips {
    val i = equipSequence[j]; // Change sequence
    if (i == 5) continue; // Skip Offhand

    val isArmor = i <= 3; // True for armor, false for tool

    // Find equipment type
    var equipID as string = null;
    if (isArmor) {
      equipID = scripts.equipment.equipData.armDefinitions[i][0];
    }
    else {
      if (isNull(currGroup.ticWeapons)) continue;
      val weapon = pick_qubic(currGroup.ticWeapons, world);
      equipID = (!weapon.contains(':') ? 'tconstruct:' : '') ~ weapon;
    }
    val equipBase = itemUtils.getItem(equipID);
    if (isNull(equipBase)) {
      // logger.logWarning("equipGeneration.zs: trying to equip non-existent tool <" ~ equipID ~ ">");
      continue;
    }

    // Build tool/armor piece
    var equip = buildTiCTool(
      isArmor ? randTicMatsArmor : randTicMatsWeapn,
      equipBase.definition
    );

    // Equip is invalid, skip
    if (isNull(equip)) continue;

    // Add TconEvo "Artifact" modifier (ask for Unsealing to modify)
    equip = equip.withTag(scripts.equipment.utils_tcon.addSingleModifier(equip.tag, 'tconevo.artifact'));

    // Other random mods
    if (world.random.nextDouble() < difficulty + 0.25) equip = addRandomModifiers(equip, isArmor, world);

    // Damage item
    if (equip.isDamageable) {
      val rndDamage = (0.35 + world.random.nextDouble() / 2.0) * equip.maxDamage;
      val dmg = min(32766, max(1, rndDamage as int));
      equip = equip.withDamage(dmg);
    }

    entity.setItemToSlot(slots[i], equip);
  }
}

// -------------------------------
// Spawn Event
// -------------------------------

// Search armorEntitys for entity ID
function getGroup(entity as string) as IData {
  for group in scripts.equipment.equipData.armorEntitys.asList() {
    for i in 0 .. group.entityID.length {
      if (entity == group.entityID[i].asString()) {
        return group;
      }
    }
  }
  return null;
}

function onSpawnEvent(e as crafttweaker.event.EntityJoinWorldEvent) as void {
  if (e.world.remote || !(e.entity instanceof IEntityLivingBase)) return;
  val entity as IEntityLivingBase = e.entity;

  if (isNull(e.entity.definition) || isNull(e.entity.definition.id)) return;
  val iGroup = getGroup(entity.definition.id);

  if (isNull(iGroup) || isNull(iGroup.groups)) return;
  equipEntity(iGroup, entity, e.world);
}

// -------------------------------
// Hook on events
// -------------------------------
events.onEntityJoinWorld(function (event as crafttweaker.event.EntityJoinWorldEvent) {
  onSpawnEvent(event);
});
