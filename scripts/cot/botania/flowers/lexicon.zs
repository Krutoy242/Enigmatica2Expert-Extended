/*
This file add/removes pages, entries and recipes diplayed in lexica botania.

It does 3 things
- adds new entries (mostly cutom made flowers)
- replaces recipes related to botania craftings that are displayed in lexica botania
- removes entries with crafting table recipes (since it's not working correctly)
*/

#modloaded botania
import mods.botania.Lexicon;
import native.vazkii.botania.common.lib.LibBrewNames;

//////////////////////
// Generating flowers//
//////////////////////

Lexicon.addEntry('botania.entry.campanimia', 'botania.category.generationFlowers', <botania:specialflower>.withTag({type: 'campanimia'}));
Lexicon.addTextPage('botania.page.campanimia0', 'botania.entry.campanimia', 0);
Lexicon.addPetalPage('botania.page.campanimia1', 'botania.entry.campanimia', 1, [<botania:specialflower>.withTag({type: 'campanimia'})], [[
  <botania:rune:1>,
  <botania:rune:2>,
  <botania:rune:3>,
  <botania:rune>,
  <quark:rune:14>,
  <quark:rune:2>,
  <quark:rune:4>,
]]);
Lexicon.addRecipeMapping(<botania:specialflower>.withTag({type: 'campanimia'}), 'botania.entry.campanimia', 0);

Lexicon.addEntry('botania.entry.nuclianthus', 'botania.category.generationFlowers', <botania:specialflower>.withTag({type: 'nuclianthus'}));
Lexicon.setEntryKnowledgeType('botania.entry.nuclianthus', 'alfheim');
Lexicon.addTextPage('botania.page.nuclianthus0', 'botania.entry.nuclianthus', 0);
Lexicon.addPetalPage('botania.page.nuclianthus1', 'botania.entry.nuclianthus', 1, [<botania:specialflower>.withTag({type: 'nuclianthus'})], [[
  <quark:rune:5>,
  <quark:rune:4>,
  <quark:rune:4>,
  <quark:rune:1>,
  <botania:manaresource:1>,
  <botania:rune:6>,
  <botania:rune:6>,
]]);
Lexicon.addRecipeMapping(<botania:specialflower>.withTag({type: 'nuclianthus'}), 'botania.entry.nuclianthus', 0);

//////////////////////
// Functional flowers//
//////////////////////

Lexicon.addEntry('botania.entry.antirrhift', 'botania.category.functionalFlowers', <botania:specialflower>.withTag({type: 'antirrhift'}));
Lexicon.setEntryKnowledgeType('botania.entry.antirrhift', 'alfheim');
Lexicon.addTextPage('botania.page.antirrhift0', 'botania.entry.antirrhift', 0);
Lexicon.addPetalPage('botania.page.antirrhift1', 'botania.entry.antirrhift', 1, [<botania:specialflower>.withTag({type: 'antirrhift'})], [[
  <botania:manaresource:8>,
  <botania:rune:15>,
  <quark:rune:2>,
  <quark:rune>,
  <quark:rune>,
  <thaumicaugmentation:material:5>,
  <thaumicaugmentation:material:5>,
]]);
Lexicon.addRecipeMapping(<botania:specialflower>.withTag({type: 'antirrhift'}), 'botania.entry.antirrhift', 0);

Lexicon.addEntry('botania.entry.rokku_eryngium', 'botania.category.functionalFlowers', <botania:specialflower>.withTag({type: 'rokku_eryngium'}));
Lexicon.setEntryKnowledgeType('botania.entry.rokku_eryngium', 'alfheim');
Lexicon.addTextPage('botania.page.rokku_eryngium0', 'botania.entry.rokku_eryngium', 0);
Lexicon.addPetalPage('botania.page.rokku_eryngium1', 'botania.entry.rokku_eryngium', 1, [<botania:specialflower>.withTag({type: 'rokku_eryngium'})], [[
  <botania:manaresource:5>,
  <botania:manaresource:9>,
  <botania:rune:11>,
  <botania:rune:12>,
  <quark:rune:11>,
  <quark:rune>,
  <quark:rune>,
]]);
Lexicon.addRecipeMapping(<botania:specialflower>.withTag({type: 'rokku_eryngium'}), 'botania.entry.rokku_eryngium', 0);

