#modloaded thaumictinkerer
#ignoreBracketErrors

import mods.thaumictinkerer.NecromancyTablet;

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

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:necromancy_tablet>);
mods.thaumcraft.Infusion.registerRecipe(
  'necromancy_tablet', // Name
  'TT_NECROMANCY', // Research
  <thaumictinkerer:necromancy_tablet>, // Output
  2, // Instability
  Aspects('75💀 75👻 50⚰️ 50🔄 30✊ 75❤️'), 
  <quark:obsidian_pressure_plate>, // CentralItem
  [<thaumictinkerer:arcane_quartz>, <minecraft:iron_bars>, <thaumictinkerer:arcane_quartz>, <minecraft:iron_bars>, <thaumictinkerer:arcane_quartz>, <minecraft:iron_bars>, <thaumictinkerer:arcane_quartz>, <thaumictinkerer:escape_sigil>]
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:entity_soul_peaceful>);
mods.thaumcraft.Crucible.registerRecipe(
  'entity_soul_peaceful', // Name
  'TT_NECROMANCY', // Research
  <thaumictinkerer:entity_soul_peaceful>, // Output
  <thaumcraft:alumentum>, // Input
  Aspects('10🐺 10❤️')
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:entity_soul_hostile>);
mods.thaumcraft.Crucible.registerRecipe(
  'entity_soul_hostile', // Name
  'TT_HOSTILE_SOUL', // Research
  <thaumictinkerer:entity_soul_hostile>, // Output
  <thaumcraft:alumentum>, // Input
  Aspects('10💀 10⚰️')
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:entity_soul_arcane>);
mods.thaumcraft.Crucible.registerRecipe(
  'entity_soul_arcane', // Name
  'TT_ARCANE_SOUL', // Research
  <thaumictinkerer:entity_soul_arcane>, // Output
  <thaumcraft:alumentum>, // Input
  Aspects('10🔮 10👨 10🧠')
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:entity_soul_demonic>);
mods.thaumcraft.Crucible.registerRecipe(
  'entity_soul_demonic', // Name
  'TT_DEMONIC_SOUL', // Research
  <thaumictinkerer:entity_soul_demonic>, // Output
  <thaumcraft:alumentum>, // Input
  Aspects('20🧨 10💀')
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:entity_soul_alien>);
mods.thaumcraft.Crucible.registerRecipe(
  'entity_soul_alien', // Name
  'TT_ALIEN_SOUL', // Research
  <thaumictinkerer:entity_soul_alien>, // Output
  <thaumcraft:alumentum>, // Input
  Aspects('20👽 10🌑')
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:entity_soul_tainted>);
mods.thaumcraft.Crucible.registerRecipe(
  'entity_soul_tainted', // Name
  'TT_TAINTED_SOUL', // Research
  <thaumictinkerer:entity_soul_tainted>, // Output
  <thaumcraft:alumentum>, // Input
  Aspects('20🍇 10❤️')
);

mods.thaumcraft.Infusion.removeRecipe(<thaumictinkerer:entity_soul_eldritch>);
mods.thaumcraft.Crucible.registerRecipe(
  'entity_soul_eldritch', // Name
  'TT_ELDRITCH_SOUL', // Research
  <thaumictinkerer:entity_soul_eldritch>, // Output
  <thaumcraft:alumentum>, // Input
  Aspects('15👽 15👻') 
);

NecromancyTablet.removeAll();

