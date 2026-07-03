#priority 10
#modloaded thaumcraft

import native.net.minecraft.util.ResourceLocation;
import native.thaumcraft.api.casters.FocusEngine;
import scripts.mods.thaumcraft.spellCreation.spellApiaryAcceleration.SpellApiaryAcceleration;

//Do not make fully black color - it fails to render it!
FocusEngine.registerElement(SpellApiaryAcceleration.class,      ResourceLocation("thaumcraft", "textures/foci/apiaryacceleration.png"), 0xFFFFFF10);

