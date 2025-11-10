#modloaded deepmoblearning

val ing = <deepmoblearning:glitch_infused_ingot>;

recipes.remove(<deepmoblearning:glitch_infused_sword>);
utils.addEnchRecipe(<deepmoblearning:glitch_infused_sword>,
  <enchantment:cyclicmagic:enchantment.beheading>, Grid(['pretty',
    '    -',
    '  -  ',
    'T    '], {
    '-': <deepmoblearning:glitch_infused_ingot>,
    'T': <endreborn:sword_shard>,
  }).shaped());

recipes.remove(<deepmoblearning:soot_covered_plate> * 8);
recipes.addShaped(<deepmoblearning:soot_covered_plate> * 4, [
  [null, <psi:material:3>, null],
  [<biomesoplenty:crystal>, <tconstruct:large_plate>.withTag({ Material: 'black_quartz' }), <biomesoplenty:crystal>],
  [null, <psi:material:3>, null]]);

remakeEx(<deepmoblearning:extraction_chamber>, [
  [<ore:sheetTitaniumIridium>, <mekanism:glowpanel:11>, <ore:sheetTitaniumIridium>],
  [<extrautils2:decorativesolid:7>, <deepmoblearning:machine_casing>, <extrautils2:decorativesolid:7>]]);

remakeEx(<deepmoblearning:simulation_chamber>, [
  [<ore:gearEmerald>, <mekanism:glowpanel:6>, <ore:gearEmerald>],
  [<extrautils2:decorativesolid:7>, <deepmoblearning:machine_casing>, <extrautils2:decorativesolid:7>]]);

craft.reshapeless(<patchouli:guide_book>.withTag({"patchouli:book": "deepmoblearning:book"}), 'AB', {
  A: <minecraft:book>,
  B: <psi:material:3>,
});

craft.remake(<deepmoblearning:deep_learner>, ['pretty',
  '□ ♥ □',
  '♥ G ♥',
  '□ S □'], {
  '□': <deepmoblearning:soot_covered_plate>,
  '♥': <minecraft:repeater>,
  'G': <ore:paneGlass>,
  'S': <psi:material:3>,
});

# [Soot-covered Machine Casing]*2 from [3D Print][+3]
craft.remake(<deepmoblearning:machine_casing> * 2, ["pretty",
  "□ п □",
  "□ 3 □",
  "□ ■ □"], {
  "□": <deepmoblearning:soot_covered_plate>, # Soot-covered Plate
  "п": <tconstruct:large_plate>.withTag({Material: "manyullyn"}), # Manyullyn Large Plate
  "3": <enderio:item_basic_capacitor:1>,
  "■": <ore:blockBlackIron>,                 # Block of Black Iron
});

recipes.remove(<deepmoblearning:polymer_clay> * 16);
recipes.addShapeless(<deepmoblearning:polymer_clay> * 16, [LiquidIngr('concrete'), <ore:dustClay>, <ore:dustClay>, <ore:dustClay>, <ore:dustGold>, <ore:dustLapis>]);

// Remove level-to-level conversions
recipes.remove(<deepmoblearning:living_matter_hellish>);
recipes.remove(<deepmoblearning:living_matter_extraterrestrial>);

// Add mass crafting recipes for iron
val matterOver = <deepmoblearning:living_matter_overworldian>;
recipes.addShapeless('Over matter to Iron Blocks', <minecraft:iron_block> * 2, [
  matterOver, matterOver, matterOver, matterOver, <thaumcraft:flesh_block>, matterOver, matterOver, matterOver, matterOver]);

// Add mass crafting recipes for gold
val matterHell = <deepmoblearning:living_matter_hellish>;
recipes.addShaped('Hellish matter to Gold Blocks', <minecraft:gold_block> * 4, [
  [<ore:glowstone>, matterHell, <ore:glowstone>],
  [matterHell, <ore:blockFakeIron>, matterHell],
  [matterHell, matterHell, matterHell]]);

// [Trial Keystone] from [Soot-covered Plate][+3]
craft.remake(<deepmoblearning:trial_keystone>, ['pretty',
  '◊ § ◊',
  '□ п □',
  '□ □ □'], {
  '□': <ore:plateSilicon>, // Silicon Plate
  '§': <deepmoblearning:trial_key>, // Trial Key
  '◊': <ore:gemDiamond>, // Diamond
  'п': <deepmoblearning:soot_covered_plate>, // Soot-covered Plate
});

// [Blank Data Model] from [Soot-covered Redstone][+2]
craft.remake(<deepmoblearning:data_model_blank>, ['pretty',
  '* M *',
  'M ♥ M',
  '* M *'], {
  '♥': <psi:material:3>,
  '*': <ore:itemPulsatingCrystal>, // Pulsating Crystal
  'M': <randomthings:ingredient:13>,
});

// [Ender Air Bottle] from [End Stone][+2]
craft.shapeless(<botania:manaresource:15> * 16, 'EeG', {
  'E': <deepmoblearning:living_matter_extraterrestrial>, // Extraterrestrial Matter
  'e': <ore:endstone> | <ore:oc:stoneEndstone>, // End Stone
  'G': <minecraft:glass_bottle>, // Glass Bottle
});

