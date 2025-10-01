#ignoreBracketErrors
#modloaded bloodmagic

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

<bloodmagic:living_armour_helmet>.maxDamage = 900;
<bloodmagic:living_armour_chest>.maxDamage = 900;
<bloodmagic:living_armour_leggings>.maxDamage = 900;
<bloodmagic:living_armour_boots>.maxDamage = 900;
<bloodmagic:sentient_armour_helmet>.maxDamage = 1200;
<bloodmagic:sentient_armour_chest>.maxDamage = 1200;
<bloodmagic:sentient_armour_leggings>.maxDamage = 1200;
<bloodmagic:sentient_armour_boots>.maxDamage = 1200;

// Add JEI hint for custom Imperfect zombie feature
var previevRitual as IItemStack = <littletiles:multitiles>.withTag({tiles: [{
    bBox: [0, 0, 0, 1, 1, 1] as int[], tile: {block: "bloodmagic:ritual_stone"}
  }, {
    bBox: [0, 1, 0, 1, 2, 1] as int[], tile: {block: "minecraft:coal_block"}
  }], min: [0, 0, 0] as int[], size: [1, 2, 1] as int[], grid: 1, count: 2});
scripts.jei.crafting_hints.fill(
  null,
  <liquid:lifeessence>,
  <scalinghealth:crystalshard> * 3,
  isNull(previevRitual) ? <bloodmagic:ritual_stone>: previevRitual
);

previevRitual = <littletiles:multitiles>.withTag({tiles: [{
    boxes: [[0, 0, 1, 1, 1, 2] as int[], [1, 0, 0, 2, 1, 1] as int[], [1, 0, 2, 2, 1, 3] as int[], [2, 0, 1, 3, 1, 2] as int[]], tile: {block: "bloodmagic:ritual_stone:2"}
  }, {
    bBox: [1, 0, 1, 2, 1, 2] as int[], tile: {block: "bloodmagic:ritual_stone"}
  }], min: [0, 0, 0] as int[], size: [3, 1, 3] as int[], grid: 1, count: 5});
<assembly:crafting_hints>.addJEIRecipe(mods.requious.AssemblyRecipe.create(function (c) {
  c.addFluidOutput('fluid_out', <fluid:pyrotheum> * 1000);
})
  .requireFluid('fluid_in', <liquid:lifeessence> * 500)
  .requireItem('input0', isNull(previevRitual) ? <bloodmagic:ritual_stone>: previevRitual)
);

// Blood Orb Oredicts
<ore:orbTier1>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:weak' }));
<ore:orbTier1>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:apprentice' }));
<ore:orbTier1>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:magician' }));
<ore:orbTier1>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:master' }));
<ore:orbTier1>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:archmage' }));
<ore:orbTier1>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:transcendent' }));

<ore:orbTier2>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:apprentice' }));
<ore:orbTier2>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:magician' }));
<ore:orbTier2>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:master' }));
<ore:orbTier2>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:archmage' }));
<ore:orbTier2>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:transcendent' }));

<ore:orbTier3>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:magician' }));
<ore:orbTier3>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:master' }));
<ore:orbTier3>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:archmage' }));
<ore:orbTier3>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:transcendent' }));

<ore:orbTier4>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:master' }));
<ore:orbTier4>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:archmage' }));
<ore:orbTier4>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:transcendent' }));

<ore:orbTier5>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:archmage' }));
<ore:orbTier5>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:transcendent' }));

