#modloaded lilliputian zenutils
#priority 4000

import crafttweaker.entity.IEntity;

function setEntitySize(entity as IEntity, newSize as float) as void {
  if (isNull(entity.nbt) || isNull(entity.nbt.ForgeCaps)) return;

  val newTag = entity.nbt.deepUpdate(
    { ForgeCaps: { 'lilliputian:size': { scale: newSize } } },
    mods.zenutils.DataUpdateOperation.MERGE)
  ;

  entity.updateNBT(newTag);
}
