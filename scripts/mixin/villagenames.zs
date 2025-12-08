#modloaded villagenames
#loader mixin

import native.net.minecraft.entity.passive.EntityVillager;
import native.net.minecraft.nbt.NBTTagCompound;

/*

Fix constant TPS lag caused by villagenames wrong villager handling

Related: https://legacy.curseforge.com/minecraft/mc-mods/village-names/issues/18

*/
#mixin Mixin {targets: "astrotibs.villagenames.handler.EntityMonitorHandler"}
zenClass EntityMonitorHandlerMixin {
    #mixin Redirect {method: "onLivingUpdateEvent", at: {value: "INVOKE", target: "Lnet/minecraft/entity/passive/EntityVillager;func_70014_b(Lnet/minecraft/nbt/NBTTagCompound;)V"}}
    function cancelWrite(instance as EntityVillager, i as NBTTagCompound) as void {
        // no-op
    }

    #mixin Redirect {method: "onLivingUpdateEvent", at: {value: "INVOKE", target: "Lnet/minecraft/nbt/NBTTagCompound;func_74762_e(Ljava/lang/String;)I", ordinal: 0}}
    #mixin Local {parameter: -1, ref: false}
    function getProfession(instance as NBTTagCompound, key as string, villager as EntityVillager) as int {
        return villager.profession;
    }

    #mixin Redirect {method: "onLivingUpdateEvent", at: {value: "INVOKE", target: "Lnet/minecraft/nbt/NBTTagCompound;func_74762_e(Ljava/lang/String;)I", ordinal: 1}}
    #mixin Local {parameter: -1, ref: false}
    function getCareerId(instance as NBTTagCompound, key as string, villager as EntityVillager) as int {
        return villager.careerId;
    }

    #mixin Redirect {method: "onLivingUpdateEvent", at: {value: "INVOKE", target: "Lnet/minecraft/nbt/NBTTagCompound;func_74762_e(Ljava/lang/String;)I", ordinal: 2}}
    #mixin Local {parameter: -1, ref: false}
    function getCareerLevel(instance as NBTTagCompound, key as string, villager as EntityVillager) as int {
        return villager.careerLevel;
    }
}
