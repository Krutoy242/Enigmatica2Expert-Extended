#modloaded jei requious
#priority 975
#ignoreBracketErrors

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.requious.SlotVisual;

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
val x = <assembly:entity_kill_entity>;
x.addJEICatalyst(<randomthings:slimecube>);
scripts.jei.requious.addInsOuts(x, [[0, 0], [4, 0]], [[8, 0]]);
x.setJEIDurationSlot(2, 0, 'duration0', scripts.jei.requious.getVisGauge(3, 6));
x.setJEIDurationSlot(6, 0, 'duration1', SlotVisual.arrowRight());

function add(entity1 as IIngredient, entity2 as IIngredient, output as IItemStack) as void {
  scripts.jei.requious.add(<assembly:entity_kill_entity>, { [entity1, entity2] as IIngredient[]: [output] });
}
