#modloaded nuclearcraft

import crafttweaker.item.IIngredient;

import scripts.mods.nuclearcraft.NTP.coilclasses.ConverterInfo;
import scripts.mods.nuclearcraft.NTP.coilconverterlist.ConverterInfoList;

val purpur = <minecraft:purpur_block>;
val purped = <ore:stonePurpur>;
purped.add(purpur);

val barat = <trinity:solid_baratol>;
val barared = <ore:stoneBaratol>;
barared.add(barat);

// [Basic Redstone Field Converter] from [HSLA Steel Ingot][+2]
craft.remake(<nuclearcraft:turbine_dynamo_coil_baseconverter>, ['pretty',
  '□ п □',
  'п ▬ п',
  '□ п □'], {
  '□': <ore:plateElectrumFlux>, // Fluxed Electrum Plate
  'п': <ore:plateSilver>, // Silver Plate
  '▬': <ore:ingotHSLASteel>, // HSLA Steel Ingot
});

val attank = <qmd:cell:3>.withTag({ particle_storage: { particle_amount: 100000, particle_capacity: 100000 } });
val attankre = attank.transformReplace(<qmd:cell>);

recipes.addShaped('ntp antitritium coil', itemUtils.getItem('nuclearcraft:turbine_dynamo_coil_antitritiumconverter') * 2,
  [[attankre, attankre, attankre],
    [<ore:ingotHSLASteel>, <nuclearcraft:turbine_dynamo_coil_baseconverter>, <ore:ingotHSLASteel>],
    [attankre, attankre, attankre]]);

function addConverterRecipe(info as ConverterInfo) as void {
  var material = null as IIngredient;

  for prefix in ['ingot', 'dust', 'gem', 'stone'] as string[] {
    val ore = oreDict[prefix ~ info.name];
    if (!isNull(ore.firstItem)) {
      material = ore;
      break;
    }
  }

  if (isNull(material)) {
    logger.logWarning(`[NTP][Converter Recipes]: cannot find ingredient for "${info.name}".`);
    return;
  }

  recipes.addShaped(`ntp ${info.name} coil`, itemUtils.getItem(`nuclearcraft:turbine_dynamo_coil_${info.name.toLowerCase()}converter`) * 2,
    [[material, material, material],
      [<ore:ingotHSLASteel>, <nuclearcraft:turbine_dynamo_coil_baseconverter>, <ore:ingotHSLASteel>],
      [material, material, material]]);
}

for info in ConverterInfoList {
  addConverterRecipe(info);
}
