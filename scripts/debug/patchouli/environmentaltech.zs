#modloaded patchouli environmentaltech
#reloadable
#sideonly client
#priority -1000

val controllerEfficiency = [
  native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.cont.TileContSolarT1.MAX_EFFICIENCY,
  native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.cont.TileContSolarT2.MAX_EFFICIENCY,
  native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.cont.TileContSolarT3.MAX_EFFICIENCY,
  native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.cont.TileContSolarT4.MAX_EFFICIENCY,
  native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.cont.TileContSolarT5.MAX_EFFICIENCY,
  native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.cont.TileContSolarT6.MAX_EFFICIENCY,
] as float[];

val cellEfficiency = [
  native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.cell.et.TileSolarCell1Litherite.EFFICIENCY,
  native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.cell.et.TileSolarCell2Erodium.EFFICIENCY,
  native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.cell.et.TileSolarCell3Kyronite.EFFICIENCY,
  native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.cell.et.TileSolarCell4Pladium.EFFICIENCY,
  native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.cell.et.TileSolarCell5Ionite.EFFICIENCY,
  native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.cell.et.TileSolarCell6Aethium.EFFICIENCY,
] as float[];

var lines = [
  '{',
  '  "name": "Solar Panel",',
  '  "icon": "environmentaltech:solar_cont_1",',
  '  "category": "World",',
  '  "pages": [',
  '    {',
  '      "type": "item_list",',
  '      "title": "Solar Array Tier 1",',
] as [string];

val panel = scripts.mods.environmentaltech.evt.panel;

for j in 0 .. 6 {
  if (j != 0) lines += '    },\n    {\n      "type": "item_list",'
    ~ '\n      "title": "Solar Array Tier ' ~ (j + 1) ~ '",';
  val cellCount = pow((j + 1) * 2 + 1, 2) as int;
  for i, ingr in panel {
    val item = ingr.itemArray[0];
    lines += '      "item' ~ i ~ '": "'
      ~ item.definition.id ~ (item.damage == 0 ? '' : ':' ~ item.damage)
      ~ '#' ~ cellCount ~ '",';
  }
  for i, ingr in panel {
    val rft = cellCount as double
      * native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.TileContSolarBase.PRODUCTION_RATE
      * pow(native.com.valkyrieofnight.et.m_multiblocks.m_solar.tile.TileContSolarBase.PRODUCTION_POWER, j)
      * crafttweaker.util.Math.min(controllerEfficiency[j], cellEfficiency[i]);
    lines += '      "text' ~ i ~ '": "'
      ~ mods.zenutils.StaticString.format('%11s', 
        mods.zenutils.StaticString.format('%,d', rft as int))
      ~ ' RF/t"' ~ (i == 5 ? '' : ',');
  }
}
lines += '    }\n  ]\n}\n';
print('Save this into file "patchouli_books/e2e_e/en_us/entries/world/solar_panel.json"\n'
  + mods.zenutils.StaticString.join(lines as string[], '\n'));
