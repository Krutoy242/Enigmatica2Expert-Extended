#reloadable
#ignoreBracketErrors
#modloaded ctintegration

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
});
scripts.do.build.entity.add(<entity:betteranimalsplus:bobbit_worm>, [['xcc']], {
  x: <contenttweaker:conglomerate_of_life>,
  c: <minecraft:stone_slab:1>,
});

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
