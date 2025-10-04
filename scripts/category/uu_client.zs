#modloaded ic2
#reloadable
#priority -1
#sideonly client

import mods.zenutils.StaticString.format;

<ic2:crystal_memory>.addAdvancedTooltip(function (item) {
  val replicable = scripts.lib.mod.ic2.getCrystalMemoryContent(item);
  if (isNull(replicable)) return null;

  val cost = scripts.category.uu.getCost(replicable, -1);
  if (cost <= 0) return null;

  val increase = 64.0 * scripts.category.uu.diffIncrease(0.01 * cost);
  val increaseText = increase < 0.01 ? format('%,.6f', increase) : format('%,.2f', increase);

  return mods.zenutils.I18n.format('e2ee.acquire.increase', increaseText);
});
