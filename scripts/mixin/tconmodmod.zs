#loader mixin
#modloaded tconstruct

import native.java.text.DecimalFormat;
import native.net.minecraft.nbt.NBTTagCompound;
import native.slimeknights.tconstruct.library.modifiers.ModifierNBT;

#mixin {targets: "xyz.phanta.tconmodmod.modifier.ModReinforcedTMM"}
zenClass MixinModReinforcedTMM {
    #mixin Static
    #mixin Overwrite
    function getReinforcedChance(modifierTag as NBTTagCompound) as float {
        val level = ModifierNBT.readTag(modifierTag).level as int;
        if (level <= 0) return 0.0f;
        if (level >= 10) return 1.0f;
        return 1.0f - pow(0.5, level) as float;
    }

    #mixin Redirect {method: "getExtraInfo", at: {value: "INVOKE", target: "Ljava/text/DecimalFormat;format(D)Ljava/lang/String;"}}
    function preciseFormat(instance as DecimalFormat, chance as double) as string {
        return DecimalFormat("#.#%").format(chance);
    }
}

#mixin {targets: "xyz.phanta.tconmodmod.modifier.ModReinforcedConArmTMM"}
zenClass MixinModReinforcedConArmTMM {
    #mixin Static
    #mixin Overwrite
    function getReinforcedChance(modifierTag as NBTTagCompound) as float {
        val level = ModifierNBT.readTag(modifierTag).level as int;
        if (level <= 0) return 0.0f;
        if (level >= 10) return 1.0f;
        return 1.0f - pow(0.5, level) as float;
    }

    #mixin Redirect {method: "getExtraInfo", at: {value: "INVOKE", target: "Ljava/text/DecimalFormat;format(D)Ljava/lang/String;"}}
    function preciseFormat(instance as DecimalFormat, chance as double) as string {
        return DecimalFormat("#.#%").format(chance);
    }
}