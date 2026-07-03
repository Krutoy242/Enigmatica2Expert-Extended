#priority 10
#modloaded thaumcraft

import native.net.minecraft.util.ResourceLocation;
import native.thaumcraft.api.casters.FocusEngine;
import scripts.mods.thaumcraft.spellCreation.spellApiaryAcceleration.SpellApiaryAcceleration;
import scripts.mods.thaumcraft.spellCreation.spellBlackout.SpellBlackout;
import scripts.mods.thaumcraft.spellCreation.spellBloomia.SpellBloomia;
import scripts.mods.thaumcraft.spellCreation.spellButtercatch.SpellButtercatch;
import scripts.mods.thaumcraft.spellCreation.spellCrossbreed.SpellCrossbreed;
import scripts.mods.thaumcraft.spellCreation.spellCrystalize.SpellCrystalize;
import scripts.mods.thaumcraft.spellCreation.spellEfreetFalme.SpellEfreetFlame;
import scripts.mods.thaumcraft.spellCreation.spellEnderRift.SpellEnderRift;
import scripts.mods.thaumcraft.spellCreation.spellExplosion.SpellExplosion;
import scripts.mods.thaumcraft.spellCreation.spellFeralis.SpellFeralis;
import scripts.mods.thaumcraft.spellCreation.spellVampirysm.SpellVampirysm;

//Do not make fully black color - it fails to render it!
FocusEngine.registerElement(SpellApiaryAcceleration.class,      ResourceLocation("thaumcraft", "textures/foci/apiaryacceleration.png"), 0xFFFFFF10);
FocusEngine.registerElement(SpellBlackout.class,                ResourceLocation("thaumcraft", "textures/foci/blackout.png"),           0xFF101010);
FocusEngine.registerElement(SpellBloomia.class,                 ResourceLocation("thaumcraft", "textures/foci/bloomia.png"),            0xFF8BC763);
FocusEngine.registerElement(SpellButtercatch.class,             ResourceLocation("thaumcraft", "textures/foci/buttercatch.png"),        0xFFC8C8C8);
FocusEngine.registerElement(SpellCrossbreed.class,              ResourceLocation("thaumcraft", "textures/foci/crossbreed.png"),         0xFFDCB250);
FocusEngine.registerElement(SpellCrystalize.class,              ResourceLocation("thaumcraft", "textures/foci/crystalize.png"),         0xFFADD8E6);
FocusEngine.registerElement(SpellEfreetFlame.class,             ResourceLocation("thaumcraft", "textures/foci/efreetflame.png"),        0xFF780000);
FocusEngine.registerElement(SpellEnderRift.class,               ResourceLocation("thaumcraft", "textures/foci/enderrift.png"),          0xFF2B3D3F);
FocusEngine.registerElement(SpellExplosion.class,               ResourceLocation("thaumadditions", "textures/aspects/exitium.png"),     0xFF787878);
FocusEngine.registerElement(SpellFeralis.class,                 ResourceLocation("thaumcraft", "textures/foci/feralis.png"),            0xFFCC8408);
FocusEngine.registerElement(SpellVampirysm.class,               ResourceLocation("thaumcraft", "textures/foci/vampirysm.png"),          0xFF781212);

