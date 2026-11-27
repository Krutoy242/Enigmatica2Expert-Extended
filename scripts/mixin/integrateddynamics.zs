#modloaded integrateddynamics
#loader mixin

import mixin.CallbackInfo;
import mixin.Operation;
import native.java.lang.Object;
import native.java.lang.Integer;
import native.java.util.Collection;
import native.java.util.Collections;
import native.java.util.Map.Entry;
import native.net.minecraft.item.ItemStack;
import native.org.cyclops.commoncapabilities.api.ingredient.IngredientComponent;
import native.org.cyclops.cyclopscore.ingredient.collection.IIngredientMapMutable;

/*
  A pending storage scan can stall the server thread for up to a second.
  Check without waiting and retry on a later tick if the scan is still running.
*/
#mixin { targets: 'org.cyclops.integrateddynamics.core.network.IngredientObserver' }
zenClass MixinIngredientObserver {
  #mixin ModifyArg
  #{
  #  method: 'observe()Z',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Ljava/util/concurrent/Future;get(JLjava/util/concurrent/TimeUnit;)Ljava/lang/Object;'
  #  },
  #  index: 0,
  #  require: 1
  #}
  function pollPreviousObservation(timeout as long) as long {
    return 0;
  }
}

/*
  Bulk crafting copies and hashes the entire ingredient index for repeated lookups.
  Use direct lookup for exact matches and cache up to 64 item queries.
  Discard cached positions whenever the index adds or removes a storage position.
*/
#mixin { targets: 'org.cyclops.integrateddynamics.core.network.IngredientPositionsIndex' }
zenClass MixinIngredientPositionsIndex {
  var craftingPerfLookupStacks as [ItemStack];
  var craftingPerfLookupFlags as [int];
  var craftingPerfLookupResults as [Collection];

  #mixin Inject { method: ['addPosition', 'removePosition'], at: { value: 'HEAD' }, require: 1 }
  function invalidatePositionLookup(ci as CallbackInfo) as void {
    this.craftingPerfLookupStacks = null;
    this.craftingPerfLookupFlags = null;
    this.craftingPerfLookupResults = null;
  }

  #mixin WrapOperation
  #{
  #  method: 'getPositions',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lorg/cyclops/cyclopscore/ingredient/collection/IIngredientMapMutable;getAll(Ljava/lang/Object;Ljava/lang/Object;)Ljava/util/Collection;'
  #  },
  #  require: 1
  #}
  function reusePositionLookup(index as IIngredientMapMutable, prototype as Object, condition as Object, original as Operation) as Collection {
    if (index.getComponent() != IngredientComponent.ITEMSTACK) return original.call(index, prototype, condition);

    // 7: item, metadata and NBT; 15: also quantity.
    val flags = condition as Integer as int;
    if (flags != 7 && flags != 15) return original.call(index, prototype, condition);
    val stack = prototype as ItemStack;
    if (stack.func_190926_b()) return original.call(index, prototype, condition);

    if (isNull(this.craftingPerfLookupStacks)) {
      this.craftingPerfLookupStacks = [] as [ItemStack];
      this.craftingPerfLookupFlags = [] as [int];
      this.craftingPerfLookupResults = [] as [Collection];
    }

    for i in 0 .. this.craftingPerfLookupStacks.length {
      // Keep wildcard and concrete queries in separate cache entries.
      if (this.craftingPerfLookupFlags[i] == flags && ItemStack.func_77989_b(stack, this.craftingPerfLookupStacks[i])) {
        return this.craftingPerfLookupResults[i];
      }
    }

    var result = Collections.emptyList() as Collection;
    if (flags == 15) {
      val positions = index.get(prototype);
      if (!isNull(positions)) result = Collections.singletonList(positions) as Collection;
    }
    else {
      val matcher = index.getComponent().getMatcher();
      val entries = index.iterator();
      var matchedKey as Object = null;
      var ambiguous = false;
      while entries.hasNext() {
        val entry = entries.next() as Entry;
        val key = entry.getKey();
        if (matcher.matches(prototype, key, condition)) {
          if (!isNull(matchedKey)) {
            ambiguous = true;
            break;
          }
          matchedKey = key;
        }
      }
      // Preserve extraction order when several prototypes match.
      if (ambiguous) result = original.call(index, prototype, condition) as Collection;
      else if (!isNull(matchedKey)) result = Collections.singletonList(index.get(matchedKey)) as Collection;
    }
    if (this.craftingPerfLookupStacks.length >= 64) {
      this.craftingPerfLookupStacks.clear();
      this.craftingPerfLookupFlags.clear();
      this.craftingPerfLookupResults.clear();
    }
    this.craftingPerfLookupStacks.add(stack.func_77946_l());
    this.craftingPerfLookupFlags.add(flags);
    this.craftingPerfLookupResults.add(result);
    return result;
  }
}
