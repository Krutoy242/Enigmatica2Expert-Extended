#modloaded zentoolforge tconevo
#priority 5
#reloadable

// ######################################################################
//
//  Random modifier engine for mob gear (TCon / Construct's Armory / TconEvo)
//
//  Everything here is driven by native introspection — no hard-coded
//  per-modifier slot/level/energy lists. Pipeline (see generateModifiers):
//    1. Build the per-piece pool of *actually applicable* modifiers via the
//       native IModifier.canApply (honours slot, category, compatibility).   [#1]
//    2. Spend a difficulty-scaled "points" budget on that pool, Warhammer
//       army-building style (cheap spam vs few god-tier).                     [#5]
//    3. Apply each pick with a random number of extra levels.                [#2]
//    4. Fill backpack/belt inventories with difficulty-scaled loot.          [#4]
//    5. Level up Draconic-Evolution upgrades on DE-material gear.            [#7]
//    6. Inject Forge/EU energy into anything that became chargeable.         [#6]
//  No modifiers at difficulty 0.0; loads (>=MIN_AT_FULL) at 1.0.            [#3]
//
// ######################################################################

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IWorld;
import crafttweaker.util.Math.max;
import crafttweaker.util.Math.min;

import native.net.minecraft.item.ItemStack;
import native.net.minecraft.nbt.NBTTagList;
import native.net.minecraft.nbt.NBTTagCompound;
import native.net.minecraftforge.items.ItemStackHandler;
import native.slimeknights.tconstruct.library.TinkerRegistry;
import native.slimeknights.tconstruct.library.modifiers.IModifier;
import native.slimeknights.tconstruct.library.traits.ITrait;
import native.slimeknights.tconstruct.library.utils.TagUtil;
import native.slimeknights.tconstruct.library.utils.TinkerUtil;
import native.slimeknights.tconstruct.library.utils.ToolHelper;
import native.xyz.phanta.tconevo.util.ToolUtils;
import native.xyz.phanta.tconevo.capability.PowerWrapper;
import native.xyz.phanta.tconevo.trait.base.IncrementalModifier;
import native.xyz.phanta.tconevo.trait.draconicevolution.DraconicTieredModifier;

// -------------------------------
// Tuning
// -------------------------------
static MAX_MODS          as int    = 12;   // hard cap on number of distinct modifiers
static MIN_AT_FULL       as int    = 6;    // guaranteed modifier count at difficulty 1.0       [#3]
static FILTER_BUDGET     as int    = 64;   // free modifiers granted on the scratch copy while filtering
static MAX_EXTRA_LEVELS  as int    = 50;   // extra applications a leveled modifier may gain     [#2]
static BUDGET_POW        as double = 8.0;  // budget = topCost * difficulty^BUDGET_POW
static UNLOCK_POW        as double = 1.2;  // modifier eligible when difficulty >= (cost/topCost)^(1/UNLOCK_POW)
static MIN_ENERGY_FRAC   as double = 0.1;  // always charge >=10% so the energy bar is visible    [#6]

// -------------------------------
// Random helpers
// -------------------------------
function rndCube(w as IWorld) as double { val a as double = w.random.nextDouble(); return a * a * a; }

// Difficulty-weighted index into an ordered (common -> rare) list of length `len`.
function weightedIndex(len as int, difficulty as double, w as IWorld) as int {
  if (len <= 1) return 0;
  val chance = w.random.nextDouble();
  val b = pow(chance, 4.0 * pow(1.05 - difficulty, 2.0));
  return (min(0.9999, max(0.0, b)) * len) as int;
}

// -------------------------------
// Points model  [#5]
// -------------------------------
static topCostCache as int = -1;
function getTopCost() as int {
  if (topCostCache > 0) return topCostCache;
  var top = scripts.equipment.equipData.DEFAULT_MOD_POINTS;
  for k, v in scripts.equipment.equipData.modifierPoints {
    val vi = v as int;
    if (vi > top) top = vi;
  }
  topCostCache = top;
  return top;
}
function cost(mod as IModifier) as int { return scripts.equipment.equipData.getModifierPoints(mod.getIdentifier()); }

