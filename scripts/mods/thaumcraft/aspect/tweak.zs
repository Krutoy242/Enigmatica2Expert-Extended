#modloaded thaumcraft
#reloadable
#priority 3000

import crafttweaker.entity.IEntityDefinition;
import crafttweaker.item.IItemStack;

function set(aspectString as string, item as IItemStack) as void {
  if (isNull(item)) return;
  if (aspectString.length() <= 0) {
    logger.logWarning('Empty aspect list for: ' ~ item.commandString);
    return;
  }
  val aspects = Aspects(aspectString);
  if (aspects.length <= 0) {
    logger.logWarning('Empty aspect list for: ' ~ item.commandString ~ ' aspects: ' ~ aspectString);
    return;
  }
  item.setAspects(aspects);
}

function setEntity(aspectString as string, entity as IEntityDefinition) as void {
  if (isNull(entity)) return;
  if (aspectString.length() <= 0) {
    logger.logWarning('Empty aspect list for entity: ' ~ entity.id);
    return;
  }
  val aspects = Aspects(aspectString);
  if (aspects.length <= 0) {
    logger.logWarning('Empty aspect list for entity: ' ~ entity.id ~ ' aspects: ' ~ aspectString);
    return;
  }
  entity.setAspects(aspects);
  <minecraft:spawn_egg>.withTag({EntityTag: {id: entity.id}}).setAspects(aspects);
}