NecromancyTablet.addRecipe('minecraft:cow', <entity:minecraft:cow>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('2🐺 2⛰️ 1🛡️'),
[<ore:bone>, <thaumcraft:tallow>, <ore:leather>]);
NecromancyTablet.addRecipe('minecraft:sheep', <entity:minecraft:sheep>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('2🐺 2⛰️ 1🔨'), 
[<ore:bone>, <thaumcraft:tallow>, <ore:string>, <ore:string>]);
NecromancyTablet.addRecipe('minecraft:pig', <entity:minecraft:pig>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('2🐺 2⛰️ 1❤️'),
[<ore:bone>, <thaumcraft:tallow>, <thaumcraft:tallow>]);
NecromancyTablet.addRecipe('minecraft:chicken', <entity:minecraft:chicken>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('2🐺 2🕊️ 1🍃'),
[<ore:bone>, <thaumcraft:tallow>, <ore:feather>]);
NecromancyTablet.addRecipe('minecraft:rabbit', <entity:minecraft:rabbit>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('2🐺 2👁️ 1🍃'),
[<ore:bone>, <thaumcraft:tallow>, <minecraft:rabbit_hide>]);
NecromancyTablet.addRecipe('minecraft:wolf', <entity:minecraft:wolf>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('4🐺 2⛰️ 1🗡️'),
[<ore:bone>, <thaumcraft:tallow>, <ore:bone>, <ore:bone>]);
NecromancyTablet.addRecipe('thaumadditions:blue_wolf', <entity:thaumadditions:blue_wolf>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('4🐺 2⛰️ 1🗡️'),
[<thaumadditions:blue_bone>, <thaumcraft:tallow>, <ore:bone>, <ore:bone>]);
NecromancyTablet.addRecipe('minecraft:ocelot', <entity:minecraft:ocelot>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('4🐺 2⛰️ 1✊'),
[<ore:bone>, <thaumcraft:tallow>, <ore:fish>, <ore:gunpowder>]);
NecromancyTablet.addRecipe('minecraft:parrot', <entity:minecraft:parrot>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('4🐺 2🕊️ 1🛎️'),
[<ore:bone>, <thaumcraft:tallow>, <ore:feather>, <ore:dye>]);
NecromancyTablet.addRecipe('minecraft:horse', <entity:minecraft:horse>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('8🐺 2⛰️ 1🏃'),
[<ore:bone>, <thaumcraft:tallow>, <ore:leather>, <ore:leather>, <minecraft:apple>]);
NecromancyTablet.addRecipe('minecraft:donkey', <entity:minecraft:donkey>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('6🐺 2⛰️ 1🔗'),
[<ore:bone>, <thaumcraft:tallow>, <ore:leather>, <ore:leather>, <minecraft:apple>, <minecraft:carrot>]);
NecromancyTablet.addRecipe('minecraft:mule', <entity:minecraft:mule>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('6🐺 2⛰️ 1🙌'),
[<ore:bone>, <thaumcraft:tallow>, <ore:leather>, <ore:leather>, <minecraft:carrot>]);
NecromancyTablet.addRecipe('minecraft:llama', <entity:minecraft:llama>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('6🐺 2⛰️ 1🔄'),
[<ore:bone>, <thaumcraft:tallow>, <ore:leather>, <ore:wool>, <ore:slimeball>]);
NecromancyTablet.addRecipe('minecraft:polar_bear', <entity:minecraft:polar_bear>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('10🐺 2⛰️ 4🧊'),
[<ore:bone>, <thaumcraft:tallow>, <ore:fish>, <minecraft:snowball>, <minecraft:snowball>, <ore:wool>]);
NecromancyTablet.addRecipe('minecraft:squid', <entity:minecraft:squid>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('2🐺 2💧 1🌑'),
[<ore:fish>, <ore:listAllwater>]);
NecromancyTablet.addRecipe('minecraft:bat', <entity:minecraft:bat>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('2🐺 2🕊️ 1🌑'),
[<ore:leather>, <ore:feather>]);
NecromancyTablet.addConsumingRecipe('minecraft:mooshroom', <entity:minecraft:mooshroom>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('2🐺 2⛰️ 1❤️'),
[<ore:bone>, <thaumcraft:tallow>, <ore:leather>, <ore:mushroomAny>]);
NecromancyTablet.addConsumingRecipe('rats:rat', <entity:rats:rat>, <thaumictinkerer:entity_soul_peaceful:*>, Aspects('2🐀'),
[<ore:bone>, <thaumcraft:tallow>, <ore:foodCheese>]);

