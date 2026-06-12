/*
`self_fix` auto-repair logic (reloadable half of the bridge).

Called from the ToolHelper.damageTool / ArmorHelper.damageArmor HEAD mixins
(scripts/mixin/selffix/selffix.zs) with the REAL ItemStack being damaged — so we can
mutate it in place (no CraftTweaker copy / findEquipped dance needed anymore).

Repair rule (per original spec):
  spend exactly one suitable kit when EITHER
    (a) the tool/armor would break from this hit (or is already broken — mattock-till), OR
    (b) the accumulated damage is at least one full kit's worth (100% efficient, no waste).
Kit suitability + repaired amount are derived from TConstruct's own material data, the same
way the crafting grid does it.
*/
#modloaded tconstruct conarm
#reloadable

import native.net.minecraft.item.Item;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.entity.EntityLivingBase;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.init.SoundEvents;
import native.net.minecraft.util.SoundCategory;

import native.slimeknights.tconstruct.library.materials.HeadMaterialStats;
import native.slimeknights.tconstruct.library.materials.Material;
import native.slimeknights.tconstruct.library.tinkering.TinkersItem;
import native.slimeknights.tconstruct.library.utils.TagUtil;
import native.slimeknights.tconstruct.library.utils.TinkerUtil;
import native.slimeknights.tconstruct.library.utils.ToolHelper;
import native.slimeknights.tconstruct.tools.TinkerTools;

import native.c4.conarm.common.ConstructsRegistry;
import native.c4.conarm.common.armor.utils.ArmorHelper;
import native.c4.conarm.lib.materials.CoreMaterialStats;
import native.c4.conarm.lib.tinkering.TinkersArmor;

// ConArm scales each armor piece's durability (and repair) by this per-slot factor,
// indexed by EntityEquipmentSlot.getIndex() = feet,legs,chest,head (ArmorHelper.durabilityMultipliers).
static ARMOR_SLOT_MULT as int[] = [13, 15, 16, 11] as int[];

function hasSelfFix(stack as ItemStack) as bool {
  if (!stack.hasTagCompound()) return false;
  return TinkerUtil.hasTrait(stack.getTagCompound(), 'self_fix');
}

// Material identifiers that actually repair this item: the materials at getRepairParts()
// indices (e.g. a Mattock's two heads, a Hammer's head + plates), read exactly the way the
// crafting grid does via TConstruct's own TinkerUtil/TagUtil.
function repairMaterialIds(stack as ItemStack, repairParts as int[]) as string[] {
  val materials as [Material] = TinkerUtil.getMaterialsFromTagList(TagUtil.getBaseMaterialsTagList(stack));
  var ids = [] as string[];
  for idx in repairParts {
    if (idx >= 0 && idx < materials.length) ids += materials[idx].identifier;
  }
  return ids;
}

// Durability one kit restores, replicating ToolCore/ArmorCore.repairCustom:
//   stat.durability * kitCost * slotMult / VALUE_Ingot(144)   (slotMult == 1 for tools)
function kitRepairAmount(kit as ItemStack, repairMatIds as string[], statType as string, kitCost as int, slotMult as int) as int {
  val mat = TinkerUtil.getMaterialFromStack(kit);
  if (mat.identifier == 'unknown' || !(repairMatIds has mat.identifier)) return 0;
  val stats = mat.getStats(statType);
  if (isNull(stats)) return 0;
  val durability = statType == 'head' ? (stats as HeadMaterialStats).durability : (stats as CoreMaterialStats).durability as int;
  return durability * kitCost * slotMult / 144;
}

// Tinkers' Tool Forge "clank" to everyone nearby (caller guarantees server side).
function playAnvil(entity as EntityLivingBase) as void {
  val w = entity.getEntityWorld();
  w.playSound(null, entity.posX, entity.posY, entity.posZ, SoundEvents.BLOCK_ANVIL_USE, SoundCategory.PLAYERS, 0.9f, 0.95f + 0.2f * w.rand.nextFloat());
}

// Consume one suitable kit and repair the live stack in place.
function autoFix(stack as ItemStack, player as EntityPlayer, isArmor as bool, kitItem as Item, repairMatIds as string[], statType as string, kitCost as int, slotMult as int, amount as int) as void {
  val maxDamage = stack.getMaxDamage();
  val currentDamage = stack.getItemDamage();
  val broken = ToolHelper.isBroken(stack);
  val wouldBreak = broken || (currentDamage + amount >= maxDamage);
  val damageToRestore = broken ? maxDamage : currentDamage;

  val main as [ItemStack] = player.inventory.mainInventory;
  for i in 0 .. main.length {
    val kit = main[i];
    if (isNull(kit) || kit.isEmpty() || kit.getItem() != kitItem) continue;

    val kitAmount = kitRepairAmount(kit, repairMatIds, statType, kitCost, slotMult);
    if (kitAmount <= 0) continue; // kit material doesn't fit this item

    // 100% efficiency unless saving from breaking. `continue` (not `return`): on a multi-head
    // tool a high-durability kit may overfill while a different head's kit still fits.
    if (!wouldBreak && currentDamage < kitAmount) continue;

    val heal = kitAmount < damageToRestore ? kitAmount : damageToRestore;
    if (isArmor) ArmorHelper.repairArmor(stack, heal, player);
    else ToolHelper.repairTool(stack, heal, player);

    player.inventory.decrStackSize(i, 1);
    playAnvil(player);
    return;
  }
}

scripts.mixin.selffix.shared.Op.onToolDamage = function (stack as ItemStack, amount as int, entity as EntityLivingBase) as void {
  if (amount <= 0) return;                                   // re-entrancy from our own repair / heals
  if (isNull(entity) || !(entity instanceof EntityPlayer)) return;
  val player = entity as EntityPlayer;
  if (player.getEntityWorld().isRemote) return;             // server-side only (inventory authority)
  if (!(stack.getItem() instanceof TinkersItem) || !hasSelfFix(stack)) return;

  val repairMatIds = repairMaterialIds(stack, (stack.getItem() as TinkersItem).getRepairParts());
  autoFix(stack, player, false, TinkerTools.sharpeningKit, repairMatIds, 'head', TinkerTools.sharpeningKit.getCost(), 1, amount);
};

scripts.mixin.selffix.shared.Op.onArmorDamage = function (stack as ItemStack, amount as int, player as EntityPlayer, slot as int) as void {
  if (amount <= 0) return;
  if (isNull(player) || player.getEntityWorld().isRemote) return;
  if (!(stack.getItem() instanceof TinkersArmor) || !hasSelfFix(stack)) return;

  val slotMult = slot >= 0 && slot < ARMOR_SLOT_MULT.length ? ARMOR_SLOT_MULT[slot] : 1;
  val repairMatIds = repairMaterialIds(stack, (stack.getItem() as TinkersArmor).getRepairParts());
  autoFix(stack, player, true, ConstructsRegistry.polishingKit, repairMatIds, 'core', ConstructsRegistry.polishingKit.getCost(), slotMult, amount);
};