// Lowest difficulty at which a modifier of the given cost may appear.
function unlockDifficulty(c as int) as double {
  val ratio = (c as double) / (getTopCost() as double);
  return pow(min(1.0, max(0.0, ratio)), 1.0 / UNLOCK_POW);
}

// -------------------------------
// Native applicability filter  [#1]
// -------------------------------
// True only if `mod` is compatible with every trait & base modifier already on
// the piece. Replicates IModifier.canApply's compatibility checks using only
// boolean calls, so we never trip its TinkerGuiException throw path.
function modCompatible(root as NBTTagCompound, mod as IModifier) as bool {
  if (isNull(root)) return true;
  val traits = TagUtil.getTraitsTagList(root);
  for i in 0 .. traits.tagCount() {
    val t as ITrait = TinkerRegistry.getTrait(traits.getStringTagAt(i));
    if (!isNull(t) && (!mod.canApplyTogether(t) || !t.canApplyTogether(mod))) return false;
  }
  val mods = TagUtil.getBaseModifiersTagList(root);
  for i in 0 .. mods.tagCount() {
    val m as IModifier = TinkerRegistry.getModifier(mods.getStringTagAt(i));
    if (!isNull(m) && (!mod.canApplyTogether(m) || !m.canApplyTogether(mod))) return false;
  }
  return true;
}

// canApply is relatively expensive and runs on every spawned mob, so the
// slot/category/custom verdict is cached per item definition. It is made
// material-independent by stripping the scratch piece's material traits before
// the canApply pass; the (cheap) material-specific trait/modifier compatibility
// is then re-applied per piece below.
static slotPoolCache as IModifier[][string] = {} as IModifier[][string];

function buildSlotPool(item as IItemStack, isArmor as bool) as IModifier[] {
  val scratch = (item as ItemStack).copy();
  val sroot = scratch.tagCompound;
  if (!isNull(sroot)) {
    TagUtil.setTraitsTagList(sroot, NBTTagList());        // ignore material traits for the cached verdict
    scratch.setTagCompound(sroot);
  }
  ToolUtils.getAndSetModifierCount(scratch, FILTER_BUDGET); // never starve the free-modifier check
  val pool = isArmor ? scripts.equipment.utils_tcon.allArmorMods : scripts.equipment.utils_tcon.allToolMods;
  var out = [] as IModifier[];
  for mod in pool {
    if (mod.canApply(scratch, scratch)) out += mod;
  }
  return out;
}

// Pool of modifiers the native game would actually allow on this exact piece.
function applicablePool(item as IItemStack, isArmor as bool) as IModifier[] {
  val defId = item.definition.id;
  var slotPool = slotPoolCache[defId];
  if (isNull(slotPool)) {
    slotPool = buildSlotPool(item, isArmor);
    slotPoolCache[defId] = slotPool;
  }
  // material-specific trait/modifier compatibility, evaluated per actual piece
  val root = (item as ItemStack).tagCompound;
  var out = [] as IModifier[];
  for mod in slotPool {
    if (modCompatible(root, mod)) out += mod;
  }
  return out;
}

// -------------------------------
// Budget-based selection  [#5][#3]
// -------------------------------
function selectModifiers(candidates as IModifier[], difficulty as double, w as IWorld) as IModifier[] {
  var chosen = [] as IModifier[];
  if (difficulty <= 0.0 || candidates.length == 0) return chosen; // no modifiers at 0 difficulty [#3]

  // difficulty-gated eligible subset
  var eligible = [] as IModifier[];
  for m in candidates {
    if (difficulty + 0.0001 >= unlockDifficulty(cost(m))) eligible += m;
  }
  if (eligible.length == 0) return chosen;

  var budget = pow(difficulty, BUDGET_POW) * (getTopCost() as double);

  // spend the budget on affordable, not-yet-chosen modifiers
  var guard = 0;
  while (chosen.length < MAX_MODS && guard < 400) {
    guard += 1;
    var affordable = [] as IModifier[];
    for m in eligible {
      if (!(chosen has m) && (cost(m) as double) <= budget) affordable += m;
    }
    if (affordable.length == 0) break;
    val pick = affordable[(w.random.nextDouble() * affordable.length) as int];
    chosen += pick;
    budget -= cost(pick) as double;
  }

  // floor: guarantee a minimum headcount at high difficulty (cheapest first)
  val minMods = ((difficulty * (MIN_AT_FULL as double)) + 0.5) as int;
  guard = 0;
  while (chosen.length < minMods && guard < 400) {
    guard += 1;
    var best as IModifier = null;
    var bestCost = 0;
    for m in eligible {
      if (chosen has m) continue;
      val c = cost(m);
      if (isNull(best) || c < bestCost) { best = m; bestCost = c; }
    }
    if (isNull(best)) break;
    chosen += best;
  }
  return chosen;
}