<ore:orbTier6>.add(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:transcendent' }));

// Blood Magic Guide
recipes.addShapeless('Blood Magic Guide',
  <guideapi:bloodmagic-guide>,
  [<minecraft:book>, <bloodmagic:soul_snare>]);

// Alt recipes for non-tech players
for i, ingr in [
  <thaumcraft:stone_ancient_glyphed>,
  <extrautils2:decorativesolid:3>,
] as IItemStack[] {
  // Rune of Speed
  recipes.remove(<bloodmagic:blood_rune:1>);
  recipes.addShaped('Rune of Speed ' ~ i, <bloodmagic:blood_rune:1>,
    [[ingr, <bloodmagic:slate>, ingr],
      [<bloodmagic:blood_rune>, <ore:foodCake>, <bloodmagic:blood_rune>],
      [ingr, <bloodmagic:slate>, ingr]]);

  // Rune of Sacrifice
  recipes.remove(<bloodmagic:blood_rune:3>);
  recipes.addShaped('Rune of Sacrifice ' ~ i, <bloodmagic:blood_rune:3> * 3,
    [[ingr, <bloodmagic:slate:1>, ingr],
      [<bloodmagic:slate:1>, utils.reuse(<ore:orbTier2>), <bloodmagic:slate:1>],
      [ingr, <astralsorcery:itemcrystalsword:*>.withTag({ astralsorcery: {} }), ingr]]);

  // Imperfect Ritual Stone
  recipes.remove(<bloodmagic:ritual_controller:1>);
  recipes.addShaped('Imperfect Ritual Stone ' ~ i, <bloodmagic:ritual_controller:1>,
    [[<ore:obsidian>, ingr, <ore:obsidian>],
      [ingr, utils.reuse(<ore:orbTier1>), ingr],
      [<ore:obsidian>, ingr, <ore:obsidian>]]);
}

// [Rune of Capacity] from [Blank Rune][+3]
craft.remake(<bloodmagic:blood_rune:6>, ['pretty',
  'M F M',
  'F B F',
  'M I M'], {
  'M': <ore:stoneMetamorphic>, // Metamorphic Forest Stone
  'F': <flopper:flopper>, // Flopper
  'B': <bloodmagic:blood_rune>, // Blank Rune
  'I': <bloodmagic:slate:2>, // Imbued Slate
});

craft.remake(<bloodmagic:blood_rune:5>, ['pretty',
  'M ◊ M',
  '◊ B ◊',
  'M I M'], {
  'M': <ore:stoneMetamorphic>,
  '◊': <ore:gemAquamarine>,
  'B': <bloodmagic:blood_rune>,
  'I': <bloodmagic:slate:2>,
});

// Rune of the orb
recipes.remove(<bloodmagic:blood_rune:8>);
recipes.addShaped('Rune of the Orb', <bloodmagic:blood_rune:8>,
  [[<bloodmagic:slate:1>, utils.reuse(<ore:orbTier1>), <bloodmagic:slate:1>],
    [<bloodmagic:slate:2>, utils.reuse(<ore:orbTier4>), <bloodmagic:slate:2>],
    [<bloodmagic:slate:3>, utils.reuse(<ore:orbTier1>), <bloodmagic:slate:3>]]);

// Rune of acceleration
recipes.remove(<bloodmagic:blood_rune:9>);
recipes.addShaped('Rune of Acceleration', <bloodmagic:blood_rune:9>,
  [[<bloodmagic:blood_tank>, <bloodmagic:slate:3>, <bloodmagic:blood_tank>],
    [<ore:ingotGold>, <actuallyadditions:item_drill_upgrade_speed_ii>, <minecraft:gold_ingot>],
    [<bloodmagic:blood_tank>, utils.reuse(<ore:orbTier4>), <bloodmagic:blood_tank>]]);

// Ritual Stone
recipes.remove(<bloodmagic:ritual_stone>);
recipes.addShaped('Ritual Stone', <bloodmagic:ritual_stone> * 4,
  [[<thaumcraft:salis_mundus>, <bloodmagic:slate:1>, <thaumcraft:salis_mundus>],
    [<bloodmagic:slate:1>, utils.reuse(<ore:orbTier2>), <bloodmagic:slate:1>],
    [<ore:obsidian>, <bloodmagic:slate:1>, <ore:obsidian>]]);

// Hellfire Forge
recipes.remove(<bloodmagic:soul_forge>);
recipes.addShaped('Hellfire Forge', <bloodmagic:soul_forge>,
  [[<ore:nuggetQuartz>, <ore:dustAstralStarmetal>, <ore:nuggetQuartz>],
    [<thaumcraft:stone_arcane>, <ore:ingotBrass>, <thaumcraft:stone_arcane>],
    [<thaumcraft:stone_arcane>, <botania:storage>, <thaumcraft:stone_arcane>]]);

// Blood Altar
recipes.remove(<bloodmagic:altar>);
recipes.addShaped('Blood Altar', <bloodmagic:altar>,
  [[<ore:livingrock>, <astralsorcery:itemcraftingcomponent:3>, <ore:livingrock>],
    [<ore:plateBrass>, <minecraft:furnace>, <ore:plateBrass>],
    [<thaumcraft:stone_arcane>, <bloodmagic:monster_soul>, <thaumcraft:stone_arcane>]]);

// Blood Letter's Pack
recipes.remove(<bloodmagic:pack_self_sacrifice>);
recipes.addShaped("Blood Letter's Pack", <bloodmagic:pack_self_sacrifice>,
  [[<botania:managlass>, <botania:bloodpendant>, <botania:managlass>],
    [<minecraft:flint>, <minecraft:leather_chestplate>.anyDamage(), <minecraft:flint>],
    [<botania:managlass>, <bloodmagic:slate>, <botania:managlass>]]);

// Coat of Arms
recipes.remove(<bloodmagic:pack_sacrifice>);
recipes.addShaped('Coat of Arms', <bloodmagic:pack_sacrifice>,
  [[<botania:managlass>, <minecraft:bucket>, <botania:managlass>],
    [<thermalfoundation:material:354>, <minecraft:leather_chestplate>, <thermalfoundation:material:354>],
    [<botania:managlass>, <bloodmagic:slate>, <botania:managlass>]]);

// Sacrificial Dagger
recipes.remove(<bloodmagic:sacrificial_dagger>);
recipes.addShaped('Sacrificial Dagger', <bloodmagic:sacrificial_dagger>,
  [[<botania:managlass>, <botania:managlass>, <botania:managlass>],
    [null, <thaumcraft:ingot:2>, <botania:managlass>],
    [<botania:enderdagger>.anyDamage(), null, <botania:managlass>]]);

// Rudimentary Snare
recipes.remove(<bloodmagic:soul_snare>);
recipes.addShaped('Rudimentary Snare', <bloodmagic:soul_snare> * 8,
  [[<thaumcraft:fabric>, <ore:ingotManasteel>, <thaumcraft:fabric>],
    [<ore:ingotManasteel>, <ore:redstoneRoot>, <ore:ingotManasteel>],
    [<thaumcraft:fabric>, <ore:ingotManasteel>, <thaumcraft:fabric>]]);

// Blank Slate
mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:stone>);
mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:slate>, <botania:livingrock>, 0, 1000, 10, 10);

