#modloaded nuclearcraft
#reloadable
#ignoreBracketErrors

import crafttweaker.item.IItemStack;

if (!native.nc.config.NCConfig.radiation_enabled_public) {
  Purge(<nuclearcraft:helm_hazmat>);
  Purge(<nuclearcraft:chest_hazmat>);
  Purge(<nuclearcraft:legs_hazmat>);
  Purge(<nuclearcraft:boots_hazmat>);
} else {
  # Way cheaper since radiation choking
  # [Radiation Scrubber] from [Graphite Block][+2]
  craft.remake(<nuclearcraft:radiation_scrubber>, ["pretty",
    "□ ▲ □",
    "▲ ■ ▲",
    "□ ▲ □"], {
    "□": <ore:plateBasic>,
    "▲": <ore:dustVilliaumite>,
    "■": <ore:blockGraphite>,
  });

  # --------------------------------------------------------------
  # Radiation Shielding recipes
  # --------------------------------------------------------------
  if (!isNull(loadedMods['conarm'])) {
    val armorPieces = [
      <conarm:helmet:*>,
      <conarm:chestplate:*>,
      <conarm:leggings:*>,
      <conarm:boots:*>,
    ] as IItemStack[];
    val radPlates = [
      <nuclearcraft:rad_shielding>,
      <nuclearcraft:rad_shielding:1>,
      <nuclearcraft:rad_shielding:2>,
    ] as IItemStack[];
    for i, plate in radPlates {
      val resistance = 0.03 * pow(10.0, i as double);
      val updFn = getUpdateFn(resistance);
      for armor in armorPieces {
        recipes.addShapeless('RadResist '~i~' '~armor.name,
          armor.withDamage(0).updateTag({ncRadiationResistance: resistance}),
          [armor.marked(''), plate], updFn, null
        );
      }
    }
  }
  # --------------------------------------------------------------

  # Radiation mutations
  # Sadly, radiation mutations works really laggy and cant
  #   be implemented in heavy modpacks...
  // for threshold, pair in {
  //   0.05d: {
  //     <ore:dirt> | <ore:grass> | <ore:gravel>: <nuclearcraft:wasteland_earth>,
  //     <ore:logWood> : <biomesoplenty:log_4:5>,
  //     <ore:treeLeaves> : <biomesoplenty:leaves_1:9>,
  //   },
  //   0.3d: {
  //     <ore:stone>: <twilightforest:deadrock>,
  //     <ore:gravel> | <ore:cobblestone> :<twilightforest:deadrock:1>,
  //     <ore:stoneGranite> | <ore:stoneDiorite> | <ore:stoneAndesite>: <twilightforest:deadrock:2>,
  //   }
  // } as IItemStack[IIngredient][double] {
  //   for _from, _to in pair {
  //     mods.nuclearcraft.Radiation.addBlockMutation(_from, _to, threshold);
  //   }
  // }

  # --------------------------------------------------------------
  # [Hazmat Suit Headwear] from [Leather Cap][+2]
  recipes.removeByRecipeName("nuclearcraft:helm_hazmat");
  craft.make(<nuclearcraft:helm_hazmat>, ["pretty",
    "d d d",
    "M L M"], {
    "d": <ore:dyeYellow>,    # Floral Yellow Powder
    "M": <nuclearcraft:rad_shielding:1>, # Medium Radiation Shielding
    "L": <minecraft:leather_helmet>.anyDamage(), # Leather Cap
  });

  # [Hazmat Suit Chestpiece] from [Leather Tunic][+2]
  recipes.removeByRecipeName("nuclearcraft:chest_hazmat");
  craft.make(<nuclearcraft:chest_hazmat>, ["pretty",
    "d d d",
    "M L M"], {
    "d": <ore:dyeYellow>,    # Floral Yellow Powder
    "M": <nuclearcraft:rad_shielding:1>, # Medium Radiation Shielding
    "L": <minecraft:leather_chestplate>.anyDamage(), # Leather Tunic
  });

  # [Hazmat Suit Leggings] from [Leather Pants][+2]
  recipes.removeByRecipeName("nuclearcraft:legs_hazmat");
  craft.make(<nuclearcraft:legs_hazmat>, ["pretty",
    "d d d",
    "M L M"], {
    "d": <ore:dyeYellow>,    # Floral Yellow Powder
    "M": <nuclearcraft:rad_shielding:1>, # Medium Radiation Shielding
    "L": <minecraft:leather_leggings>.anyDamage(), # Leather Pants
  });

  # [Hazmat Suit Boots] from [Leather Boots][+2]
  recipes.removeByRecipeName("nuclearcraft:boots_hazmat");
  craft.make(<nuclearcraft:boots_hazmat>, ["pretty",
    "d d d",
    "M L M"], {
    "d": <ore:dyeYellow>,    # Floral Yellow Powder
    "M": <nuclearcraft:rad_shielding:1>, # Medium Radiation Shielding
    "L": <minecraft:leather_boots>.anyDamage(), # Leather Boots
  });
}

function getUpdateFn(resistance as double) as crafttweaker.recipes.IRecipeFunction {
  return function(out, ins, cInfo) {
    if (isNull(ins)) return out;
    for mark, item in ins {
      if (isNull(item)) continue;
      return item.updateTag({ncRadiationResistance: resistance});
    }
    return out;
  } as crafttweaker.recipes.IRecipeFunction;
}
