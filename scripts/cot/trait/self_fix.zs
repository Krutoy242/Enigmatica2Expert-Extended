#loader contenttweaker
#modloaded tconstruct conarm

import mods.contenttweaker.conarm.ArmorTraitBuilder;
import mods.contenttweaker.tconstruct.TraitBuilder;

/*
 * `self_fix` only REGISTERS the trait here so tools/armor can carry it (granted by the
 * material). The auto-repair behaviour lives in a universal mixin instead of a trait
 * callback — scripts/mixin/selffix/ injects into ToolHelper.damageTool /
 * ArmorHelper.damageArmor, the single choke points every durability loss passes through
 * (mining, mattock tilling, Tasty-eat, abilities, combat). A trait's own onToolDamage
 * never sees the right-click abilities or vanilla-routed losses, so it cannot cover them.
 */

val self_fix = TraitBuilder.create('self_fix');
self_fix.color = 0x888888;
self_fix.localizedName = game.localize('e2ee.tconstruct.trait.self_fix.name');
self_fix.localizedDescription = game.localize('e2ee.tconstruct.trait.self_fix.description');
self_fix.register();

val self_fix_armor = ArmorTraitBuilder.create('self_fix');
self_fix_armor.color = 0x888888;
self_fix_armor.localizedName = game.localize('e2ee.tconstruct.trait.self_fix.name');
self_fix_armor.localizedDescription = game.localize('e2ee.tconstruct.trait.self_fix.description');
self_fix_armor.register();
