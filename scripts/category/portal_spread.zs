#ignoreBracketErrors
#modloaded zenutils
#reloadable

import crafttweaker.item.IItemStack;

// Defined with portal spread
val removals = [
  <mysticalagriculture:soulstone>,
] as IItemStack[];

for item in removals {
  if (isNull(item)) continue;
  recipes.removeShaped(item);
}

// Make portal spread available in skyblock
scripts.do.portal_spread.recipes.spread.setDimensionFallback(3, 0);