// -------------------------------
// Leveled application  [#2]
// -------------------------------
function modTagSig(item as IItemStack, id as string) as string {
  val tag = TinkerUtil.getModifierTag(item as ItemStack, id);
  return isNull(tag) ? '' : tag.toString();
}

// Apply `mod` once, then up to `extra` more times. Stops early as soon as an
// application stops changing the modifier's data (single-use / maxed level),
// which also yields the in-between "points" of multi-level mods like Haste.
function applyLeveled(item as IItemStack, mod as IModifier, extra as int) as IItemStack {
  val id = mod.getIdentifier();
  var st = scripts.equipment.utils_tcon.addSingleModifier(item, id);
  if (extra <= 0) return st;
  var prev = modTagSig(st, id);
  var k = 0;
  while (k < extra) {
    val next = scripts.equipment.utils_tcon.addSingleModifier(st, id);
    val sig = modTagSig(next, id);
    if (sig == prev) break;
    st = next;
    prev = sig;
    k += 1;
  }
  return st;
}

function rollExtraLevels(difficulty as double, w as IWorld) as int {
  return (rndCube(w) * difficulty * (MAX_EXTRA_LEVELS as double) + 0.0) as int;
}

// -------------------------------
// Inventory loot  [#4]
// -------------------------------
function randomFrom(loot as IItemStack[], difficulty as double, w as IWorld) as IItemStack {
  if (loot.length == 0) return null;
  val base = loot[weightedIndex(loot.length, difficulty, w)];
  if (isNull(base)) return null;
  val cnt = 1 + (w.random.nextDouble() * difficulty * 8.0) as int;
  return base * min(cnt, base.maxStackSize);
}

function fillHandler(modTag as NBTTagCompound, key as string, size as int, loot as IItemStack[], difficulty as double, w as IWorld) as void {
  val handler = ItemStackHandler(size);
  if (modTag.hasKey(key)) {
    val existing = modTag.getCompoundTag(key);
    if (!isNull(existing) && existing.hasKey('Size')) handler.deserializeNBT(existing);
  }
  // fill a difficulty-scaled fraction of distinct slots (~25-85% at full difficulty)
  val fillCount = min(size, 1 + ((0.25 + 0.6 * w.random.nextDouble()) * difficulty * (size as double)) as int);
  for slot in 0 .. fillCount {
    val drop = randomFrom(loot, difficulty, w);
    if (!isNull(drop)) handler.setStackInSlot(slot, drop as ItemStack);
  }
  modTag.setTag(key, handler.serializeNBT());
}

// Detect any accessory-inventory modifier on the piece by its storage key and
// populate it: travel_sack -> "knapsack" (27 items), travel_belt -> "hotbar"
// (9 items), potion_belt -> "potions" (7 potions).
function fillInventories(item as IItemStack, difficulty as double, w as IWorld) as IItemStack {
  if (difficulty <= 0.0) return item;
  val native = item as ItemStack;
  val root = native.tagCompound;
  if (isNull(root)) return item;
  val items = scripts.equipment.equipData.inventoryLoot;
  val potions = scripts.equipment.equipData.potionLoot;
  val list = TagUtil.getModifiersTagList(root);
  var changed = false;
  for i in 0 .. list.tagCount() {
    val modTag = list.getCompoundTagAt(i);
    if (modTag.hasKey('knapsack')) { fillHandler(modTag, 'knapsack', 27, items, difficulty, w);  changed = true; }
    if (modTag.hasKey('hotbar'))   { fillHandler(modTag, 'hotbar', 9, items, difficulty, w);     changed = true; }
    if (modTag.hasKey('potions'))  { fillHandler(modTag, 'potions', 7, potions, difficulty, w);  changed = true; }
    list.set(i, modTag);
  }
  if (!changed) return item;
  TagUtil.setModifiersTagList(root, list);
  native.setTagCompound(root);
  return native as IItemStack;
}