// Orb tier 1
mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:diamond>);
mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:weak' }),
  <botania:manaresource:2>, 0, 2000, 12, 12);

// Orb tier 2
mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:redstone_block>);
mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:apprentice' }),
  <thaumcraft:crystal_essence>.withTag({ Aspects: [{ amount: 1, key: 'victus' }] }), 1, 5000, 25, 25);

// Orb tier 3
mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:gold_block>);
mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:magician' }),
  <thaumcraft:metal_thaumium>, 2, 25000, 50, 50);

// Orb tier 5
mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:nether_star>);
mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:blood_orb>.withTag({ orb: 'bloodmagic:archmage' }),
  <botania:manaresource:5>, 4, 80000, 200, 200);

// Dagger of Sacrifice
mods.bloodmagic.BloodAltar.removeRecipe(<minecraft:iron_sword>);
mods.bloodmagic.BloodAltar.addRecipe(<bloodmagic:dagger_of_sacrifice>,
  <thaumcraft:thaumium_sword>, 1, 3000, 12, 12);

// Remake recipe of blood tanks

// [Blood Tank Tier 1] from [Glass][+2]
craft.remake(<bloodmagic:blood_tank>, ['B', '■', 'A'], {
  'B': <bloodmagic:slate>, // Blank Slate
  '■': <ore:blockGlass>, // Glass
  'A': <thaumcraft:stone_arcane>, // Arcane Stone
});

recipes.addShapeless('Clearing Blood Tank 0', <bloodmagic:blood_tank>, [<bloodmagic:blood_tank>]);
for i in 1 .. 16 {
  val tank = itemUtils.getItem('bloodmagic:blood_tank', i);
  val prevTank = itemUtils.getItem('bloodmagic:blood_tank', i - 1);

  val t16cost = 2000000.0; // Change only this number

  val t16powr = pow(1.5, 15);
  val t16mult = t16cost / t16powr;
  val t1resde = (15 - i) * (t16cost / 6000);

  val cost = (((pow(1.5, i as double) * t16mult) as int - t1resde) / 500) * 500;

  recipes.remove(tank);
  mods.bloodmagic.BloodAltar.addRecipe(tank, prevTank, max(0, min(4, i / 2)), cost, 10 + 10 * i, 10 + 10 * i);
  recipes.addShapeless('Clearing Blood Tank ' ~ i, tank, [tank]);
}

