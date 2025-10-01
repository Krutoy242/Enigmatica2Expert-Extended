#loader mixin
#modloaded jei
#sideonly client

import native.mezz.jei.api.recipe.IRecipeCategory;

#mixin {targets: "mezz.jei.recipes.RecipeRegistry"}
zenClass MixinRecipeCategoryComparator {
  #mixin Static
  #mixin ModifyVariable {method: "<init>", at: {value: "HEAD"}, ordinal: 0, argsOnly: true}
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
      'ThaumicJEI',
      'Rats',
      'Plethora',
      'FTB Quests',
      'Environmental Tech',
      'Quantum Minecraft Dynamics',
      'End: Reborn',
      'Advanced Rocketry',
      'Gendustry JEI Addon',
      'nuclearcraft',
      'Requious Frakto',
    ];
    return categories.sort(function (a as IRecipeCategory, b as IRecipeCategory) as int {
      val aN = order.indexOf(a.modName);
      val bN = order.indexOf(b.modName);
      return (aN == -1 ? 99999 : aN) - (bN == -1 ? 99999 : bN);
    });
  }
}
