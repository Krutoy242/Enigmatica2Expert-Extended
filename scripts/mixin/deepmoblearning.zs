#modloaded deepmoblearning enderio biomesoplenty
#loader mixin

import native.net.minecraft.item.Item;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.util.ResourceLocation;

/*
  Replace the hardcoded "throw fragments in water" recipe for the
  [Glitch Infused Ingot]. Stock DML consumes a [Gold Ingot] + [Lapis Lazuli];
  the Expert progression demands end-game materials instead:
    [Gold Ingot]   -> [Stellar Alloy Ingot]     (<enderio:item_alloy_endergy_ingot:3>)
    [Lapis Lazuli] -> [Terrestrial Artifact]     (<biomesoplenty:terrestrial_artifact>)

  EntityItemGlitchFragment.onUpdate (SRG: func_70071_h_) scans nearby EntityItems
  with getAnyInList(list, filter). We swap the `filter` ItemStack (arg index 1)
  for the two relevant lookups, identified by invoke ordinal:
    ordinal 0 = gold lookup, ordinal 1 = lapis lookup (ordinal 2 = fragment, left as-is).
*/
#mixin { targets: 'mustapelto.deepmoblearning.common.entities.EntityItemGlitchFragment' }
zenClass MixinEntityItemGlitchFragment {
  #mixin ModifyArg
  #{
  #  method: 'func_70071_h_',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lmustapelto/deepmoblearning/common/entities/EntityItemGlitchFragment;getAnyInList(Ljava/util/List;Lnet/minecraft/item/ItemStack;)Lnet/minecraft/entity/item/EntityItem;',
  #    ordinal: 0
  #  },
  #  index: 1
  #}
  function replaceGold(filter as ItemStack) as ItemStack {
    return makeStack('enderio', 'item_alloy_endergy_ingot', 3);
  }

  #mixin ModifyArg
  #{
  #  method: 'func_70071_h_',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lmustapelto/deepmoblearning/common/entities/EntityItemGlitchFragment;getAnyInList(Ljava/util/List;Lnet/minecraft/item/ItemStack;)Lnet/minecraft/entity/item/EntityItem;',
  #    ordinal: 1
  #  },
  #  index: 1
  #}
  function replaceLapis(filter as ItemStack) as ItemStack {
    return makeStack('biomesoplenty', 'terrestrial_artifact', 0);
  }

  function makeStack(modid as string, path as string, meta as int) as ItemStack {
    val item = Item.REGISTRY.getObject(ResourceLocation(modid, path)) as Item;
    return ItemStack(item, 1, meta);
  }
}
