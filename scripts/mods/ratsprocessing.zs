#modloaded rats requious

import crafttweaker.item.IItemStack;

static listRatPoop as IItemStack[] = [
/* Inject_js(
getFurnaceRecipes()
?.filter(g=>g.in_id==='rats:rat_nugget_ore')
.map(g=>'  '+g.input.replace(/"/gm, "'"))
.join(',\n')
) */
  <rats:rat_nugget_ore:1>.withTag({OreItem: {id: 'thaumcraft:ore_amber', Count: 1, Damage: 0 as short}, IngotItem: {id: 'thaumcraft:amber', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:2>.withTag({OreItem: {id: 'forestry:resources', Count: 1, Damage: 0 as short}, IngotItem: {id: 'forestry:apatite', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:3>.withTag({OreItem: {id: 'astralsorcery:blockcustomsandore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'astralsorcery:itemcraftingcomponent', Count: 3, Damage: 0 as short}}),
  <rats:rat_nugget_ore:4>.withTag({OreItem: {id: 'tconstruct:ore', Count: 1, Damage: 1 as short}, IngotItem: {id: 'tconstruct:ingots', Count: 1, Damage: 1 as short}}),
  <rats:rat_nugget_ore:5>.withTag({OreItem: {id: 'twilightforest:armor_shard_cluster', Count: 1, Damage: 0 as short}, IngotItem: {id: 'twilightforest:knightmetal_ingot', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:6>.withTag({OreItem: {id: 'actuallyadditions:block_misc', Count: 1, Damage: 3 as short}, IngotItem: {id: 'actuallyadditions:item_misc', Count: 1, Damage: 5 as short}}),
  <rats:rat_nugget_ore:7>.withTag({OreItem: {id: 'nuclearcraft:ore', Count: 1, Damage: 5 as short}, IngotItem: {id: 'nuclearcraft:ingot', Count: 1, Damage: 5 as short}}),
  <rats:rat_nugget_ore:8>.withTag({OreItem: {id: 'thaumcraft:ore_cinnabar', Count: 1, Damage: 0 as short}, IngotItem: {id: 'thaumcraft:quicksilver', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:9>.withTag({OreItem: {id: 'minecraft:coal_ore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'minecraft:coal', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:10>.withTag({OreItem: {id: 'tconstruct:ore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'tconstruct:ingots', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:11>.withTag({OreItem: {id: 'thermalfoundation:ore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'thermalfoundation:material', Count: 1, Damage: 128 as short}}),
  <rats:rat_nugget_ore:12>.withTag({OreItem: {id: 'minecraft:diamond_ore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'minecraft:diamond', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:13>.withTag({OreItem: {id: 'libvulpes:ore0', Count: 1, Damage: 0 as short}, IngotItem: {id: 'libvulpes:productdust', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:14>.withTag({OreItem: {id: 'minecraft:emerald_ore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'minecraft:emerald', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:15>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 0 as short}, IngotItem: {id: 'thermalfoundation:ore', Count: 2, Damage: 4 as short}}),
  <rats:rat_nugget_ore:16>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 5 as short}, IngotItem: {id: 'netherendingores:ore_other_1', Count: 2, Damage: 6 as short}}),
  <rats:rat_nugget_ore:17>.withTag({OreItem: {id: 'netherendingores:ore_other_1', Count: 1, Damage: 3 as short}, IngotItem: {id: 'tconstruct:ore', Count: 2, Damage: 1 as short}}),
  <rats:rat_nugget_ore:18>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 8 as short}, IngotItem: {id: 'netherendingores:ore_other_1', Count: 2, Damage: 9 as short}}),
  <rats:rat_nugget_ore:19>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 9 as short}, IngotItem: {id: 'appliedenergistics2:quartz_ore', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:20>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 10 as short}, IngotItem: {id: 'appliedenergistics2:charged_quartz_ore', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:21>.withTag({OreItem: {id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 0 as short}, IngotItem: {id: 'minecraft:coal_ore', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:22>.withTag({OreItem: {id: 'netherendingores:ore_other_1', Count: 1, Damage: 5 as short}, IngotItem: {id: 'tconstruct:ore', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:23>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 1 as short}, IngotItem: {id: 'thermalfoundation:ore', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:24>.withTag({OreItem: {id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 1 as short}, IngotItem: {id: 'minecraft:diamond_ore', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:25>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 14 as short}, IngotItem: {id: 'libvulpes:ore0', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:26>.withTag({OreItem: {id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 2 as short}, IngotItem: {id: 'minecraft:emerald_ore', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:27>.withTag({OreItem: {id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 3 as short}, IngotItem: {id: 'minecraft:gold_ore', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:28>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 6 as short}, IngotItem: {id: 'netherendingores:ore_other_1', Count: 2, Damage: 7 as short}}),
  <rats:rat_nugget_ore:29>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 9 as short}, IngotItem: {id: 'netherendingores:ore_other_1', Count: 2, Damage: 10 as short}}),
  <rats:rat_nugget_ore:30>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 2 as short}, IngotItem: {id: 'thermalfoundation:ore', Count: 2, Damage: 7 as short}}),
  <rats:rat_nugget_ore:31>.withTag({OreItem: {id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 4 as short}, IngotItem: {id: 'minecraft:iron_ore', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:32>.withTag({OreItem: {id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 5 as short}, IngotItem: {id: 'minecraft:lapis_ore', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:33>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 3 as short}, IngotItem: {id: 'thermalfoundation:ore', Count: 2, Damage: 3 as short}}),
  <rats:rat_nugget_ore:34>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 4 as short}, IngotItem: {id: 'thermalfoundation:ore', Count: 2, Damage: 8 as short}}),
  <rats:rat_nugget_ore:35>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 5 as short}, IngotItem: {id: 'thermalfoundation:ore', Count: 2, Damage: 5 as short}}),
  <rats:rat_nugget_ore:36>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 11 as short}, IngotItem: {id: 'mekanism:oreblock', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:37>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 3 as short}, IngotItem: {id: 'biomesoplenty:gem_ore', Count: 2, Damage: 2 as short}}),
  <rats:rat_nugget_ore:38>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 6 as short}, IngotItem: {id: 'thermalfoundation:ore', Count: 2, Damage: 6 as short}}),
  <rats:rat_nugget_ore:39>.withTag({OreItem: {id: 'netherendingores:ore_other_1', Count: 1, Damage: 1 as short}, IngotItem: {id: 'minecraft:quartz_ore', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:40>.withTag({OreItem: {id: 'netherendingores:ore_end_vanilla', Count: 1, Damage: 6 as short}, IngotItem: {id: 'minecraft:redstone_ore', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:41>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 1 as short}, IngotItem: {id: 'biomesoplenty:gem_ore', Count: 2, Damage: 1 as short}}),
  <rats:rat_nugget_ore:42>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 2 as short}, IngotItem: {id: 'biomesoplenty:gem_ore', Count: 2, Damage: 6 as short}}),
  <rats:rat_nugget_ore:43>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 7 as short}, IngotItem: {id: 'thermalfoundation:ore', Count: 2, Damage: 2 as short}}),
  <rats:rat_nugget_ore:44>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 8 as short}, IngotItem: {id: 'thermalfoundation:ore', Count: 2, Damage: 1 as short}}),
  <rats:rat_nugget_ore:45>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_1', Count: 1, Damage: 12 as short}, IngotItem: {id: 'immersiveengineering:ore', Count: 2, Damage: 5 as short}}),
  <rats:rat_nugget_ore:46>.withTag({OreItem: {id: 'netherendingores:ore_end_modded_2', Count: 1, Damage: 7 as short}, IngotItem: {id: 'netherendingores:ore_other_1', Count: 2, Damage: 8 as short}}),
  <rats:rat_nugget_ore:47>.withTag({OreItem: {id: 'biomesoplenty:gem_ore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'biomesoplenty:gem', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:48>.withTag({OreItem: {id: 'draconicevolution:draconium_ore', Count: 1, Damage: 2 as short}, IngotItem: {id: 'draconicevolution:draconium_ore', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:49>.withTag({OreItem: {id: 'minecraft:gold_ore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'minecraft:gold_ingot', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:50>.withTag({OreItem: {id: 'thermalfoundation:ore', Count: 1, Damage: 7 as short}, IngotItem: {id: 'thermalfoundation:material', Count: 1, Damage: 135 as short}}),
  <rats:rat_nugget_ore:51>.withTag({OreItem: {id: 'minecraft:iron_ore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'minecraft:iron_ingot', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:52>.withTag({OreItem: {id: 'minecraft:lapis_ore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'minecraft:dye', Count: 1, Damage: 4 as short}}),
  <rats:rat_nugget_ore:53>.withTag({OreItem: {id: 'thermalfoundation:ore', Count: 1, Damage: 3 as short}, IngotItem: {id: 'thermalfoundation:material', Count: 1, Damage: 131 as short}}),
  <rats:rat_nugget_ore:54>.withTag({OreItem: {id: 'nuclearcraft:ore', Count: 1, Damage: 6 as short}, IngotItem: {id: 'nuclearcraft:ingot', Count: 1, Damage: 6 as short}}),
  <rats:rat_nugget_ore:55>.withTag({OreItem: {id: 'nuclearcraft:ore', Count: 1, Damage: 7 as short}, IngotItem: {id: 'nuclearcraft:ingot', Count: 1, Damage: 7 as short}}),
  <rats:rat_nugget_ore:56>.withTag({OreItem: {id: 'biomesoplenty:gem_ore', Count: 1, Damage: 5 as short}, IngotItem: {id: 'biomesoplenty:gem', Count: 1, Damage: 5 as short}}),
  <rats:rat_nugget_ore:57>.withTag({OreItem: {id: 'thermalfoundation:ore', Count: 1, Damage: 8 as short}, IngotItem: {id: 'thermalfoundation:material', Count: 1, Damage: 136 as short}}),
  <rats:rat_nugget_ore:81>.withTag({OreItem: {id: 'minecraft:quartz_ore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'minecraft:quartz', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:89>.withTag({OreItem: {id: 'thermalfoundation:ore', Count: 1, Damage: 5 as short}, IngotItem: {id: 'thermalfoundation:material', Count: 1, Damage: 133 as short}}),
  <rats:rat_nugget_ore:90>.withTag({OreItem: {id: 'mekanism:oreblock', Count: 1, Damage: 0 as short}, IngotItem: {id: 'mekanism:ingot', Count: 1, Damage: 1 as short}}),
  <rats:rat_nugget_ore:91>.withTag({OreItem: {id: 'biomesoplenty:gem_ore', Count: 1, Damage: 2 as short}, IngotItem: {id: 'biomesoplenty:gem', Count: 1, Damage: 2 as short}}),
  <rats:rat_nugget_ore:92>.withTag({OreItem: {id: 'contenttweaker:ore_phosphor', Count: 1, Damage: 0 as short}, IngotItem: {id: 'contenttweaker:nugget_phosphor', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:93>.withTag({OreItem: {id: 'thermalfoundation:ore', Count: 1, Damage: 6 as short}, IngotItem: {id: 'thermalfoundation:material', Count: 1, Damage: 134 as short}}),
  <rats:rat_nugget_ore:94>.withTag({OreItem: {id: 'twilightforest:ironwood_raw', Count: 1, Damage: 0 as short}, IngotItem: {id: 'twilightforest:ironwood_ingot', Count: 2, Damage: 0 as short}}),
  <rats:rat_nugget_ore:95>.withTag({OreItem: {id: 'minecraft:redstone_ore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'minecraft:redstone', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:96>.withTag({OreItem: {id: 'astralsorcery:blockcustomore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'mysticalagriculture:prosperity_ore', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:97>.withTag({OreItem: {id: 'biomesoplenty:gem_ore', Count: 1, Damage: 1 as short}, IngotItem: {id: 'biomesoplenty:gem', Count: 1, Damage: 1 as short}}),
  <rats:rat_nugget_ore:98>.withTag({OreItem: {id: 'biomesoplenty:gem_ore', Count: 1, Damage: 6 as short}, IngotItem: {id: 'biomesoplenty:gem', Count: 1, Damage: 6 as short}}),
  <rats:rat_nugget_ore:99>.withTag({OreItem: {id: 'thermalfoundation:ore', Count: 1, Damage: 2 as short}, IngotItem: {id: 'thermalfoundation:material', Count: 1, Damage: 130 as short}}),
  <rats:rat_nugget_ore:100>.withTag({OreItem: {id: 'astralsorcery:blockcustomore', Count: 1, Damage: 1 as short}, IngotItem: {id: 'astralsorcery:itemcraftingcomponent', Count: 1, Damage: 1 as short}}),
  <rats:rat_nugget_ore:101>.withTag({OreItem: {id: 'biomesoplenty:gem_ore', Count: 1, Damage: 4 as short}, IngotItem: {id: 'biomesoplenty:gem', Count: 1, Damage: 4 as short}}),
  <rats:rat_nugget_ore:102>.withTag({OreItem: {id: 'nuclearcraft:ore', Count: 1, Damage: 3 as short}, IngotItem: {id: 'nuclearcraft:ingot', Count: 1, Damage: 3 as short}}),
  <rats:rat_nugget_ore:103>.withTag({OreItem: {id: 'thermalfoundation:ore', Count: 1, Damage: 1 as short}, IngotItem: {id: 'thermalfoundation:material', Count: 1, Damage: 129 as short}}),
  <rats:rat_nugget_ore:104>.withTag({OreItem: {id: 'biomesoplenty:gem_ore', Count: 1, Damage: 3 as short}, IngotItem: {id: 'biomesoplenty:gem', Count: 1, Damage: 3 as short}}),
  <rats:rat_nugget_ore:105>.withTag({OreItem: {id: 'endreborn:block_wolframium_ore', Count: 1, Damage: 0 as short}, IngotItem: {id: 'endreborn:item_ingot_wolframium', Count: 1, Damage: 0 as short}}),
  <rats:rat_nugget_ore:106>.withTag({OreItem: {id: 'immersiveengineering:ore', Count: 1, Damage: 5 as short}, IngotItem: {id: 'immersiveengineering:metal', Count: 1, Damage: 5 as short}}),
  <rats:rat_nugget_ore>.withTag({OreItem: {id: 'thermalfoundation:ore', Count: 1, Damage: 4 as short}, IngotItem: {id: 'thermalfoundation:material', Count: 1, Damage: 132 as short}})
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
  val oreItem = poop.tag.OreItem.toItemStack();
  val ingotItem = poop.tag.IngotItem.toItemStack();
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