Lexicon.addEntry('botania.entry.jikanacea', 'botania.category.functionalFlowers', <botania:specialflower>.withTag({type: 'jikanacea'}));
Lexicon.setEntryKnowledgeType('botania.entry.jikanacea', 'alfheim');
Lexicon.addTextPage('botania.page.jikanacea0', 'botania.entry.jikanacea', 0);
Lexicon.addPetalPage('botania.page.jikanacea1', 'botania.entry.jikanacea', 1, [<botania:specialflower>.withTag({type: 'jikanacea'})], [[
  <astralsorcery:itemcraftingcomponent:4>,
  <botania:rune:14>,
  <botania:rune:9>,
  <quark:rune:2>,
  <quark:rune:4>,
  <quark:rune:4>,
  <thaumicaugmentation:material:5>,
]]);
Lexicon.addRecipeMapping(<botania:specialflower>.withTag({type: 'jikanacea'}), 'botania.entry.jikanacea', 0);

Lexicon.addEntry('botania.entry.echinacenko', 'botania.category.functionalFlowers', <botania:specialflower>.withTag({type: 'echinacenko'}));
Lexicon.addTextPage('botania.page.echinacenko0', 'botania.entry.echinacenko', 0);
Lexicon.addPetalPage('botania.page.echinacenko1', 'botania.entry.echinacenko', 1, [<botania:specialflower>.withTag({type: 'echinacenko'})], [[
  <quark:rune:2>,
  <quark:rune:2>,
  <quark:rune:5>,
  <botania:rune:10>,
  <botania:rune:12>,
  <botania:manaresource:1>,
]]);
Lexicon.addRecipeMapping(<botania:specialflower>.withTag({type: 'echinacenko'}), 'botania.entry.echinacenko', 0);

Lexicon.addEntry('botania.entry.amuileria_kaerunea', 'botania.category.functionalFlowers', <botania:specialflower>.withTag({type: 'amuileria_kaerunea'}));
Lexicon.setEntryKnowledgeType('botania.entry.amuileria_kaerunea', 'alfheim');
Lexicon.addTextPage('botania.page.amuileria_kaerunea0', 'botania.entry.amuileria_kaerunea', 0);
Lexicon.addPetalPage('botania.page.amuileria_kaerunea1', 'botania.entry.amuileria_kaerunea', 1, [<botania:specialflower>.withTag({type: 'amuileria_kaerunea'})], [[
  <botania:manaresource:9>,
  <botania:rune:8>,
  <minecraft:end_rod>,
  <quark:rune:3>,
  <quark:rune:3>,
  <quark:rune:4>,
  <quark:rune>,
]]);
Lexicon.addRecipeMapping(<botania:specialflower>.withTag({type: 'amuileria_kaerunea'}), 'botania.entry.amuileria_kaerunea', 0);

Lexicon.removePage('botania.entry.brewery', 5);
Lexicon.removePage('botania.entry.brewery', 5);
Lexicon.removePage('botania.entry.brewery', 5);
Lexicon.removePage('botania.entry.brewery', 5);
Lexicon.removePage('botania.entry.brewery', 5);
Lexicon.removePage('botania.entry.brewery', 5);
Lexicon.removePage('botania.entry.brewery', 5);
Lexicon.removePage('botania.entry.brewery', 5);
Lexicon.removePage('botania.entry.brewery', 5);
Lexicon.removePage('botania.entry.brewery', 5);
Lexicon.removePage('botania.entry.brewery', 5);
Lexicon.removePage('botania.entry.brewery', 5);
Lexicon.removePage('botania.entry.brewery', 5);

