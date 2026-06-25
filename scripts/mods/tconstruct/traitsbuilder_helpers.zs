#modloaded tconstruct conarm
#loader tconstruct_traits reloadable
#priority 100

import native.slimeknights.tconstruct.library.TinkerRegistry;
import native.slimeknights.tconstruct.library.materials.Material;
import native.slimeknights.tconstruct.library.materials.IMaterialStats;

static _baselineLogged as bool[string] = {};

function logBaseline(id as string, mat as Material) as void {
  if (!utils.DEBUG) return;
  print('[material_traits] Baseline: "' ~ id ~ '" — defaultTraits:');
  val defTraits = mat.getDefaultTraits();
  if (!isNull(defTraits) && defTraits.length > 0) {
    var s = '';
    for tr in defTraits {
      if (!isNull(tr)) s = s ~ (s == '' ? '' : ', ') ~ tr.identifier;
    }
    print('[material_traits]   -> $ ' ~ s);
  }
  else {
    print('[material_traits]   -> $ (none)');
  }

  val stats as [IMaterialStats] = mat.getAllStats();
  for s in stats {
    val part = s.identifier;
    val existing = mat.getAllTraitsForStats(part);
    if (isNull(existing) || existing.length == 0) {
      print('[material_traits]   ' ~ part ~ ': (empty)');
    }
    else {
      var s2 = '';
      for tr in existing {
        if (!isNull(tr)) s2 = s2 ~ (s2 == '' ? '' : ', ') ~ tr.identifier;
      }
      print('[material_traits]   ' ~ part ~ ': ' ~ s2);
    }
  }
}

function _prepare(id as string) as Material {
  val mat = TinkerRegistry.getMaterial(id);
  if (isNull(mat) || mat == Material.UNKNOWN) {
    if (utils.DEBUG) print('[material_traits] WARNING: material "' ~ id ~ '" not found');
    return null;
  }
  if (isNull(_baselineLogged[id])) {
    _baselineLogged[id] = true;
    logBaseline(id, mat);
  }
  return mat;
}

function _addTrait(mat as Material, part as string, id as string) as void {
  if (!mat.hasStats(part)) return;
  val tr = TinkerRegistry.getTrait(id);
  if (isNull(tr)) { if (utils.DEBUG) print('[material_traits] WARNING: trait "' ~ id ~ '" not found, skipping'); return; }
  mat.addTrait(tr, part);
}

function _removeTrait(mat as Material, part as string, id as string) as void {
  if (!mat.hasStats(part)) return;
  mat.crt_removeTrait(id, part);
}

function _overwritePart(mat as Material, part as string, ids as string[]) as void {
  if (!mat.hasStats(part)) return;
  mat.crt_clearTraitsForPart(part);
  for id in ids {
    val tr = TinkerRegistry.getTrait(id);
    if (isNull(tr)) { if (utils.DEBUG) print('[material_traits] WARNING: trait "' ~ id ~ '" not found, skipping'); continue; }
    mat.addTrait(tr, part);
  }
}