NecromancyTablet.addRecipe('minecraft:zombie', <entity:minecraft:zombie>, <thaumictinkerer:entity_soul_hostile:*>, Aspects('2💀 2⚰️ 4👨'),
[<thaumcraft:tallow>, <ore:bone>, <ore:itemSkull>, <minecraft:rotten_flesh>, <thaumcraft:brain>]);
NecromancyTablet.addRecipe('minecraft:husk', <entity:minecraft:husk>, <thaumictinkerer:entity_soul_hostile:*>, Aspects('2💀 2⚰️ 4👨 2⚡'),
[<thaumcraft:tallow>, <ore:bone>, <ore:itemSkull>, <ore:sand>, <thaumcraft:brain>]);
NecromancyTablet.addRecipe('minecraft:skeleton', <entity:minecraft:skeleton>, <thaumictinkerer:entity_soul_hostile:*>, Aspects('2⚰️ 2⚡ 4🗡️'),
[<thaumcraft:tallow>, <minecraft:bow>, <ore:bone>, <ore:itemSkull>, <minecraft:dye:15>, <ore:arrow>]);
NecromancyTablet.addRecipe('minecraft:stray', <entity:minecraft:stray>, <thaumictinkerer:entity_soul_hostile:*>, Aspects('2⚰️ 2⚡ 4🗡️ 2🧊'),
[<thaumcraft:tallow>, <minecraft:bow>, <ore:bone>, <ore:itemSkull>, <ore:arrow>, <minecraft:snowball>]);
NecromancyTablet.addRecipe('minecraft:creeper', <entity:minecraft:creeper>, <thaumictinkerer:entity_soul_hostile:*>, Aspects('4💣 4🔥 1⚗️ 2⚡'),
[<ore:treeLeaves>, <ore:bone>, <ore:gunpowder>, <minecraft:tnt>]);
NecromancyTablet.addRecipe('minecraft:spider', <entity:minecraft:spider>, <thaumictinkerer:entity_soul_hostile:*>, Aspects('4🐺 2🔗 2🦉'),
[<thaumcraft:tallow>, <minecraft:spider_eye>, <minecraft:spider_eye>, <ore:string>, <ore:string>]);
NecromancyTablet.addRecipe('minecraft:slime', <entity:minecraft:slime>, <thaumictinkerer:entity_soul_hostile:*>, Aspects('2💧 2❤️'),
[<thaumcraft:tallow>, <minecraft:slime>, <ore:listAllwater>]);
NecromancyTablet.addRecipe('minecraft:guardian', <entity:minecraft:guardian>, <thaumictinkerer:entity_soul_hostile:*>, Aspects('4💧 2🛡️ 2🦉'),
[<thaumcraft:tallow>, <minecraft:prismarine_shard>, <minecraft:prismarine_shard>, <minecraft:prismarine_crystals>, <ore:listAllwater> ]);
NecromancyTablet.addRecipe('minecraft:silverfish', <entity:minecraft:silverfish>, <thaumictinkerer:entity_soul_hostile:*>, Aspects('4⚡ 2〇 2🔗'),
[<thaumcraft:tallow>, <ore:cobblestone>, <ore:stone>, <ore:stone>]);
NecromancyTablet.addRecipe('thaumcraft:brainyzombie', <entity:thaumcraft:brainyzombie>, <thaumictinkerer:entity_soul_hostile:*>, Aspects('2💀 2⚰️ 4👨 2🧠'),
[<thaumcraft:tallow>, <ore:bone>, <ore:itemSkull>, <minecraft:rotten_flesh>, <thaumcraft:brain>]);
NecromancyTablet.addRecipe('thaumcraft:giantbrainyzombie', <entity:thaumcraft:giantbrainyzombie>, <thaumictinkerer:entity_soul_hostile:*>, Aspects('2💀 2⚰️ 4👨 6🙌 4🦄'),
[<thaumcraft:tallow>, <ore:bone>, <ore:itemSkull>, <minecraft:rotten_flesh>, <thaumcraft:brain>, <mia:kobold_ring>]);
NecromancyTablet.addRecipe('thaumcraft:wisp', <entity:thaumcraft:wisp>, <thaumictinkerer:entity_soul_hostile:*>, Aspects('1💨 1💧 1🔥 1⟁ 1⚡ 1⛰️'),
[
<thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'aer' }] }),
<thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'aqua' }] }),
<thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'ignis' }] }),
<thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'ordo' }] }),
<thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'perditio' }] }),
<thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'terra' }] }),
]);