// Creative Dagger
val crDgr = <bloodmagic:sacrificial_dagger:1>.withTag({ HideFlags: 1 } + <enchantment:enderio:shimmer>.makeEnchantment(1).makeTag());
mods.jei.JEI.addItem(crDgr);

val capRune = <bloodmagic:blood_rune:7>;
val sprIng = <randomthings:ingredient:3>;
val bldTnk = <contenttweaker:meat_singularity>.withTag({ completed: 1 as byte });
val antBck = Bucket('blockfluidantimatter');
mods.extendedcrafting.TableCrafting.addShaped(0, crDgr, [
  [null, null, null, null, null, <ore:nuggetDraconicMetal>, sprIng],
  [null, null, null, null, <ore:nuggetDraconicMetal>, sprIng, <ore:nuggetDraconicMetal>],
  [null, capRune, null, <ore:nuggetDraconicMetal>, sprIng, <ore:nuggetDraconicMetal>, null],
  [null, capRune, <bloodmagic:slate:4>, <bloodmagic:sacrificial_dagger>, <ore:nuggetDraconicMetal>, null, null],
  [null, capRune, bldTnk, <bloodmagic:slate:4>, null, null, null],
  [antBck, <animus:sigil_consumption>, capRune, capRune, capRune, null, null],
  [<ore:gemBenitoite>, antBck, null, null, null, null, null],
]);

// Remove weak saltpater recipe
mods.bloodmagic.AlchemyTable.removeRecipe([<bloodmagic:component:22>, <bloodmagic:component:22>, <thermalfoundation:material:768>]);

// Remove coal dupe recipe
mods.bloodmagic.AlchemyTable.removeRecipe([<minecraft:coal>, <minecraft:coal>, <minecraft:flint>]);

// Remove unused recipes
val alcTableOres = [
  <actuallyadditions:block_misc:3>,
  <appliedenergistics2:charged_quartz_ore>,
  <appliedenergistics2:quartz_ore>,
  <astralsorcery:blockcustomore:1>,
  <astralsorcery:blockcustomsandore>,
  <biomesoplenty:gem_ore:1>,
  <biomesoplenty:gem_ore:2>,
  <biomesoplenty:gem_ore:3>,
  <biomesoplenty:gem_ore:4>,
  <biomesoplenty:gem_ore:5>,
  <biomesoplenty:gem_ore:6>,
  <biomesoplenty:gem_ore>,
  <draconicevolution:draconium_ore>,
  <endreborn:block_wolframium_ore>,
  <forestry:resources>,
  <immersiveengineering:ore:5>,
  <libvulpes:ore0:8>,
  <libvulpes:ore0>,
  <mekanism:oreblock>,
  <minecraft:diamond_ore>,
  <minecraft:emerald_ore>,
  <minecraft:gold_ore>,
  <minecraft:iron_ore>,
  <minecraft:lapis_ore>,
  <minecraft:redstone_ore>,
  <nuclearcraft:ore:3>,
  <nuclearcraft:ore:5>,
  <nuclearcraft:ore:6>,
  <nuclearcraft:ore:7>,
  <rftools:dimensional_shard_ore>,
  <tconstruct:ore:1>,
  <tconstruct:ore>,
  <thaumcraft:ore_amber>,
  <thermalfoundation:ore:1>,
  <thermalfoundation:ore:2>,
  <thermalfoundation:ore:3>,
  <thermalfoundation:ore:4>,
  <thermalfoundation:ore:5>,
  <thermalfoundation:ore:6>,
  <thermalfoundation:ore:7>,
  <thermalfoundation:ore:8>,
  <thermalfoundation:ore>,
  <trinity:trinitite>,
] as IItemStack[];

for item in alcTableOres {
  mods.bloodmagic.AlchemyTable.removeRecipe([item, <bloodmagic:cutting_fluid>]);
}

