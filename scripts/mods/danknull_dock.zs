#reloadable
#modloaded danknull extendedcrafting
#priority -1

import crafttweaker.event.PlayerInteractBlockEvent;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;

import scripts.lib.tellraw.itemObj;

static catalystRequirments as IIngredient[] = [
  <extendedcrafting:material:8>,
  <extendedcrafting:material:9>,
  <extendedcrafting:material:10>,
  <extendedcrafting:material:11>,
  <extendedcrafting:material:12>,
  <extendedcrafting:material:13>,
] as IIngredient[];

for i, catalyst in catalystRequirments {
  recipes.addShapeless('danknull_catalyst_'~i,
    <danknull:danknull_dock>.withTag({
      BlockEntityTag: {
        id: 'danknull:danknull_dock',
        DankNullStack: {
          id: 'danknull:dank_null_'~i,
          Count: 1,
          Damage: 0 as short,
        },
      },
    }),
    [<danknull:danknull_dock>, itemUtils.getItem('danknull:dank_null_'~i).marked('m'), catalyst]
  , function(out, ins, cInfo) {
    return out.withTag(out.tag.deepUpdate(
        {BlockEntityTag:{DankNullStack:{tag: ins.m.tag}}},
        mods.zenutils.DataUpdateOperation.MERGE
      )
    );
  }, 
  null);
}

# Consuming item mechanic
events.onPlayerInteractBlock(function(e as PlayerInteractBlockEvent) {
  val world = e.world;
  if(world.remote || e.canceled) return;

  // Not danknull
  if(isNull(e.block) || !(e.block.definition.id == "danknull:danknull_dock")) return;

  // Determine if we taking Dank Null out or Putting it in
  if(e.player.isSneaking) return attemptToTakeOff(e);
  return attemptToPutIn(e);
});

function attemptToPutIn(e as PlayerInteractBlockEvent) as void {
  // Creative players can do everything
  if (e.player.creative) return;

  val item = e.player.currentItem;
  if(
    isNull(item) 
    || !item.definition.id.startsWith('danknull:dank_null_')
  ) return;
  
  val requiredItem =getRequiredItem(item);
  if(isNull(requiredItem)) return;

  val itemInInv = getItemInInventory(e.player, requiredItem);
  if(isNull(itemInInv)) {
    e.player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromData([{
      translate: 'e2ee.danknull_dock.must_have',
      with: [
        itemObj(requiredItem.items[0], 'white'),
        itemObj(item),
        itemObj(e.block.getItem(e.world, null, null), 'white'),
      ]
    }]));
    return e.cancel();
  }

  itemInInv.mutable().shrink(1);
}

function attemptToTakeOff(e as PlayerInteractBlockEvent) as void {
  if (!isNull(e.player.mainHandHeldItem) || !isNull(e.player.offHandHeldItem)) return;

  val d = D(e.block.data);
  val id = d.getString('DankNullStack.id');
  if(isNull(id)) return;

  val dankInside = itemUtils.getItem(id, d.getShort('DankNullStack.Damage', 0));
  if(isNull(dankInside)) return;

  val requiredItem = getRequiredItem(dankInside);
  if(isNull(requiredItem)) return;
  e.player.give(requiredItem.items[0]);
}

function getRequiredItem(dankNullItem as IItemStack) as IIngredient {
	val dankTier = dankNullItem.definition.id.substring('danknull:dank_null_'.length) as int;
  if(dankTier < 0 || dankTier > 5) return null;
  return catalystRequirments[dankTier];
}

function getItemInInventory(player as IPlayer, ingr as IIngredient) as IItemStack {
  for i in 0 .. player.inventorySize {
    val item = player.getInventoryStack(i);
    if(isNull(item) || !ingr.matches(item)) continue;
    return item;
  }
  return null;
}
