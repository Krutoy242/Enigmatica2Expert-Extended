#modloaded jetif deepmoblearning enderio biomesoplenty
#loader mixin
#sideonly client

import native.net.minecraft.item.Item;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.ResourceLocation;

/*
  Keep the JETIF "Throwing in Fluids" JEI display in sync with the gameplay
  recipe override in scripts/mixin/deepmoblearning.zs. CompatDeepMobLearning.addRecipes
  hardcodes [Lapis Lazuli] + [Gold Ingot] as the shown inputs; swap them so JEI
  advertises the ingredients that actually work:
    new ItemStack(DYE, 1, 4)   (NEW ordinal 0, 3-arg ctor) -> [Terrestrial Artifact]
    new ItemStack(GOLD_INGOT)  (NEW ordinal 1, 1-arg ctor) -> [Stellar Alloy Ingot]
*/
#mixin { targets: 'lykrast.jetif.compat.CompatDeepMobLearning' }
zenClass MixinCompatDeepMobLearning {

  #mixin Redirect
  #{
  #  method: 'addRecipes',
  #  at: {
  #    value: 'NEW',
  #    target: 'net/minecraft/item/ItemStack',
  #    ordinal: 0
  #  }
  #}
  function replaceLapis(item as Item, count as int, meta as int) as ItemStack {
    return makeStack('biomesoplenty', 'terrestrial_artifact', 0);
  }

  #mixin Redirect
  #{
  #  method: 'addRecipes',
  #  at: {
  #    value: 'NEW',
  #    target: 'net/minecraft/item/ItemStack',
  #    ordinal: 1
  #  }
  #}
  function replaceGold(item as Item) as ItemStack {
    return makeStack('enderio', 'item_alloy_endergy_ingot', 3);
  }

  function makeStack(modid as string, path as string, meta as int) as ItemStack {
    val item = Item.REGISTRY.getObject(ResourceLocation(modid, path)) as Item;
    return ItemStack(item, 1, meta);
  }
}
