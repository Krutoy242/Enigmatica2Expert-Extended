#modloaded advancedrocketry requious
#priority 950
#reloadable
#ignoreBracketErrors

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.randomtweaker.jei.IJeiUtils;

import scripts.jei.requious.add as addRecipe;

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
val x = <assembly:asteroids>;
x.addJEICatalyst(<advancedrocketry:asteroidchip>);
x.setJEIDurationSlot(1, 0, 'duration', scripts.jei.requious.getVisGauge(3, 1));
scripts.jei.requious.addInsOuts(x, [[0, 0]], [[2, 0], [3, 0], [4, 0]]);

function addAsteroid(name as string, values as double[], output as int[IItemStack][]) as void {
  val newOutput = arrayOf(output.length, null as IItemStack);
  for i, tuple in output {
    for item, chance in tuple {
      if(isNull(item)) continue;
      newOutput[i] = item.withLore(['§8Chance: §b' ~ chance]);
    }
  }
  addRecipe(<assembly:asteroids>, { [<advancedrocketry:asteroidchip>.withLore([
    '§8Distance: §b' ~ values[0],
    '§8Mass: §b' ~ values[1],
    '§8Mass variability: §b' ~ values[2],
    '§8Probability: §b' ~ values[3],
    '§8Richness: §b' ~ values[4],
    '§8Richness variability: §b' ~ values[5],
  ]).withDisplayName('§6' + name)] as IIngredient[]:
    newOutput,
  });
}

/* Inject_js(
xml_to_js(loadText('config/advRocketry/asteroidConfig.xml')).elements[0].elements.map(
  (asteroid) => [`addAsteroid('${asteroid.attributes.name}'`, `, [${
      Object.entries(asteroid.attributes)
      .filter(([key]) => key !== 'name')
      .sort(([a],[b])=>a.length-b.length)
      .map(([,val]) => val)
      .join(', ')}]`, `, [${
      asteroid.elements
      .map((item) => `{ <${
        String(item.attributes.itemStack).replace(' ', ':')
      }>: ${item.attributes.chance} }`)
      .join(', ')}]);`]
)) */
addAsteroid('Iridium Enriched'     , [25, 100, 0.8, 3, 1, 0.2], [{ <minecraft:iron_ore>: 25 }, { <thermalfoundation:ore:7>: 25 }]);
addAsteroid('Draconium'            , [64, 75, 0.7, 5, 1, 0.5] , [{ <draconicevolution:draconium_ore>: 100 }, { <advancedrocketry:moonturf>: 25 }, { <advancedrocketry:moonturf_dark>: 25 }]);
addAsteroid('Prosperity'           , [64, 75, 0.7, 5, 1, 0.5] , [{ <mysticalagriculture:prosperity_ore>: 100 }, { <advancedrocketry:moonturf>: 25 }, { <advancedrocketry:moonturf_dark>: 25 }]);
addAsteroid('Dimensional Shard'    , [64, 75, 0.7, 5, 1, 0.5] , [{ <rftools:dimensional_shard_ore>: 100 }, { <advancedrocketry:moonturf>: 25 }, { <advancedrocketry:moonturf_dark>: 25 }]);
addAsteroid('Mana Infused'         , [64, 75, 0.7, 5, 1, 0.5] , [{ <thermalfoundation:ore:8>: 100 }, { <advancedrocketry:moonturf>: 25 }, { <advancedrocketry:moonturf_dark>: 25 }]);
addAsteroid('Destabilized Redstone', [64, 75, 0.7, 5, 1, 0.5] , [{ <thermalfoundation:ore_fluid:2>: 100 }, { <advancedrocketry:moonturf>: 25 }, { <advancedrocketry:moonturf_dark>: 25 }]);
addAsteroid('Energized Netherrack' , [64, 75, 0.7, 5, 1, 0.5] , [{ <thermalfoundation:ore_fluid:3>: 100 }, { <advancedrocketry:moonturf>: 25 }, { <advancedrocketry:moonturf_dark>: 25 }]);
addAsteroid('Resonant End Stone'   , [64, 75, 0.7, 5, 1, 0.5] , [{ <thermalfoundation:ore_fluid:4>: 100 }, { <advancedrocketry:moonturf>: 25 }, { <advancedrocketry:moonturf_dark>: 25 }]);
addAsteroid('Dilithium'            , [64, 75, 0.7, 5, 1, 0.5] , [{ <netherendingores:ore_end_modded_1:14>: 100 }, { <advancedrocketry:moonturf>: 25 }, { <advancedrocketry:moonturf_dark>: 25 }]);
addAsteroid('Titanium'             , [64, 75, 0.7, 5, 1, 0.5] , [{ <libvulpes:ore0:8>: 100 }, { <advancedrocketry:moonturf>: 25 }, { <advancedrocketry:moonturf_dark>: 25 }]);
addAsteroid('Starmetal'            , [64, 75, 0.7, 5, 1, 0.5] , [{ <astralsorcery:blockcustomore:1>: 100 }, { <advancedrocketry:moonturf>: 25 }, { <advancedrocketry:moonturf_dark>: 25 }]);
addAsteroid('Rock Crystal'         , [64, 75, 0.7, 5, 1, 0.5] , [{ <mysticalagriculture:rock_crystal_essence>: 100 }, { <advancedrocketry:moonturf>: 25 }, { <advancedrocketry:moonturf_dark>: 25 }]);
addAsteroid('Steel'                , [64, 75, 0.3, 7, 1, 0.2] , [{ <thermalfoundation:storage_alloy>: 100 }, { <advancedrocketry:moonturf>: 25 }, { <advancedrocketry:moonturf_dark>: 25 }]);
addAsteroid('Moon Turf'            , [64, 50, 0.9, 8, 1, 0.1] , [{ <advancedrocketry:moonturf>: 50 }, { <advancedrocketry:moonturf_dark>: 50 }]);
/**/

// -----------------------------------------------------------------------
val p = mods.jei.JEI.createJei('orbital_laser_drill', "Orbital Laser Drill")
.setBackground(IJeiUtils.createBackground(7*18, 3*18))
.addRecipeCatalyst(<advancedrocketry:spacelaser>)
.setIcon(<advancedrocketry:spacelaser>)
.setModid('advancedrocketry');
for y in 0 .. 3 {
  for x in 0 .. 7 {
    p.addSlot(IJeiUtils.createItemSlot('output', x*18, y*18, false, false));
  }
}
p.register();

mods.jei.JEI.createJeiRecipe("orbital_laser_drill").setOutputs([
/* Inject_js(
config('config/advRocketry/advancedRocketry.cfg')
['world and ore generation'].laserDrillOres
.map(l=>`  <ore:${l}>,`)
) */
  <ore:oreClathrateEnder>,
  <ore:oreClathrateGlowstone>,
  <ore:oreClathrateRedstone>,
  <ore:oreDraconium>,
  <ore:oreProsperity>,
  <ore:oreAstralStarmetal>,
  <ore:oreDilithium>,
  <ore:oreIridium>,
  <ore:oreMithril>,
  <ore:orePlatinum>,
  <ore:oreTitanium>,
/**/
]).build();
