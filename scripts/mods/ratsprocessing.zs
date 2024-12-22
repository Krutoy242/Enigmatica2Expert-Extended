#modloaded rats

import crafttweaker.item.IItemStack;

static listRatPoop as IItemStack[] = [
/* Inject_js(
getFurnaceRecipes()
?.filter(g=>g.in_id==='rats:rat_nugget_ore')
.map(g=>'  '+g.input.replace(/"/gm, "'"))
.join(',\n')
) */
  <rats:rat_nugget_ore:1>.withTag({OreItem: {Count: 1, id: 'thaumcraft:ore_amber', Damage: 0 as short}, IngotItem: {Count: 1, id: 'thaumcraft:amber', Damage: 0 as short}}),
  <rats:rat_nugget_ore:2>.withTag({OreItem: {Count: 1, id: 'forestry:resources', Damage: 0 as short}, IngotItem: {Count: 1, id: 'forestry:apatite', Damage: 0 as short}}),
  <rats:rat_nugget_ore:3>.withTag({OreItem: {Count: 1, id: 'astralsorcery:blockcustomsandore', Damage: 0 as short}, IngotItem: {Count: 3, id: 'astralsorcery:itemcraftingcomponent', Damage: 0 as short}}),
  <rats:rat_nugget_ore:4>.withTag({OreItem: {Count: 1, id: 'tconstruct:ore', Damage: 1 as short}, IngotItem: {Count: 1, id: 'tconstruct:ingots', Damage: 1 as short}}),
  <rats:rat_nugget_ore:5>.withTag({OreItem: {Count: 1, id: 'twilightforest:armor_shard_cluster', Damage: 0 as short}, IngotItem: {Count: 1, id: 'twilightforest:knightmetal_ingot', Damage: 0 as short}}),
  <rats:rat_nugget_ore:6>.withTag({OreItem: {Count: 1, id: 'actuallyadditions:block_misc', Damage: 3 as short}, IngotItem: {Count: 1, id: 'actuallyadditions:item_misc', Damage: 5 as short}}),
  <rats:rat_nugget_ore:7>.withTag({OreItem: {Count: 1, id: 'nuclearcraft:ore', Damage: 5 as short}, IngotItem: {Count: 1, id: 'nuclearcraft:ingot', Damage: 5 as short}}),
  <rats:rat_nugget_ore:8>.withTag({OreItem: {Count: 1, id: 'thaumcraft:ore_cinnabar', Damage: 0 as short}, IngotItem: {Count: 1, id: 'thaumcraft:quicksilver', Damage: 0 as short}}),
  <rats:rat_nugget_ore:9>.withTag({OreItem: {Count: 1, id: 'minecraft:coal_ore', Damage: 0 as short}, IngotItem: {Count: 1, id: 'minecraft:coal', Damage: 0 as short}}),
  <rats:rat_nugget_ore:10>.withTag({OreItem: {Count: 1, id: 'tconstruct:ore', Damage: 0 as short}, IngotItem: {Count: 1, id: 'tconstruct:ingots', Damage: 0 as short}}),
  <rats:rat_nugget_ore:11>.withTag({OreItem: {Count: 1, id: 'thermalfoundation:ore', Damage: 0 as short}, IngotItem: {Count: 1, id: 'thermalfoundation:material', Damage: 128 as short}}),
  <rats:rat_nugget_ore:12>.withTag({OreItem: {Count: 1, id: 'minecraft:diamond_ore', Damage: 0 as short}, IngotItem: {Count: 1, id: 'minecraft:diamond', Damage: 0 as short}}),
  <rats:rat_nugget_ore:13>.withTag({OreItem: {Count: 1, id: 'libvulpes:ore0', Damage: 0 as short}, IngotItem: {Count: 1, id: 'libvulpes:productdust', Damage: 0 as short}}),
  <rats:rat_nugget_ore:14>.withTag({OreItem: {Count: 1, id: 'draconicevolution:draconium_ore', Damage: 0 as short}, IngotItem: {Count: 1, id: 'draconicevolution:draconium_ingot', Damage: 0 as short}}),
  <rats:rat_nugget_ore:15>.withTag({OreItem: {Count: 1, id: 'minecraft:emerald_ore', Damage: 0 as short}, IngotItem: {Count: 1, id: 'minecraft:emerald', Damage: 0 as short}}),
  <rats:rat_nugget_ore:16>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 0 as short}, IngotItem: {Count: 2, id: 'thermalfoundation:ore', Damage: 4 as short}}),
  <rats:rat_nugget_ore:17>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_2', Damage: 5 as short}, IngotItem: {Count: 2, id: 'netherendingores:ore_other_1', Damage: 6 as short}}),
  <rats:rat_nugget_ore:18>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_other_1', Damage: 3 as short}, IngotItem: {Count: 2, id: 'tconstruct:ore', Damage: 1 as short}}),
  <rats:rat_nugget_ore:19>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_2', Damage: 8 as short}, IngotItem: {Count: 2, id: 'netherendingores:ore_other_1', Damage: 9 as short}}),
  <rats:rat_nugget_ore:20>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 9 as short}, IngotItem: {Count: 2, id: 'appliedenergistics2:quartz_ore', Damage: 0 as short}}),
  <rats:rat_nugget_ore:21>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 10 as short}, IngotItem: {Count: 2, id: 'appliedenergistics2:charged_quartz_ore', Damage: 0 as short}}),
  <rats:rat_nugget_ore:22>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_vanilla', Damage: 0 as short}, IngotItem: {Count: 2, id: 'minecraft:coal_ore', Damage: 0 as short}}),
  <rats:rat_nugget_ore:23>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_other_1', Damage: 5 as short}, IngotItem: {Count: 2, id: 'tconstruct:ore', Damage: 0 as short}}),
  <rats:rat_nugget_ore:24>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 1 as short}, IngotItem: {Count: 2, id: 'thermalfoundation:ore', Damage: 0 as short}}),
  <rats:rat_nugget_ore:25>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_vanilla', Damage: 1 as short}, IngotItem: {Count: 2, id: 'minecraft:diamond_ore', Damage: 0 as short}}),
  <rats:rat_nugget_ore:26>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 14 as short}, IngotItem: {Count: 2, id: 'libvulpes:ore0', Damage: 0 as short}}),
  <rats:rat_nugget_ore:27>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_vanilla', Damage: 2 as short}, IngotItem: {Count: 2, id: 'minecraft:emerald_ore', Damage: 0 as short}}),
  <rats:rat_nugget_ore:28>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_vanilla', Damage: 3 as short}, IngotItem: {Count: 2, id: 'minecraft:gold_ore', Damage: 0 as short}}),
  <rats:rat_nugget_ore:29>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_2', Damage: 6 as short}, IngotItem: {Count: 2, id: 'netherendingores:ore_other_1', Damage: 7 as short}}),
  <rats:rat_nugget_ore:30>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_2', Damage: 9 as short}, IngotItem: {Count: 2, id: 'netherendingores:ore_other_1', Damage: 10 as short}}),
  <rats:rat_nugget_ore:31>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 2 as short}, IngotItem: {Count: 2, id: 'thermalfoundation:ore', Damage: 7 as short}}),
  <rats:rat_nugget_ore:32>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_vanilla', Damage: 4 as short}, IngotItem: {Count: 2, id: 'minecraft:iron_ore', Damage: 0 as short}}),
  <rats:rat_nugget_ore:33>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_vanilla', Damage: 5 as short}, IngotItem: {Count: 2, id: 'minecraft:lapis_ore', Damage: 0 as short}}),
  <rats:rat_nugget_ore:34>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 3 as short}, IngotItem: {Count: 2, id: 'thermalfoundation:ore', Damage: 3 as short}}),
  <rats:rat_nugget_ore:35>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 4 as short}, IngotItem: {Count: 2, id: 'thermalfoundation:ore', Damage: 8 as short}}),
  <rats:rat_nugget_ore:36>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 5 as short}, IngotItem: {Count: 2, id: 'thermalfoundation:ore', Damage: 5 as short}}),
  <rats:rat_nugget_ore:37>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 11 as short}, IngotItem: {Count: 2, id: 'mekanism:oreblock', Damage: 0 as short}}),
  <rats:rat_nugget_ore:38>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_2', Damage: 3 as short}, IngotItem: {Count: 2, id: 'biomesoplenty:gem_ore', Damage: 2 as short}}),
  <rats:rat_nugget_ore:39>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 6 as short}, IngotItem: {Count: 2, id: 'thermalfoundation:ore', Damage: 6 as short}}),
  <rats:rat_nugget_ore:40>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_other_1', Damage: 1 as short}, IngotItem: {Count: 2, id: 'minecraft:quartz_ore', Damage: 0 as short}}),
  <rats:rat_nugget_ore:41>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_vanilla', Damage: 6 as short}, IngotItem: {Count: 2, id: 'minecraft:redstone_ore', Damage: 0 as short}}),
  <rats:rat_nugget_ore:42>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_2', Damage: 1 as short}, IngotItem: {Count: 2, id: 'biomesoplenty:gem_ore', Damage: 1 as short}}),
  <rats:rat_nugget_ore:43>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_2', Damage: 2 as short}, IngotItem: {Count: 2, id: 'biomesoplenty:gem_ore', Damage: 6 as short}}),
  <rats:rat_nugget_ore:44>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 7 as short}, IngotItem: {Count: 2, id: 'thermalfoundation:ore', Damage: 2 as short}}),
  <rats:rat_nugget_ore:45>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 8 as short}, IngotItem: {Count: 2, id: 'thermalfoundation:ore', Damage: 1 as short}}),
  <rats:rat_nugget_ore:46>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_1', Damage: 12 as short}, IngotItem: {Count: 2, id: 'immersiveengineering:ore', Damage: 5 as short}}),
  <rats:rat_nugget_ore:47>.withTag({OreItem: {Count: 1, id: 'netherendingores:ore_end_modded_2', Damage: 7 as short}, IngotItem: {Count: 2, id: 'netherendingores:ore_other_1', Damage: 8 as short}}),
  <rats:rat_nugget_ore:48>.withTag({OreItem: {Count: 1, id: 'biomesoplenty:gem_ore', Damage: 0 as short}, IngotItem: {Count: 1, id: 'biomesoplenty:gem', Damage: 0 as short}}),
  <rats:rat_nugget_ore:49>.withTag({OreItem: {Count: 1, id: 'minecraft:gold_ore', Damage: 0 as short}, IngotItem: {Count: 1, id: 'minecraft:gold_ingot', Damage: 0 as short}}),
  <rats:rat_nugget_ore:50>.withTag({OreItem: {Count: 1, id: 'thermalfoundation:ore', Damage: 7 as short}, IngotItem: {Count: 1, id: 'thermalfoundation:material', Damage: 135 as short}}),
  <rats:rat_nugget_ore:51>.withTag({OreItem: {Count: 1, id: 'minecraft:iron_ore', Damage: 0 as short}, IngotItem: {Count: 1, id: 'minecraft:iron_ingot', Damage: 0 as short}}),
  <rats:rat_nugget_ore:52>.withTag({OreItem: {Count: 1, id: 'minecraft:lapis_ore', Damage: 0 as short}, IngotItem: {Count: 1, id: 'minecraft:dye', Damage: 4 as short}}),
  <rats:rat_nugget_ore:53>.withTag({OreItem: {Count: 1, id: 'thermalfoundation:ore', Damage: 3 as short}, IngotItem: {Count: 1, id: 'thermalfoundation:material', Damage: 131 as short}}),
  <rats:rat_nugget_ore:54>.withTag({OreItem: {Count: 1, id: 'nuclearcraft:ore', Damage: 6 as short}, IngotItem: {Count: 1, id: 'nuclearcraft:ingot', Damage: 6 as short}}),
  <rats:rat_nugget_ore:55>.withTag({OreItem: {Count: 1, id: 'nuclearcraft:ore', Damage: 7 as short}, IngotItem: {Count: 1, id: 'nuclearcraft:ingot', Damage: 7 as short}}),
  <rats:rat_nugget_ore:56>.withTag({OreItem: {Count: 1, id: 'biomesoplenty:gem_ore', Damage: 5 as short}, IngotItem: {Count: 1, id: 'biomesoplenty:gem', Damage: 5 as short}}),
  <rats:rat_nugget_ore:57>.withTag({OreItem: {Count: 1, id: 'thermalfoundation:ore', Damage: 8 as short}, IngotItem: {Count: 1, id: 'thermalfoundation:material', Damage: 136 as short}}),
  <rats:rat_nugget_ore:80>.withTag({OreItem: {Count: 1, id: 'minecraft:quartz_ore', Damage: 0 as short}, IngotItem: {Count: 1, id: 'minecraft:quartz', Damage: 0 as short}}),
  <rats:rat_nugget_ore:88>.withTag({OreItem: {Count: 1, id: 'thermalfoundation:ore', Damage: 5 as short}, IngotItem: {Count: 1, id: 'thermalfoundation:material', Damage: 133 as short}}),
  <rats:rat_nugget_ore:89>.withTag({OreItem: {Count: 1, id: 'mekanism:oreblock', Damage: 0 as short}, IngotItem: {Count: 1, id: 'mekanism:ingot', Damage: 1 as short}}),
  <rats:rat_nugget_ore:90>.withTag({OreItem: {Count: 1, id: 'biomesoplenty:gem_ore', Damage: 2 as short}, IngotItem: {Count: 1, id: 'biomesoplenty:gem', Damage: 2 as short}}),
  <rats:rat_nugget_ore:91>.withTag({OreItem: {Count: 1, id: 'contenttweaker:ore_phosphor', Damage: 0 as short}, IngotItem: {Count: 1, id: 'contenttweaker:nugget_phosphor', Damage: 0 as short}}),
  <rats:rat_nugget_ore:92>.withTag({OreItem: {Count: 1, id: 'thermalfoundation:ore', Damage: 6 as short}, IngotItem: {Count: 1, id: 'thermalfoundation:material', Damage: 134 as short}}),
  <rats:rat_nugget_ore:93>.withTag({OreItem: {Count: 1, id: 'twilightforest:ironwood_raw', Damage: 0 as short}, IngotItem: {Count: 2, id: 'twilightforest:ironwood_ingot', Damage: 0 as short}}),
  <rats:rat_nugget_ore:94>.withTag({OreItem: {Count: 1, id: 'minecraft:redstone_ore', Damage: 0 as short}, IngotItem: {Count: 1, id: 'minecraft:redstone', Damage: 0 as short}}),
  <rats:rat_nugget_ore:95>.withTag({OreItem: {Count: 1, id: 'biomesoplenty:gem_ore', Damage: 1 as short}, IngotItem: {Count: 1, id: 'biomesoplenty:gem', Damage: 1 as short}}),
  <rats:rat_nugget_ore:96>.withTag({OreItem: {Count: 1, id: 'biomesoplenty:gem_ore', Damage: 6 as short}, IngotItem: {Count: 1, id: 'biomesoplenty:gem', Damage: 6 as short}}),
  <rats:rat_nugget_ore:97>.withTag({OreItem: {Count: 1, id: 'thermalfoundation:ore', Damage: 2 as short}, IngotItem: {Count: 1, id: 'thermalfoundation:material', Damage: 130 as short}}),
  <rats:rat_nugget_ore:98>.withTag({OreItem: {Count: 1, id: 'astralsorcery:blockcustomore', Damage: 1 as short}, IngotItem: {Count: 1, id: 'astralsorcery:itemcraftingcomponent', Damage: 1 as short}}),
  <rats:rat_nugget_ore:99>.withTag({OreItem: {Count: 1, id: 'biomesoplenty:gem_ore', Damage: 4 as short}, IngotItem: {Count: 1, id: 'biomesoplenty:gem', Damage: 4 as short}}),
  <rats:rat_nugget_ore:100>.withTag({OreItem: {Count: 1, id: 'nuclearcraft:ore', Damage: 3 as short}, IngotItem: {Count: 1, id: 'nuclearcraft:ingot', Damage: 3 as short}}),
  <rats:rat_nugget_ore:101>.withTag({OreItem: {Count: 1, id: 'thermalfoundation:ore', Damage: 1 as short}, IngotItem: {Count: 1, id: 'thermalfoundation:material', Damage: 129 as short}}),
  <rats:rat_nugget_ore:102>.withTag({OreItem: {Count: 1, id: 'biomesoplenty:gem_ore', Damage: 3 as short}, IngotItem: {Count: 1, id: 'biomesoplenty:gem', Damage: 3 as short}}),
  <rats:rat_nugget_ore:103>.withTag({OreItem: {Count: 1, id: 'endreborn:block_wolframium_ore', Damage: 0 as short}, IngotItem: {Count: 1, id: 'endreborn:item_ingot_wolframium', Damage: 0 as short}}),
  <rats:rat_nugget_ore:104>.withTag({OreItem: {Count: 1, id: 'immersiveengineering:ore', Damage: 5 as short}, IngotItem: {Count: 1, id: 'immersiveengineering:metal', Damage: 5 as short}}),
  <rats:rat_nugget_ore>.withTag({OreItem: {Count: 1, id: 'thermalfoundation:ore', Damage: 4 as short}, IngotItem: {Count: 1, id: 'thermalfoundation:material', Damage: 132 as short}})
