#modloaded psicosts

import crafttweaker.item.IIngredient;

// [Flux Resonator] from [Hardened Cell Frame][+3]
craft.remake(<psicosts:flux_resonator>, ['pretty',
  'O ▬ O',
  'C ◘ C',
  'O ▬ O'], {
  'C': <ore:sheetCopper>,                // Copper Sheet
  '◘': <thermalexpansion:frame:129>,     // Hardened Cell Frame
  '▬': <ore:ingotIvoryPsi>,              // Ivory Psimetal Ingot
  'O': <enderio:item_basic_capacitor:2>, // Octadic Capacitor
});

// [Psionic Lensing Pedestal] from [Rune of Fire][+3]
craft.remake(<psicosts:mana_resonator>, ['pretty',
  '□ □ □',
  '▲ F ▲',
  'l l l'], {
  '□': <ore:plateObsidian>, // ic2.plate.obsidian
  '▲': <ore:dustPsi>,       // Psidust
  'F': <ore:runeFireB>,     // Rune of Fire
  'l': <ore:livingrock>,    // Livingrock
});

// [Potentia Inverter] from [Phial of Potentia Essentia][+5]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<psicosts:essentia_resonator>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
  "essentia_resonator", # Name
  "FIRSTSTEPS", # Research
  100, # Vis cost
  Aspects('🔥 ⟁'),
  <psicosts:essentia_resonator>, # Output
  Grid(['pretty',
  'i ▲ i',
  '□   □',
  'i ▲ i'], {
  'i': <ic2:casing:3>,   // ic2.casing.iron
  '▲': <ore:dustPsi>,    // Psidust
  '□': <ore:plateBrass>, // Brass Plate
}).shaped());

val ingrs = {
  'P': <psicosts:material_glassy>,  // Psi Glass
  '1': <psicosts:psi_cell:0>.marked('marked'), // PSI Cell
  '2': <psicosts:psi_cell:1>.marked('marked'), // PSI-O Cell
  '3': <psicosts:psi_cell:2>.marked('marked'), // PSI-Dyne Cell
  '□': <ore:plateSilver>,           // Silver Plate
  'S': <cyclicmagic:soulstone>,     // Soulstone
  'M': <tconstruct:materials:19>,   // Mending Moss
  '-': <ore:ingotEnergeticAlloy>,   // Energetic Alloy Ingot
  '_': <ore:ingotVibrantAlloy>,
  '▬': <ore:ingotCrystallineAlloy>,
  '◊': <ore:gemPsi>,                // Psigem
  '=': <ore:ingotPsi>,              // Psimetal Ingot
  '≡': <ore:ingotEbonyPsi>,         // Ebony Psimetal Ingot
} as IIngredient[string];

// [PSI Cell] from [Mending Moss][+2]
craft.remake(<psicosts:psi_cell>, ['pretty',
  '□ P □',
  'M P M',
  '□ P □'], ingrs
);

// [PSI-O Cell] from [PSI Cell][+3]
craft.remake(<psicosts:psi_cell:1>, ['pretty',
  '= - =',
  'M 1 M',
  '□ - □'], ingrs,
utils.upgradeFnc);

// [PSI-Dyne Cell] from [PSI-O Cell][+3]
craft.remake(<psicosts:psi_cell:2>, ['pretty',
  '◊ _ ◊',
  'M 2 M',
  '□ _ □'], ingrs,
utils.upgradeFnc);

// [PSI-Force Cell] from [PSI-Dyne Cell][+3]
craft.remake(<psicosts:psi_cell:3>, ['pretty',
  '≡ ▬ ≡',
  'S 3 S',
  '□ ▬ □'], ingrs,
utils.upgradeFnc);

// [Star of PSI] from [PSI-Dyne Cell][+4]
craft.remake(<psicosts:creative_cell>, ['pretty',
  'P   § § P',
  '§ ▬ D ▬  ',
  '§ D ◘ D §',
  '  ▬ D ▬ §',
  'P § §   P'], {
  'P': <ore:ingotSpectre>,
  'D': <thaumadditions:taintwood_planks> ?? <thaumcraft:taint_log>,
  '§': <deepmoblearning:glitch_infused_ingot>,  // Glitch Infused Ingot
  '◘': <psicosts:psi_cell:2>,                   // PSI-Dyne Cell
  '▬': <ore:ingotEbonyPsi>,                     // Ebony Psimetal Ingot
});
