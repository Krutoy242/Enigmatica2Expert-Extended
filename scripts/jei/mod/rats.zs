#modloaded rats
#priority -1
//priority should be lower than scripts/mods/ratsprocessing.zs

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.oredict.IOreDictEntry;

import mods.jei.JEI;
import mods.randomtweaker.jei.IJeiUtils;

import scripts.mods.ratsprocessing;
import scripts.jei.crafting_hints;

//recipe hint: cheese -> poop
crafting_hints.add1to1(<ore:foodCheese> as IOreDictEntry, <rats:rat_nugget>)

//------
//below: recipe hints with custom JEI Category
//------

val SLOT_SIZE = 18;
val ID = 'rats_consuming';

val category = JEI.createJei(ID, 'Rats Consuming');
category.setBackground(IJeiUtils.createBackground(3 * SLOT_SIZE, 1 * SLOT_SIZE));
category.setIcon(<rats:rat_upgrade_ore_doubling>);
category.setModid('rats');

category.addSlot(IJeiUtils.createItemSlot('input', 0, 0, true, false));
category.addElement(IJeiUtils.createArrowElement(SLOT_SIZE, 1, 0));
category.addSlot(IJeiUtils.createItemSlot('output', 2 * SLOT_SIZE, 0, false, false));

category.addRecipeCatalyst(<rats:rat_upgrade_ore_doubling>);
category.addRecipeCatalyst(<rats:rat_upgrade_jury_rigged>.withTag({
  Items: [
    {Slot: 0 as byte, id: "rats:rat_upgrade_speed", Count: 1, Damage: 0 as short},
    {Slot: 1 as byte, id: "rats:rat_upgrade_ore_doubling", Count: 1, Damage: 0 as short}
  ]
})); //used for informing players that there's a faster variant
category.addRecipeCatalyst(<entity:rats:rat>.asEgg());
category.addRecipeCatalyst(<entity:rats:rat>.asSoul());

category.register();

function addRatsConsumingJEIRecipe(input as IIngredient, output as IItemStack) {
  JEI.createJeiRecipe(ID)
    .addInput(input)
    .addOutput(output)
    .build();
}

//recipe hint: ore -> ore poop
for poop in ratsprocessing.listRatPoop as IItemStack[] {
  val oreItem = IItemStack.fromData(poop.tag.OreItem);
  if (isNull(oreItem)) {
    continue;
  }
  addRatsConsumingJEIRecipe(oreItem, poop * 2, <rats:rat_upgrade_ore_doubling>);
}