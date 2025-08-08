#modloaded patchouli
#reloadable
#sideonly client
#priority -1000

import mods.zenutils.StaticString.format;

var patchouliFluids as mods.zenutils.StringList = null;
patchouliFluids = mods.zenutils.StringList.empty();

for pos, names in scripts.category.fluids.smelteryFuels {
  for name in names {
    val temp = pos.x as int;
    val time = pos.y as int;
    if (isNull(game.getLiquid(name)) || time == 0) continue;

    patchouliFluids.add(format('%09d', temp * time) + ` ${temp} ${time} ${name}`);
  }
}

// Add default fuel
patchouliFluids.add(format('%09d', 1300 * 80) + ` ${1300} ${80} lava`);

val sorted = patchouliFluids.toArray();
sorted.sort();
sorted.reverse();

var lines = [
  '{',
  '  "name": "Smeltery Fuels",',
  '  "icon": "tconstruct:smeltery_controller",',
  '  "category": "Liquids",',
  '  "pages": [',
  '    {',
  '      "item": "tconstruct:smeltery_controller",',
  '      "text": "$(l)Smeltery/$ melting temperatures was tweaked. '
    + 'Some metals $(l)require/$ better fuels than $(#d31)lava/$.'
    + '$(br)All fuels consume $(l)50/$mb.$(br)$(l)Temperature/$ '
    + 'of fuel affect melting speed.$(br)$(l)Time/$ is number of '
    + 'ticks fuel will burn.",',
  '      "type": "spotlight",',
  '      "title": "Smeltery Fuels"',
];

for i, fuels in sorted {
  if (i % 7 == 0) {
    lines += '    },';
    lines += '    {';
    lines += '      "item": "tconstruct:smeltery_controller",';
    lines += '      "type": "item_list",';
    lines += '      "title": "Smeltery Fuels",';
  }

  val split = fuels.split(' ');
  val temp = split[1] as int;
  val time = split[2] as int;
  val name = split[3];
  lines += '      "item' ~ (i % 7) ~ '": "forge:bucketfilled{FluidName:\\"' ~ name ~ '\\",Amount:1000}",';
  lines += '      "text' ~ (i % 7) ~ '": "' ~ temp ~ '°К, ' ~ time ~ ' ticks"'
    ~ (i % 7 == 6 || i == sorted.length - 1 ? '' : ',');
}
lines += '    }';
lines += '  ]';
lines += '}\n';
print('Save this into file "patchouli_books/e2e_e/en_us/entries/world/smeltery_fuels.json"\n' + mods.zenutils.StaticString.join(lines, '\n'));