// [Blood Wood] from [Spectre Wood]*2
mods.bloodmagic.BloodAltar.addRecipe(<animus:blockbloodwood>, <randomthings:spectrelog>, 0, 2000, 12, 12);

// [Crystal Cluster]*64 from [Benitoite][+3]
// mods.bloodmagic.AlchemyTable.addRecipe(IItemStack output, IItemStack[] inputs, int syphon, int ticks, int minTier);
mods.bloodmagic.AlchemyTable.addRecipe(<bloodmagic:decorative_brick:2> * 64, [
  <draconicevolution:infused_obsidian>, // Draconium Infused Obsidian
  <thaumicaugmentation:research_notes>,
  <thaumcraft:banner_crimson_cult>, // Crimson Cult Banner
  <bloodmagic:item_demon_crystal:*>, // Demon Will Crystal
  <bloodmagic:item_demon_crystal:*>, // Demon Will Crystal
  <bloodmagic:item_demon_crystal:*>, // Demon Will Crystal
], 100000, 300, 4);

// [Crystal Cluster Brick]*4 from [Crystal Cluster]
craft.shapeless(<bloodmagic:decorative_brick:3> * 4, '****', {
  '*': <bloodmagic:decorative_brick:2>, // Crystal Cluster
});

// [Sigil of the whirlwind]
mods.bloodmagic.AlchemyArray.addRecipe(<bloodmagic:sigil_whirlwind>, <minecraft:shield>, <bloodmagic:slate>);

// Remove Plant Oil from the game since there modded oils will be used
Purge(<bloodmagic:component:22>);
mods.bloodmagic.AlchemyTable.removeRecipe([<minecraft:wheat>, <minecraft:wheat>, <minecraft:dye:15>]);
mods.bloodmagic.AlchemyTable.removeRecipe([<minecraft:potato>, <minecraft:potato>, <minecraft:dye:15>]);
mods.bloodmagic.AlchemyTable.removeRecipe([<minecraft:beetroot>, <minecraft:beetroot>, <minecraft:beetroot>, <minecraft:dye:15>]);
mods.bloodmagic.AlchemyTable.removeRecipe([<minecraft:carrot>, <minecraft:carrot>, <minecraft:carrot>, <minecraft:dye:15>]);

// Remake other ingredients that used Plant Oil
mods.bloodmagic.AlchemyTable.removeRecipe([<bloodmagic:component:22>, <minecraft:gold_nugget>, <minecraft:wheat>, <minecraft:sugar>, <minecraft:brown_mushroom>, <minecraft:red_mushroom>]);
mods.bloodmagic.AlchemyTable.addRecipe(<bloodmagic:component:26> * 4, [
  <thaumcraft:bath_salts>,
  <botania:manaresource:23>,
  <psi:material>,
  <thaumcraft:bath_salts>,
  <botania:manaresource:23>,
  <psi:material>,
  ], 1000, 80, 2);
mods.bloodmagic.AlchemyTable.addRecipe(<bloodmagic:component:26> * 16, [
  <thaumcraft:bath_salts>,
  <botania:manaresource:23>,
  <psi:material>,
  <thaumcraft:bath_salts>,
  <botania:manaresource:23>,
  <rustic:fluid_bottle>.withTag({Fluid: {FluidName: "oliveoil", Amount: 1000}})
  ], 1000, 80, 2);

mods.bloodmagic.AlchemyTable.removeRecipe([<thermalfoundation:material:768>, <minecraft:gunpowder>, <minecraft:redstone>, <minecraft:sugar>, <bloodmagic:component:22>, <minecraft:potion>.withTag({Potion: "minecraft:water"})]);
mods.bloodmagic.AlchemyTable.addRecipe(<bloodmagic:cutting_fluid>, [
  <randomthings:ingredient:13>,
  <contenttweaker:nugget_phosphor>,
  <mechanics:fuel_dust_tiny>,
  ], 1000, 80, 1);

// Neuro Toxin to require less Pufferfish
mods.bloodmagic.AlchemyTable.removeRecipe([<minecraft:fish:3>]);
mods.bloodmagic.AlchemyTable.addRecipe(<bloodmagic:component:25> * 32, [
  <minecraft:fish:3>,
  ], 1000, 100, 2);

// ///////////////////////////////////////////////////////////////////
// Add cutting of any compressed block
// ///////////////////////////////////////////////////////////////////

