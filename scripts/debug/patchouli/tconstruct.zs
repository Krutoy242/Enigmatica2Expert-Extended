#modloaded patchouli tconstruct zentoolforge
#reloadable
#sideonly client
#priority -1000

var blacklistedNames = '';
for matName in scripts.equipment.equipGeneration.blacklistedMaterials {
  val ticMat = mods.zentoolforge.Toolforge.getMaterialFromID(matName);
  if (isNull(ticMat)) continue;
  blacklistedNames ~= '$(br)$(li)' ~ ticMat.getName;
}

val patchouli = '{\n'
~ '  "name": "Equip Generation",\n'
~ '  "icon": "draconicevolution:mob_soul{EntityName:\\"minecraft:zombie\\"}",\n'
~ '  "category": "World",\n'
~ '  "pages": [\n'
~ '    {\n'
~ '      "item": "draconicevolution:mob_soul{EntityName:\\"minecraft:zombie\\"}",\n'
~ '      "title": "Equip Generation",\n'
~ '      "text": "All mobs are generated with:$(br)$(li)Random TCon armor + weapon$(br)$(li)Random classic armor set + weapon$(br2)Chance that mob will have at least 1 equipment is'
~          '$(br)$(li)' ~ (scripts.equipment.equipGeneration.DEFAULT_EQUIP_CHANCE * 100) as int ~ '% base chance'
~          '$(br)$(li)' ~ (100 - scripts.equipment.equipGeneration.OVERWORLD_EQUIP_CHANCE * 100) as int ~ '% less in $(l)Overworld/$'
~          '$(br)$(li)' ~ (scripts.equipment.equipGeneration.NEXT_EQUIP_CHANCE * 100) as int ~ '% added to reroll for each next slot",\n'
~ '      "type": "spotlight"\n'
~ '    },\n'
~ '    {\n'
~ '      "item": "draconicevolution:mob_soul{EntityName:\\"minecraft:skeleton\\"}",\n'
~ '      "title": "Equip Generation",\n'
~ '      "text": "Different mobs have different armor types and different TCon materials.$(br)$(l)Zombies/$ have static chance to spawn with any avaliable material.$(br2)Roll used $(l)qubic/$ function, so $(l)Paper/$ would spawn $(l)~20%/$ times and $(l)Gelid Metal/$ $(l)~0.3%/$ times.",\n'
~ '      "type": "spotlight"\n'
~ '    },\n'
~ '    {\n'
~ '      "item": "draconicevolution:mob_soul{EntityName:\\"minecraft:zombie_pigman\\"}",\n'
~ '      "title": "Equip Generation",\n'
~ '      "text": "Mobs will never spawn with this TCon materials:' ~ blacklistedNames ~ '",\n'
~ '      "type": "spotlight"\n'
~ '    },\n'
~ '    {\n'
~ '      "item": "draconicevolution:mob_soul{EntityName:\\"minecraft:wither_skeleton\\"}",\n'
~ '      "title": "Equip Generation",\n'
~ '      "text": "Tinker\'s armor and tools have chance to get random modifier. If this happen, item 100% would have additional $(l)Creative/$ modifier.$(br)All equipment generated already damaged, so no exploits with $(l)mob-stripping farm/$!",\n'
~ '      "type": "spotlight"\n'
~ '    }\n'
~ '  ]\n'
~ '}\n';

print('Save this into file "patchouli_books/e2e_e/en_us/entries/world/equip_generation.json"\n' ~ patchouli);
