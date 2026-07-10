#modloaded zentoolforge
#priority 100
#reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.util.Math.max;

import native.net.minecraft.item.ItemStack;
import native.slimeknights.tconstruct.library.TinkerRegistry;
import native.slimeknights.tconstruct.library.modifiers.IModifier;
import native.slimeknights.tconstruct.library.utils.ToolBuilder;
import native.slimeknights.tconstruct.library.utils.TagUtil;
import native.slimeknights.tconstruct.library.utils.TinkerUtil;
import native.slimeknights.tconstruct.library.tinkering.TinkersItem;
import native.c4.conarm.lib.ArmoryRegistry;
import native.c4.conarm.lib.tinkering.TinkersArmor;
import native.c4.conarm.lib.tinkering.ArmorBuilder;
import native.xyz.phanta.tconevo.trait.draconicevolution.DraconicTieredModifier;

// -------------------------------
// Dynamic modifier pools
// -------------------------------
// Instead of hardcoding identifiers, pull every registered modifier straight
// from Tinkers' (tools) and Construct's Armory (armor) registries, exactly the
// way TinkersPlannerAntique does for its planner UI (filter by visibility +
// "has items to apply with"). This way new modifiers from any mod show up
// automatically and identifiers always match what the registry actually uses
// (e.g. armor traits get a "_armor" suffix).

// Single blacklist of identifiers that must never roll randomly on mob gear.
static modifierBlacklist as string[] = [
  // Leveling system — managed separately via applyLevelingBonus()
  'toolleveling',
  'leveling',
  'leveling_armor',
  // Sealing modifier — added explicitly to every generated piece
  'tconevo.artifact',
  // Creative / debug only
  'creative',
  'extramodifier',
  // Construct's Armory display-only placeholders
  'polished',
  'extra_trait',
  // Cosmetic / situational, out of place on a mob
  'incognito',
] as string[];

// Identifier prefixes to drop wholesale. These cover the per-material
// reinforcement ("fortify<mat>"), extra-trait ("extratrait<mat...>") and armor
// polish ("polished_armor<mat>") modifiers, of which there are hundreds — pure
// noise for random mob gear.
static modifierPrefixBlacklist as string[] = [
  'fortify',
  'extratrait',
  'polished',
] as string[];

function isModifierBlacklisted(id as string) as bool {
  if (modifierBlacklist has id) return true;
  for p in modifierPrefixBlacklist {
    if (id.startsWith(p)) return true;
  }
  return false;
}

// requireItems mirrors how TinkersPlannerAntique builds its pools: tool
// modifiers must report craftable application items (this also filters out the
// item-less armor traits that leak into the shared TinkerRegistry), while armor
// modifiers register their items externally so the check is skipped for them.
// The actual per-piece applicability (slot, category, compatibility) is decided
// natively at generation time by modifierGen.zs via IModifier.canApply().
function collectModifiers(mods as [IModifier], requireItems as bool) as IModifier[] {
  var out = [] as IModifier[];
  for mod in mods {
    if (isNull(mod)) continue;
    if (mod.isHidden()) continue;
    if (requireItems && !mod.hasItemsToApplyWith()) continue;
    // Draconic-Evolution upgrades are gated to DE materials (handled separately
    // via the `evolved` trait) — never roll them onto ordinary gear.
    if (mod instanceof DraconicTieredModifier) continue;
    val id = mod.getIdentifier();
    if (isNull(id) || id == '') continue;
    if (isModifierBlacklisted(id)) continue;
    if (out has mod) continue; // dedup
    out += mod;
  }
  return out;
}

// Random-roll pools, as live IModifier instances (so canApply / instanceof work).
static allToolMods  as IModifier[] = [] as IModifier[];
static allArmorMods as IModifier[] = [] as IModifier[];
allToolMods  = collectModifiers(TinkerRegistry.getAllModifiers() as [IModifier], true);
allArmorMods = collectModifiers(ArmoryRegistry.getAllArmorModifiers() as [IModifier], false);

// Draconic-Evolution upgrade modifiers (both tool & armor variants implement the
// DraconicTieredModifier marker). They are auto-granted at tier 0 by a DE
// material's `evolved` trait; modifierGen.zs levels them up by difficulty.
static allDraconicMods as IModifier[] = [] as IModifier[];
for mod in TinkerRegistry.getAllModifiers() as [IModifier] {
  if (!isNull(mod) && (mod instanceof DraconicTieredModifier) && !(allDraconicMods has mod)) allDraconicMods += mod;
}
for mod in ArmoryRegistry.getAllArmorModifiers() as [IModifier] {
  if (!isNull(mod) && (mod instanceof DraconicTieredModifier) && !(allDraconicMods has mod)) allDraconicMods += mod;
}

