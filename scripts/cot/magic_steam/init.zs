/*

Magical steam processing

Increase density of the steam by "enriching" it
with magical components.

This reduce size of the required turbine and
increase power output.

Author: 825_Jaded_Vector

*/

#loader contenttweaker

import mods.contenttweaker.Color;
import mods.contenttweaker.VanillaFactory;

// catlyst definitions
// Grade 1 (astral)
val NRG1 = VanillaFactory.createItem('naquadah_resevoir_grade_1');
NRG1.maxStackSize = 1;
NRG1.maxDamage = 10000;
NRG1.rarity = 'rare';
NRG1.register();
val NCG1 = VanillaFactory.createItem('naquadah_catalyst_grade_1');
NCG1.register();

// Grade 2 (botanic)
val NRG2 = VanillaFactory.createItem('naquadah_resevoir_grade_2');
NRG2.maxStackSize = 1;
NRG2.maxDamage = 15000;
NRG2.rarity = 'rare';
NRG2.register();
val NCG2 = VanillaFactory.createItem('naquadah_catalyst_grade_2');
NCG2.register();

// Grade 3 (alchemic)
val NRG3 = VanillaFactory.createItem('naquadah_resevoir_grade_3');
NRG3.maxStackSize = 1;
NRG3.maxDamage = 20000;
NRG3.rarity = 'rare';
NRG3.register();
val NCG3 = VanillaFactory.createItem('naquadah_catalyst_grade_3');
NCG3.register();

// Grade 4 (thaumic)
val NRG4 = VanillaFactory.createItem('naquadah_resevoir_grade_4');
NRG4.maxStackSize = 1;
NRG4.maxDamage = 32767;
NRG4.rarity = 'rare';
NRG4.register();
val NCG4 = VanillaFactory.createItem('naquadah_catalyst_grade_4');
NCG4.register();

// Grade5 (ultimate)
val NRG5 = VanillaFactory.createItem('naquadah_resevoir_grade_5');
// NRG5.maxStackSize = 1;
// NRG5.maxDamage = 10000;
NRG5.rarity = 'rare';
NRG5.register();
val NCG5 = VanillaFactory.createItem('naquadah_catalyst_grade_5');
NCG5.register();

// Dense steam definintions

// Grade 1 (astral)
val DS1 = VanillaFactory.createFluid('magic_steam_grade_1', Color.fromHex('7fb3e4'));
DS1.material = <blockmaterial:water>;
DS1.viscosity = 20;
DS1.temperature = 1000;
DS1.density = -200;
DS1.register();

// Grade 2 (botanic)
val DS2 = VanillaFactory.createFluid('magic_steam_grade_2', Color.fromHex('adfcad'));// 7fb3e48a
DS2.material = <blockmaterial:water>;
DS2.viscosity = 20;
DS2.temperature = 1000;
DS2.density = -200;
DS2.register();

// Grade 3 (alchemic)
val DS3 = VanillaFactory.createFluid('magic_steam_grade_3', Color.fromHex('c58686'));
DS3.material = <blockmaterial:water>;
DS3.viscosity = 20;
DS3.temperature = 1000;
DS3.density = -200;
DS3.register();

// Grade 4 (thaumic)
val DS4 = VanillaFactory.createFluid('magic_steam_grade_4', Color.fromHex('ad6ac7'));
DS4.material = <blockmaterial:water>;
DS4.viscosity = 20;
DS4.temperature = 1000;
DS4.density = -200;
DS4.register();

// Grade5 (ultimate)
val DS5 = VanillaFactory.createFluid('magic_steam_grade_5', Color.fromHex('c1c76a'));// adfcad8c
DS5.material = <blockmaterial:water>;
DS5.viscosity = 20;
DS5.temperature = 1000;
DS5.density = -200;
DS5.register();
