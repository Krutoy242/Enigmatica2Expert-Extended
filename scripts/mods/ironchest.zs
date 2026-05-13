#modloaded ironchest

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

// *======= Recipes =======*

// Iron Chest
recipes.remove(<ironchest:iron_chest>);
recipes.addShaped('Iron Chest',
  <ironchest:iron_chest>,
  [[<ore:plateIron>, <ore:plateIron>, <ore:plateIron>],
    [<ore:plateIron>, <ore:chest>, <ore:plateIron>],
    [<ore:plateIron>, <ore:plateIron>, <ore:plateIron>]]);

// Gold Chest
recipes.remove(<ironchest:iron_chest:1>);
recipes.addShaped('Gold Chest',
  <ironchest:iron_chest:1>,
  [[<ore:plateGold>, <ore:plateGold>, <ore:plateGold>],
    [<ore:plateGold>, <ironchest:iron_chest>, <ore:plateGold>],
    [<ore:plateGold>, <ore:plateGold>, <ore:plateGold>]]);

// Diamond Chest
recipes.remove(<ironchest:iron_chest:2>);
recipes.addShaped('Diamond Chest',
  <ironchest:iron_chest:2>,
  [[<ore:blockGlass>, <ore:blockGlass>, <ore:blockGlass>],
    [<ore:gemDiamondRat>, <ironchest:iron_chest:1>, <ore:gemDiamondRat>],
    [<ore:blockGlass>, <ore:gearDiamond>, <ore:blockGlass>]]);

for output, ingrs in {
  <ironchest:wood_iron_chest_upgrade>       : [<ore:plateIron>],
  <ironchest:iron_gold_chest_upgrade>       : [<ore:plateGold>],
  <ironchest:gold_diamond_chest_upgrade>    : [<ore:gemDiamondRat>, <ore:gearDiamond>, <ore:blockGlass>],
  <ironchest:diamond_crystal_chest_upgrade> : [<ore:blockGlass>],
  <ironchest:diamond_obsidian_chest_upgrade>: [<ore:obsidian>],

  <ironchest:vanilla_iron_shulker_upgrade>    : [<ic2:casing:3>/* Iron Item Casing */],
  <ironchest:iron_gold_shulker_upgrade>       : [<ic2:casing:2>/* Gold Item Casing */],
  <ironchest:gold_diamond_shulker_upgrade>    : [<ore:gemDiamondRat>, <ore:gemDiamondRat>, <ore:paneGlass>],
  <ironchest:diamond_crystal_shulker_upgrade> : [<ore:paneGlass>],
  <ironchest:diamond_obsidian_shulker_upgrade>: [<ore:obsidian>, null],
} as IIngredient[][IItemStack] {
  craft.remake(output, ['pretty',
    '  ■  ',
    '◊ ‚ ◊',
    '■ ¤ ■'], {
    '¤': ingrs.length > 1 ? ingrs[1] : ingrs[0],
    '■': ingrs.length > 2 ? ingrs[2] : ingrs[0],
    '◊': ingrs[0],
    '‚': <ore:nuggetFakeIron>, // Iron Alloy Nugget
  });
}

// *======= Remove & Hide =======*

for i, meta in [3, 4] as int[] {
  Purge(<item:ironchest:iron_chest:${meta}>);
  for color in [
    'white',
    'orange',
    'magenta',
    'light_blue',
    'yellow',
    'lime',
    'pink',
    'gray',
    'silver',
    'cyan',
    'purple',
    'blue',
    'brown',
    'green',
    'red',
    'black',
  ] as string[] {
    Purge(<item:ironchest:iron_shulker_box_${color}:${meta}>);

    // Remove unused silver/copper chests recipes
    if (i == 0) {
      recipes.removeByRecipeName(`ironchest:shulker/${color}/iron/copper_iron_shulker_box`);
      recipes.removeByRecipeName(`ironchest:shulker/${color}/gold/silver_gold_shulker_box`);
      recipes.removeByRecipeName(`ironchest:shulker/${color}/diamond/silver_diamond_shulker_box`);
      recipes.removeByRecipeName(`ironchest:shulker/${color}/iron/copper_iron_shulker_box`);
      recipes.removeByRecipeName(`ironchest:shulker/${color}/diamond/silver_diamond_shulker_box`);
    }
  }
}

// Alt for animals
// [DirtChest 9000!] from [Framed Framed Chest][+2]
craft.remake(<ironchest:iron_chest:7>, ['pretty',
  'd P d',
  'd   d',
  'd d d'], {
  'd': <ore:dirt>,                  // Dirt
  'P': <ore:ratPoop>,               // Rat "Nugget"
});