// -------------------------------
// Apply modifier (native)
// -------------------------------
function addSingleModifier(item as IItemStack, name as string) as IItemStack {
  if (isNull(name) || name == '') return item;
  val mcStack = item as ItemStack;
  val itemClass = mcStack.item;
  val isArmorItem = itemClass instanceof TinkersArmor;
  val mod1 = isArmorItem ? ArmoryRegistry.getArmorModifier(name) : TinkerRegistry.getModifier(name);
  val mod = isNull(mod1)
    ? (isArmorItem ? TinkerRegistry.getModifier(name) : ArmoryRegistry.getArmorModifier(name))
    : mod1;
  if (isNull(mod)) return item;

  mod.apply(mcStack);

  if (!isArmorItem) {
    val root = mcStack.tagCompound;
    ToolBuilder.rebuildTool(root, itemClass as TinkersItem);
  }

  return mcStack;
}

// -------------------------------
// Leveling-backed modifier budget (native)
// -------------------------------
// Random modifiers spend free-modifier slots. To avoid generating gear that
// used more modifiers than it could afford, we pretend the piece was leveled
// up (via Tinkers'/Construct's Armory tool-leveling) so each random modifier is
// paid for by a bonus slot. Rebuild then recomputes the budget as
//   free = baseFree + bonusModifiers - used
// keeping the piece a perfectly valid, "already experienced" item.
function applyLevelingBonus(item as IItemStack, isArmor as bool, bonus as int) as IItemStack {
  if (bonus <= 0) return item;
  val mcStack = item as ItemStack;
  val itemClass = mcStack.item;
  val root = mcStack.tagCompound;
  if (isNull(root)) return item;

  val modId = isArmor ? 'leveling_armor' : 'toolleveling';
  val tagList = TagUtil.getModifiersTagList(root);
  val index = TinkerUtil.getIndexInCompoundList(tagList, modId);
  if (index < 0) return item; // no leveling modifier present, nothing to grant

  val modTag = tagList.getCompoundTagAt(index);
  modTag.setInteger('level', modTag.getInteger('level') + bonus);
  modTag.setInteger('bonus_modifiers', modTag.getInteger('bonus_modifiers') + bonus);
  modTag.setInteger('xp', 0);
  tagList.set(index, modTag);
  TagUtil.setModifiersTagList(root, tagList);
  mcStack.setTagCompound(root);

  if (isArmor) {
    ArmorBuilder.rebuildArmor(root, itemClass as TinkersArmor);
  }
  else {
    ToolBuilder.rebuildTool(root, itemClass as TinkersItem);
  }
  mcStack.setTagCompound(root);

  return mcStack;
}

// Like applyLevelingBonus but SETS the leveling level / bonus-modifiers to exact
// values instead of adding. Used to first grant generous headroom (so per-apply
// tool rebuilds never run the budget negative) and then trim it back down so the
// finished piece exposes only `baseFree` spare modifier slots.
function setLevelingBonus(item as IItemStack, isArmor as bool, level as int, bonus as int) as IItemStack {
  val mcStack = item as ItemStack;
  val itemClass = mcStack.item;
  val root = mcStack.tagCompound;
  if (isNull(root)) return item;

  val modId = isArmor ? 'leveling_armor' : 'toolleveling';
  val tagList = TagUtil.getModifiersTagList(root);
  val index = TinkerUtil.getIndexInCompoundList(tagList, modId);
  if (index < 0) return item;

  val modTag = tagList.getCompoundTagAt(index);
  modTag.setInteger('level', max(1, level));
  modTag.setInteger('bonus_modifiers', max(0, bonus));
  modTag.setInteger('xp', 0);
  tagList.set(index, modTag);
  TagUtil.setModifiersTagList(root, tagList);
  mcStack.setTagCompound(root);

  if (isArmor) {
    ArmorBuilder.rebuildArmor(root, itemClass as TinkersArmor);
  }
  else {
    ToolBuilder.rebuildTool(root, itemClass as TinkersItem);
  }
  mcStack.setTagCompound(root);

  return mcStack;
}

function constructTool(
  base as IItemStack,
  mat1 as string,
  mat2 as string,
  mat3 as string,
  mat4 as string,
  modifiers as string[] = null
) as IItemStack {
  var tool = mods.zentoolforge.Toolforge.buildTool(base.definition, [
    mods.zentoolforge.Toolforge.getMaterialFromID(mat1),
    mods.zentoolforge.Toolforge.getMaterialFromID(mat2),
    mods.zentoolforge.Toolforge.getMaterialFromID(mat3),
    mods.zentoolforge.Toolforge.getMaterialFromID(mat4),
  ]);
  if (!isNull(modifiers)) {
    for modif in modifiers {
      tool = addSingleModifier(tool, modif);
    }
  }
  return tool;
}
