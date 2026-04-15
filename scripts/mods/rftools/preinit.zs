#modloaded rftools
#loader preinit

import native.net.minecraft.util.ResourceLocation;

for itemId, value in {
  'iceandfire:dragonegg_red': 100.0f,
  'iceandfire:dragonegg_green': 100.0f,
  'iceandfire:dragonegg_bronze': 100.0f,
  'iceandfire:dragonegg_gray': 100.0f,
  'iceandfire:dragonegg_blue': 100.0f,
  'iceandfire:dragonegg_white': 100.0f,
  'iceandfire:dragonegg_sapphire': 100.0f,
  'iceandfire:dragonegg_silver': 100.0f,
  'iceandfire:fire_dragon_flesh': 4.0f,
  'iceandfire:ice_dragon_flesh': 4.0f,
  'iceandfire:fire_dragon_heart': 50.0f,
  'iceandfire:ice_dragon_heart': 50.0f,
  'iceandfire:hippogryph_egg': 20.0f,
  'iceandfire:hippogryph_egg': 20.0f,
  'iceandfire:iceandfire.deathworm_egg': 20.0f,
  'iceandfire:myrmex_desert_egg': 20.0f,
  'iceandfire:myrmex_jungle_egg': 20.0f,
  'iceandfire:fire_lily': 25.0f,
  'iceandfire:frost_lily': 25.0f,
  'twilightforest:raw_meef': 1.6f,
  'twilightforest:firefly': 15.0f,
  'twilightforest:cicada': 15.0f,
  'twilightforest:moonworm': 3.0f,
  'rats:raw_rat': 1.0f,
  'rats:little_black_worm': 200.0f,
  'rats:centipede': 230.0f,
  'rats:ratglove_petals': 3.9f,
  'rats:ratglove_flower': 1.1f,
  'scalinghealth:heartcontainer': 500.0f,
} as float[string] {
  val rl = ResourceLocation(itemId);
  native.mcjty.rftools.blocks.spawner.SpawnerConfiguration.livingMatter[rl] = value;
}
