#modloaded ftbquests

furnace.setFuel(<ftbquests:chest>, 0);

val rarities = [
  'common',
  'uncommon',
  'rare',
  'legendary',
  'mythic',
] as string[];

for i, rarity in rarities {
  if (i == 0) continue;
  recipes.addShapeless(<ftbquests:lootcrate>.withTag({ type: rarities[i - 1] }) * 9, [<ftbquests:lootcrate>.withTag({ type: rarity })]);
}
