#modloaded immersiveengineering alfinivia jei
#priority 950

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.potions.IPotionEffect;
import mods.jei.JEI;
import mods.randomtweaker.jei.IJeiUtils;

val ARROW_WIDTH = 18 + 4;

val p = JEI.createJei("railgun_bullets", "Railgun Bullets")
  .setBackground(IJeiUtils.createBackground(18 * 4, 18 * 1))
  .setIcon(<immersiveengineering:railgun>)
  .setModid("alfinivia")
  .addRecipeCatalyst(<immersiveengineering:railgun>);

p.addSlot(IJeiUtils.createItemSlot("input", 0, 0, true, false));
p.addElement(IJeiUtils.createArrowElement(18, 1, 0));
p.addSlot(IJeiUtils.createItemSlot("output0", 18 + ARROW_WIDTH, 0, false, false));
p.addSlot(IJeiUtils.createItemSlot("output1", 18 * 2 + ARROW_WIDTH, 0, false, false));
p.register();

function addRailgunBulletJEI(item as IIngredient, damage as float, gravity as float) {
    JEI.createJeiRecipe("railgun_bullets")
        .addInput(item)
        .addOutput(<engineersdecor:sign_defense>.withDisplayName("§cDamage") * damage)
        .addOutput(<engineersdecor:sign_caution>.withDisplayName("§aGravity").withLore(["§7" ~ gravity]))
        .build();
}

static CHEM_ID as string = "chemthrower_effects";
val chem_p = JEI.createJei(CHEM_ID, "Chemthrower Effects")
    .setBackground(IJeiUtils.createBackground(18 * 5, 18 * 1))
    .setIcon(<immersiveengineering:chemthrower>)
    .setModid("alfinivia")
    .addRecipeCatalyst(<immersiveengineering:chemthrower>);

chem_p.addSlot(IJeiUtils.createLiquidSlot("input", 0, 0, 16, 16, 1, false, true, false));
chem_p.addElement(IJeiUtils.createArrowElement(18, 1, 0));
chem_p.addSlot(IJeiUtils.createItemSlot("output_damage", 18 + ARROW_WIDTH, 0, false, false));
chem_p.addSlot(IJeiUtils.createItemSlot("output_flammable", 18 * 2 + ARROW_WIDTH, 0, false, false));
chem_p.addSlot(IJeiUtils.createItemSlot("output_potion", 18 * 3 + ARROW_WIDTH, 0, false, false));
chem_p.register();

function addChemthrowerDamageJEI(liquid as ILiquidStack, damage as float) {
    JEI.createJeiRecipe(CHEM_ID).addInput(liquid)
        .addOutput(damage > 0 ? (<engineersdecor:sign_defense>).withDisplayName("§cDamage") * damage : null)
        .build();
}
function addChemthrowerFlammableJEI(liquid as ILiquidStack, damage as float) {
    JEI.createJeiRecipe(CHEM_ID).addInput(liquid)
        .addOutput(damage > 0 ? (<engineersdecor:sign_defense>).withDisplayName("§cDamage") * damage : null)
        .addOutput(<minecraft:flint_and_steel>.withDisplayName("§6Flammable"))
        .build();
}
function addChemthrowerPotionJEI(liquid as ILiquidStack, damage as float, effects as IPotionEffect[]) {
    val recipe = JEI.createJeiRecipe(CHEM_ID).addInput(liquid);
    recipe.addOutput(damage > 0 ? (<engineersdecor:sign_defense>).withDisplayName("§cDamage") * damage : null);
    for effect in effects {
        recipe.addOutput(<minecraft:potion>.withTag({CustomPotionEffects: [{
            Id: effect.potion.numericalId, Amplifier: effect.amplifier, Duration: effect.duration,
        }]}));
    }
    recipe.build();
}
function addChemthrowerRadiationJEI(liquid as ILiquidStack, damage as float, effects as IPotionEffect[]) {
    addChemthrowerPotionJEI(liquid, damage, effects);
}
