/*

Magical steam processing

Increase density of the steam by "enriching" it
with magical components.

This reduce size of the required turbine and
increase power output.

Author: 825_Jaded_Vector

*/

#loader contenttweaker
#modloaded astralsorcery botania thaumcraft immersiveengineering nuclearcraft

import mods.contenttweaker.VanillaFactory;

import scripts.cot.init.buildItem;

function buildReservoir(id as string, maxDamage as int) as void {
  val item = VanillaFactory.createItem(id);
  if (maxDamage > 0) item.maxDamage = maxDamage;
  item.maxStackSize = 1;
  item.rarity = 'rare';
  item.register();
}

// catalyst definitions
// Grade 1 (astral)
buildReservoir('naquadah_resevoir_grade_1', 10000);
buildItem('naquadah_catalyst_grade_1');

// Grade 2 (botanic)
buildReservoir('naquadah_resevoir_grade_2', 15000);
buildItem('naquadah_catalyst_grade_2');

// Grade 3 (alchemic)
buildReservoir('naquadah_resevoir_grade_3', 20000);
buildItem('naquadah_catalyst_grade_3');

// Grade 4 (thaumic)
buildReservoir('naquadah_resevoir_grade_4', 32000);
buildItem('naquadah_catalyst_grade_4');

// Grade5 (ultimate)
buildReservoir('naquadah_resevoir_grade_5', -1);
buildItem('naquadah_catalyst_grade_5');

// Dense steam definintions

// Grade 1 (astral)
val DS1 = VanillaFactory.createFluid('magic_steam_grade_1', 0xFF7FB3E4);
DS1.material = <blockmaterial:water>;
DS1.viscosity = 20;
DS1.temperature = 1000;
DS1.density = -200;
DS1.register();

// Grade 2 (botanic)
val DS2 = VanillaFactory.createFluid('magic_steam_grade_2', 0xFFADFCAD); 
DS2.material = <blockmaterial:water>;
DS2.viscosity = 20;
DS2.temperature = 1000;
DS2.density = -200;
DS2.register();

// Grade 3 (alchemic)
val DS3 = VanillaFactory.createFluid('magic_steam_grade_3', 0xFFC58686);
DS3.material = <blockmaterial:water>;
DS3.viscosity = 20;
DS3.temperature = 1000;
DS3.density = -200;
DS3.register();

// Grade 4 (thaumic)
val DS4 = VanillaFactory.createFluid('magic_steam_grade_4', 0xFFAD6AC7);
DS4.material = <blockmaterial:water>;
DS4.viscosity = 20;
DS4.temperature = 1000;
DS4.density = -200;
DS4.register();

// Grade5 (ultimate)
val DS5 = VanillaFactory.createFluid('magic_steam_grade_5', 0xFFC1C76A); 
DS5.material = <blockmaterial:water>;
DS5.viscosity = 20;
DS5.temperature = 1000;
DS5.density = -200;
DS5.register();
