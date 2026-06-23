#modloaded tconstruct conarm
#priority 3999
#reloadable

import crafttweaker.command.ICommandSender;

import native.slimeknights.tconstruct.library.TinkerRegistry;
import native.slimeknights.tconstruct.library.modifiers.IModifier;
import native.slimeknights.tconstruct.library.traits.ITrait;
import native.slimeknights.tconstruct.library.materials.Material;
import native.c4.conarm.lib.ArmoryRegistry;

val cmd = mods.zenutils.command.ZenCommand.create('dump_tcon');
cmd.requiredPermissionLevel = 0;
cmd.execute = function (command, server, sender, args) {
  dumpTConInfo(sender);
};
cmd.register();

function dumpTConInfo(sender as ICommandSender) as void {
  sender.sendMessage('\u00A76========== TCon Registry Dump ==========');
  print('=== TCon Registry Dump ===');

  // ── Materials ──
  sender.sendMessage('\u00A7e\u00A7lMaterials:');
  val mats as [Material] = TinkerRegistry.getAllMaterials();
  var matCount = 0 as int;
  var hiddenMatCount = 0 as int;
  var matTraitEntries = 0 as int;
  var uniqueTraitIds = {} as bool[string];

  for mat in mats {
    matCount = matCount + 1 as int;
    if (mat.hidden) hiddenMatCount = hiddenMatCount + 1 as int;

    val defTraits as [ITrait] = mat.getDefaultTraits();
    if (!isNull(defTraits)) {
      for tr in defTraits {
        if (isNull(tr)) continue;
        matTraitEntries = matTraitEntries + 1 as int;
        uniqueTraitIds[tr.identifier] = true;
      }
    }
  }

  sender.sendMessage('  Total: \u00A7f' ~ matCount ~ '\u00A77 (hidden: \u00A78' ~ hiddenMatCount ~ '\u00A77)');
  sender.sendMessage('  Default trait entries: \u00A7f' ~ matTraitEntries ~ '\u00A77 (unique IDs: \u00A7f' ~ uniqueTraitIds.length ~ '\u00A77)');
  print('Materials: ' ~ matCount ~ ' (' ~ hiddenMatCount ~ ' hidden), ' ~ matTraitEntries ~ ' trait entries (' ~ uniqueTraitIds.length ~ ' unique)');

  // ── All modifiers / traits from TinkerRegistry ──
  sender.sendMessage('');
  sender.sendMessage('\u00A7e\u00A7lTinkerRegistry Modifiers (incl. traits registered as modifiers):');
  sender.sendMessage('\u00A78  [T]=trait [M]=pure-mod [A]=conarm  "id" -> localizedName');
  val mods as [IModifier] = TinkerRegistry.getAllModifiers();
  var modCount = 0 as int;
  var traitModCount = 0 as int;
  var modRawKeyCount = 0 as int;
  var modHiddenCount = 0 as int;
  var tconTraitSet = {} as bool[string];

  for mod in mods {
    modCount = modCount + 1 as int;

    val modId = mod.identifier;
    if (isNull(modId) || modId == '') continue;

    val isTrait = !isNull(TinkerRegistry.getTrait(modId));
    if (isTrait) {
      traitModCount = traitModCount + 1 as int;
      tconTraitSet[modId] = true;
    }
    if (mod.hidden) modHiddenCount = modHiddenCount + 1 as int;

    val localized = mod.localizedName;
    val hasLocalized = !isNull(localized) && localized != '' && !localized.startsWith('modifier.') && !localized.startsWith('trait.');
    if (!hasLocalized) modRawKeyCount = modRawKeyCount + 1 as int;

    val tTag = isTrait ? '\u00A7a[T] ' : '\u00A7d[M] ';
    val lName = hasLocalized ? localized : ('\u00A78' ~ (isNull(localized) || localized == '' ? '<raw key>' : localized));
    sender.sendMessage('  ' ~ tTag ~ '\u00A7e' ~ modId ~ '\u00A77 \u2192 ' ~ lName);
  }

  // ── ConArm armor modifiers ──
  sender.sendMessage('');
  sender.sendMessage('\u00A7b\u00A7lArmoryRegistry (ConArm) Armor Modifiers:');
  val armorMods as [IModifier] = ArmoryRegistry.getAllArmorModifiers();
  var armorModCount = 0 as int;
  var armorRawKeyCount = 0 as int;

  for aMod in armorMods {
    armorModCount = armorModCount + 1 as int;

    val aId = aMod.identifier;
    if (isNull(aId) || aId == '') continue;

    val localized = aMod.localizedName;
    val hasLocalized = !isNull(localized) && localized != '' && !localized.startsWith('modifier.') && !localized.startsWith('trait.');
    if (!hasLocalized) armorRawKeyCount = armorRawKeyCount + 1 as int;

    val lName = hasLocalized ? localized : ('\u00A78' ~ (isNull(localized) || localized == '' ? '<raw key>' : localized));
    sender.sendMessage('  \u00A7b[A] \u00A7e' ~ aId ~ '\u00A77 \u2192 ' ~ lName);
  }

  // ── Summary ──
  sender.sendMessage('');
  sender.sendMessage('\u00A76============================================');
  sender.sendMessage('\u00A7e\u00A7lSummary:');
  sender.sendMessage('  Materials                  : \u00A7f' ~ matCount);
  sender.sendMessage('  Material trait entries     : \u00A7f' ~ matTraitEntries ~ '\u00A77 (unique IDs: \u00A7f' ~ uniqueTraitIds.length ~ '\u00A77)');
  sender.sendMessage('  TCon modifiers (total)     : \u00A7f' ~ modCount);
  sender.sendMessage('    Traits (in traits map)   : \u00A7a' ~ traitModCount);
  sender.sendMessage('    Pure modifiers           : \u00A7d' ~ (modCount - traitModCount));
  sender.sendMessage('    Hidden                   : \u00A78' ~ modHiddenCount);
  sender.sendMessage('  ConArm armor mods          : \u00A7b' ~ armorModCount);
  sender.sendMessage('  Raw / missing lang keys    : \u00A78' ~ (modRawKeyCount + armorRawKeyCount));
  sender.sendMessage('  Armor raw lang keys        : \u00A78' ~ armorRawKeyCount);
  sender.sendMessage('\u00A76============================================');
  sender.sendMessage('\u00A77Full data also written to server log (crafttweaker.log).');

  // Full log dump
  print('=== TCon Registry Dump (full) ===');
  print('--- Materials ---');
  print('Total: ' ~ matCount ~ ', Hidden: ' ~ hiddenMatCount ~ ', Trait entries: ' ~ matTraitEntries ~ ', Unique trait IDs: ' ~ uniqueTraitIds.length);
  print('--- TinkerRegistry Modifiers ---');
  for mod in mods {
    val modId = mod.identifier;
    if (isNull(modId) || modId == '') continue;
    val isTrait = !isNull(TinkerRegistry.getTrait(modId));
    val localized = mod.localizedName;
    val hasLocalized = !isNull(localized) && localized != '' && !localized.startsWith('modifier.') && !localized.startsWith('trait.');
    val tag = isTrait ? 'TRAIT' : 'MOD';
    val name = hasLocalized ? localized : ('<raw: ' ~ (isNull(localized) || localized == '' ? '???' : localized) ~ '>');
    print('  [' ~ tag ~ '] ' ~ modId ~ ' -> ' ~ name ~ (mod.hidden ? ' (HIDDEN)' : ''));
  }
  print('--- ArmoryRegistry (ConArm) ---');
  for aMod in armorMods {
    val aId = aMod.identifier;
    if (isNull(aId) || aId == '') continue;
    val localized = aMod.localizedName;
    val hasLocalized = !isNull(localized) && localized != '' && !localized.startsWith('modifier.') && !localized.startsWith('trait.');
    val name = hasLocalized ? localized : ('<raw: ' ~ (isNull(localized) || localized == '' ? '???' : localized) ~ '>');
    print('  [ARMOR] ' ~ aId ~ ' -> ' ~ name);
  }
  print('--- Summary ---');
  print('Materials=' ~ matCount ~ ' TConMods=' ~ modCount ~ ' Traits=' ~ traitModCount ~ ' PureMods=' ~ (modCount - traitModCount) ~ ' ConArm=' ~ armorModCount ~ ' RawKeys=' ~ (modRawKeyCount + armorRawKeyCount) ~ ' Hidden=' ~ modHiddenCount);
  print('=== DumpTCon end ===');
}
