#modloaded patchouli ic2
#loader ic2_postinit reloadable
#sideonly client
#priority -1000

import mods.zenutils.StaticString.format;

var lines = [
  '{',
  '  "name": "UU",',
  '  "icon": "ic2:misc_resource:3",',
  '  "category": "World",',
  '  "pages": [',
  '    {',
] as [string];

var list = [] as [string];
val it = native.ic2.core.uu.UuGraph.iterator();
while (it.hasNext()) {
  val entry = it.next() as native.java.util.Map.Entry;
  val item = (entry.key as native.net.minecraft.item.ItemStack).wrapper;
  val cost = toString(entry.value) as double as int;
  list += format('%010d', cost)
    ~ ' ' ~ item.definition.id ~ (item.damage == 0 ? '' : ':' ~ item.damage);
}

for i, uuTuple in list.sort() {
  if (i % 42 == 0) {
    if (i != 0) {
      lines += '    },';
      lines += '    {';
    }
    lines += '      "title": "Sorted Replicables",';
    lines += '      "type": "grid",';
  }

  val id = uuTuple.split(' ')[1];
  lines += '      "item' ~ (i % 42) ~ '": "' ~ id ~ '"'
    ~ (i % 42 == 41 || i == list.length - 1 ? '' : ',');
}
lines += '    }';
lines += '  ]';
lines += '}\n';
print('Save this into file "patchouli_books/e2e_e/en_us/entries/world/uu.json"\n'
  + mods.zenutils.StaticString.join(lines as string[], '\n'));
