#loader mixin
#modloaded jeresources

import native.jeresources.entry.WorldGenEntry;
import native.jeresources.util.LogHelper;

import native.java.util.Comparator;
import native.java.util.List;
import native.java.util.regex.Matcher;
import native.java.util.regex.Pattern;

import native.java.lang.Integer;
import native.java.lang.Math;

#mixin {targets: "jeresources.registry.WorldGenRegistry"}
zenClass MixinWorldGenRegistry {

    #mixin Inject {method: "getWorldGen", at = {value: "RETURN"}}
    function sortInfo(cir as mixin.CallbackInfoReturnable) as void {
        LogHelper.info("E2EE: Sorting JER worldgen entries by absolute value of dim id", []);

        val dimIdPattern as Pattern = Pattern.compile("\\((-?\\d+)\\)", Pattern.MULTILINE);

        val extractDimId as function(WorldGenEntry)int = function(entry as WorldGenEntry) as int {
            val matcher as Matcher = dimIdPattern.matcher(entry.getRestriction().getDimensionRestriction());
            if (matcher.matches()) {
                return Math.abs(Integer.parseInt(matcher.group(1)));
            }
            return 10000;
        };

        val result as List = cir.getReturnValue();
        result.sort(function(a as WorldGenEntry, b as WorldGenEntry) as int {
            val dimIdDiff as int = extractDimId(a) - extractDimId(b);
            if (dimIdDiff != 0) {
                return dimIdDiff;
            }
            return a.toString().compareTo(b.toString());
        });
    }
}
