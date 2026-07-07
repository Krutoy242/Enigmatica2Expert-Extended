#modloaded thaumictinkerer
#ignoreBracketErrors


// [Feline Amulet]
mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:feline_charm>);
mods.thaumcraft.Infusion.registerRecipe(
  'cat_amulet', // Name
  'TT_FELINE_CHARM', // Research
  <thaumictinkerer:feline_charm>, // Output
  1, // Instability
  Aspects('50🐺 25🛎️ 50🙌'),
  <thaumcraft:baubles>, // CentralItem
  [<ore:gunpowder>, <actuallyadditions:item_hairy_ball>, <ore:listAllfishraw>, <actuallyadditions:item_hairy_ball>]
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:xp_talisman>);
mods.thaumcraft.Infusion.registerRecipe(
  'experience_charm', // Name
  'TT_XP_TALISMAN', // Research
  <thaumictinkerer:xp_talisman>, // Output
  2, // Instability
  Aspects('50〇 50✊ 100🧠'),
  <thaumcraft:baubles:1>, // CentralItem
  [<thaumictinkerer:arcane_quartz>, <thaumictinkerer:arcane_quartz>, <minecraft:glass_bottle>, <thaumictinkerer:arcane_quartz>, <thaumictinkerer:arcane_quartz>, <minecraft:glass_bottle>]
);

