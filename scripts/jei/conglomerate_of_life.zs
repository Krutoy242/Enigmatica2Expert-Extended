#modloaded jei contenttweaker
#reloadable

// Lower than scripts/cot/functions.zs
#priority -200

import mods.jei.JEI;
import mods.randomtweaker.jei.IJeiUtils;

val SLOT_SIZE = 18;
val ARROW_WIDTH = SLOT_SIZE + 4;

val p = JEI.createJei('conglomerate_of_life', 'Conglomerate of Life Drops')
  .setBackground(IJeiUtils.createBackground(2 * SLOT_SIZE + ARROW_WIDTH, SLOT_SIZE))
  .setIcon(<contenttweaker:conglomerate_of_life>)
  .setModid('contenttweaker')
  .addRecipeCatalyst(<contenttweaker:conglomerate_of_life>);

p.addSlot(IJeiUtils.createItemSlot('input', 0, 0, true, false)); // For entity
p.addElement(IJeiUtils.createArrowElement(SLOT_SIZE, 1, 0));
p.addSlot(IJeiUtils.createItemSlot('output', SLOT_SIZE + ARROW_WIDTH, 0, false, false)); // For item drop

p.register();

for entityDef, drops in scripts.cot.functions.lifeRecipes {
  if (isNull(entityDef)) continue;

  for item, outChance in drops {
    val recipe = JEI.createJeiRecipe('conglomerate_of_life');
    recipe.addInput(entityDef.asIngr());

    val outputStack = item.withLore(['§fChance: §b' ~ (outChance * 100) as int ~ '%']);
    val amount = outChance < 1.0 ? 1 : outChance;
    recipe.addOutput(outputStack * amount);
    recipe.build();
  }
}