mods.botania.Lexicon.addBrewPage('botania.page.brewery5a','botania.entry.brewery',5,LibBrewNames.SPEED,[<minecraft:nether_wart>,<minecraft:sugar>,<actuallyadditions:item_dust:7>],'botania.page.brewery5b');
mods.botania.Lexicon.addBrewPage('botania.page.brewery6a','botania.entry.brewery',6,LibBrewNames.STRENGTH,[<minecraft:nether_wart>,<minecraft:blaze_powder>,<astralsorcery:itemusabledust>],'botania.page.brewery6b');
mods.botania.Lexicon.addBrewPage('botania.page.brewery7a','botania.entry.brewery',7,LibBrewNames.HASTE,[<minecraft:nether_wart>,<minecraft:prismarine_crystals>,<actuallyadditions:item_dust:7>],'botania.page.brewery7b');
mods.botania.Lexicon.addBrewPage('botania.page.brewery8a','botania.entry.brewery',8,LibBrewNames.HEALING,[<minecraft:nether_wart>,<minecraft:speckled_melon>,<thaumcraft:quicksilver>],'botania.page.brewery8b');
mods.botania.Lexicon.addBrewPage('botania.page.brewery9a','botania.entry.brewery',9,LibBrewNames.JUMP_BOOST,[<minecraft:nether_wart>,<minecraft:rabbit_foot>,<actuallyadditions:item_dust:7>],'botania.page.brewery9b');
mods.botania.Lexicon.addBrewPage('botania.page.brewery10a','botania.entry.brewery',10,LibBrewNames.REGEN,[<minecraft:nether_wart>,<minecraft:ghast_tear>,<astralsorcery:itemusabledust>],'botania.page.brewery10b');
mods.botania.Lexicon.addBrewPage('botania.page.brewery11a','botania.entry.brewery',11,LibBrewNames.RESISTANCE,[<minecraft:nether_wart>,<minecraft:quartz>,<actuallyadditions:item_dust:7>],'botania.page.brewery11b');
mods.botania.Lexicon.addBrewPage('botania.page.brewery12a','botania.entry.brewery',12,LibBrewNames.FIRE_RESISTANCE,[<minecraft:nether_wart>,<minecraft:magma_cream>,<actuallyadditions:item_dust:7>],'botania.page.brewery12b');
mods.botania.Lexicon.addBrewPage('botania.page.brewery13a','botania.entry.brewery',13,LibBrewNames.WATER_BREATHING,[<minecraft:nether_wart>,<minecraft:fish:3>,<actuallyadditions:item_dust:7>],'botania.page.brewery13b');
mods.botania.Lexicon.addBrewPage('botania.page.brewery14a','botania.entry.brewery',14,LibBrewNames.INVISIBILITY,[<minecraft:nether_wart>,<minecraft:golden_carrot>,<minecraft:fermented_spider_eye>,<actuallyadditions:item_dust:7>],'botania.page.brewery14b');
mods.botania.Lexicon.addBrewPage('botania.page.brewery15a','botania.entry.brewery',15,LibBrewNames.NIGHT_VISION,[<minecraft:nether_wart>,<minecraft:golden_carrot>,<actuallyadditions:item_dust:7>],'botania.page.brewery15b');
mods.botania.Lexicon.addBrewPage('botania.page.brewery16a','botania.entry.brewery',16,LibBrewNames.ABSORPTION,[<minecraft:nether_wart>,<minecraft:golden_apple>,<astralsorcery:itemusabledust>],'botania.page.brewery16b');
mods.botania.Lexicon.addBrewPage('botania.page.brewery17a','botania.entry.brewery',17,LibBrewNames.REGEN_WEAK,[<minecraft:nether_wart>,<minecraft:ghast_tear>,<actuallyadditions:item_dust:7>],'botania.page.brewery17b');
mods.botania.Lexicon.addBrewPage('botania.page.complexBrews2a','botania.entry.brewery',18,LibBrewNames.SOUL_CROSS,[<minecraft:nether_wart>,<ore:boneWither>,<randomthings:ingredient:7>],'botania.page.complexBrews2b');
mods.botania.Lexicon.addBrewPage('botania.page.complexBrews3a','botania.entry.brewery',19,LibBrewNames.FEATHER_FEET,[<minecraft:nether_wart>,<minecraft:feather>,<actuallyadditions:item_dust:7>],'botania.page.complexBrews3b');
mods.botania.Lexicon.addBrewPage('botania.page.complexBrews4a','botania.entry.brewery',20,LibBrewNames.EMPTINESS,[<minecraft:nether_wart>,<thaumcraft:shimmerleaf>,<actuallyadditions:item_dust:7>,<darkutils:material>],'botania.page.complexBrews4b');
mods.botania.Lexicon.addBrewPage('botania.page.complexBrews5a','botania.entry.brewery',21,LibBrewNames.BLOODTHIRST,[<minecraft:nether_wart>,<thaumcraft:vishroom>,<actuallyadditions:item_dust:7>,<darkutils:material>],'botania.page.complexBrews5b');
mods.botania.Lexicon.addBrewPage('botania.page.complexBrews6a','botania.entry.brewery',22,LibBrewNames.ALLURE,[<minecraft:nether_wart>,<harvestcraft:fishtrapbaititem>,<actuallyadditions:item_dust:7>],'botania.page.complexBrews6b');
mods.botania.Lexicon.addBrewPage('botania.page.complexBrews7a','botania.entry.brewery',23,LibBrewNames.CLEAR,[<minecraft:nether_wart>,<ore:listAllmilk>,<thaumcraft:quicksilver>],'botania.page.complexBrews7b');
mods.botania.Lexicon.addBrewPage('botania.page.chronos_a','botania.entry.brewery',24,'chronos',[<minecraft:nether_wart>, <twilightforest:magic_leaves>, <contenttweaker:compressed_white_sand>, <astralsorcery:itemusabledust>],'botania.page.chronos_b');
mods.botania.Lexicon.addBrewPage('botania.page.darkness_resistance_a','botania.entry.brewery',25,'darkness_resistance',[<minecraft:nether_wart>, <twilightforest:torchberries>, <actuallyadditions:item_dust:7>],'botania.page.darkness_resistance_b');
mods.botania.Lexicon.addBrewPage('botania.page.easyculty_a','botania.entry.brewery',26,'easyculty',[<minecraft:nether_wart>, <biomesoplenty:shroompowder>, <cyclicmagic:heart_toxic>, <thaumcraft:void_seed>],'botania.page.easyculty_b');