// -------------------------------
// Draconic-Evolution upgrades  [#7]
// -------------------------------
// DE materials grant the `evolved` trait, which auto-adds every eligible DE
// upgrade at tier 0. Here we level those present upgrades up, scaled by
// difficulty and capped by the material's evolved tier.
function applyDraconicTiers(item as IItemStack, isArmor as bool, difficulty as double, w as IWorld) as IItemStack {
  if (difficulty <= 0.0) return item;
  val evolvedId = isArmor ? 'tconevo.evolved_armor' : 'tconevo.evolved';
  var st = item;
  // The `evolved` StackableTrait keeps its canonical id in the modifiers list
  // (the traits list holds the per-level id), so check via ToolUtils.hasModifier.
  if (!ToolUtils.hasModifier(st as ItemStack, evolvedId)) return st;
  // material's evolved tier caps how far its DE upgrades may be raised
  // (wyvern=1, draconic=2, chaotic=3); a DE upgrade sits at level = tier+1.
  val evolvedTier = max(1, ToolUtils.getTraitLevel(st as ItemStack, evolvedId));
  for mod in scripts.equipment.utils_tcon.allDraconicMods {
    val id = mod.getIdentifier();
    if (!ToolUtils.hasModifier(st as ItemStack, id)) continue; // only the ones the material granted (already tier 0)
    var bonus = (rndCube(w) * difficulty * ((evolvedTier + 1) as double)) as int;
    if (difficulty >= 0.999) bonus = evolvedTier; // full material tier at max difficulty
    bonus = min(evolvedTier, bonus);
    // each extra application raises the upgrade one tier (it is already at tier 0)
    for k in 0 .. bonus {
      st = scripts.equipment.utils_tcon.addSingleModifier(st, id);
    }
  }
  return st;
}

// -------------------------------
// Energy charge  [#6]
// -------------------------------
// Reconstruct the stack from NBT so TconEvo's energy capability re-attaches to
// the freshly-modified item, then inject a difficulty-scaled charge (>=10%).
function chargeEnergy(item as IItemStack, difficulty as double) as IItemStack {
  if (difficulty <= 0.0) return item;
  val nbt = NBTTagCompound();
  (item as ItemStack).writeToNBT(nbt);
  val fresh = ItemStack(nbt);
  if (!PowerWrapper.isPowered(fresh)) return item;
  val pw = PowerWrapper.wrap(fresh);
  if (isNull(pw)) return item;
  val maxE = pw.getEnergyMax();
  if (maxE <= 0) return item;
  val frac = max(MIN_ENERGY_FRAC, min(1.0, difficulty));
  pw.inject(((maxE as double) * frac) as int, true, true);
  return fresh as IItemStack;
}

// Headroom of leveling "bonus modifiers" granted before applying anything, so
// that the per-application tool rebuild (which throws when free<0) always has
// budget. Trimmed back to the real used-count afterwards by trimBudget().
static LEVEL_HEADROOM as int = 120;

// Trim the leveling bonus to exactly the modifiers used, so the finished piece
// keeps the genuine "free modifiers" count instead of the inflated headroom.
function trimBudget(item as IItemStack, isArmor as bool) as IItemStack {
  val root = (item as ItemStack).tagCompound;
  if (isNull(root)) return item;
  val used = TagUtil.getBaseModifiersUsed(root);
  return scripts.equipment.utils_tcon.setLevelingBonus(item, isArmor, max(1, used), used);
}

