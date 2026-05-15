#modloaded twilightforest
#reloadable

import crafttweaker.item.IItemStack;
import native.net.minecraft.item.ItemStack;
import native.net.minecraftforge.oredict.OreDictionary;
import native.twilightforest.inventory.ContainerTFUncrafting;

scripts.mixin.twilightforest.shared.Op.validateUncraft = function (
  input as ItemStack,
  ingredients as ItemStack[]
) as void {
  val inputCT = input.wrapper as IItemStack;

  // Build 3x3 crafting grid from uncrafting ingredients (null = empty slot)
  val grid = [
    [
      !ingredients[0].isEmpty() ? ingredients[0].wrapper : null,
      !ingredients[1].isEmpty() ? ingredients[1].wrapper : null,
      !ingredients[2].isEmpty() ? ingredients[2].wrapper : null,
    ],
    [
      !ingredients[3].isEmpty() ? ingredients[3].wrapper : null,
      !ingredients[4].isEmpty() ? ingredients[4].wrapper : null,
      !ingredients[5].isEmpty() ? ingredients[5].wrapper : null,
    ],
    [
      !ingredients[6].isEmpty() ? ingredients[6].wrapper : null,
      !ingredients[7].isEmpty() ? ingredients[7].wrapper : null,
      !ingredients[8].isEmpty() ? ingredients[8].wrapper : null,
    ],
  ] as IItemStack[][];

  // Try to find a crafting recipe that produces output from this grid
  val result = recipes.craft(grid);
  if (
    isNull(result)
    || result.definition.id != inputCT.definition.id
    || result.metadata != inputCT.metadata
    || !(inputCT.tag has result.tag)
  ) {
    // Make all outputs red (unavailable)
    for stack in ingredients {
      if (!stack.isEmpty()) {
        ContainerTFUncrafting.markStack(stack);
      }
    }
    return;
  }

  // Forbid to receive same item stack as output
  for stack in ingredients {
    if (
      !stack.isEmpty()
      && stack.item == input.item
            && (stack.itemDamage == OreDictionary.WILDCARD_VALUE || stack.itemDamage == input.itemDamage)
        ) {
      ContainerTFUncrafting.markStack(stack);
    }
  }
};
