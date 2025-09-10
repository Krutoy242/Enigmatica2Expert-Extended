#modloaded thaumcraft randomtweaker
#priority 2000
#reloadable

import thaumcraft.aspect.CTAspectStack;

zenClass CAspect {
  zenConstructor() {}

  // Modded aspects that will be defaulted to vanilla TC's ones if mod is absent
  var caeles as CTAspectStack = <aspect:humanus>;
  var exitium as CTAspectStack = <aspect:perditio>;
  var fluctus as CTAspectStack = <aspect:motus>;
  var imperium as CTAspectStack = <aspect:machina>;
  var infernum as CTAspectStack = <aspect:ignis>;
  var sonus as CTAspectStack = <aspect:alkimia>;
  var ventus as CTAspectStack = <aspect:permutatio>;
  var visum as CTAspectStack = <aspect:auram>;
}

global Aspect as CAspect = CAspect();

global Aspects as function(string)CTAspectStack[] = function(aspects as string) as CTAspectStack[] {
  return scripts.mods.thaumcraft.aspect.toAspects(aspects);
};
