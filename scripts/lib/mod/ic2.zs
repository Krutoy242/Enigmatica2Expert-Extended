#priority 2000
#reloadable

import crafttweaker.item.IItemStack;

function getCrystalMemoryContent(item as IItemStack) as IItemStack {
  if (
    isNull(item)
    || item.definition.id != 'ic2:crystal_memory'
    || !item.hasTag
    || isNull(item.tag.Pattern)
    || isNull(item.tag.Pattern.id)
  ) return null;

  return item.tag.Pattern.toItemStack();
}
