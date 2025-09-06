#modloaded thaumictinkerer

// Fix conflict
// [Black Quartz Block] from [Smokey Quartz]
recipes.removeByRecipeName('thaumictinkerer:black_quartz_block');
craft.make(<thaumictinkerer:black_quartz_block>, ['pretty',
  '⌃   ⌃',
  '     ',
  '⌃   ⌃'], {
  '⌃': <ore:quartzDark>, // Smokey Quartz
});

// [Osmotic Enchanter] from [Shadow Enchanter][+7]
mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:osmotic_enchanter>);
mods.thaumcraft.Infusion.registerRecipe(
  'osmotic_enchanter', // Name
  'INFUSION', // Research
  <thaumictinkerer:osmotic_enchanter>, // Output
  8, // Instability
  Aspects('100🔮 100🧠 100👽'),
  <thaumadditions:shadow_enchanter> ?? <draconicevolution:diss_enchanter>, // Central Item
  Grid(['pretty',
    '▬ S ▬',
    'p   p',
    '▬ S ▬'], {
    '▬': <ore:ingotDraconium>, // Draconium Ingot
    'S': <randomthings:spectreilluminator>, // Spectre Illuminator
    'p': <thaumictinkerer:spellbinding_cloth>.anyDamage(), // Spellbinding Cloth
  }).spiral(1));

// Conversion recipe between Thaumic Tinkerer Black Quartz Block & Botania Block of Smokey Quartz
recipes.addShapeless(<botania:quartztypedark>, [<thaumictinkerer:black_quartz_block>]);
recipes.addShapeless(<thaumictinkerer:black_quartz_block>, [<botania:quartztypedark>]);

// [Nether shard]
mods.tconstruct.Casting.addTableRecipe(<thaumictinkerer:kamiresource:1>, <thaumcraft:nugget:9>, <fluid:xu_demonic_metal>, 48, true);
<thaumictinkerer:kamiresource:1>.addTooltip('§4Drops from zombie pigmens in the nether');

// [Ender shard]
mods.botania.ManaInfusion.addConjuration(<thaumictinkerer:kamiresource>, <enderio:item_material:62>, 1000);
<thaumictinkerer:kamiresource>.addTooltip('§3Drops from endermans in the end');

// Casting
mods.tconstruct.Casting.addBasinRecipe(<thaumictinkerer:ichor_block>, null, <liquid:molten_ichorium>, 1296);
mods.tconstruct.Casting.addTableRecipe(<thaumictinkerer:kamiresource:3>, <tconstruct:cast_custom:0>, <liquid:molten_ichorium>, 144);
mods.tconstruct.Casting.addTableRecipe(<thaumictinkerer:kamiresource:5>, <tconstruct:cast_custom:1>, <liquid:molten_ichorium>, 16);
mods.nuclearcraft.IngotFormer.addRecipe(<liquid:molten_ichorium> * 144, <thaumictinkerer:kamiresource:3>, 1.0, 1.0);

// [Ichor]
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('ichor',
  'TT_ICHOR@0',
  100,
  Aspects('3⟁ 3🔥 3💨 3💧 3⚡ 3⛰️'),
  <thaumictinkerer:kamiresource:2> * 5,
  Grid(['pretty',
    'A E A',
    'B A I',
    'A N A'], {
    'E': <thaumictinkerer:kamiresource>, // Ender shard
    'N': <thaumictinkerer:kamiresource:1>, // Nether shard
    'B': <psi:material:3>, // Ebony psi metal
    'I': <psi:material:4>, // Ivony psi metal
    'A': <ore:gemAmber>, // Amber
  }).shaped());

mods.astralsorcery.Lightwell.addLiquefaction(<thaumictinkerer:kamiresource:2>, <liquid:molten_ichorium>, 0.1, 15.0, 15630848);

recipes.remove(<thaumictinkerer:kamiresource:2>);
recipes.remove(<thaumictinkerer:ichor_block>);
mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:ichor_block>);
recipes.addShapeless('ichorium_block',<thaumictinkerer:ichor_block>,
  [<thaumictinkerer:kamiresource:3>,<thaumictinkerer:kamiresource:3>,<thaumictinkerer:kamiresource:3>,
    <thaumictinkerer:kamiresource:3>,<thaumictinkerer:kamiresource:3>,<thaumictinkerer:kamiresource:3>,
    <thaumictinkerer:kamiresource:3>,<thaumictinkerer:kamiresource:3>,<thaumictinkerer:kamiresource:3>,
  ]);
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumictinkerer:kamiresource:3>);
recipes.addShapeless('ichorium_block_to_ingot', <thaumictinkerer:kamiresource:3> * 9, [<thaumictinkerer:ichor_block>]);

mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumictinkerer:kamiresource:4>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('ichor_cloth',
  'TT_ICHORARMOR',
  50,
  Aspects('4⛰️ 4🔥 4💧'),
  <thaumictinkerer:kamiresource:4> * 4,
  Grid(['pretty',
    '  E  ',
    'E I E',
    '  E  '], {
    'I': <thaumictinkerer:kamiresource:3>, // Ichorium ingot
    'E': <thaumcraft:fabric>, // Enchanted fabric
  }).shaped());

// [Light gas phial]
mods.thaumcraft.Crucible.removeRecipe(<thaumictinkerer:gas_light_item>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('gas_light_item',
  'TT_GAS',
  10,
  [],
  <thaumictinkerer:gas_light_item> * 8,
  Grid(['pretty',
    'P P P',
    'P I P',
    'P P P'], {
    'P': <thaumcraft:phial>, // Phial
    'I': <astralsorcery:itemusabledust>, // Illumination powder
  }).shaped());

// [Shadow gas phial]
mods.thaumcraft.Crucible.removeRecipe(<thaumictinkerer:gas_shadow_item>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('gas_shadow_item',
  'TT_GAS',
  10,
  [],
  <thaumictinkerer:gas_shadow_item> * 8,
  Grid(['pretty',
    'P P P',
    'P I P',
    'P P P'], {
    'P': <thaumcraft:phial>, // Phial
    'I': <astralsorcery:itemusabledust:1>, // Illumination powder
  }).shaped());

// [Feline Amulet]
mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:cat_amulet>);
mods.thaumcraft.Infusion.registerRecipe(
  'cat_amulet', // Name
  'TT_CAT_AMULET', // Research
  <thaumictinkerer:cat_amulet>, // Output
  1, // Instability
  Aspects('50🐺 25🛎️ 50🙌'),
  <thaumcraft:baubles>, // CentralItem
  [<thaumictinkerer:kamiresource:2>, <actuallyadditions:item_hairy_ball>, <ore:listAllfishraw>, <actuallyadditions:item_hairy_ball>]
);

// [Cleansing charm]
mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:cleaning_talisman>);
mods.thaumcraft.Infusion.registerRecipe(
  'cleanser', // Name
  'TT_CLEANING_TALISMAN', // Research
  <thaumictinkerer:cleaning_talisman>, // Output
  3, // Instability
  Aspects('100❤️ 50⟁ 50🔷'),
  <thaumcraft:verdant_charm:*>, // CentralItem
  [<botania:quartz:5>, <rustic:elixir>.withTag({ ElixirEffects: [{ Effect: 'minecraft:instant_health', Duration: 1, Amplifier: 1 }] }), <ore:quartzDark>, <thaumicwonders:panacea>]
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:experience_charm>);
mods.thaumcraft.Infusion.registerRecipe(
  'experience_charm', // Name
  'TT_EXPERIENCE_CHARM', // Research
  <thaumictinkerer:experience_charm>, // Output
  2, // Instability
  Aspects('50〇 50✊ 100🧠'),
  <thaumictinkerer:kamiresource:1>, // CentralItem
  [<ore:quartzDark>, <ore:quartzDark>, <minecraft:glass_bottle>, <ore:quartzDark>, <ore:quartzDark>, <minecraft:glass_bottle>]
);