NecromancyTablet.addConsumingRecipe('minecraft:villager', <entity:minecraft:villager>, <thaumictinkerer:entity_soul_arcane:*>, Aspects('10👨 5🔄 5⟁'),
[<ore:bone>, <thaumcraft:tallow>, <ore:itemSkull>, <ore:gemEmerald>, <thaumcraft:brain>, <minecraft:potion>.withTag({ Potion: 'minecraft:healing' })]);
NecromancyTablet.addConsumingRecipe('minecraft:evocation_illager', <entity:minecraft:evocation_illager>, <thaumictinkerer:entity_soul_arcane:*>, Aspects('10👨 5🔮 5🗡️'),
[<ore:bone>, <thaumcraft:tallow>, <ore:itemSkull>, <ore:blockEmerald>, <thaumcraft:nugget:10>, <thaumcraft:fabric>, <thaumcraft:fabric>, <randomthings:ingredient:5>]);
NecromancyTablet.addConsumingRecipe('minecraft:vindication_illager', <entity:minecraft:vindication_illager>, <thaumictinkerer:entity_soul_arcane:*>, Aspects('10👨 5✊ 5🗡️'),
[<ore:bone>, <thaumcraft:tallow>, <ore:itemSkull>, <ore:gemEmerald>, <minecraft:iron_axe:*>, <minecraft:leather_chestplate:*>, <thaumcraft:nugget:10>]);
NecromancyTablet.addRecipe('minecraft:vex', <entity:minecraft:vex>, <thaumictinkerer:entity_soul_arcane:*>, Aspects('4🕊️ 2🗡️ 2🔮'),
[<cyclicmagic:corrupted_chorus>, <thaumcraft:tallow>, <rats:rat_upgrade_flight>, <mia:kobold_ring>]);
NecromancyTablet.addRecipe('minecraft:witch', <entity:minecraft:witch>, <thaumictinkerer:entity_soul_arcane:*>, Aspects('4👨 2🔮 2⚗️'),
[<ore:bone>, <thaumcraft:tallow>, <ore:itemSkull>, <actuallyadditions:item_hairy_ball>, <cyclicmagic:ender_lightning:*>]);
NecromancyTablet.addConsumingRecipe('thaumcraft:pech', <entity:thaumcraft:pech>, <thaumictinkerer:entity_soul_arcane:*>, Aspects('10👨 10✊ 5🔄'),
[<ore:bone>, <thaumcraft:tallow>, <ore:itemSkull>, <twilightforest:magic_map_focus>, <thaumcraft:fabric>, <thaumcraft:nugget:10>]);

NecromancyTablet.addRecipe('minecraft:zombie_pigman', <entity:minecraft:zombie_pigman>, <thaumictinkerer:entity_soul_demonic:*>, Aspects('2💀 2⚰️ 4🐺'),
[<thaumcraft:tallow>, <ore:bone>, <ore:itemSkull>, <minecraft:rotten_flesh>, <thaumcraft:brain>, <minecraft:porkchop>]);
NecromancyTablet.addRecipe('minecraft:magma_cube', <entity:minecraft:magma_cube>, <thaumictinkerer:entity_soul_demonic:*>, Aspects('2💧 2❤️ 1🧨'),
[<thaumcraft:tallow>, <minecraft:slime>, <minecraft:magma>]);
NecromancyTablet.addRecipe('minecraft:wither_skeleton', <entity:minecraft:wither_skeleton>, <thaumictinkerer:entity_soul_demonic:*>, Aspects('2⚰️ 4⚡ 4🗡️ 4👻'),
[<thaumcraft:tallow>, <ore:coal>, <ore:bone>, <minecraft:skull:1>, <biomesoplenty:ash>, <biomesoplenty:ash>]);
NecromancyTablet.addRecipe('minecraft:blaze', <entity:minecraft:blaze>, <thaumictinkerer:entity_soul_demonic:*>, Aspects('4🔥 4🧨'),
[<minecraft:nether_brick>, <minecraft:blaze_powder>, <minecraft:blaze_powder>, <minecraft:blaze_powder>, <minecraft:fire_charge>]);
NecromancyTablet.addRecipe('thaumcraft:firebat', <entity:thaumcraft:firebat>, <thaumictinkerer:entity_soul_demonic:*>, Aspects('4🐺 4🔥 2🧨 2🕊️'),
[<ore:leather>, <ore:feather>, <ore:gunpowder>, <minecraft:blaze_powder>]);