mods.bloodmagic.AlchemyTable.removeRecipe([<minecraft:gunpowder>, <minecraft:gunpowder>, <thermalfoundation:material:768>]);
mods.bloodmagic.AlchemyTable.addRecipe(<bloodmagic:cutting_fluid:1>, [
  <minecraft:gunpowder>,
  <minecraft:gunpowder>,
  <appliedenergistics2:material:45>,
  ], 500, 60, 1);

val compressions = [
  [
    [<minecraft:stone>, <additionalcompression:stone_compressed>, <additionalcompression:stone_compressed:1>, <additionalcompression:stone_compressed:2>, <additionalcompression:stone_compressed:3>, <additionalcompression:stone_compressed:4>, <additionalcompression:stone_compressed:5>, <additionalcompression:stone_compressed:6>, <additionalcompression:stone_compressed:7>, <additionalcompression:stone_compressed:8>, <additionalcompression:stone_compressed:9>],
    [<minecraft:cobblestone>, <extrautils2:compressedcobblestone>, <extrautils2:compressedcobblestone:1>, <extrautils2:compressedcobblestone:2>, <extrautils2:compressedcobblestone:3>, <extrautils2:compressedcobblestone:4>, <extrautils2:compressedcobblestone:5>, <extrautils2:compressedcobblestone:6>, <extrautils2:compressedcobblestone:7>, <additionalcompression:cobblestone_compressed:8>, <additionalcompression:cobblestone_compressed:9>],
    [<minecraft:gravel>, <extrautils2:compressedgravel>, <extrautils2:compressedgravel:1>, <additionalcompression:gravel_compressed:2>, <additionalcompression:gravel_compressed:3>, <additionalcompression:gravel_compressed:4>, <additionalcompression:gravel_compressed:5>, <additionalcompression:gravel_compressed:6>, <additionalcompression:gravel_compressed:7>, <additionalcompression:gravel_compressed:8>, <additionalcompression:gravel_compressed:9>],
    [<minecraft:sand>, <extrautils2:compressedsand>, <extrautils2:compressedsand:1>, <additionalcompression:blocksand_compressed:2>, <additionalcompression:blocksand_compressed:3>, <additionalcompression:blocksand_compressed:4>, <additionalcompression:blocksand_compressed:5>, <additionalcompression:blocksand_compressed:6>, <additionalcompression:blocksand_compressed:7>, <additionalcompression:blocksand_compressed:8>, <additionalcompression:blocksand_compressed:9>],
    [<exnihilocreatio:block_dust>, <excompressum:compressed_block>, <additionalcompression:dust_compressed:1>, <additionalcompression:dust_compressed:2>, <additionalcompression:dust_compressed:3>, <additionalcompression:dust_compressed:4>, <additionalcompression:dust_compressed:5>, <additionalcompression:dust_compressed:6>, <additionalcompression:dust_compressed:7>, <additionalcompression:dust_compressed:8>, <additionalcompression:dust_compressed:9>],
  ],
  [
    [<minecraft:netherrack>, <extrautils2:compressednetherrack>, <extrautils2:compressednetherrack:1>, <extrautils2:compressednetherrack:2>, <extrautils2:compressednetherrack:3>, <extrautils2:compressednetherrack:4>, <extrautils2:compressednetherrack:5>, <additionalcompression:netherrack_compressed:6>, <additionalcompression:netherrack_compressed:7>, <additionalcompression:netherrack_compressed:8>, <additionalcompression:netherrack_compressed:9>],
    [<exnihilocreatio:block_netherrack_crushed>, <excompressum:compressed_block:6>, <additionalcompression:gravelnether_compressed:1>, <additionalcompression:gravelnether_compressed:2>, <additionalcompression:gravelnether_compressed:3>, <additionalcompression:gravelnether_compressed:4>, <additionalcompression:gravelnether_compressed:5>, <additionalcompression:gravelnether_compressed:6>, <additionalcompression:gravelnether_compressed:7>, <additionalcompression:gravelnether_compressed:8>, <additionalcompression:gravelnether_compressed:9>],
  ],
  [
    [<minecraft:end_stone>, <excompressum:compressed_block:10>, <additionalcompression:endstone_compressed:1>, <additionalcompression:endstone_compressed:2>, <additionalcompression:endstone_compressed:3>, <additionalcompression:endstone_compressed:4>, <additionalcompression:endstone_compressed:5>, <additionalcompression:endstone_compressed:6>, <additionalcompression:endstone_compressed:7>, <additionalcompression:endstone_compressed:8>, <additionalcompression:endstone_compressed:9>],
    [<exnihilocreatio:block_endstone_crushed>, <excompressum:compressed_block:7>, <additionalcompression:gravelend_compressed:1>, <additionalcompression:gravelend_compressed:2>, <additionalcompression:gravelend_compressed:3>, <additionalcompression:gravelend_compressed:4>, <additionalcompression:gravelend_compressed:5>, <additionalcompression:gravelend_compressed:6>, <additionalcompression:gravelend_compressed:7>, <additionalcompression:gravelend_compressed:8>, <additionalcompression:gravelend_compressed:9>],
  ]
] as IItemStack[][][];