// [Celestial gateway + Celestial pearl]
mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:warp_gate>);
mods.thaumcraft.Infusion.registerRecipe(
  'warp_gate', // Name
  'TT_WARP_SERIES', // Research
  <thaumictinkerer:warp_gate>, // Output
  5, // Instability
  Aspects('100🏃 200👽 100♒ 100☀️'),
  <thaumicwonders:portal_anchor:*>, // CentralItem
  [<botania:biomestonea>, <botania:biomestonea:1>, <botania:biomestonea:2>, <botania:biomestonea:3>, <botania:biomestonea:4>, <botania:biomestonea:5>, <botania:biomestonea:6>, <botania:biomestonea:7>]
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:sky_pearl>);
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('sky_pearl',
  'TT_WARP_SERIES@0',
  50,
  Aspects('4⟁ 2💨'),
  <thaumictinkerer:sky_pearl>,
  Grid(['pretty',
    'I E I',
    'E M E',
    'I E I'], {
    'I': <thaumictinkerer:kamiresource:5>, // Ichorium nugget
    'M': <botania:manaresource:1>, // Mana pearl
    'E': <thaumictinkerer:kamiresource>, // Ender shard
  }).shaped());

mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumictinkerer:summoner>);
mods.thaumcraft.Infusion.registerRecipe(
  'summoner', // Name
  'TT_SUMMONING', // Research
  <thaumictinkerer:summoner>, // Output
  8, // Instability
  Aspects('100💀 100👻 200🦄 100👽'),
  <botania:terraplate>, // CentralItem
  [<thaumcraft:plate:3>, <thaumcraft:inlay>, <thaumcraft:plate:3>, <thaumcraft:inlay>, <thaumcraft:plate:3>, <thaumcraft:inlay>, <thaumcraft:plate:3>, <thaumcraft:inlay>]
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:blood_sword>);
mods.thaumcraft.Infusion.registerRecipe(
  'blood_sword', // Name
  'TT_SUMMONING', // Research
  <thaumictinkerer:blood_sword>, // Output
  5, // Instability
  Aspects('100🩸 50🐀 200⚰️'),
  <thaumcraft:thaumium_sword>, // CentralItem
  [<extrautils2:goldenlasso:1>, <iceandfire:dread_shard>, <iceandfire:dread_shard>, <iceandfire:dread_shard>,
    <extrautils2:goldenlasso:1>, <thaumictinkerer:kamiresource:1>, <thaumictinkerer:kamiresource:1>, <thaumictinkerer:kamiresource:1>]
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:kami_helm>);
mods.thaumcraft.Infusion.registerRecipe(
  'TT_kami_helm', // Name
  'TT_KAMIHELM', // Research
  <thaumictinkerer:kami_helm>, // Output
  10, // Instability
  Aspects('250🕯️ 150💧 125✨ 125🛡️ 60🧠 60❤️'),
  <thaumictinkerer:ichor_helm>, // CentralItem
  [<minecraft:ender_eye>, <tinkersaddons:modifier_item>, <thaumicwonders:night_vision_goggles>, <botania:quartz:1>]
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:kami_chest>);
mods.thaumcraft.Infusion.registerRecipe(
  'TT_kami_chest', // Name
  'TT_KAMICHEST', // Research
  <thaumictinkerer:kami_chest>, // Output
  10, // Instability
  Aspects('250🕯️ 150💨 125🛡️ 125🕊️ 125⟁ 60👽'),
  <thaumictinkerer:ichor_chest>, // CentralItem
  [<botania:quartz:6>, <thaumicaugmentation:thaumostatic_harness>, <mysticalagradditions:stuff:3>, <minecraft:shield>]
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:kami_legs>);
mods.thaumcraft.Infusion.registerRecipe(
  'TT_kami_legs', // Name
  'TT_KAMILEGS', // Research
  <thaumictinkerer:kami_legs>, // Output
  10, // Instability
  Aspects('250🕯️ 150🔥 125🧨 125🛎️ 60🦉 60💀'),
  <thaumictinkerer:ichor_legs>, // CentralItem
  [<thaumictinkerer:energetic_nitor>, <iceandfire:manuscript>, <thaumcraft:verdant_charm:*>, <botania:quartz:4>]
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:kami_boots>);
mods.thaumcraft.Infusion.registerRecipe(
  'TT_kami_boots', // Name
  'TT_KAMIBOOTS', // Research
  <thaumictinkerer:kami_boots>, // Output
  10, // Instability
  Aspects('250🕯️ 150⛰️ 125🛠️ 125🛡️ 60🌱 60🏃'),
  <thaumictinkerer:ichor_boots>, // CentralItem
  [<botania:quartz:5>, <thaumadditions:traveller_belt>, <rats:plague_essence>, <thaumcraft:lamp_growth>]
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:infused_seeds>);
