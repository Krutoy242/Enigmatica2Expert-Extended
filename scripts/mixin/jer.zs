#loader mixin
#modloaded jeresources

import native.jeresources.entry.WorldGenEntry;
import native.jeresources.util.LogHelper;

import native.java.util.regex.Matcher;
import native.java.util.regex.Pattern;

import native.java.lang.Math;

#mixin { targets: 'jeresources.registry.WorldGenRegistry' }
zenClass MixinWorldGenRegistry {
  #mixin Inject { method: 'getWorldGen', at: { value: 'RETURN' } }
  function sortInfo(cir as mixin.CallbackInfoReturnable) as void {
    LogHelper.info('E2EE: Sorting JER worldgen entries by absolute value of dim id and distribution', []);

    val dimIdPattern as Pattern = Pattern.compile('\\((-?\\d{1,9})\\)$');

    val extractDimId as function(WorldGenEntry)int = function (entry as WorldGenEntry) as int {
      val matcher as Matcher = dimIdPattern.matcher(entry.getDimension());
      if (matcher.find()) {
        return matcher.group(1);
      }
      return 2147483647;
    };

    val result as [WorldGenEntry] = cir.getReturnValue();
    result.sort(function (a as WorldGenEntry, b as WorldGenEntry) as int {
      val idA = extractDimId(a);
      val idB = extractDimId(b);
      val hasIdA = idA != 2147483647;
      val hasIdB = idB != 2147483647;
      if (hasIdA && !hasIdB) return -1;
      if (!hasIdA && hasIdB) return 1;

      if (hasIdA) {
        val absA = Math.abs(idA);
        val absB = Math.abs(idB);
        if (absA < absB) return -1;
        if (absA > absB) return 1;
        if (idA < idB) return -1;
        if (idA > idB) return 1;
      }
      val dimA = a.getDimension();
      val dimB = b.getDimension();
      if (dimA != dimB) {
        if (dimA == 'Block Drops') return 1;
        if (dimB == 'Block Drops') return -1;
        return dimA.compareTo(dimB);
      }
      val distA = a.getAverageBlockCountPerChunk();
      val distB = b.getAverageBlockCountPerChunk();
      if (distA > distB) return -1;
      if (distA < distB) return 1;
      val stackA = a.getBlock();
      val stackB = b.getBlock();
      val regA = stackA.getItem().getRegistryName();
      val regB = stackB.getItem().getRegistryName();
      var keyA = a.toString();
      var keyB = b.toString();
      if (!isNull(regA)) {
        keyA = regA.toString() ~ ':' ~ stackA.getItemDamage();
      }
      if (!isNull(regB)) {
        keyB = regB.toString() ~ ':' ~ stackB.getItemDamage();
      }
      return keyA.compareTo(keyB);
    });
  }
}
