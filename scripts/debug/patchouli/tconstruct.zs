#modloaded patchouli tconstruct
#reloadable
#sideonly client
#priority -1000

import crafttweaker.data.IData;

val patchouli = {
  name    : 'Equip Generation',
  icon    : 'draconicevolution:mob_soul{EntityName:"minecraft:zombie"}',
  category: 'Mobs',
  pages   : [
    {
      item : 'draconicevolution:mob_soul{EntityName:"minecraft:zombie"}',
      title: 'Equip Generation',
      text : `All mobs are generated with:`
      ~ `$(br)$(li)Random TCon armor + weapon`
      ~ `$(br)$(li)Random classic armor set + weapon$(br2)Chance that mob will have at least 1 equipment is`
      ~ `$(br)$(li)${scripts.equipment.equipGeneration.DEFAULT_EQUIP_CHANCE * 100}% base chance`
      ~ `$(br)$(li)${100 - scripts.equipment.equipGeneration.OVERWORLD_EQUIP_CHANCE * 100}% less in $(l)Overworld/<
      ~ >$(br)$(li)${scripts.equipment.equipGeneration.NEXT_EQUIP_CHANCE * 100}% added to reroll for each next slot`,
      type: 'spotlight',
    },
    {
      item : 'draconicevolution:mob_soul{EntityName:"minecraft:skeleton"}',
      title: 'Equip Generation',
      text : 'Different mobs have different armor types and different TCon materials.'
        + '$(br)$(l)Zombies/$ have static chance to spawn with any avaliable material.$(br2)Roll used $(l)qubic/$ function, so $(l)Paper/$ would spawn $(l)~20%/$ times and $(l)Gelid Metal/$ $(l)~0.3%/$ times.',
      type: 'spotlight',
    },
    {
      item : 'draconicevolution:mob_soul{EntityName:"minecraft:zombie_pigman"}',
      title: 'Equip Generation',
      text : `Mobs will never spawn with this TCon materials:`
      ~ `$(br)$(li)${mods.zenutils.StaticString.join(scripts.equipment.equipGeneration.blacklistedMaterials, '$(br)$(li)')}`,
      type: 'spotlight',
    },
    {
      item : 'draconicevolution:mob_soul{EntityName:"minecraft:wither_skeleton"}',
      title: 'Equip Generation',
      text : "Tinker's armor and tools have chance to get random modifier. If this happen, item 100% would have additional $(l)Creative/$ modifier."
        + '$(br)All equipment generated already damaged, so no exploits with $(l)mob-stripping farm/$!',
      type: 'spotlight',
    },
  ],
} as IData;

print(`Save this into file `
  ~ `"patchouli_books/e2e_e/en_us/entries/world/equip_generation.json"\n`
  ~ patchouli.toJson()
);
