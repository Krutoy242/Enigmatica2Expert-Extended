#loader contenttweaker
#modloaded tconstruct

import mods.contenttweaker.conarm.ArmorTraitBuilder;

val faraday = ArmorTraitBuilder.create('faraday');
faraday.color = 0x0073B2; // #0073B2
faraday.localizedName = game.localize('e2ee.tconstruct.trait.faraday.name');
faraday.localizedDescription = game.localize('e2ee.tconstruct.trait.faraday.description');
faraday.onHurt = function (trait, armor, player, source, damage, newDamage, evt) {
  if (
    source.damageType == 'ieWireShock' // Immersive Engineering
    || source.damageType == 'electricity' // IC2
  ) {
    evt.cancel();
  }
  return newDamage;
};
faraday.register();
