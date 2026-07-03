#priority 10
#modloaded thaumcraft

import native.net.minecraft.util.ResourceLocation;
import native.thaumcraft.api.casters.FocusEngine;
import scripts.mods.thaumcraft.spellCreation.spellApiaryAcceleration.SpellApiaryAcceleration;
import scripts.mods.thaumcraft.spellCreation.spellBlackout.SpellBlackout;
import scripts.mods.thaumcraft.spellCreation.spellBloomia.SpellBloomia;
import scripts.mods.thaumcraft.spellCreation.spellButtercatch.SpellButtercatch;
import scripts.mods.thaumcraft.spellCreation.spellCrossbreed.SpellCrossbreed;

//Do not make fully black color - it fails to render it!
FocusEngine.registerElement(SpellApiaryAcceleration.class,      ResourceLocation("thaumcraft", "textures/foci/apiaryacceleration.png"), 0xFFFFFF10);
FocusEngine.registerElement(SpellBlackout.class,                ResourceLocation("thaumcraft", "textures/foci/blackout.png"),           0xFF101010);
FocusEngine.registerElement(SpellBloomia.class,                 ResourceLocation("thaumcraft", "textures/foci/bloomia.png"),            0xFF8BC763);
FocusEngine.registerElement(SpellButtercatch.class,             ResourceLocation("thaumcraft", "textures/foci/buttercatch.png"),        0xFFC8C8C8);
FocusEngine.registerElement(SpellCrossbreed.class,              ResourceLocation("thaumcraft", "textures/foci/crossbreed.png"),         0xFFDCB250);

