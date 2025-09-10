#modloaded jei requious
#priority 10
#reloadable

import crafttweaker.entity.IEntityItem;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

static list as IItemStack[string][IIngredient] = {} as IItemStack[string][IIngredient];

function setEx(input as IIngredient, blockID_output as IItemStack[string], catalyst as IItemStack) as void {
  list[input] = blockID_output;
  for blockID, output in blockID_output {
    scripts.jei.expire_in_block.add(input, catalyst, output);
  }
}

function set(input as IIngredient, blockID_output as IItemStack[string]) as void {
  list[input] = blockID_output;
  for blockID, output in blockID_output {
    scripts.jei.expire_in_block.add(input, itemUtils.getItem(blockID), output);
  }
}

events.onItemExpire(function (e as crafttweaker.event.ItemExpireEvent) {
  if (e.entity.world.remote) return; // Remote world
  if (isNull(e.item) || isNull(e.item.item)) return; // No item

  val item = e.item.item.anyAmount();
  for ingr, tuple in list {
    if (ingr has item) {
      val block = e.entity.world.getBlock(e.entity.position);
      if (isNull(block)
        || isNull(block.definition)
        || isNull(block.definition.id)
        || block.definition.id == 'minecraft:air'
      ) return;
      val blockID = block.definition.id;
      val output = tuple[blockID];
      if (!isNull(output)) {
        return explodeItem(e.item, output);
      }
    }
  }
});

function explodeItem(
  inputItEnt as IEntityItem, // Item that would be exploded
  output as IItemStack // New items
) as void {
  val desiredAmount = inputItEnt.item.amount * output.amount;
  utils.geyser(inputItEnt.world, output, inputItEnt.x, inputItEnt.y, inputItEnt.z, desiredAmount, 0, 0, 0, 3);
}
