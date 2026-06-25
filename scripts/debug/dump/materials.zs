#modloaded tconstruct conarm
#priority 3999
#reloadable

import crafttweaker.command.ICommandSender;

import native.slimeknights.tconstruct.library.TinkerRegistry;
import native.slimeknights.tconstruct.library.materials.Material;
import native.slimeknights.tconstruct.library.materials.HeadMaterialStats;
import native.slimeknights.tconstruct.library.materials.HandleMaterialStats;
import native.slimeknights.tconstruct.library.materials.ExtraMaterialStats;
import native.slimeknights.tconstruct.library.materials.BowMaterialStats;
import native.slimeknights.tconstruct.library.materials.BowStringMaterialStats;
import native.slimeknights.tconstruct.library.materials.FletchingMaterialStats;
import native.slimeknights.tconstruct.library.materials.IMaterialStats;

import native.c4.conarm.lib.materials.CoreMaterialStats;
import native.c4.conarm.lib.materials.PlatesMaterialStats;
import native.c4.conarm.lib.materials.TrimMaterialStats;

scripts.debug.dump.main.registerSubcommand('materials', function (sender as ICommandSender) as void {
  dumpMaterials(sender);
});

function join(parts as string[], sep as string) as string {
  if (isNull(parts) || parts.length == 0) return '';
  var result = '';
  var first = true;
  for p in parts {
    if (isNull(p)) continue;
    if (!first) result ~= sep;
    first = false;
    result ~= p;
  }
  return result;
}

