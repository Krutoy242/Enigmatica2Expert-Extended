#modloaded tconstruct
#loader mixin

import native.net.minecraft.item.ItemStack;
import native.net.minecraftforge.fluids.Fluid;
import native.net.minecraft.nbt.NBTTagCompound;
import native.slimeknights.tconstruct.library.smeltery.ICastingRecipe;
import native.slimeknights.tconstruct.library.modifiers.ModifierAspect;
import native.slimeknights.tconstruct.library.modifiers.ModifierNBT;
import native.slimeknights.tconstruct.library.modifiers.ModifierNBT.IntegerNBT;
import native.slimeknights.tconstruct.library.tools.ToolNBT;
import native.slimeknights.tconstruct.library.utils.TagUtil;
import native.slimeknights.tconstruct.tools.modifiers.ToolModifier;
import mixin.CallbackInfo;

#mixin {targets: "slimeknights.tconstruct.smeltery.TinkerSmeltery"}
zenClass MixinTinkerSmeltery {
    #mixin Static
    #mixin Redirect
    #{
    #    method: "registerToolpartMeltingCasting",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lslimeknights/tconstruct/library/TinkerRegistry;registerMelting(Lnet/minecraft/item/ItemStack;Lnet/minecraftforge/fluids/Fluid;I)V",
    #        ordinal: 0
    #    }
    #}
    function disableToolpartMelting(stack as ItemStack, fluid as Fluid, amount as int) as void {
        // NO-OP
    }

    #mixin Static
    #mixin Redirect
    #{
    #    method: "registerToolpartMeltingCasting",
    #    at: {
    #        value: "INVOKE",
    #        target: "Lslimeknights/tconstruct/library/TinkerRegistry;registerTableCasting(Lslimeknights/tconstruct/library/smeltery/ICastingRecipe;)V",
    #        ordinal: 0
    #    }
    #}
    function disableCastRecipes(recipe as ICastingRecipe) as void {
        // NO-OP
    }

    #mixin Static
    #mixin Inject {method: "registerRecipeOredictMelting", at: {value: "HEAD"}, cancellable: true}
    function disableRecipeOredictMelting(ci as CallbackInfo) as void {
        ci.cancel();
    }
}

#mixin {targets: "slimeknights.tconstruct.tools.modifiers.ModEmerald"}
zenClass MixinModEmerald {
    #mixin ModifyConstant {method: "applyEffect", constant: {intValue: 2}}
    function buffDurabilityBonus(value as int) as int {
        return 1;
    }
}

/*
Speed up casting cooldown time
Some metals have high melting temperature, which causing them to cooldown forever
*/
#mixin {targets: "slimeknights.tconstruct.library.smeltery.CastingRecipe"}
zenClass MixinCastingRecipe {
    #mixin Static
    #mixin ModifyConstant {method: "calcCooldownTime", constant: {intValue: 1600}}
    function shorterCooldown(value as int) as int {
        return value * 10;
    }
}

/*
Nether Quartz modifier add percentaged damage (instead of fixed number)

Now each level adding
1. +`1` bare damage
2. +`10%` of base damage
3. +`x^4/(20^4/8)` as high-level bonus, where `x` is base damage

So, if your weapon deals 10 damage, on lvl 1 it would be 12 dmg. On level 10 it would be 35 dmd. On level 20 - 120 dmg.
*/
#mixin {targets: "slimeknights.tconstruct.tools.modifiers.ModSharpness"}
zenClass MixinModSharpness {
    #mixin Shadow
    #mixin Final
    var max as int;

    #mixin Overwrite
    function applyEffect(rootCompound as NBTTagCompound, modifierTag as NBTTagCompound) as void {
        val data as IntegerNBT = ModifierNBT.readInteger(modifierTag);
        val toolData as ToolNBT = TagUtil.getOriginalToolStats(rootCompound);
        var attack as float = toolData.attack;
        val level as float = (1.0f * data.current) / max;
        attack += attack * (level * level * level * level / (20.0f * 20.0f * 20.0f * 20.0f / 8.0f)) + level * 0.1f * attack + level;
        val nBTTagCompound as NBTTagCompound = TagUtil.getToolTag(rootCompound);
        attack -= toolData.attack;
        attack += nBTTagCompound.getFloat("Attack");
        nBTTagCompound.setFloat("Attack", attack);
    }
}
