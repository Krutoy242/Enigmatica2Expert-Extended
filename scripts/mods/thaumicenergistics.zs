#modloaded thaumicenergistics

import crafttweaker.item.IIngredient;

/*
This fix not working - event not fired at all

# Fix Essentia cells right-click dissassemble
# Without this fix components not returned always
# https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/30
events.onEntityLivingUseItem(function(e as crafttweaker.event.EntityLivingUseItemEvent.All){
  if(!e.isPlayer || e.player.world.remote) return;
  e.player.sendMessage("§7Entering onEntityLivingUseItemStart");
  if(!e.player.isSneaking) return;
  e.player.sendMessage("§7Player Sneaking");
  val id = e.item.definition.id;
  if(!id.startsWith("thaumicenergistics:essentia_cell_")) return;
  e.player.sendMessage("§7startsWith essentia_cell_");
  e.item.mutable().shrink(1);
  e.player.give(<appliedenergistics2:material:39>);
  e.player.give(itemUtils.getItem(id.replaceAll("_cell_", "_component_")));
  e.cancel();
  e.player.sendMessage("§7Finished");
});

*/

// [1k ME Essentia Storage Component]
mods.thaumcraft.Infusion.removeRecipe(<thaumicenergistics:essentia_component_1k>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('essentia_component_1k',
  'ESSENTIASTORAGE1k',
  10,
  [],
  <thaumicenergistics:essentia_component_1k>,
  Grid(['pretty',
    'Q L Q',
    'C C C',
    'Q L Q'], {
    'C': <appliedenergistics2:material:1>, // Certus quartz
    'L': <appliedenergistics2:material:22>, // Logic processor
    'Q': <thaumcraft:nugget:5>, // Quicksilver nugget
}).shaped());

// [4k ME Essentia Storage Component]
mods.thaumcraft.Infusion.removeRecipe(<thaumicenergistics:essentia_component_4k>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('essentia_component_4k',
  'ESSENTIASTORAGE4k',
  10,
  [],
  <thaumicenergistics:essentia_component_4k>,
  Grid(['pretty',
    'Q L Q',
    'C I C',
    'Q L Q'], {
    'I': <thaumcraft:mechanism_simple>, // Simple mechanism
    'C': <thaumicenergistics:essentia_component_1k>, // 1k ME Essentia Storage Component
    'L': <appliedenergistics2:material:22>, // Logic processor
    'Q': <thaumcraft:nugget:5>, // Quicksilver nugget
}).shaped());

// [16k ME Essentia Storage Component]
mods.thaumcraft.Infusion.removeRecipe(<thaumicenergistics:essentia_component_16k>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('essentia_component_16k',
  'ESSENTIASTORAGE16k',
  10,
  [],
  <thaumicenergistics:essentia_component_16k>,
  Grid(['pretty',
    'Q L Q',
    'C I C',
    'Q L Q'], {
    'I': <thaumcraft:mechanism_complex>, // Complex mechanism
    'C': <thaumicenergistics:essentia_component_4k>, // 4k ME Essentia Storage Component
    'L': <appliedenergistics2:material:23>, // Calculation processor
    'Q': <thaumcraft:nugget:5>, // Quicksilver nugget
}).shaped());

// [64k ME Essentia Storage Component]
mods.thaumcraft.Infusion.removeRecipe(<thaumicenergistics:essentia_component_64k>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('essentia_component_64k',
  'ESSENTIASTORAGE64k',
  10,
  [],
  <thaumicenergistics:essentia_component_64k>,
  Grid(['pretty',
    'Q L Q',
    'C I C',
    'Q L Q'], {
    'I': <thaumicwonders:primordial_grain>, // Primordial grain
    'C': <thaumicenergistics:essentia_component_16k>, // 16k ME Essentia Storage Component
    'L': <appliedenergistics2:material:23>, // Calculation processor
    'Q': <thaumcraft:nugget:5>, // Quicksilver nugget
}).shaped());



val cellIngrs = {
  '⌃': <thaumicaugmentation:fortified_glass>, // Quartz Glass
  '♥': <ore:plateConcrete>,
  '□': <thaumcraft:plate>, // Iron Plate
  'I': <thaumadditions:jar_eldritch>, // Iron Chest
  '1': <thaumicenergistics:essentia_component_1k>, // 1k ME Essentia Storage Component
  '4': <thaumicenergistics:essentia_component_4k>, // 4k ME Essentia Storage Component
  '6': <thaumicenergistics:essentia_component_16k>, // 16k ME Essentia Storage Component
  'k': <thaumicenergistics:essentia_component_64k>, // 64k ME Essentia Storage Component
} as IIngredient[string];

// [1k ME Essentia Storage Cell] from [1k ME Essentia Storage Component][+4]
recipes.remove(<thaumicenergistics:essentia_cell_1k>);
craft.make(<thaumicenergistics:essentia_cell_1k>, ['pretty',
  '⌃ ♥ ⌃',
  '♥ 1 ♥',
  '□ I □'], cellIngrs
);

// [4k ME Essentia Storage Cell] from [4k ME Essentia Storage Component][+4]
recipes.remove(<thaumicenergistics:essentia_cell_4k>);
craft.make(<thaumicenergistics:essentia_cell_4k>, ['pretty',
  '⌃ ♥ ⌃',
  '♥ 4 ♥',
  '□ I □'], cellIngrs
);

// [16k ME Essentia Storage Cell] from [16k ME Essentia Storage Component][+4]
recipes.remove(<thaumicenergistics:essentia_cell_16k>);
craft.make(<thaumicenergistics:essentia_cell_16k>, ['pretty',
  '⌃ ♥ ⌃',
  '♥ 6 ♥',
  '□ I □'], cellIngrs
);

// [64k ME Essentia Storage Cell] from [64k ME Essentia Storage Component][+4]
recipes.remove(<thaumicenergistics:essentia_cell_64k>);
craft.make(<thaumicenergistics:essentia_cell_64k>, ['pretty',
  '⌃ ♥ ⌃',
  '♥ k ♥',
  '□ I □'], cellIngrs
);

// [Essentia Infusion Provider] from [ME Interface][+7]
mods.thaumcraft.Infusion.removeRecipe(<thaumicenergistics:infusion_provider>);
mods.thaumcraft.Infusion.registerRecipe(
  'infusion_provider', // Name
  'INFUSIONPROVIDER', // Research
  <thaumicenergistics:infusion_provider>, // Output
  7, // Instability
  Aspects('100🔨 100🙌 100🔮'),
  <appliedenergistics2:interface>, // Central Item
  Grid(['pretty',
    '▬ ‚ ▬',
    'C   C',
    '▬ ‚ ▬'], {
    '▬': <ore:ingotFluixSteel>, // Fluix Steel Ingot
    '‚': <ore:nuggetPrimordial>, // Primal Metal Nugget
    'C': <thaumicenergistics:coalescence_core>, // Coalescence Core
  }).spiral(1));

// [Creative ME Essentia Storage Cell] from [ME Storage Housing][+5]
craft.remake(<thaumicenergistics:essentia_cell_creative>, ['pretty',
  '      6      ',
  '    T E T    ',
  '  T C S C T  ',
  '6 E S M S E 6',
  '  T C S C T  ',
  '    T E T    ',
  '      6      '], {
  '6': <thaumicenergistics:essentia_component_64k>, // 64k ME Essentia Storage Component
  'T': <ore:sheetTitanium>, // Titanium Sheet
  'E': <ore:processorElite>, // Elite Processor
  'C': <thaumicwonders:creative_essentia_jar>, // Creative Essentia Jar
  'S': <threng:material:14>, // Speculative Processor
  'M': <appliedenergistics2:material:39>, // ME Storage Housing
});

// [Arcane Crafting Terminal] from [ME Terminal][+3]
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumicenergistics:arcane_terminal>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(
  "arcane_terminal", # Name
  "ARCANETERMINAL", # Research
  50, # Vis cost
  [],
  <thaumicenergistics:arcane_terminal>, # Output
  Grid(['pretty',
  '  N  ',
  '¤ M ¤',
  '  A  '], {
  'N': <thermallogistics:manager>,     // Network Manager
  '¤': <ore:gearVibrant>,              // Vibrant Bimetal Gear
  'M': <appliedenergistics2:part:380>, // ME Terminal
  'A': <thaumcraft:arcane_workbench>,  // Arcane Workbench
}).shaped());
