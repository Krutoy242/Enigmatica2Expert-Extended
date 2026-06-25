#modloaded tconstruct conarm
#loader tconstruct_traits reloadable
#priority 0

import scripts.mods.tconstruct.traitsbuilder_helpers._prepare;
import scripts.mods.tconstruct.traitsbuilder_helpers._addTrait;
import scripts.mods.tconstruct.traitsbuilder_helpers._removeTrait;
import scripts.mods.tconstruct.traitsbuilder_helpers._overwritePart;

zenClass TraitsBuilder {
  var materials as string[] = [] as string[];
  var currentParts as string[] = [] as string[];

  zenConstructor() {}

  function forMaterials(ids as string[]) as TraitsBuilder {
    materials = ids;
    return this;
  }

  function forParts(parts as string[]) as TraitsBuilder {
    currentParts = parts;
    return this;
  }

  function overwriteParts(ids as string[]) as TraitsBuilder {
    if (materials.length == 0 || currentParts.length == 0) return this;
    for matId in materials {
      val mat = _prepare(matId);
      if (isNull(mat)) continue;
      for part in currentParts {
        _overwritePart(mat, part, ids);
      }
    }
    return this;
  }

  function addToParts(ids as string[]) as TraitsBuilder {
    if (materials.length == 0 || currentParts.length == 0) return this;
    for matId in materials {
      val mat = _prepare(matId);
      if (isNull(mat)) continue;
      for part in currentParts {
        for id in ids {
          _addTrait(mat, part, id);
        }
      }
    }
    return this;
  }

  function removeFromParts(ids as string[]) as TraitsBuilder {
    if (materials.length == 0 || currentParts.length == 0) return this;
    for matId in materials {
      val mat = _prepare(matId);
      if (isNull(mat)) continue;
      for part in currentParts {
        for id in ids {
          _removeTrait(mat, part, id);
        }
      }
    }
    return this;
  }
}
