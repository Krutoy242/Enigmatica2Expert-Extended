#reloadable
#ignoreBracketErrors
#modloaded zenutils requious

import crafttweaker.item.IItemStack;

function abs(n as double) as double { return n < 0 ? -n : n; }
scripts.do.build.entity.add(<entity:twilightforest:quest_ram>, [
  ['cw  '],
  [' xww'],
  [' w w'],
], {
  c: <twilightforest:cicada>,
  w: <contenttweaker:compressed_string>,
  x: <contenttweaker:conglomerate_of_life>,
}, function(world as crafttweaker.world.IWorld, p as crafttweaker.util.Position3f) as void {
  for pl in world.getAllPlayers() {
    if (abs(pl.x - p.x) > 20 || abs(pl.y - p.y) > 20 || abs(pl.z - p.z) > 20) continue;
    pl.sendPlaySoundPacket('minecraft:entity.sheep.ambient', 'ambient', p, 1, 1);
  }
}).shift(0, 0, 0);

scripts.do.build.entity.add(<entity:twilightforest:castle_guardian>, [
  [
    '     ',
    '  o  ',
    ' oxo ',
    '  o  ',
    '     ',
  ], [
    '     ',
    '     ',
    '  I  ',
    '     ',
    '     ',
  ], [
    '     ',
    ' TrT ',
    ' rIr ',
    ' TrT ',
    '     ',
  ], [
    ' o o ',
    'oTrTo',
    ' rIr ',
    'oTrTo',
    ' o o ',
  ],
], {
  o: <twilightforest:castle_brick>,
  T: <advancedrocketry:metal0:1>,
  r: <thaumcraft:stone_porous>,
  I: <bloodmagic:demon_pillar_2>,
  x: <contenttweaker:conglomerate_of_life>,
}, function(world as crafttweaker.world.IWorld, p as crafttweaker.util.Position3f) as void {
  for entity in world.getEntitiesWithinAABB(crafttweaker.util.IAxisAlignedBB.create(p).grow(1, 3, 1)) {
    if (entity.definition.id != 'twilightforest:castle_guardian') continue;
    val living as crafttweaker.entity.IEntityLivingBase = entity;
    living.addPotionEffect(<potion:mia:growth_potion>.makePotionEffect(50, 10));
    living.addPotionEffect(<potion:potioncore:diamond_skin>.makePotionEffect(30000, 10));
    living.addPotionEffect(<potion:potioncore:iron_skin>.makePotionEffect(30000, 10));
    living.addPotionEffect(<potion:potioncore:magic_shield>.makePotionEffect(30000, 10));
    living.addPotionEffect(<potion:rustic:wither_ward>.makePotionEffect(30000, 10));
    living.addPotionEffect(<potion:minecraft:regeneration>.makePotionEffect(30000, 10));
  }
}).mirrored();

// Add alt mob recipes
scripts.do.build.entity.add(<entity:betteranimalsplus:horseshoecrab>, [['xt']], {
  x: <contenttweaker:conglomerate_of_life>,
  t: <extrautils2:spike_stone>,
}).shift(0, 0.5, 0);
scripts.do.build.entity.add(<entity:betteranimalsplus:bobbit_worm>, [['xcc']], {
  x: <contenttweaker:conglomerate_of_life>,
  c: <minecraft:stone_slab:1>,
}).shift(0, 1, 0);

scripts.do.build.entity.add(<entity:betteranimalsplus:walrus>, [['aax']], {
  a: <additionalcompression:meatfish_compressed>,
  x: <contenttweaker:conglomerate_of_life>
}).shift(0, 1, 0);

// Greater Crimson Portal custom spawning
scripts.do.build.entity.add(<entity:thaumcraft:cultistportalgreater>, [
  [
    '             ',
    '             ',
    '             ',
    '             ',
    '             ',
    '             ',
    '      x      ',
    '             ',
    '             ',
    '             ',
    '             ',
    '             ',
    '             ',
  ], [
    '      f      ',
    '             ',
    '             ',
    '             ',
    '             ',
    '     aaa     ',
    'f    aoa    f',
    '     aaa     ',
    '             ',
    '             ',
    '             ',
    '             ',
    '      f      ',
  ],
], {
  f: <thaumcraft:banner_red>,
  o: <thaumadditions:mithminite_block>,
  a: <thaumicaugmentation:starfield_glass>,
  x: <contenttweaker:conglomerate_of_life>,
}).shift(0, 0, -0.5).mirrored();

scripts.do.build.entity.add(<entity:quark:pirate>, [
  [
    '  a  '
  ], [
    'bcccb'
  ], [
    'bcxcb'
  ], [
    ' ccc '
  ], [
    ' d d '
  ]
], {
  a: <minecraft:bone_block>,
  b: <minecraft:cobblestone_wall>,
  c: <additionalcompression:bone_compressed>,
  d: <minecraft:fence>,
  x: <contenttweaker:conglomerate_of_life>
});

scripts.do.build.entity.add(<entity:emberroot:withercat>, [
  [
    'abx'
  ]
], {
  a: <mekanism:cardboardbox>,
  b: <darkutils:wither_block>,
  x: <contenttweaker:conglomerate_of_life>
}).shift(0, 1, 0);