// -------------------------------
// Public entry point
// -------------------------------
function generateModifiers(item as IItemStack, isArmor as bool, difficulty as double, w as IWorld) as IItemStack {
  var st = item;

  // No power modifiers whatsoever at zero difficulty [#3]
  if (difficulty > 0.0) {
    // grant generous budget headroom so the incremental tool rebuilds never throw
    st = scripts.equipment.utils_tcon.applyLevelingBonus(st, isArmor, LEVEL_HEADROOM);

    // 1+2: native-filtered pool, budgeted selection, leveled application
    val candidates = applicablePool(st, isArmor);
    val chosen = selectModifiers(candidates, difficulty, w);
    for mod in chosen {
      st = applyLeveled(st, mod, rollExtraLevels(difficulty, w));
    }

    // 4: fill backpack/belt accessories
    st = fillInventories(st, difficulty, w);

    // 7: level up Draconic-Evolution upgrades on DE-material gear
    st = applyDraconicTiers(st, isArmor, difficulty, w);
  }

  // seal so players must unseal to modify (always; while headroom still covers it)
  st = scripts.equipment.utils_tcon.addSingleModifier(st, 'tconevo.artifact');

  // trim the headroom back down to the real used count (only if we inflated it)
  if (difficulty > 0.0) st = trimBudget(st, isArmor);

  // 6: charge energy last (reconstructs the stack to attach the capability)
  st = chargeEnergy(st, difficulty);

  return st;
}

// -------------------------------
// Debug dump of every modifier with its effective points  [#5]
// -------------------------------
function dumpModifierPoints() as void {
  print('[modifierGen] ===== MODIFIER POINTS DUMP (default=' ~ scripts.equipment.equipData.DEFAULT_MOD_POINTS ~ ', top=' ~ getTopCost() ~ ') =====');
  for mod in scripts.equipment.utils_tcon.allToolMods {
    val id = mod.getIdentifier();
    val inc = (mod instanceof IncrementalModifier) ? (' maxLvl=' ~ (mod as IncrementalModifier).getLevelMaximum()) : '';
    val dra = (mod instanceof DraconicTieredModifier) ? ' DRACONIC' : '';
    print('[modifierGen] TOOL  ' ~ cost(mod) ~ '  ' ~ id ~ ' (unlock>=' ~ unlockDifficulty(cost(mod)) ~ ')' ~ inc ~ dra);
  }
  for mod in scripts.equipment.utils_tcon.allArmorMods {
    val id = mod.getIdentifier();
    val dra = (mod instanceof DraconicTieredModifier) ? ' DRACONIC' : '';
    print('[modifierGen] ARMOR ' ~ cost(mod) ~ '  ' ~ id ~ ' (unlock>=' ~ unlockDifficulty(cost(mod)) ~ ')' ~ dra);
  }
  print('[modifierGen] ===== END DUMP =====');
}

// Compact human-readable summary of a generated piece (for /grant testing).
function describeItem(item as IItemStack) as string {
  val native = item as ItemStack;
  val root = native.tagCompound;
  if (isNull(root)) return 'no-nbt';
  var s = '';
  val mods = TagUtil.getModifiersTagList(root);
  for i in 0 .. mods.tagCount() {
    val mt = mods.getCompoundTagAt(i);
    val id = mt.getString('identifier');
    if (isNull(id) || id == '') continue;
    val lvl = mt.hasKey('level') ? mt.getInteger('level') : 0;
    val cur = mt.hasKey('current') ? mt.getInteger('current') : 0;
    var suff = '';
    if (lvl > 1) suff = '@' ~ lvl;
    if (cur > 0) suff = suff ~ '(x' ~ cur ~ ')';
    if (mt.hasKey('knapsack')) suff = suff ~ '[knapsack:' ~ mt.getCompoundTag('knapsack').getTagList('Items', 10).tagCount() ~ ']';
    if (mt.hasKey('hotbar')) suff = suff ~ '[hotbar:' ~ mt.getCompoundTag('hotbar').getTagList('Items', 10).tagCount() ~ ']';
    if (mt.hasKey('potions')) suff = suff ~ '[potions:' ~ mt.getCompoundTag('potions').getTagList('Items', 10).tagCount() ~ ']';
    s = s ~ id ~ suff ~ ', ';
  }
  s = s ~ '| free=' ~ ToolHelper.getFreeModifiers(native);
  val nbt = NBTTagCompound();
  native.writeToNBT(nbt);
  val fresh = ItemStack(nbt);
  if (PowerWrapper.isPowered(fresh)) {
    val pw = PowerWrapper.wrap(fresh);
    if (!isNull(pw)) s = s ~ ' | energy=' ~ pw.getEnergy() ~ '/' ~ pw.getEnergyMax();
  }
  return s;
}
