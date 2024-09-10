#loader mixin

import mixin.CallbackInfoReturnable;

#mixin Mixin
#{targets: "quaternary.botaniatweaks.modules.jei.RecipeWrapperAgglomeration"}
zenClass MixinManaPoolRecipeWrapper {

    #mixin Shadow
    #mixin Final
    var manaCost as int;

    // Show mana numerical value
    function getTooltipStrings(mouseX as int, mouseY as int) as [string] {
        if (mouseX > 35 && mouseX < 140 && mouseY > 60 && mouseY < 65) {
            return [manaCost ~ " mana"] as [string];
        }
        return [] as [string];
    }
}