NecromancyTablet.addRecipe('minecraft:enderman', <entity:minecraft:enderman>, <thaumictinkerer:entity_soul_alien:*>, Aspects('8👽 4🌑'),
[<thaumcraft:tallow>, <thaumcraft:salis_mundus>, <minecraft:ender_eye>, <ore:endstone>, <ore:netherrack>, <ore:grass>]);
NecromancyTablet.addRecipe('minecraft:endermite', <entity:minecraft:endermite>, <thaumictinkerer:entity_soul_alien:*>, Aspects('4👽 2〇 2🔗'),
[<thaumcraft:tallow>, <thaumcraft:salis_mundus>, <minecraft:end_bricks>, <minecraft:end_bricks>, <minecraft:ender_eye>]);
NecromancyTablet.addConsumingRecipe('minecraft:shulker', <entity:minecraft:shulker>, <thaumictinkerer:entity_soul_alien:*>, Aspects('8👽 2🕊️ 2🛎️'),
[<thaumcraft:tallow>, <thaumcraft:salis_mundus>, <ore:stonePurpur>, <ore:stonePurpur>, <minecraft:ender_eye>, <ore:itemSkull>]);
NecromancyTablet.addConsumingRecipe('endreborn:chronologist', <entity:endreborn:chronologist>, <thaumictinkerer:entity_soul_alien:*>, Aspects('6👽 4✊ 2👁️'),
[<thaumcraft:tallow>, <thaumcraft:salis_mundus>, <minecraft:ender_eye>, <minecraft:chorus_flower>, <ore:stonePurpur>, <ore:endstone>]);
NecromancyTablet.addRecipe('endreborn:endguard', <entity:endreborn:endguard>, <thaumictinkerer:entity_soul_alien:*>, Aspects('6👽 2🕊️ 2🍃'),
[<thaumcraft:tallow>, <thaumcraft:salis_mundus>, <minecraft:chorus_fruit>, <minecraft:chorus_fruit>, <minecraft:chorus_fruit>]);
NecromancyTablet.addRecipe('endreborn:watcher', <entity:endreborn:watcher>, <thaumictinkerer:entity_soul_alien:*>, Aspects('6👽 4🌑 2🦉'),
[<thaumcraft:tallow>, <thaumcraft:salis_mundus>, <minecraft:ender_eye>, <ore:endstone>, <ore:endstone>, <ore:endstone>]);

val vitiumCrystal = <thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'vitium' }] });
NecromancyTablet.addRecipe('thaumcraft:taintacle', <entity:thaumcraft:taintacle>, <thaumictinkerer:entity_soul_tainted:*>, Aspects('4🍇 1👽 4❤️'),
[<thaumcraft:tallow>, vitiumCrystal, <harvestcraft:octopuscookeditem>]);
NecromancyTablet.addRecipe('thaumcraft:taintcrawler', <entity:thaumcraft:taintcrawler>, <thaumictinkerer:entity_soul_tainted:*>, Aspects('4🍇 2〇 2🔗'),
[<thaumcraft:tallow>, vitiumCrystal, <minecraft:spider_eye>, <thaumcraft:salis_mundus>]);
NecromancyTablet.addRecipe('thaumcraft:taintswarm', <entity:thaumcraft:taintswarm>, <thaumictinkerer:entity_soul_tainted:*>, Aspects('4🍇 4🩸'),
[<thaumcraft:tallow>, vitiumCrystal, <minecraft:spider_eye>, <minecraft:dye:15>]);
NecromancyTablet.addConsumingRecipe('thaumcraft:taintseed', <entity:thaumcraft:taintseed>, <thaumictinkerer:entity_soul_tainted:*>, Aspects('10🍇 4❤️'),
[<thaumcraft:tallow>, vitiumCrystal, vitiumCrystal, <thaumcraft:condenser_lattice_dirty>, <thaumcraft:potion_sprayer>]);
NecromancyTablet.addConsumingRecipe('thaumcraft:thaumslime', <entity:thaumcraft:thaumslime>, <thaumictinkerer:entity_soul_tainted:*>, Aspects('2🍇 4⚗️ 4💧'),
[<thaumcraft:tallow>, vitiumCrystal, vitiumCrystal, <minecraft:slime>]);

NecromancyTablet.addRecipe('thaumicaugmentation:eldritch_guardian', <entity:thaumicaugmentation:eldritch_guardian>, <thaumictinkerer:entity_soul_eldritch:*>, Aspects('10👽 6⚰️ 4〇'),
[<thaumcraft:tallow>, <thaumcraft:curio:3>, <thaumcraft:salis_mundus>, <thaumcraft:void_seed>]);
NecromancyTablet.addConsumingRecipe('thaumcraft:inhabitedzombie', <entity:thaumcraft:inhabitedzombie>, <thaumictinkerer:entity_soul_eldritch:*>, Aspects('2💀 2⚰️ 4👨 6🙌'),
[<thaumcraft:tallow>, <ore:bone>, <ore:itemSkull>, <minecraft:rotten_flesh>, <thaumcraft:brain>, <thaumcraft:crimson_plate_helm:*>]);