function dumpMaterials(sender as ICommandSender) as void {
  sender.sendMessage(
    'materialId;localizedName;hidden;castable;craftable;'
    ~ 'fluidName;representativeItem;shardItem;textColor;'
    ~ 'headDurability;headMiningSpeed;headAttack;headHarvestLevel;'
    ~ 'handleModifier;handleDurability;extraDurability;'
    ~ 'bowDrawSpeed;bowRange;bowBonusDamage;'
    ~ 'bowstringModifier;fletchingAccuracy;fletchingModifier;hasProjectile;'
    ~ 'coreDurability;coreDefense;platesModifier;platesDurability;platesToughness;trimExtraDurability;'
    ~ 'defaultTraits;partTraits;extraPartTypes'
  );

  val mats as [Material] = TinkerRegistry.getAllMaterials();

  for mat in mats {
    if (isNull(mat)) continue;

    val id       = toString(mat.identifier);
    val name     = toString(mat.localizedName);
    val hidden   = mat.hidden ? 'yes' : 'no';
    val castable = mat.castable ? 'yes' : 'no';
    val craft    = mat.craftable ? 'yes' : 'no';

    var fluidName = '';
    if (mat.hasFluid()) {
      val f = mat.getFluid();
      if (!isNull(f)) fluidName = toString(f.name);
    }

    var rep = '';
    val repNative = mat.getRepresentativeItem();
    if (!isNull(repNative)) {
      val repStack = repNative.wrapper;
      if (!isNull(repStack)) rep = toString(repStack.commandString);
    }
    var shard = '';
    val shardNative = mat.getShard();
    if (!isNull(shardNative)) {
      val shardStack = shardNative.wrapper;
      if (!isNull(shardStack)) shard = toString(shardStack.commandString);
    }

    val tColor = toString(mat.materialTextColor);

    var hDura = '';
    var hSpd = '';
    var hAtk = '';
    var hHL = '';
    if (mat.hasStats('head')) {
      val s = mat.getStats('head') as HeadMaterialStats;
      if (!isNull(s)) {
        hDura = toString(s.durability);
        hSpd = toString(s.miningspeed);
        hAtk = toString(s.attack);
        hHL = toString(s.harvestLevel);
      }
    }

    var hMod = '';
    var hDura2 = '';
    if (mat.hasStats('handle')) {
      val s = mat.getStats('handle') as HandleMaterialStats;
      if (!isNull(s)) {
        hMod = toString(s.modifier);
        hDura2 = toString(s.durability);
      }
    }

    var eDura = '';
    if (mat.hasStats('extra')) {
      val s = mat.getStats('extra') as ExtraMaterialStats;
      if (!isNull(s)) eDura = toString(s.extraDurability);
    }

    var bDraw = '';
    var bRng = '';
    var bBonus = '';
    if (mat.hasStats('bow')) {
      val s = mat.getStats('bow') as BowMaterialStats;
      if (!isNull(s)) {
        bDraw = toString(s.drawspeed);
        bRng = toString(s.range);
        bBonus = toString(s.bonusDamage);
      }
    }

    var bsMod = '';
    if (mat.hasStats('bowstring')) {
      val s = mat.getStats('bowstring') as BowStringMaterialStats;
      if (!isNull(s)) bsMod = toString(s.modifier);
    }

    var fAcc = '';
    var fMod = '';
    if (mat.hasStats('fletching')) {
      val s = mat.getStats('fletching') as FletchingMaterialStats;
      if (!isNull(s)) {
        fAcc = toString(s.accuracy);
        fMod = toString(s.modifier);
      }
    }

    val hasProj = mat.hasStats('projectile') ? 'yes' : 'no';

    var cDura = '';
    var cDef = '';
    if (mat.hasStats('core')) {
      val s = mat.getStats('core') as CoreMaterialStats;
      if (!isNull(s)) {
        cDura = toString(s.durability);
        cDef = toString(s.defense);
      }
    }

    var pMod = '';
    var pDura = '';
    var pTough = '';
    if (mat.hasStats('plates')) {
      val s = mat.getStats('plates') as PlatesMaterialStats;
      if (!isNull(s)) {
        pMod = toString(s.modifier);
        pDura = toString(s.durability);
        pTough = toString(s.toughness);
      }
    }

    var tDura = '';
    if (mat.hasStats('trim')) {
      val s = mat.getStats('trim') as TrimMaterialStats;
      if (!isNull(s)) tDura = toString(s.extraDurability);
    }

    var defTraitStr = '';
    val defTraits = mat.getDefaultTraits();
    if (!isNull(defTraits) && defTraits.length > 0) {
      val ids = [] as [string];
      for tr in defTraits {
        if (!isNull(tr)) ids.add(tr.identifier);
      }
      defTraitStr = join(ids as string[], '|');
    }

    val partTraitParts = [] as [string];
    val knownParts = [
      'head', 'handle', 'extra', 'bow', 'bowstring',
      'projectile', 'fletching', 'shaft',
      'core', 'plates', 'trim',
      'laser_medium', 'tconevo.magic',
    ] as string[];

    for part in knownParts {
      if (!mat.hasStats(part)) continue;
      val trList = mat.getAllTraitsForStats(part);
      var entry = part;
      if (!isNull(trList) && trList.length > 0) {
        val ids = [] as [string];
        for tr in trList {
          if (!isNull(tr)) ids.add(tr.identifier);
        }
        entry ~= '=' ~ join(ids as string[], ',');
      }
      partTraitParts.add(entry);
    }

    var extraPartTypes = '';
    val allStats as [IMaterialStats] = mat.getAllStats();
    if (!isNull(allStats)) {
      val exoticIds = [] as [string];
      for s in allStats {
        if (isNull(s)) continue;
        val sid = s.identifier;
        if (isNull(sid) || sid == '') continue;
        var isKnown = false;
        for kp in knownParts {
          if (kp == sid) {
            isKnown = true;
            break;
          }
        }
        if (isKnown) continue;
        exoticIds.add(sid);
      }
      if (exoticIds.length > 0) {
        extraPartTypes = join(exoticIds as string[], '|');
      }
    }

    var partTraitsStr = join(partTraitParts as string[], '|');
    if (isNull(partTraitsStr)) partTraitsStr = '';

    sender.sendMessage(
      id ~ ';' ~ name ~ ';' ~ hidden ~ ';' ~ castable ~ ';' ~ craft ~ ';'
      ~ fluidName ~ ';' ~ rep ~ ';' ~ shard ~ ';' ~ tColor ~ ';'
      ~ hDura ~ ';' ~ hSpd ~ ';' ~ hAtk ~ ';' ~ hHL ~ ';'
      ~ hMod ~ ';' ~ hDura2 ~ ';' ~ eDura ~ ';'
      ~ bDraw ~ ';' ~ bRng ~ ';' ~ bBonus ~ ';'
      ~ bsMod ~ ';' ~ fAcc ~ ';' ~ fMod ~ ';' ~ hasProj ~ ';'
      ~ cDura ~ ';' ~ cDef ~ ';' ~ pMod ~ ';' ~ pDura ~ ';' ~ pTough ~ ';' ~ tDura ~ ';'
      ~ defTraitStr ~ ';' ~ partTraitsStr ~ ';' ~ extraPartTypes
    );
  }

  sender.sendMessage('\u00A7aDumped \u00A7f' ~ mats.length ~ '\u00A7a materials');
}
