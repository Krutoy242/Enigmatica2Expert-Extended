#modloaded kami
#ignoreBracketErrors

// [Ichor]
mods.thaumcraft.Infusion.removeRecipe(<kami:ichor>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('ichor',
  'KAMI_ICHOR',
  100,
  Aspects('3⟁ 3🔥 3💨 3💧 3⚡ 3⛰️'),
  <kami:ichor> * 5,
  Grid(['pretty',
    'A E A',
    'B N I',
    'A F A'], {
    'E': <thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'ascension' }] }),
    'F': <thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'terminus' }] }),
    'N': <thaumicwonders:primordial_grain>,
    'B': <psi:material:3>, // Ebony psi metal
    'I': <psi:material:4>, // Ivony psi metal
    'A': <ore:gemAmber>, // Amber
}).shaped());

mods.astralsorcery.Lightwell.addLiquefaction(<kami:ichor>, <liquid:ichorium>, 0.1, 15.0, 15630848);
mods.astralsorcery.Lightwell.addLiquefaction(<kami:ichor_block>, <liquid:ichorium>, 0.2, 75.0, 15630848);

mods.thaumcraft.Infusion.removeRecipe(<kami:ichorium_ingot>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('ichor_cloth',
  'KAMI_ICHORWEAVE_FABRIC',
  50,
  Aspects('4⛰️ 4🔥 4💧'),
  <kami:ichorweave_fabric> * 4,
  Grid(['pretty',
    '  E  ',
    'E I E',
    '  E  '], {
    'I': <kami:ichorium_ingot>,
    'E': <thaumcraft:fabric>,
}).shaped());

mods.thaumcraft.ArcaneWorkbench.removeRecipe(<kami:blessed_silverwood_rod>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('blessed_silverwood_rod',
  'KAMI_ICHORIUM_TOOLS',
  50,
  Aspects('2⛰️ 2🔥 2💧 2⟁'),
  <kami:blessed_silverwood_rod>,
  Grid(['pretty',
    '  E I',
    'E W E',
    'W E  '], {
    'I': <kami:ichorium_ingot>,
    'W': <thaumcraft:log_silverwood>,
    'E': <randomthings:ingredient:5>
}).shaped());


mods.thaumcraft.Infusion.removeRecipe(<kami:awakened_ichorium_sword>);
mods.thaumcraft.Infusion.registerRecipe(
  'awakened_ichorium_sword', // Name
  'KAMI_AWAKENED_ICHORIUM_SWORD', // Research
  <kami:awakened_ichorium_sword>.withTag({ Unbreakable: 1 as byte, infench: [{ lvl: 4 as short, id: 5 as short }] }), // Output
  10, // Instability
  Aspects('500🗡️ 200❤️ 200💀 200🐲 200🗯️ 200♾️'),
  <kami:ichorweave_hood:*>, // CentralItem
  [<thaumadditions:mithminite_ingot>, <iceandfire:witherbone>, <ore:eyeOfDragon>, <twilightforest:raw_meef>]
);

mods.thaumcraft.Infusion.removeRecipe(<kami:awakened_ichorium_shovel>);
mods.thaumcraft.Infusion.registerRecipe(
  'awakened_ichorium_shovel', // Name
  'KAMI_AWAKENED_ICHORIUM_SHOVEL', // Research
  <kami:awakened_ichorium_shovel>.withTag({ mode: 0, Unbreakable: 1 as byte }), // Output
  10, // Instability
  Aspects('500⚰️ 200⛰️ 200🔗 200🛠️ 200🗯️ 200♾️'),
  <kami:ichorium_sword:*>, // CentralItem
  [<thaumadditions:mithminite_ingot>, <quark:soul_powder>, <thaumcraft:stone_porous>, <tconstruct:soil:4>]
);

mods.thaumcraft.Infusion.removeRecipe(<kami:awakened_ichorium_pickaxe>);
mods.thaumcraft.Infusion.registerRecipe(
  'awakened_ichorium_pickaxe', // Name
  'KAMI_AWAKENED_ICHORIUM_PICKAXE', // Research
  <kami:awakened_ichorium_pickaxe>.withTag({ mode: 0, Unbreakable: 1 as byte, infench: [{ lvl: 4 as short, id: 4 as short }] }), // Output
  10, // Instability
  Aspects('500💣 200⛰️ 200🛎️ 200🛠️ 200🗯️ 200♾️'),
  <kami:ichorium_pickaxe:*>, // CentralItem
  [<thaumadditions:mithminite_ingot>, <tconstruct:materials:13>, <thaumicwonders:hexamite>, <tconstruct:materials:12>]
);

mods.thaumcraft.Infusion.removeRecipe(<kami:awakened_ichorium_axe>);
mods.thaumcraft.Infusion.registerRecipe(
  'awakened_ichorium_axe', // Name
  'KAMI_AWAKENED_ICHORIUM_AXE', // Research
  <kami:awakened_ichorium_axe>.withTag({ mode: 0, Unbreakable: 1 as byte }), // Output
  10, // Instability
  
  Aspects('500🌱 200💪 200💣 200🛠️ 200🗯️ 200♾️'),
  <kami:ichorium_axe:*>, // CentralItem
  [<thaumadditions:mithminite_ingot>, <cyclicmagic:ender_lightning>, <bloodmagic:cutting_fluid:1>, <botania:lens:10>]
);

mods.thaumcraft.Infusion.removeRecipe(<kami:awakened_ichorweave_hood>);
mods.thaumcraft.Infusion.registerRecipe(
  'kami_helm', // Name
  'KAMI_AWAKENED_ICHORWEAVE_HOOD', // Research
  <kami:awakened_ichorweave_hood>, // Output
  10, // Instability
  Aspects('250🗯️ 150💧 125✨ 125🛡️ 60🧠 60❤️'),
  <kami:ichorweave_hood:*>, // CentralItem
  [<minecraft:ender_eye>, <tinkersaddons:modifier_item>, <thaumicwonders:night_vision_goggles>, <botania:quartz:1>]
);

mods.thaumcraft.Infusion.removeRecipe(<kami:awakened_ichorweave_robe>);
mods.thaumcraft.Infusion.registerRecipe(
  'kami_chest', // Name
  'KAMI_AWAKENED_ICHORWEAVE_ROBE', // Research
  <kami:awakened_ichorweave_robe>, // Output
  10, // Instability
  Aspects('250🗯️ 150💨 125🛡️ 125🕊️ 125⟁ 60👽'),
  <kami:ichorweave_robe:*>, // CentralItem
  [<botania:quartz:6>, <thaumicaugmentation:thaumostatic_harness>, <mysticalagradditions:stuff:3>, <minecraft:shield>]
);

mods.thaumcraft.Infusion.removeRecipe(<kami:awakened_ichorweave_leggings>);
mods.thaumcraft.Infusion.registerRecipe(
  'kami_legs', // Name
  'KAMI_AWAKENED_ICHORWEAVE_LEGGINGS', // Research
  <kami:awakened_ichorweave_leggings>, // Output
  10, // Instability
  Aspects('250🗯️ 150🔥 125🧨 125🛎️ 60🦉 60💀'),
  <kami:ichorweave_leggings:*>, // CentralItem
  [<thaumictinkerer:energetic_nitor>, <iceandfire:manuscript>, <thaumcraft:verdant_charm:*>, <botania:quartz:4>]
);

mods.thaumcraft.Infusion.removeRecipe(<kami:awakened_ichorweave_boots>);
mods.thaumcraft.Infusion.registerRecipe(
  'kami_boots', // Name
  'KAMI_AWAKENED_ICHORWEAVE_BOOTS', // Research
  <kami:awakened_ichorweave_boots>, // Output
  10, // Instability
  Aspects('250🗯️ 150⛰️ 125🛠️ 125🛡️ 60🌱 60🏃'),
  <kami:ichorweave_boots:*>, // CentralItem
  [<botania:quartz:5>, <thaumadditions:traveller_belt>, <rats:plague_essence>, <thaumcraft:lamp_growth>]
);

mods.thaumcraft.Infusion.removeRecipe(<kami:ichorium_caster>);
mods.thaumcraft.Infusion.registerRecipe(
  'kami_ichorium_caster', // Name
  'KAMI_ICHORIUM_CASTER', // Research
  <kami:ichorium_caster>, // Output
  10, // Instability
  
  Aspects('250✨ 250♾️ 150💪 250🔮 250〇'),
  <thaumicaugmentation:gauntlet:1>, // CentralItem
  [<thaumcraft:primordial_pearl:*>, <kami:ichorweave_fabric>, <kami:ichorium_ingot>, <kami:ichorweave_fabric>,  <kami:ichorium_ingot>, <kami:ichorweave_fabric>,  <kami:ichorium_ingot>, <kami:ichorweave_fabric>]
);

mods.thaumcraft.Infusion.removeRecipe(<kami:focus_pouch>);
mods.thaumcraft.Infusion.registerRecipe(
  'kami_focus_pouch', // Name
  'KAMI_BOTTOMLESS_POUCH', // Research
  <thaumcraft:focus_pouch>, // Output
  10, // Instability
  Aspects('100♾️ 150👨 250🔮 250〇 100🔨'),
  <kami:focus_pouch>, // CentralItem
  [<kami:ichorweave_fabric>, <thaumcraft:hungry_chest>, <kami:ichorweave_fabric>, <thaumictinkerer:arcane_quartz>, <kami:ichorweave_fabric>, <botania:manaresource:15>, <kami:ichorweave_fabric>, <thaumictinkerer:arcane_quartz>]
);

mods.thaumcraft.ArcaneWorkbench.removeRecipe(<kami:ichorweave_hood>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('ichorweave_hood',
  'KAMI_ICHORWEAVE_ARMOR',
  250,
  Aspects('8💧'),
  <kami:ichorweave_hood>,
  Grid(['pretty',
    'E E E',
    'E I E',
    '     '], {
    'I': <thaumcraft:void_robe_helm:*>, 
    'E': <kami:ichorweave_fabric>,
}).shaped());

mods.thaumcraft.ArcaneWorkbench.removeRecipe(<kami:ichorweave_robe>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('ichorweave_robe',
  'KAMI_ICHORWEAVE_ARMOR',
  250,
  Aspects('8💨'),
  <kami:ichorweave_robe>,
  Grid(['pretty',
    'E I E',
    'E E E',
    'E E E'], {
    'I': <thaumcraft:void_robe_chest:*>, 
    'E': <kami:ichorweave_fabric>,
}).shaped());

mods.thaumcraft.ArcaneWorkbench.removeRecipe(<kami:ichorweave_leggings>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('ichorweave_leggings',
  'KAMI_ICHORWEAVE_ARMOR',
  250,
  Aspects('8🔥'),
  <kami:ichorweave_leggings>,
  Grid(['pretty',
    'E E E',
    'E I E',
    'E   E'], {
    'I': <thaumcraft:void_robe_legs:*>, 
    'E': <kami:ichorweave_fabric>,
}).shaped());

mods.thaumcraft.ArcaneWorkbench.removeRecipe(<kami:ichorweave_boots>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('ichorweave_boots',
  'KAMI_ICHORWEAVE_ARMOR',
  250,
  Aspects('8⛰️'),
  <kami:ichorweave_boots>,
  Grid(['pretty',
    '     ',
    'E   E',
    'E I E'], {
    'I': <thaumicaugmentation:void_boots:*>, 
    'E': <kami:ichorweave_fabric>,
}).shaped());
