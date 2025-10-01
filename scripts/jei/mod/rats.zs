#modloaded rats jei
#priority -1
//priority should be lower than scripts/mods/ratsprocessing.zs
#sideonly client

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.oredict.IOreDictEntry;

import mods.jei.JEI;
import mods.randomtweaker.jei.IJeiUtils;

import scripts.mods.ratsprocessing;
import scripts.jei.crafting_hints;

//recipe hint: cheese -> poop
crafting_hints.add1to1(
  <ore:foodCheese>,
  <rats:rat_nugget>,
  <entity:rats:rat>.asIngr()
);

//------
//below: recipe hints with custom JEI Category
//------

val SLOT_SIZE = 18;
val ARROW_WIDTH = SLOT_SIZE + 4;
val ID = 'rats_consuming';

JEI.createJei(ID, game.localize(`e2ee.jei.${ID}.title`))
  //basic information
  .setBackground(IJeiUtils.createBackground(2 * SLOT_SIZE + ARROW_WIDTH, SLOT_SIZE))
  .setIcon(<rats:rat_upgrade_ore_doubling>)
  .setModid('rats')
  //input and output
  .addSlot(IJeiUtils.createItemSlot('input', 0, 0, true, false))
  .addElement(IJeiUtils.createArrowElement(SLOT_SIZE, 1, 0))
  .addSlot(IJeiUtils.createItemSlot('output', SLOT_SIZE + ARROW_WIDTH, 0, false, false))
  //catalysts
  .addRecipeCatalyst(<rats:rat_upgrade_ore_doubling>)
  .addRecipeCatalyst(<rats:rat_upgrade_jury_rigged>.withTag({
    Items: [
      {Slot: 0 as byte, id: "rats:rat_upgrade_speed", Count: 1, Damage: 0 as short},
      {Slot: 1 as byte, id: "rats:rat_upgrade_ore_doubling", Count: 1, Damage: 0 as short}
    ]
  })) //used for informing players that there's a faster variant
  .addRecipeCatalyst(<entity:rats:rat>.asEgg())
  .addRecipeCatalyst(<entity:rats:rat>.asSoul())
  //done
  .register();

//recipe hint: ore -> ore poop
for poop in ratsprocessing.listRatPoop as IItemStack[] {
  val oreItem = poop.tag.OreItem.toItemStack();
  if (isNull(oreItem)) {
    continue;
  }
  JEI.createJeiRecipe(ID)
    .addInput(oreItem)
    .addOutput(poop * 2)
    .build();
}