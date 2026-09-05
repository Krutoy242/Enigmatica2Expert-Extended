#loader mixin
#modloaded jei
#sideonly client

import native.java.lang.Object;
import native.mezz.jei.api.ingredients.IIngredientHelper;
import native.mezz.jei.api.recipe.IRecipeCategory;

import mixin.CallbackInfoReturnable;

#mixin { targets: 'mezz.jei.recipes.RecipeRegistry' }
zenClass MixinRecipeCategoryComparator {
  #mixin Static
  #mixin ModifyVariable { method: '<init>', at: { value: 'HEAD' }, ordinal: 0, argsOnly: true }
  function reorder(categories as [IRecipeCategory]) as [IRecipeCategory] {
    val order as string[] = [
      'Minecraft',
      "Tinkers' Antique",
      'Forestry',
      'Just Enough Fluid Interactions',
      'Minor Integrations & Additions',
      'inworldcrafting',
      'Just Enough Resources',
      'Just Enough Magiculture',
      "Pam's HarvestCraft",
      'Just Enough Fluid Behavior',
      "Tinkers' Complement",
      'reim',
      'Had Enough Items',
      'Rustic',
      'ic2',
      'Botania',
      'Flux Networks',
      'psi',
      'Random Things',
      'Integrated Dynamics',
      'Thermal Expansion',
      'JustEnoughPetroleum',
      'Immersive Technology',
      'Applied Energistics 2',
      'Industrial Foregoing',
      'industrialforegoing',
      'exnihilocreatio',
      'Actually Additions',
      'draconicevolution',
      'Industrial Wires',
      'Mystical Agriculture',
      'Ex Compressum',
      'enderiomachines',
      'Mystical Agradditions',
      'Mystical Creations',
      'PackagedAuto',
      'Chisel',
      'ExtendedCrafting: Nomifactory Edition',
      'iceandfire',
      'Lazy AE2',
      'Thaumic Additions: Reconstructed',
      'tweakedpetroleumgas',
      'deepmoblearning',
      'compactmachines3',
      'Avaritia',
      'deepmoblearningbm',
      'bloodmagic',
      'thaumicwonders',
      'randomtweaker',
      'rats',
      'advancedrocketry',
      'enderio',
      'Mekanism',
      'mechanics',
      'jetif',
      'tweakedexcavation',
      'Farming for Blockheads',
      'cyclicmagic',
      'tweakedpetroleum',
      'Cooking for Blockheads',
      'Immersive Engineering',
      'Astral Sorcery',
      'Botania Tweaks',
      "Neeve's AE2: Extended Life Additions",
      'Blood Magic: Alchemical Wizardry',
      'extrautils2',
      'Just Enough Pattern Banner',
      'Rats',
      'Plethora',
      'FTB Quests',
      'nuclearcraft',
      'Quantum Minecraft Dynamics',
      'Environmental Tech',
      'Advanced Rocketry',
      'End: Reborn',
      'Gendustry JEI Addon',
      'Requious Frakto',
      'ThaumicJEI',
    ];
    return categories.sort(function (a as IRecipeCategory, b as IRecipeCategory) as int {
      val aN = order.indexOf(a.modName);
      val bN = order.indexOf(b.modName);
      return (aN == -1 ? 99999 : aN) - (bN == -1 ? 99999 : bN);
    });
  }
}

/*
  Hide all filled containers from the item list.
  Otherwise `config/jei/itemBlacklist.cfg` has to spell out every
  container × fluid/mob/gas pair (~3200 lines), while empty containers stay visible.

  Uid format is `<registry name>:<subtype>`: fluid containers report the
  `empty;` subtype when empty, florbs/morbs/vials report no subtype at all.
*/
#mixin { targets: 'mezz.jei.config.Config' }
zenClass MixinConfigFilledContainers {
  #mixin Static
  #mixin Inject
  #{
  #  method: 'isIngredientOnConfigBlacklist(Ljava/lang/Object;Lmezz/jei/api/ingredients/IIngredientHelper;)Z',
  #  at: { value: 'HEAD' },
  #  cancellable: true
  #}
  function hideFilledContainers(ingredient as Object, helper as IIngredientHelper, cir as CallbackInfoReturnable) as void {
    val uid = helper.getUniqueId(ingredient) as string;
    if (isNull(uid)) return;

    // Weed-Ex and Compressed Air cells are usable items, not fluid storage
    if (uid.startsWith('ic2:fluid_cell:')) {
      if (
        !uid.startsWith('ic2:fluid_cell:empty;')
        && !uid.startsWith('ic2:fluid_cell:ic2air;')
        && !uid.startsWith('ic2:fluid_cell:ic2weed_ex;')
      ) cir.setReturnValue(true);
      return;
    }

    if (uid.startsWith('openblocks:tank:')) {
      if (!uid.startsWith('openblocks:tank:empty;')) cir.setReturnValue(true);
      return;
    }

    if (
      uid.startsWith('thermalexpansion:florb:')
      || uid.startsWith('thermalexpansion:morb:')
      || uid.startsWith('enderio:item_soul_vial:')
      || uid.startsWith('mekanism:gastank:0:creative:')
    ) cir.setReturnValue(true);
  }
}