scripts.do.build.entity.add(<entity:emberroot:enderminy>, [
  [
    'x'
  ], [
    'a'
  ]
], {
  a: <additionalcompression:pearlender_compressed>,
  x: <contenttweaker:conglomerate_of_life>
}).shift(0, 1, 0);

scripts.do.build.entity.add(<entity:quark:crab>, [
  [
    'c   c',
    ' ccc ',
    'ccccc',
    ' ccc ',
    'b a b',
    '  x  '
  ]
], {
  a: <additionalcompression:spidereye_compressed>,
  b: <minecraft:red_sandstone>,
  c: <minecraft:stone_slab2>,
  x: <contenttweaker:conglomerate_of_life>
}).shift(0, 1, 0);

for fakeIronBlock in <ore:blockFakeIron>.items {
  scripts.do.build.entity.add(<entity:emberroot:rainbow_golem>, [
    [
      ' b '
    ], [
      'axa'
    ], [
      ' a '
    ]
  ], {
    a: fakeIronBlock,
    b: <thaumadditions:amber_lamp>,
    x: <contenttweaker:conglomerate_of_life>
  });
}

scripts.do.build.entity.add(<entity:rats:illager_piper>, [
  [
    'x'
  ], [
    'b'
  ], [
    'a'
  ], [
    'a'
  ]
], {
  a: <minecraft:noteblock>,
  b: <rats:jack_o_ratern>,
  x: <contenttweaker:conglomerate_of_life>
});

scripts.do.build.entity.add(<entity:emberroot:hero>, [
  [
    'x'
  ], [
    'b'
  ], [
    'a'
  ], [
    'a'
  ]
], {
  a: <thermalfoundation:rockwool:4>,
  b: <rats:brain_block>,
  x: <contenttweaker:conglomerate_of_life>
});

scripts.do.build.entity.add(<entity:emberroot:knight_fallen>, [
  [
    'x'
  ], [
    'b'
  ], [
    'a'
  ], [
    'a'
  ]
], {
  a: <darkutils:wither_block>,
  b: <rats:brain_block>,
  x: <contenttweaker:conglomerate_of_life>
});

scripts.do.build.entity.add(<entity:iceandfire:dread_lich>, [
  [
    '  a  '
  ], [
    'bcccb'
  ], [
    'bcxcb'
  ], [
    ' ccc '
  ], [
    ' b b '
  ]
], {
  a: <minecraft:bone_block>,
  b: <quark:quartz_wall>,
  c: <appliedenergistics2:sky_stone_block>,
  x: <contenttweaker:conglomerate_of_life>
});

/** This mobs spawns weird. His position on spawn is a bit above ground but then he teleports a few blocks below, setting spawn way higher does not change his final position. Same thing happens when normal spawn egg is used. */
scripts.do.build.entity.add(<entity:iceandfire:stymphalianbird>, [
  [
    ' a ',
    'axa',
    ' b '
  ]
], {
  a: <additionalcompression:feather_compressed>,
  b: <thermalfoundation:storage_alloy:3>,
  x: <contenttweaker:conglomerate_of_life>
}).shift(0, 20, 0);

scripts.do.build.entity.add(<entity:iceandfire:amphithere>, [
  [
    '  a  ',
    '  a  ',
    '  a  ',
    'aaxaa',
    '  b  '
  ]
], {
  a: <additionalcompression:feather_compressed>,
  b: <actuallyadditions:block_crystal:4>,
  x: <contenttweaker:conglomerate_of_life>
}).shift(0, 1, 0);

scripts.do.build.entity.add(<entity:iceandfire:hippocampus>, [
  [
    ' c ',
    ' c ',
    ' x ',
    'aba'
  ]
], {
  a: <quark:prismarine_rough_wall>,
  b: <additionalcompression:meatfish_compressed>,
  c: <minecraft:prismarine>,
  x: <contenttweaker:conglomerate_of_life>
}).shift(0, 1, 0);

for dragonforgeBrick in [<iceandfire:dragonforge_fire_brick>, <iceandfire:dragonforge_ice_brick>] as IItemStack[] {
  scripts.do.build.entity.add(<entity:iceandfire:seaserpent>, [
    [
      'b',
      'b',
      'b',
      'b',
      'x',
      'a'
    ]
  ], {
    a: <rats:rattrap>,
    b: dragonforgeBrick,
    x: <contenttweaker:conglomerate_of_life>
  }).shift(0, 1, 0);
}

scripts.do.build.entity.add(<entity:endreborn:endguard>, [
  [
    'x'
  ], [
    'a'
  ], [
    'a'
  ]
], {
  a: <minecraft:purpur_block>,
  x: <contenttweaker:conglomerate_of_life>
}).shift(0, 1, 0);

scripts.do.build.entity.add(<entity:plustic:supremeleader>, [
  [
    ' x '
  ], [
    ' a '
  ]
], {
  a: <additionalcompression:dustgunpowder_compressed>,
  x: <contenttweaker:conglomerate_of_life>
}).shift(0, 0.5, 0);
