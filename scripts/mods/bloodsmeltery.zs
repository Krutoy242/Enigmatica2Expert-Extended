#modloaded bloodsmeltery

// Slate alt creation
mods.tconstruct.Alloy.addRecipe(<liquid:rune> * 250, [<liquid:lifeessence> * 1000, <liquid:livingrock> * 144]);
mods.tconstruct.Casting.addBasinRecipe(<bloodmagic:blood_rune>, null, <liquid:rune>, 1000);

// Fix slates dupe
mods.tconstruct.Melting.removeRecipe(<fluid:rune>, <bloodmagic:blood_rune>);

// Remove from Crucible since it cant handle NBT tags propertly
for i in 0 .. 5 {
  mods.thermalexpansion.Crucible.removeRecipe(<bloodmagic:monster_soul>.definition.makeStack(i).withTag({ souls: 1.0 as float }));

  // For some reason, this recipes cannot be found despite being exact.
  // for will in [
  //   'vengeful',
  //   'corrosive',
  //   'steadfast',
  //   'raw',
  //   'destructive',
  // ] as string[] {
  //   mods.thermalexpansion.Crucible.removeRecipe(<bloodmagic:soul_gem>.definition.makeStack(i).withTag({souls: 1.0, demonWillType: will}));
  // }
}

// Alt easier automatable recipe
mods.thermalexpansion.Transposer.addFillRecipe(<tconevo:metal:30>, <tconevo:material>, <fluid:raw_will> * 1000, 2000);
