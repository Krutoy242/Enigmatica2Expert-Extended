#loader mixin

import native.net.silentchaos512.scalinghealth.lib.EnumAreaDifficultyMode;
import native.net.silentchaos512.scalinghealth.config.Config;
import native.net.minecraft.world.World;
import native.net.minecraft.util.math.BlockPos;

#mixin Mixin
#{targets: "net.silentchaos512.scalinghealth.event.DifficultyHandler"}
zenClass MixinDifficultyHandler {
    #mixin Redirect
    #{
    #   method: "indexRecipes",
    #   at: {
    #       value: "INVOKE",
    #       target: "Lnet/silentchaos512/scalinghealth/lib/EnumAreaDifficultyMode;getAreaDifficulty(Lnet/minecraft/world/World;Lnet/minecraft/util/math/BlockPos;)D"
    #   }
    #}
    function nonLinearDifficulty(mode as EnumAreaDifficultyMode, world as World, pos as BlockPos) as double {
        val origin = mode.getAreaDifficulty(world, pos);
        return origin * origin / Config.Difficulty.maxValue;
    }
}