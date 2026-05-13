/*
Amuileria kaerunea (Aquilegia caerulea + Kaminari[thunder]) - crafting with lightning
*/

#modloaded botania
#loader contenttweaker

import mods.contenttweaker.VanillaFactory;

val amuileria_kaerunea = VanillaFactory.createSubTileFunctional('amuileria_kaerunea', 0xFFFF);
amuileria_kaerunea.maxMana = 5000;
amuileria_kaerunea.range = 1;
amuileria_kaerunea.register();
