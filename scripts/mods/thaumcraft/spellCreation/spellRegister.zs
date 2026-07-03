#priority 10
#modloaded thaumcraft

import native.net.minecraft.util.ResourceLocation;
import native.thaumcraft.api.casters.FocusEngine;
import scripts.mods.thaumcraft.spellCreation.spellApiaryAcceleration.SpellApiaryAcceleration;
import scripts.mods.thaumcraft.spellCreation.spellBlackout.SpellBlackout;
import scripts.mods.thaumcraft.spellCreation.spellBloomia.SpellBloomia;

//Do not make fully black color - it fails to render it!
FocusEngine.registerElement(SpellApiaryAcceleration.class,      ResourceLocation("thaumcraft", "textures/foci/apiaryacceleration.png"), 0xFFFFFF10);
FocusEngine.registerElement(SpellBlackout.class,                ResourceLocation("thaumcraft", "textures/foci/blackout.png"),           0xFF101010);
FocusEngine.registerElement(SpellBloomia.class,                 ResourceLocation("thaumcraft", "textures/foci/bloomia.png"),            0xFF8BC763);