Lexicon.removePage('botania.entry.complexBrews', 1);
Lexicon.removePage('botania.entry.complexBrews', 1);
Lexicon.removePage('botania.entry.complexBrews', 1);
Lexicon.removePage('botania.entry.complexBrews', 1);
Lexicon.removePage('botania.entry.complexBrews', 1);
Lexicon.removePage('botania.entry.complexBrews', 1);
Lexicon.removePage('botania.entry.complexBrews', 1);

mods.botania.Lexicon.addBrewPage('botania.page.complexBrews1a','botania.entry.complexBrews',1,LibBrewNames.OVERLOAD,[<minecraft:nether_wart>,<rustic:ginseng>,<rustic:wind_thistle>,<biomesoplenty:double_plant:2>,<botania:manaresource:23>],'botania.page.complexBrews1b');
mods.botania.Lexicon.addBrewPage('botania.page.complexBrewsCustom2a','botania.entry.complexBrews',2,"scarlet_veil",[<minecraft:nether_wart>,<rustic:blood_orchid>,<rustic:ironberries>,<extrautils2:redorchid>,<botania:manaresource:23>],'botania.page.complexBrewsCustom2b');
mods.botania.Lexicon.addBrewPage('botania.page.complexBrewsCustom3a','botania.entry.complexBrews',3,"calamity",[<minecraft:nether_wart>,<rustic:horsetail>,<rustic:marsh_mallow>,<endreborn:item_lormyte_crystal>,<botania:manaresource:23>],'botania.page.complexBrewsCustom3b');
mods.botania.Lexicon.addBrewPage('botania.page.complexBrewsCustom4a','botania.entry.complexBrews',4,"warbound",[<minecraft:nether_wart>,<rustic:tomato>,<rustic:aloe_vera>,<rustic:honeycomb>,<botania:manaresource:23>],'botania.page.complexBrewsCustom4b');
mods.botania.Lexicon.addBrewPage('botania.page.complexBrewsCustom5a','botania.entry.complexBrews',5,"depthbound",[<minecraft:nether_wart>,<rustic:mooncap_mushroom>,<rustic:core_root>,<biomesoplenty:coral:1>,<botania:manaresource:23>],'botania.page.complexBrewsCustom5b');
mods.botania.Lexicon.addBrewPage('botania.page.complexBrewsCustom6a','botania.entry.complexBrews',6,"sanguine_oath",[<minecraft:nether_wart>,<rustic:chamomile>,<rustic:cohosh>,<scalinghealth:crystalshard>,<botania:manaresource:23>],'botania.page.complexBrewsCustom6b');
mods.botania.Lexicon.addBrewPage('botania.page.complexBrewsCustom7a','botania.entry.complexBrews',7,"aerial_delirium",[<minecraft:nether_wart>,<rustic:olives>,<rustic:deathstalk_mushroom>,<iceandfire:pixie_dust>,<botania:manaresource:23>],'botania.page.complexBrewsCustom7b');

