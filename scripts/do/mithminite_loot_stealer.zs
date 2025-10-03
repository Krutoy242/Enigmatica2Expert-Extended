/**
 * Enhances boss loot drops when slain by a player with the 'LOOT_STEALER' research
 * and a tool bearing the 'researcher' trait.
 */
#modloaded thaumcraft
#priority -1
#reloadable

import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;

function hasResearcherTrait(tool as IItemStack) as bool {
  return !isNull(tool.tag)
      && !isNull(tool.tag.TinkerData)
      && !isNull(tool.tag.Traits)
      && (tool.tag.Traits.asList() has 'researcher');
}

events.register(function(e as crafttweaker.event.EntityLivingDeathDropsEvent) {
  if (e.entity.world.remote) return;
  if (!(e.entity instanceof IEntityLivingBase)) return;

  val entity as IEntityLivingBase = e.entity;
  if (isNull(entity.definition) || isNull(entity.definition.id) || !entity.isBoss) return;

  if (!(e.damageSource.trueSource instanceof IPlayer)) return;
  val player as IPlayer = e.damageSource.trueSource;
  if (isNull(player) || !player.thaumcraftKnowledge.isResearchComplete('LOOT_STEALER')) return;

  val mainHand = player.mainHandHeldItem;
  val offHand = player.offHandHeldItem;
  val validTool = (!isNull(mainHand) && hasResearcherTrait(mainHand))
    || (!isNull(offHand) && hasResearcherTrait(offHand));

  if (!validTool) return;

  val rand = e.entity.world.getRandom();
  for drop in e.drops {
    if (isNull(drop.item)) continue;
    if (drop.item.amount > 1) {
      e.addItem(drop.item * rand.nextInt(1, drop.item.amount / 2));
    }
  }
});
