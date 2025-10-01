#modloaded ic2
#loader ic2_postinit reloadable
#priority -1
#sideonly client

import crafttweaker.item.ITooltipFunction;
import mods.zenutils.StaticString.format;

val uuTooltip as ITooltipFunction = function (item) {
  // Prevent internal technical calls to throw "player is null" exceptions
  // For more information see below
  if (isNull(client.player.native)) return null;

  val cost = scripts.category.uu.getCost(item, -1);
  val text = scripts.category.uu.formatUUCost(cost);
  val actualCost = scripts.category.uu.difficultCost(cost, client.player.difficulty);
  if (actualCost == cost) return text; // default cost

  val actualCostText = format('%,.2f', 0.01 * actualCost)
    .replace('.00', '');
  return `§8(${actualCostText}) ${text}`;
};

val it = native.ic2.core.uu.UuGraph.iterator();
while (it.hasNext()) {
  val entry = it.next() as native.java.util.Map.Entry;
  val itemNative = entry.key as native.net.minecraft.item.ItemStack;
  if (!isNull(itemNative)) {
    itemNative.wrapper.only(function (item) { return !item.hasTag; })
      .addAdvancedTooltip(uuTooltip);
  }
}

/*

Error of CTIntegration mod that causing player.difficulty getter malfunction with "#sideonly cliest"
Related (not exactly): https://github.com/TCreopargh/CraftTweakerIntegration/issues/10

[Client thread/ERROR] [Had Enough Items]: Error while Testing for mod name formatting
java.lang.NullPointerException: Cannot invoke "net.minecraft.entity.player.EntityPlayer.hashCode()" because "player" is null
	at net.silentchaos512.scalinghealth.utils.SHPlayerDataHandler.getKey(SHPlayerDataHandler.java:103) ~[SHPlayerDataHandler.class:?]
	at net.silentchaos512.scalinghealth.utils.SHPlayerDataHandler.get(SHPlayerDataHandler.java:69) ~[SHPlayerDataHandler.class:?]
	at xyz.tcreopargh.ctintegration.scalinghealth.DifficultyManager.getDifficulty(DifficultyManager.java:63) ~[DifficultyManager.class:1.8.0]

*/