/////////////////
// Lexicon fixes//
/////////////////

/*
Due to how lexicon works, it's impossible to fix page with crafting table recipe.
Futhermore the way botania lexicon works removing pages can be confusing here's example:

We got entry with 5 pages.
[1][2][3][4][5]
And we want to remove 3rd and 4th page. If we remove 3rd page, we remove page with index 2. This is how it will look then.
[1][2][4][5]    //after removing index "2"
Now we want remove page with number "4", we once again want to remove page with index 2.
[1][2][5]       //after removing index "2" second time
*/

Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 7);
Lexicon.removePage('botania.entry.runeAltar', 3);

Lexicon.addRunePage('botania.page.runeAltar4', 'botania.entry.runeAltar', 6, [<botania:rune:0> * 2],
  [[<ore:dustBlizz>, <ore:fish>, <ore:gemAquamarine>, <ore:ingotManasteel>, <ore:powderMana>]], [5000]);
Lexicon.addRunePage('botania.page.runeAltar5', 'botania.entry.runeAltar', 7, [<botania:rune:2> * 2],
  [[<ore:dustBasalz>, <biomesoplenty:ash>, <ore:podzol>, <ore:ingotManasteel>, <ore:powderMana>]], [5000]);
Lexicon.addRunePage('botania.page.runeAltar6', 'botania.entry.runeAltar', 8, [<botania:rune:3> * 2],
  [[<ore:dustBlitz>, <ore:boneDragon>, <twilightforest:raven_feather>, <ore:ingotManasteel>, <ore:powderMana>]], [5000]);
Lexicon.addRunePage('botania.page.runeAltar7', 'botania.entry.runeAltar', 9, [<botania:rune:1> * 2],
  [[<ore:dustBlaze>, <ore:slimeballMagma>, <ore:gemAmber>, <ore:ingotManasteel>, <ore:powderMana>]], [5000]);
Lexicon.addRunePage('botania.page.runeAltar8', 'botania.entry.runeAltar', 10, [<botania:rune:4>],
  [[<ore:runeWaterB>, <ore:runeFireB>, <astralsorcery:blockinfusedwood>, <ore:flower>, <ore:nitor>]], [10000]);
Lexicon.addRunePage('botania.page.runeAltar9', 'botania.entry.runeAltar', 11, [<botania:rune:5>],
  [[<ore:runeEarthB>, <ore:runeAirB>, <ore:treeSapling>, <ore:nuggetBrass>, <ore:livingwood>]], [10000]);
Lexicon.addRunePage('botania.page.runeAltar10', 'botania.entry.runeAltar', 12, [<botania:rune:6>],
  [[<ore:runeFireB>, <ore:runeAirB>, <ore:quicksilver>, <minecraft:deadbush>, <ore:stoneMetamorphic>]], [10000]);
Lexicon.addRunePage('botania.page.runeAltar11', 'botania.entry.runeAltar', 13, [<botania:rune:7>],
  [[<ore:runeWaterB>, <ore:runeEarthB>, <mctsmelteryio:iceball> ?? <iceandfire:dragon_ice>, <astralsorcery:itemusabledust>, <ore:blockSalt>]], [10000]);
Lexicon.addRunePage('botania.page.runeAltar12', 'botania.entry.runeAltar', 14, [<botania:rune:8>],
  [[<ore:manaPearl>, <ore:powderMana>, <ore:quartzMana>, <ore:manaDiamond>, <ore:clothManaweave>]], [20000]);
