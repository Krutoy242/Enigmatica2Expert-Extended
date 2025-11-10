#modloaded thaumicaugmentation

// T:{id:"thaumicaugmentation:morphic_tool",Count:1,Damage:0s,ForgeCaps:{Parent:{functional:{id:"minecraft:diamond_sword",Count:1,Damage:0s},display:{id:"minecraft:golden_hoe",Count:1,Damage:0s}}}}

scripts.lib.loot.tweak('thaumicaugmentation:entity/primal_wisp', 'main', null, null, [<thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'amogus' }] })], [10, 30], true);
scripts.lib.loot.tweak('thaumicaugmentation:entity/primal_wisp', 'main', null, null, [<randomthings:ingredient:2>], [5, 30], true);
scripts.lib.loot.tweak('thaumicaugmentation:entity/primal_wisp', 'main', null, null, [<rftools:infused_enderpearl>], [1, 3], true);

// [Ancient Runes]*8 from [White Rune][+1]
craft.make(<thaumicaugmentation:stone:3> * 8, ['pretty',
  'A A A',
  'A W A',
  'A A A'], {
  'A': <thaumcraft:stone_ancient>, // Ancient Stone
  'W': <quark:rune:*>, // White Rune
});

// [Ancient Barrier] from [Barrier Stone][+1]
craft.make(<thaumcraft:stone_ancient_doorway>, ['pretty',
  'A A A',
  'A B A',
  'A A A'], {
  'A': <thaumcraft:stone_ancient>, // Ancient Stone
  'B': <thaumcraft:paving_stone_barrier>, // Barrier Stone
});

// [Ancient Rock] from [Ancient Cobblestone]
furnace.addRecipe(<thaumcraft:stone_ancient_rock>, <thaumicaugmentation:stone:10>);

// [Intricate Glyphed Stone] from [A book written by a Cow][+1]
craft.make(<thaumicaugmentation:stone:4>, ['pretty',
  'A A A',
  'A § A',
  'A A A'], {
  'A': <thaumcraft:stone_ancient>, // Ancient Stone
  '§': scripts.mods.bibliocraft_books.bookWrittenBy_ingr['Cow'], // A book written by a Cow
});

// [Glyphed Stone] from [A book written by a Cow][+1]
craft.make(<thaumcraft:stone_ancient_glyphed>, ['pretty',
  'I I I',
  'I § I',
  'I I I'], {
  'I': <thaumicaugmentation:stone:4>, // Intricate Glyphed Stone
  '§': scripts.mods.bibliocraft_books.bookWrittenBy_ingr['Cow'], // A book written by a Cow
});

// [Crusted Stone] from [Crushed Endstone][+1]
craft.make(<thaumicaugmentation:stone:6>, ['pretty',
  'T T T',
  'T C T',
  'T T T'], {
  'T': <thaumicaugmentation:stone:1>, // Tainted Void Stone
  'C': <exnihilocreatio:block_endstone_crushed>, // Crushed Endstone
});

// [Glowing Crusted Stone]*8 from [Glowstone][+1]
craft.make(<thaumicaugmentation:stone:7> * 8, ['pretty',
  'C C C',
  'C g C',
  'C C C'], {
  'C': <thaumicaugmentation:stone:6>, // Crusted Stone
  'g': <ore:glowstone>, // Glowstone
});

// [Celestial observer]
mods.thaumcraft.ArcaneWorkbench.removeRecipe('thaumicaugmentation:celestial_observer_placer');
mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe('celestial_observer_placer',
  'CELESTIAL_OBSERVER',
  100,
  [],
  <thaumicaugmentation:celestial_observer_placer>,
  Grid(['pretty',
    '  S  ',
    'G T G'], {
    'G': <ore:ingotGold>, // Gold ingot
    'T': <thaumcraft:turret>, // Crossbow turret
    'S': <thaumcraft:thaumometer>, // Thaumometer
  }).shaped());

mods.bloodmagic.AlchemyTable.addRecipe(<thaumcraft:stone_ancient> * 64, [<thaumcraft:stone_arcane>, <bloodmagic:slate:4>, <botania:manaresource:5>], 100000, 300, 5);
mods.bloodmagic.AlchemyTable.addRecipe(<thaumicaugmentation:stone>, [<thaumcraft:taint_rock>, <bloodmagic:slate:4>, <botania:manaresource:5>], 100000, 300, 5);
mods.bloodmagic.AlchemyTable.addRecipe(<thaumicaugmentation:stone:1>, [<thaumcraft:taint_crust>, <bloodmagic:slate:4>, <botania:manaresource:5>], 100000, 300, 5);
mods.bloodmagic.AlchemyTable.addRecipe(<thaumicaugmentation:stone:2>, [<thaumcraft:taint_soil>, <bloodmagic:slate:4>, <botania:manaresource:5>], 100000, 300, 5);

// 🚒 Inworld crafting
furnace.addRecipe(<thaumicaugmentation:urn:2>, <randomthings:beanpod>, 1.0);
