#priority 2000
#reloadable
#modloaded ctintegration

import crafttweaker.item.IItemStack;

function getCrystalMemoryContent(item as IItemStack) as IItemStack {
  if (
    isNull(item)
    || item.definition.id != 'ic2:crystal_memory'
    || !item.hasTag
    || isNull(item.tag.Pattern)
    || isNull(item.tag.Pattern.id)
  ) return null;

  return IItemStack.fromData(item.tag.Pattern);
}
