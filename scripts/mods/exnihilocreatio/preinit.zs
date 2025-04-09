#loader contenttweaker
#modloaded exnihilocreatio

/*

// This code can add lot of items https://i.imgur.com/TINWhLn.png
// https://docs.blamejared.com/1.12/en/Mods/Ex_Nihilo_Creatio/Ores/

mods.exnihilocreatio.Ore.addRecipe(
  "id_name", # Name would be used for ids. <crafttweaker:item_ore_id_name>
  "EEEEEE", # HEX Color
  <ore:oreRockCrystal>.firstItem,
  {
    "en_us": "Display Name",
    "ru_ru": "Клиентское Имя",
  },
  "BaseName" # Ore BASE name. From uppercase. <ore:oreBaseName>
);

*/

mods.exnihilocreatio.Ore.addRecipe(
  'tungsten',
  '2B2C2A',
  <ore:oreTungsten>.firstItem,
  {
    'en_us': 'Tungsten',
    'ru_ru': 'Вольфрам',
  },
  'Tungsten'
);

mods.exnihilocreatio.Ore.addRecipe(
  'anglesite',
  'FACB20',
  <ore:oreAnglesite>.firstItem,
  {
    'en_us': '§6Anglesite',
    'ru_ru': '§6Англезит',
  },
  'Anglesite'
);

mods.exnihilocreatio.Ore.addRecipe(
  'benitoite',
  '0D7DFC',
  <ore:oreBenitoite>.firstItem,
  {
    'en_us': '§bBenitoite',
    'ru_ru': '§bБенитоит',
  },
  'Benitoite'
);
