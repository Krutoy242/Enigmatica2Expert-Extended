#modloaded exnihilocreatio fluidintetweaker
#reloadable
#norun

import mods.fluidintetweaker.FBTweaker;

FBTweaker.addJEIRecipeWrapper(
  <liquid:witchwater>, 2,
  FBTweaker.outputBuilder()
    .addEvent(
      FBTweaker.eventBuilder()
        .createEntityConversionEvent("minecraft:zombie", "minecraft:pig")
        .done())
    .done());