/**/
] as IItemStack[];

function getOreBase(item as IItemStack) as string {
  val lookup = '^(oreEnd|oreNether|ingot|dust|gem)';
  for ore in item.ores {
    if (!ore.name.matches(lookup ~ '.+')) continue;
    val base = ore.name.replaceAll(lookup, '');
    if (base == '') continue;
    return base;
  }
  return null;
}

function getOutput(poop as IItemStack) as IItemStack {
  if (isNull(poop.tag.OreItem) || isNull(poop.tag.IngotItem)) return null;

  // Get what resource we got after processing
  val oreItem = IItemStack.fromData(poop.tag.OreItem);
  val ingotItem = IItemStack.fromData(poop.tag.IngotItem);
  if (isNull(ingotItem) || isNull(oreItem)) return null;

  var resultOreBase = getOreBase(ingotItem);
  if (isNull(resultOreBase)) resultOreBase = getOreBase(oreItem);
  if (isNull(resultOreBase)) return null;

  val outputOre = oreDict.get('crystalShard' ~ resultOreBase);
  if (isNull(outputOre) || outputOre.items.length <= 0) return null;

  return outputOre.items[0] * ingotItem.amount;
}

for poop in listRatPoop {
  val out = getOutput(poop);
  if (isNull(out)) continue;
  // Fake recipe
  recipes.addShapeless(out, [poop, poop, poop]);
}

// Actual recipe function
recipes.addHiddenShapeless(
  'actual rat recipe',
  <biomesoplenty:mudball>, [
    <rats:rat_nugget_ore:*>.marked('0'),
    <rats:rat_nugget_ore:*>.marked('1'),
    <rats:rat_nugget_ore:*>.marked('2'),
  ], function (out, ins, cInfo) {
    val insList = ins.values;
    for i, item in insList {
      if (i == 0) continue;

      // Check all nuggets same
      if (insList[i - 1].damage != item.damage) return null;
    }
    return getOutput(ins['0']);
  });
