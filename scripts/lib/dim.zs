#loader mixin
#priority 3000

zenClass Dim {
  var id   as int;
  var name as string;
  var tags as string[];

  zenConstructor(_id as int, _name as string, _tags as string[]) {
    id = _id;
    name = _name;
    tags = _tags ?? [] as string[];
  }

  function hasTag(tag as string) as bool {
    for t in tags {
      if (t == tag) return true;
    }
    return false;
  }
}

zenClass Op {
  static allDims as Dim[int] = {} as Dim[int];
  static tagsMap as [int][string] = {} as [int][string];
}

function add(id as int, name as string, tags as string[] = null) as void {
  val dim = Dim(id, name, tags);
  Op.allDims[id] = dim;

  for t in dim.tags {
    if (isNull(Op.tagsMap[t])) {
      Op.tagsMap[t] = [id] as [int];
    }
    else {
      Op.tagsMap[t].add(id);
    }
  }
}

function get(name as string) as int {
  val lowerName = name.toLowerCase();
  for id, dim in Op.allDims {
    if (dim.name.toLowerCase() == lowerName) return id as int;
  }
  for id, dim in Op.allDims {
    if (dim.name.toLowerCase().contains(lowerName)) return id as int;
  }
  return 0;
}

// 🟢 Home
add(0, 'Overworld', ['ORGANIC', 'MAGIC']);
add(1, 'The End', ['ORGANIC', 'MAGIC']);
add(-1, 'Nether', ['ORGANIC', 'MAGIC']);

// 🚀 The vast vacuum between stars.
// Host to space stations.
add(-2, 'Space');

// 💠 Internal digital space of Applied Energistics 2.
add(2, 'Storage Cell');

// ☁️ A small island floating in the endless sky.
add(3, 'Skyblock');

// 🌲 Rich in Flux Goo and Primal Metals.
add(7, 'Twilight Forest', ['MAGIC', 'ORGANIC']);

// 🧀 Land of the rats.
// Filled with cheese and rat-related wonders.
add(-8, 'Ratlantis', ['MAGIC', 'ORGANIC']);

// ⬛ Unbreakable dimension of pure bedrock.
// Accessed via Thaumic Tinkerer's secrets.
add(19, 'Bedrock World', ['MAGIC']);

// 🌕 Earth's moon. Airless and cratered.
// Primary source of Helium-3.
add(100, 'Luna');

// ☀️ Scorched planet closest to the Sun.
// Rich in Aluminium, Tin, and Liquid Mica.
add(101, 'Mercury');

// ☁️ Greenhouse planet with volcanic islands.
// Abundant Steam, Pyrotheum, and Gold.
add(102, 'Venus');

// 🔴 The red planet with giant impact holes.
// Source of Iron, Draconium, and native Oxygen.
add(103, 'Mars');

// 🌋 Volcanic moon of Jupiter with bedrock spires.
// Rich in EnderIO alloys like Soularium and Dark Steel.
add(105, 'Io');

// ❄️ Icy moon of Jupiter with a frozen ocean.
// High pressure aquifers and native Hydrogen gas.
add(106, 'Europa');

// ☢️ Radioactive moon of Saturn.
// Rich in NuclearCraft fuels, Magnesium, and Thorium.
add(108, 'Titan');

// 💎 Icy gas giant with extreme mountain ranges.
// Rich in Nickel and Liquid Cryotheum.
add(109, 'Uranus');

// 🧊 Distant blue gas giant with hard ice biomes.
// Source of Superium and Lapis Lazuli.
add(110, 'Neptune');

// 💎 Cold planet with huge hollow crystal spheres.
// Rich in Charged Quartz, Emeralds, and Terrestrial Artifacts.
add(111, 'Proxima B', ['MAGIC']);

// 🔵 Organic planet with huge blue mountains.
// Rich in Plutonium, Cobalt, and shiny blue flowers.
add(112, 'Terra Nova', ['MAGIC', 'ORGANIC']);

// ✨ Magical planet with sacred springs.
// Source of Raw Will and concentrated Flux Goo.
add(114, 'Stella', ['MAGIC', 'ORGANIC']);

// 🔥 Hot gas giant with a levitating atmosphere.
// Rich in Vapor of Levity and corrosive acids.
add(117, 'KELT-1b');

// ♨️ Triple star system planet with hot spring water.
// Frozen surface with subterranean heat.
add(120, 'KELT-4ab');

// 🌳 Alien forest planet with bioluminescent life.
// Rich in Protein, Resonant Ender, and Liquid DNA.
add(121, 'KELT-6a', ['MAGIC', 'ORGANIC']);

// 🌋 Volcanic planet with black marble and basalt.
// Rich in Rutile, Ruby, and High Pressure Magma.
add(122, 'Kepler 0118');

// ☄️ Arid planet with giant geodes and glowshrooms.
// Rich in Redstone, Amethyst, and native Oxygen.
add(123, 'Kepler 0119');

// 🌠 High-gravity region of floating debris.
// Rich in Avaritia resources and vitrified sand.
add(124, 'Asteroid Belt');

// 洞 Subterranean world of endless caverns.
// Primitive and organic environment.
add(125, 'Caveland');

// 📦 Miniature world inside a machine block.
add(144, 'Compact Machines');

// 🎋 Dense unrealistic planet
// Generated only with OTG
add(200, 'Alien Jungle');

// ☣️ Post-nuclear wasteland.
add(4598, 'nc_wasteland');

// 🌑 Abyssal dimension.
add(-11325, 'Deep Dark', ['MAGIC', 'ORGANIC']);

// 🌫️ Thaumic Augmentation boss fight dim.
// Full of Flux Goo.
add(14676, 'Emptiness', ['MAGIC', 'ORGANIC']);

// 👻 Ghostly dimension.
// First source of natural Vis crystals for skyblock.
add(-343800852, 'Spectre', ['MAGIC']);

var existingTags = [] as [string];
for t, ids in Op.tagsMap {
  existingTags += t;
}

for t in existingTags {
  val noTag = 'NO_' ~ t;
  var noIds = [] as [int];
  for id, dim in Op.allDims {
    if (!(dim.tags has t)) {
      noIds += id;
    }
  }
  Op.tagsMap[noTag] = noIds;
}

print('Loaded Dimensions: ' ~ Op.allDims.length);
print('Dimension Tags:');
for t, ids in Op.tagsMap {
  var idsStr = '';
  for id in ids {
    if (idsStr != '') idsStr += ', ';
    idsStr += id;
  }
  print('- ' ~ t ~ ': [' ~ idsStr ~ ']');
}
