/*

Attach spin animation from mod 'Cases' to other items,
such as FTBQuests's loot crates.

*/

#modloaded cases ftbquests
#reloadable

import native.com.feed_the_beast.ftbquests.quest.reward.ItemReward;
import native.net.minecraft.util.EnumActionResult;
import native.net.minecraftforge.event.entity.player.PlayerInteractEvent.RightClickItem;
import native.ru.radviger.cases.Cases;
import native.ru.radviger.cases.slot.Case;
import native.ru.radviger.cases.slot.CaseSlots;
import native.ru.radviger.cases.slot.SingleCaseSlot;
import native.ru.radviger.cases.slot.property.Amount;
import native.ru.radviger.cases.slot.property.Rarity;

events.register(function (e as native.com.feed_the_beast.ftblib.events.universe.UniverseLoadedEvent.Post) {
  val CASES = Cases.CASES as native.java.util.HashMap;
  CASES.clear();

  for tierName in ['mythic'] as string[] {
    val slots = CaseSlots();
    val file = native.com.feed_the_beast.ftbquests.quest.ServerQuestFile.INSTANCE;
    val crate = file.getLootCrate(tierName);
    for reward in crate.table.rewards {
      if (!(reward.reward instanceof ItemReward)) continue;
      val itemReward = reward.reward as ItemReward;

      val caseSlot = SingleCaseSlot(
        itemReward.item,
        Rarity.COMMON,
        Amount(itemReward.count),
        0.0f
      );
      slots.add(caseSlot);
    }

    CASES.put(tierName, Case(
      tierName,
      { en_us: tierName } as string[string],
      { en_us: tierName } as string[string],
      16711761,
      slots
    ));
  }
});

function checkRightClick(e as RightClickItem) as bool {
  if (isNull(e.itemStack) || e.itemStack.isEmpty()) return false;

  val player = e.entityPlayer;
  if (player.isSneaking()) return false;

  val stack = e.itemStack;

  val id = native.net.minecraft.item.Item.REGISTRY.getNameForObject(stack.item);
  if (isNull(id) || id.toString() != 'ftbquests:lootcrate') return false;

  val tag = stack.tagCompound;
  if (isNull(tag) || tag.getString('type') != 'mythic') return false;
  return true;
}

events.register(function (e as RightClickItem) {
  if (!checkRightClick(e)) return;
  e.setCancellationResult(EnumActionResult.SUCCESS);
  e.setCanceled(true);
}, mods.zenutils.EventPriority.low());