Lexicon.addRunePage('botania.page.runeAltar13', 'botania.entry.runeAltar', 15, [<botania:rune:9>],
  [[<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:5>, <botania:rune:5>, <botania:rune:3>, <botania:rune:3>]], [25000]);
Lexicon.addRunePage('botania.page.runeAltar14', 'botania.entry.runeAltar', 16, [<botania:rune:10>],
  [[<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:7>, <botania:rune:7>, <botania:rune:1>, <botania:rune:1>]], [25000]);
Lexicon.addRunePage('botania.page.runeAltar15', 'botania.entry.runeAltar', 17, [<botania:rune:11>],
  [[<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:4>, <botania:rune:4>, <botania:rune>, <botania:rune>]], [25000]);
Lexicon.addRunePage('botania.page.runeAltar16', 'botania.entry.runeAltar', 18, [<botania:rune:12>],
  [[<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:6>, <botania:rune:6>, <botania:rune:3>, <botania:rune:3>]], [25000]);
Lexicon.addRunePage('botania.page.runeAltar17', 'botania.entry.runeAltar', 19, [<botania:rune:13>],
  [[<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:7>, <botania:rune:7>, <botania:rune:2>, <botania:rune:2>]], [25000]);
Lexicon.addRunePage('botania.page.runeAltar18', 'botania.entry.runeAltar', 20, [<botania:rune:14>],
  [[<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:7>, <botania:rune:7>, <botania:rune>, <botania:rune>]], [25000]);
Lexicon.addRunePage('botania.page.runeAltar19', 'botania.entry.runeAltar', 21, [<botania:rune:15>],
  [[<ore:manaDiamond>, <ore:manaDiamond>, <botania:rune:5>, <botania:rune:5>, <botania:rune:1>, <botania:rune:1>]], [25000]);

Lexicon.removePage('botania.entry.cocoon', 2);

Lexicon.removePage('botania.entry.hourglass', 6);

Lexicon.removePage('botania.entry.pool', 2);
Lexicon.removePage('botania.entry.pool', 2);

Lexicon.removePage('botania.entry.excompressum.orechidEvolved', 1);
Lexicon.addPetalPage('botania.page.excompressum.orechidEvolved1', 'botania.entry.excompressum.orechidEvolved', 1, [<botania:specialflower>.withTag({type: 'excompressum.orechidEvolved'})], [[
  <ore:petalGray>,       // Mystical Gray Petal
  <ore:petalYellow>,     // Mystical Yellow Petal
  <ore:petalGreen>,      // Mystical Green Petal
  <ore:petalRed>,        // Mystical Red Petal
  <ore:quicksilver>,     // Quicksilver
  <ore:redstoneRoot>,    // Redstone Root
  <ore:nuggetBrass>,     // Alchemical Brass Nugget
  <ore:nuggetManasteel>, // Manasteel Nugget
]]);

Lexicon.removePage('botania.entry.orechidIgnem', 1);
Lexicon.addPetalPage('botania.page.orechidIgnem1', 'botania.entry.orechidIgnem', 1, [<botania:specialflower>.withTag({type: 'orechidIgnem'})], [[
  <ore:petalRed>,       // Mystical Red Petal
  <ore:petalWhite>,     // Mystical White Petal
  <ore:petalPink>,      // Mystical Pink Petal
  <ore:runeAutumnB>,    // Rune of Autumn
  <ore:runeManaB>,      // Rune of Mana
  <ore:redstoneRoot>,   // Redstone Root
  <ore:nuggetThaumium>, // Thaumium Nugget
  <ore:stoneMetamorphic>,
]]);

Lexicon.removePage('botania.entry.orechidVacuam', 1);
Lexicon.addPetalPage('botania.page.orechidVacuam1', 'botania.entry.orechidVacuam', 1, [<botania:specialflower>.withTag({type: 'orechidVacuam'})], [[
  <ore:petalYellow>,      // Mystical Yellow Petal
  <ore:petalPurple>,      // Mystical Purple Petal
  <ore:petalBlack>,       // Mystical Black Petal
  <ore:runePrideB>,       // Rune of Pride
  <ore:runeGreedB>,       // Rune of Greed
  <ore:redstoneRoot>,     // Redstone Root
  <ore:nuggetVoid>,       // Void Metal Nugget
  <ore:nuggetTerrasteel>, // Terrasteel Nugget
]]);

