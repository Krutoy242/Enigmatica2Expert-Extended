#modloaded advancedrocketry requious
#priority 950
#reloadable
#ignoreBracketErrors

import mods.randomtweaker.jei.IJeiUtils;

// -----------------------------------------------------------------------
val p = mods.jei.JEI.createJei('orbital_laser_drill', 'Orbital Laser Drill')
  .setBackground(IJeiUtils.createBackground(7 * 18, 3 * 18))
  .addRecipeCatalyst(<advancedrocketry:spacelaser>)
  .setIcon(<advancedrocketry:spacelaser>)
  .setModid('advancedrocketry');
for y in 0 .. 3 {
  for x in 0 .. 7 {
    p.addSlot(IJeiUtils.createItemSlot('output', x * 18, y * 18, false, false));
  }
}
p.register();

mods.jei.JEI.createJeiRecipe('orbital_laser_drill').setOutputs([
/* Inject_js(
config('config/advRocketry/advancedRocketry.cfg')
['world and ore generation'].laserDrillOres
.map(l=>`  <ore:${l}>,`)
) */
  <ore:oreClathrateGlowstone>,
  <ore:oreDraconium>,
  <ore:oreAstralStarmetal>,
  <ore:oreDilithium>,
  <ore:oreIridium>,
  <ore:oreMithril>,
  <ore:orePlatinum>,
  <ore:oreTitanium>,
/**/
]).build();
