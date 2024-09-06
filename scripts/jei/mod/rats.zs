#modloaded rats
#priority -1
//priority should be lower than scripts/mods/ratsprocessing.zs

import crafttweaker.liquid.ILiquidStack;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.oredict.IOreDictEntry;
import mods.requious.Assembly;
import mods.requious.AssemblyRecipe;
import mods.requious.SlotVisual;

import scripts.mods.ratsprocessing;
import scripts.jei.requious;

val x = <assembly:rats_consuming> as Assembly;

x.addJEICatalyst(<minecraft:spawn_egg>.withTag({EntityTag: {id: "rats:rat"}}));
x.addJEICatalyst(<rats:rat_upgrade_ore_doubling>);
x.addJEICatalyst(<rats:rat_upgrade_jury_rigged>.withTag({
  Items: [
    {Slot: 0 as byte, id: "rats:rat_upgrade_speed", Count: 1, Damage: 0 as short},
    {Slot: 1 as byte, id: "rats:rat_upgrade_ore_doubling", Count: 1, Damage: 0 as short}
  ]
}));

x.setJEIDurationSlot(2, 0, 'duration', SlotVisual.arrowRight());
requious.addInsOuts(x, [[0, 0], [1, 0]], [[3, 0]]);

function addRatsConsumingJEIRecipe(
  input as IIngredient,
  output as IItemStack,
  additionalRequirement as IIngredient = null
) {
  val recipe = AssemblyRecipe
    .create(function (c) { c.addItemOutput('output0', output); })
    .requireItem('input0', input)
    .requireDuration('duration', 20);
  if (!isNull(additionalRequirement)) {
    recipe.requireItem('input1', additionalRequirement);
  }
  <assembly:rats_consuming>.addJEIRecipe(recipe);
}

addRatsConsumingJEIRecipe(<ore:foodCheese> as IOreDictEntry, <rats:rat_nugget>);

for poop in ratsprocessing.listRatPoop as IItemStack[] {
  val oreItem = IItemStack.fromData(poop.tag.OreItem);
  if (isNull(oreItem)) {
    continue;
  }
  addRatsConsumingJEIRecipe(oreItem, poop * 2, <rats:rat_upgrade_ore_doubling>);
}