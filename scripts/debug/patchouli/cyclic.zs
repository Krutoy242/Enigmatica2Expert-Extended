#modloaded patchouli cyclicmagic
#reloadable
#sideonly client
#priority -1000

var lines = [
  '{',
  '  "name": "Magic Bean",',
  '  "icon": "cyclicmagic:sprout_seed",',
  '  "category": "Items",',
  '  "pages": [',
  '    {',
  '      "title": "Magic Bean Drops",',
  '      "type": "grid",',
] as [string];

val config = native.com.lothrazar.cyclicmagic.registry.ConfigRegistry.config as native.net.minecraftforge.common.config.Configuration;
val prop = config.get("cyclicmagic.blocks.magicbean", "MagicBeanDropList", [] as string[]);
val list = prop.stringList as string[];

for i, itemStr in list {
  if (i != 0 && i % 42 == 0) lines += '    },\n    {' 
    ~ '\n      "title": "Magic Bean Drops",'
    ~ '\n      "type": "grid",';
  
  lines += '      "item' ~ (i % 42) ~ '": "'
    ~ itemStr.replace('*', ':') ~ '"'
    ~ (i % 42 == 41 || i == list.length - 1 ? '' : ',');
}
lines += '    }\n  ]\n}\n';
print('Save this into file "patchouli_books/e2e_e/en_us/entries/world/magic_bean.json"\n'
  + mods.zenutils.StaticString.join(lines as string[], '\n'));
  