Lexicon.removePage('botania.entry.spreader', 5);
Lexicon.removePage('botania.entry.spreader', 5);

Lexicon.removePage('botania.entry.dreamwoodSpreader', 1);
Lexicon.removePage('botania.entry.dreamwoodSpreader', 2);

Lexicon.removePage('botania.entry.gaiaRitual', 1);

Lexicon.removePage('botania.entry.gaiaRitualHardmode', 2);

Lexicon.removePage('botania.entry.aIntro', 2);

Lexicon.removePage('botania.entry.apothecary', 7);

Lexicon.removePage('botania.entry.travelBelt', 1);

Lexicon.removePage('botania.entry.swapRing', 1);
Lexicon.removePage('botania.entry.manaRing', 1);
Lexicon.removePage('botania.entry.pixieRing', 1);
Lexicon.removePage('botania.entry.reachRing', 1);
Lexicon.removePage('botania.entry.dodgeRing', 1);
Lexicon.removePage('botania.entry.magnetRing', 1);
Lexicon.removePage('botania.entry.miningRing', 1);
Lexicon.removePage('botania.entry.waterRing', 1);
Lexicon.removePage('botania.entry.auraRing', 1);

Lexicon.removePage('botania.entry.exchangeRod', 3);
Lexicon.removePage('botania.entry.smeltRod', 1);
Lexicon.removePage('botania.entry.dirtRod', 2);
Lexicon.removePage('botania.entry.terraformRod', 3);
Lexicon.removePage('botania.entry.waterRod', 1);
Lexicon.removePage('botania.entry.fireRod', 2);
Lexicon.removePage('botania.entry.skyDirtRod', 1);
Lexicon.removePage('botania.entry.diviningRod', 2);
Lexicon.removePage('botania.entry.tornadoRod', 2);
Lexicon.removePage('botania.entry.gravityRod', 2);
Lexicon.removePage('botania.entry.cobbleRod', 1);
Lexicon.removePage('botania.entry.missileRod', 2);

Lexicon.removePage('botania.entry.manaGear', 2);
Lexicon.removePage('botania.entry.manaGear', 2);
Lexicon.removePage('botania.entry.manaGear', 2);
Lexicon.removePage('botania.entry.manaGear', 2);
Lexicon.removePage('botania.entry.manaGear', 2);
Lexicon.removePage('botania.entry.manaGear', 2);
Lexicon.removePage('botania.entry.manaGear', 2);
Lexicon.removePage('botania.entry.manaGear', 2);
Lexicon.removePage('botania.entry.manaGear', 2);

Lexicon.removePage('botania.entry.elfGear', 3);
Lexicon.removePage('botania.entry.elfGear', 4);
Lexicon.removePage('botania.entry.elfGear', 5);
Lexicon.removePage('botania.entry.elfGear', 6);
Lexicon.removePage('botania.entry.elfGear', 7);
Lexicon.removePage('botania.entry.elfGear', 7);
Lexicon.removePage('botania.entry.elfGear', 7);
Lexicon.removePage('botania.entry.elfGear', 7);
Lexicon.removePage('botania.entry.elfGear', 7);

Lexicon.removePage('botania.entry.manaweave', 3);
Lexicon.removePage('botania.entry.manaweave', 3);
Lexicon.removePage('botania.entry.manaweave', 3);
Lexicon.removePage('botania.entry.manaweave', 3);

Lexicon.removePage('botania.entry.terraAxe', 1);

Lexicon.removePage('botania.entry.terrasteelArmor', 1);
Lexicon.removePage('botania.entry.terrasteelArmor', 1);
Lexicon.removePage('botania.entry.terrasteelArmor', 1);
Lexicon.removePage('botania.entry.terrasteelArmor', 1);

Lexicon.removeEntry('botania.entry.glassPick');

Lexicon.removePage('botania.entry.superTravelBelt', 1);

Lexicon.removePage('botania.entry.knockbackBelt', 1);

Lexicon.removePage('botania.entry.decorativeBlocks', 5);
