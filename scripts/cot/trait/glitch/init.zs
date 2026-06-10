/*

CoT material + trait definitions (glitch_power, glitch_flight, glitch_drop)

*/
#loader contenttweaker
#modloaded tconstruct conarm deepmoblearning

import mods.contenttweaker.conarm.ArmorTraitBuilder;
import mods.contenttweaker.conarm.ExtendedMaterialBuilder;
import mods.contenttweaker.tconstruct.TraitBuilder;
import native.mustapelto.deepmoblearning.common.DMLConfig;
import crafttweaker.entity.IEntityEquipmentSlot;
import native.net.minecraft.item.ItemStack;
import native.slimeknights.tconstruct.library.utils.TinkerUtil;

val glitch_flight = ArmorTraitBuilder.create('glitch_flight');
glitch_flight.color = 0x16B77B;
glitch_flight.localizedName = game.localize('e2ee.tconstruct.trait.glitch_flight.name');
glitch_flight.localizedDescription = game.localize('e2ee.tconstruct.trait.glitch_flight.description');
glitch_flight.onArmorTick = function (trait, armorItem, world, player) {
  if (!DMLConfig.GLITCH_ARMOR_SETTINGS.GLITCH_CREATIVE_FLIGHT_ENABLED as bool) return;

  var count = 0;
  val slots = [head, chest, legs, feet] as IEntityEquipmentSlot[];

  for slot in slots {
    val armor = player.getItemInSlot(slot);
    if (isNull(armor)) continue;
    val nativeTag = (armor.native as ItemStack).getTagCompound();
    if (!isNull(nativeTag) && TinkerUtil.hasTrait(nativeTag, 'glitch_flight_armor')) {
      count += 1;
    }
  }

  if (count == 4) {
    if (!player.native.capabilities.allowFlying) {
      player.native.capabilities.allowFlying = true;
      player.native.sendPlayerAbilities();
    }
  }
  else {
    if (!player.creative && player.native.capabilities.allowFlying) {
      player.native.capabilities.allowFlying = false;
      player.native.capabilities.isFlying = false;
      player.native.sendPlayerAbilities();
    }
  }
};
glitch_flight.onArmorRemove = function (trait, armorItem, player, slotIndex) {
  if (!player.creative && player.native.capabilities.allowFlying) {
    player.native.capabilities.allowFlying = false;
    player.native.capabilities.isFlying = false;
    player.native.sendPlayerAbilities();
  }
};
glitch_flight.register();

val glitch_drop = ArmorTraitBuilder.create('glitch_drop');
glitch_drop.color = 0x16B77B;
glitch_drop.localizedName = game.localize('e2ee.tconstruct.trait.glitch_drop.name');
glitch_drop.localizedDescription = game.localize('e2ee.tconstruct.trait.glitch_drop.description');
glitch_drop.register();

val glitch_power = TraitBuilder.create('glitch_power');
glitch_power.color = 0x16B77B;
glitch_power.localizedName = game.localize('e2ee.tconstruct.trait.glitch_power.name');
glitch_power.localizedDescription = game.localize('e2ee.tconstruct.trait.glitch_power.description');
glitch_power.calcDamage = function (trait, tool, attacker, target, originalDamage, newDamage, isCritical) {
  if (originalDamage <= 0) return originalDamage;
  val tag = (tool.native as ItemStack).getTagCompound();
  if (isNull(tag)) return newDamage;
  val permDamage = tag.getInteger('permDamage');
  if (permDamage <= 0) return newDamage;
  return newDamage + permDamage as float;
};

glitch_power.extraInfo = function (thisTrait, item, tag) {
  var result = [] as string[];
  if (!isNull(item.tag) && !isNull(item.tag.permDamage)) {
    val current = item.tag.permDamage.asInt();
    result += '§b+' ~ current ~ ' §rPermanent Damage (Max 18)';
  }
  else {
    result += '§b+0 §rPermanent Damage (Max 18)';
  }
  return result;
};
glitch_power.register();

val glitch = ExtendedMaterialBuilder.create('glitch');
glitch.color = 0x16B77B;
glitch.craftable = false;
glitch.castable = true;
glitch.liquid = <liquid:glitch>;
glitch.representativeItem = <item:deepmoblearning:glitch_infused_ingot>;
glitch.addItem(<item:deepmoblearning:glitch_infused_ingot>);
glitch.localizedName = game.localize('e2ee.tconstruct.material.glitch.name');

glitch.addCoreMaterialStats(25.0, 15.0);
glitch.addPlatesMaterialStats(1.2, 12.0, 3.0);
glitch.addTrimMaterialStats(10.0);
glitch.addHeadMaterialStats(2200, 8.0, 9.0, 3);
glitch.addHandleMaterialStats(1.2, 100);
glitch.addExtraMaterialStats(150);
glitch.addBowMaterialStats(1.5, 1.5, 5.0);

glitch.addMaterialTrait(<conarmtrait:glitch_flight>, 'core');
glitch.addMaterialTrait(<conarmtrait:glitch_drop>, 'plates');
glitch.addMaterialTrait(<conarmtrait:glitch_drop>, 'trim');
glitch.addMaterialTrait('glitch_power', 'head');
glitch.addMaterialTrait('glitch_power', 'handle');
glitch.addMaterialTrait('glitch_power', 'extra');
glitch.register();