for group in compressions {
  var longest = 0;
  for type in group {
    longest = max(longest, type.length);
  }

  for i in 1 .. group.length {
    for j in 0 .. longest {
      if (group[i - 1].length < j || group[i].length < j || isNull(group[i - 1][j]) || isNull(group[i][j])) continue;
      mods.bloodmagic.AlchemyTable.addRecipe(group[i][j], [group[i - 1][j], <bloodmagic:cutting_fluid:1>], i * 200, j * 10 + 10, min(4, j / 4));
    }
  }
}

// ///////////////////////////////////////////////////////////////////
// Magic alloying alternative
// ///////////////////////////////////////////////////////////////////

function magicAlloy(output as IItemStack, map as string, ingrs as IIngredient[string]) as void {
  ingrs['F'] = <bloodmagic:component:25>;
  mods.bloodmagic.AlchemyTable.addRecipe(output, Grid([map+'F'], ingrs).shapeless(), 2000, 10, 3);
}

/* Inject_js(
_.uniqBy([
  ...loadJson('exports/recipes/nuclearcraft_alloy_furnace.json').recipes,
  ...loadJson('exports/recipes/AlloySmelter.json').recipes,
]
  .map((r) => {
    function stacksToOreSet(stacks) {
      return stacks.map(({ name }) => {
        const [mod, id, meta] = name.split(':')
        return [...getItemOredictSet(`${mod}:${id}`, meta || '0')]
      })
    }

    function getDustForm(oreList) {
      for (const ore of oreList) {
        if (/^dust([A-Z].*)/.test(ore)) return getByOredict_first(ore)
        const realOre = ore === 'ingotPsioMetal' ? 'ingotSilver' : ore
        const oreBase = realOre.match(/^block([A-Z].*)/)?.[1]
          || realOre.match(/^ingot([A-Z].*)/)?.[1]
          || realOre.match(/^item([A-Z].*)/)?.[1]
        if (!oreBase) continue

        const dust = getByOreBase(oreBase).dust
        if (dust) return dust
      }
    }

    function itemsToOres(items) {
      return items.map(({ stacks }) => [
        ...stacksToOreSet(stacks.filter(s => s.type !== 'oredict')),
        ...stacks.filter(s => s.type === 'oredict').map(s => s.name),
      ].flat())
    }

    // OUTPUTS
    const outputOres = [...new Set(itemsToOres(r.output.items).flat())]
    const outputDust = getDustForm(outputOres)
    if (!outputDust) return undefined

    // INPUTS
    const filteredInputs = r.input.items.filter(i => i.stacks.every(s => /item|oredict/.test(s.type)))

    const inputOres = itemsToOres(filteredInputs).filter(i => i.length)
    if (inputOres.length < 2) return undefined

    const dustInputOres = inputOres.map(getDustForm)
    if (inputOres.length !== dustInputOres.filter(Boolean).length) return undefined

    // const inputSerialized = [
    //   ...dustInputOres.map((s, i) => `${s.commandString}${filteredInputs[i].amount == 1 ? '' : ` * ${filteredInputs[i].amount}`}`),
    // ].sort(naturalSort).concat('', '').slice(0, 3)
    let mapChars = ''
    const inputSerialized = []
    dustInputOres.forEach((s, i) => {
      let index = dustInputOres.findIndex((o, j) => j < i && o.commandString === s.commandString)
      const fresh = index === -1
      if (fresh) index = i
      const char = 'ABCDEF'[index]
      mapChars += char.repeat(filteredInputs[index].amount)
      if (fresh) inputSerialized.push(`${char}: ${s.commandString}`)
    })

    return [
      mapChars.length > 6 ? '//' : '  ',
      `magicAlloy(`,
      outputDust.commandString,
      ...(r.output.items[0].amount == 1
        ? ['', '']
        : [` * `, r.output.items[0].amount]),
      `, '`,
      `${mapChars}',`,
      `{${inputSerialized.join(', ')}});`,
    ]
  })
  .filter(Boolean)
  .sort((a, b) => naturalSort(String(a?.slice(1)), String(b?.slice(1)))), r => String(r))
)*/
  magicAlloy(<advancedrocketry:productdust:1> * 2, 'AB',            {A: <libvulpes:productdust:7>, B: <thermalfoundation:material:71>});
