#modloaded patchouli appliedenergistics2
#reloadable
#sideonly client
#priority -1000

var lines = [
  '{',
  '  "name": "Matter Cannon",',
  '  "icon": "appliedenergistics2:matter_cannon",',
  '  "category": "World",',
  '  "pages": [',
  '    {',
  '      "title": "Matter Cannon Ammo",',
  '      "text": "This items can be used as ammo for $(l)Matter Cannon/$.$(br)Number represent $(l)Atomic_Mass / 10/$, not actual damage!",',
  '      "type": "text"',
  '    },',
  '    {',
  '      "title": "Matter Cannon Ammo",',
  '      "type": "grid",',
] as [string];

val itemMass = scripts.mods.appliedenergistics2.itemMass;

var length = 0;
for a, b in itemMass { length += 1; }

var i = 0;
for item, mass in itemMass {
  lines += '      "item' ~ i ~ '": "'
    ~ item.definition.id ~ (item.damage == 0 ? '' : ':' ~ item.damage)
    ~ '#' ~ mass as int ~ '"' ~ (i == length - 1 ? '' : ',');
  i += 1;
}
lines += '    }\n  ]\n}\n';
print('Save this into file "patchouli_books/e2e_e/en_us/entries/world/matter_cannon.json"\n'
  + mods.zenutils.StaticString.join(lines as string[], '\n'));