// [Dragon's Breath] from [Dragon Scale][+2]
craft.shapeless(<minecraft:dragon_breath>, 'EDG', {
  'E': <deepmoblearning:living_matter_extraterrestrial>, // Extraterrestrial Matter
  'D': <mysticalagradditions:stuff:3>, // Dragon Scale
  'G': <minecraft:glass_bottle>, // Glass Bottle
});

// [Unstable Glitch Fragment] from [Gelid Enderium Dust][+3]
craft.remake(<deepmoblearning:glitch_fragment>, ['pretty',
  '◊ P ◊',
  'e ▲ e',
  '◊ P ◊'], {
  '◊': <ore:gemXorcite>, // Xorcite Shard
  'P': <endreborn:item_end_shard>, // Purpur Shards
  'e': <ore:essence>, // Essence
  '▲': <ore:dustGelidEnderium>, // Gelid Enderium Dust
});

val dataModels = {
  blaze            : 'minecraft:blaze',
  creeper          : 'minecraft:creeper',
  // dragon           : 'minecraft:ender_dragon',
  enderman         : 'minecraft:enderman',
  ghast            : 'minecraft:ghast',
  guardian         : 'minecraft:guardian',
  shulker          : 'minecraft:shulker',
  skeleton         : 'minecraft:stray',
  slime            : 'minecraft:slime',
  spider           : 'minecraft:spider',
  thermal_elemental: 'thermalfoundation:blizz',
  tinker_slime     : 'tconstruct:blueslime',
  twilight_darkwood: 'twilightforest:kobold',
  twilight_forest  : 'twilightforest:swarm_spider',
  twilight_glacier : 'twilightforest:penguin',
  twilight_swamp   : 'twilightforest:minotaur',
  witch            : 'minecraft:witch',
  // wither           : 'minecraft:wither',
  wither_skeleton  : 'minecraft:wither_skeleton',
  zombie           : 'minecraft:husk',
} as string[string];

for model, mob in dataModels {
  val data_model = itemUtils.getItem('deepmoblearning:data_model_' ~ model);
  if (isNull(data_model)) {
    print('ERROR: no data model for ' ~ model);
    continue;
  }
  recipes.addShapeless('Data upgrade ' ~ model,
    data_model.withTag({ tier: 1 }), [
      <enderio:item_broken_spawner>.withTag({ entityId: mob }),
      data_model,
    ]
  );
}

// Peaceful Alt
// [Ender Dragon Data Model] from [Ender Dragon Data Model][+7]
mods.thaumcraft.Infusion.registerRecipe(
  'data_model_dragon', // Name
  'INFUSION', // Research
  <deepmoblearning:data_model_dragon>.withTag({ tier: 1 }), // Output
  10, // Instability
  Aspects('100🐲 100☀️ 100❤️'),
  <deepmoblearning:data_model_dragon>, // Central Item
  Grid(['pretty',
    'E ▬ E',
    '-   -',
    'E ▬ E'], {
    'E': <ore:dragonEgg>, // Dragon Egg
    '▬': <ore:ingotGlitch>, // Glitch Infused Ingot
    '-': <ore:dragonsteelIngot>, // Ice Dragonsteel Ingot
  }).spiral(1));

// [Ender Dragon Data Model] from [Ender Dragon Data Model][+7]
mods.thaumcraft.Infusion.registerRecipe(
  'data_model_wither', // Name
  'INFUSION', // Research
  <deepmoblearning:data_model_wither>.withTag({ tier: 1 }), // Output
  10, // Instability
  Aspects('100👽 100☀️ 100❤️'),
  <deepmoblearning:data_model_wither>, // Central Item
  Grid(['pretty',
    'E ▬ E',
    '-   -',
    'E ▬ E'], {
    'E': <draconicevolution:ender_energy_manipulator>,
    '▬': <ore:ingotGlitch>, // Glitch Infused Ingot
    '-': <ore:itemInfinityGoop>,
  }).spiral(1));

////////////////////////////////////
// Twilight Forest matter
////////////////////////////////////
// [Borer Essence]*32 from [Twilight Matter][+1]
craft.shapeless(<twilightforest:borer_essence> * 32, '▲§', {
  '▲': <ore:dustPyrotheum>, // Pyrotheum Dust
  '§': <deepmoblearning:living_matter_twilight>, // Twilight Matter
});

// [Transformation Powder]*64 from [Twilight Matter][+1]
craft.shapeless(<twilightforest:transformation_powder> * 64, '▲§', {
  '▲': <ore:dustAerotheum>, // Aerotheum Dust
  '§': <deepmoblearning:living_matter_twilight>, // Twilight Matter
});

// [Ice Bomb]*8 from [Twilight Matter][+1]
craft.shapeless(<twilightforest:ice_bomb> * 8, '▲§', {
  '▲': <ore:dustCryotheum>, // Cryotheum Dust
  '§': <deepmoblearning:living_matter_twilight>, // Twilight Matter
});

// [Armor Shard]*16 from [Twilight Matter][+1]
craft.shapeless(<twilightforest:armor_shard> * 16, '▲§', {
  '▲': <ore:dustPetrotheum>, // Petrotheum Dust
  '§': <deepmoblearning:living_matter_twilight>, // Twilight Matter
});

// [Steeleaf] from [Twilight Matter][+1]
craft.shapeless(<twilightforest:steeleaf_ingot>, 'T§', {
  'T': <ore:cropTea>, // Tea Leaf
  '§': <deepmoblearning:living_matter_twilight>, // Twilight Matter
});
////////////////////////////////////