//magicAlloy(<advancedrocketry:productdust>   * 3, 'AAAAAAABBB',    {A: <thermalfoundation:material:68>, B: <libvulpes:productdust:7>});
  magicAlloy(<qmd:chemical_dust:7>               , 'AB',            {A: <qmd:dust:7>, B: <thermalfoundation:material:771>});
  magicAlloy(<thermalfoundation:material:96>     , 'ABBBB',         {A: <thermalfoundation:material>, B: <nuclearcraft:dust:8>});
  magicAlloy(<thermalfoundation:material:96>     , 'ABBBB',         {A: <thermalfoundation:material>, B: <thermalfoundation:material:768>});
  magicAlloy(<thermalfoundation:material:97>  * 2, 'AB',            {A: <thermalfoundation:material:1>, B: <thermalfoundation:material:66>});
  magicAlloy(<thermalfoundation:material:98>  * 3, 'AAB',           {A: <thermalfoundation:material>, B: <thermalfoundation:material:69>});
  magicAlloy(<thermalfoundation:material:98>  * 3, 'ABB',           {A: <thermalfoundation:material:69>, B: <thermalfoundation:material>});
  magicAlloy(<thermalfoundation:material:99>  * 4, 'AAAB',          {A: <thermalfoundation:material:64>, B: <thermalfoundation:material:65>});
  magicAlloy(<thermalfoundation:material:100> * 2, 'AB',            {A: <thermalfoundation:material:64>, B: <thermalfoundation:material:69>});
//magicAlloy(<thermalfoundation:material:101> * 4, 'ABBBCCCCCCCCCC',{A: <thermalfoundation:material:64>, B: <thermalfoundation:material:66>, C: <minecraft:redstone>});
//magicAlloy(<thermalfoundation:material:102> * 4, 'AAABCCCC',      {A: <thermalfoundation:material:65>, B: <thermalfoundation:material:66>, C: <minecraft:glowstone_dust>});
/**/

// Specially manually setted alloys
magicAlloy(<advancedrocketry:productdust>   * 3, 'AAABB    ',{A: <thermalfoundation:material:68>, B: <libvulpes:productdust:7>});
// ///////////////////////////////////////////////////////////////////
// Sheets magic-only alt
for oreBase in [
  'TitaniumAluminide',
  'TitaniumIridium',
  'Iron',
  'Copper',
  'Steel',
  'Titanium',
  'Aluminium',
] as string[] {
  mods.bloodmagic.AlchemyTable.addRecipe(oreDict.get('sheet' ~ oreBase).firstItem * 4, [
    <bloodmagic:cutting_fluid>,
    oreDict.get('block' ~ oreBase),
    ], 1000, 80, 3);
}
// ///////////////////////////////////////////////////////////////////
// Allow Dispenser be used to activate rituals
<bloodmagic:activation_crystal>.definition.addDispenserBehavior(function(source, item) {
  if (
    item.hasTag
    && !isNull(item.tag.binding)
    && !isNull(item.tag.binding.name)
  ) {
    val binding = item.tag.binding.name.asString();
    val player = source.world.getPlayerByName(binding);
    if (!isNull(player)) {
      player.simulateRightClickBlock(item, mainHand, source.pos.getOffset(source.facing, 1), source.facing.opposite(), 0.5f, 0.5f, 0.5f);
    }
  }
  return item;
});
