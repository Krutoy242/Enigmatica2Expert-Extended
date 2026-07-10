#modloaded thaumcraft
#priority 1000

import native.net.minecraft.world.World;
import native.thaumcraft.api.casters.FocusEffect;

/*
  Server-safe bridge for Thaumcraft spell particle rendering.

  Each spell's renderParticleFX builds a client-only FXGeneric and calls
  ParticleEngine.addEffectWithDelay(World, Particle, int). Both reference
  net.minecraft.client.particle.Particle, which is stripped from a dedicated
  server jar. ZenUtils resolves native-method parameter types while compiling
  the call, so the class is loaded eagerly at parse time and the server crashes
  with NoClassDefFoundError before the code ever runs (a runtime isRemote check
  cannot help).

  So the FX code lives in spellFX_client.zs (#sideonly client) and each spell
  only calls the matching pointer below. On the server these stay null and the
  spell's renderParticleFX is a no-op; nothing client-only is ever parsed.
*/
zenClass SpellFX {
  static apiaryAcceleration as function(FocusEffect,World,double,double,double,double,double,double)void;
  static blackout           as function(FocusEffect,World,double,double,double,double,double,double)void;
  static bloomia            as function(FocusEffect,World,double,double,double,double,double,double)void;
  static buttercatch        as function(FocusEffect,World,double,double,double,double,double,double)void;
  static chronostasis       as function(FocusEffect,World,double,double,double,double,double,double)void;
  static crossbreed         as function(FocusEffect,World,double,double,double,double,double,double)void;
  static crystalize         as function(FocusEffect,World,double,double,double,double,double,double)void;
  static efreetFlame        as function(FocusEffect,World,double,double,double,double,double,double)void;
  static enderRift          as function(FocusEffect,World,double,double,double,double,double,double)void;
  static explosion          as function(FocusEffect,World,double,double,double,double,double,double)void;
  static feralis            as function(FocusEffect,World,double,double,double,double,double,double)void;
  static vampirysm          as function(FocusEffect,World,double,double,double,double,double,double)void;
}
