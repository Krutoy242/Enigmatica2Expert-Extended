#modloaded loottweaker twilightforest
#ignoreBracketErrors

import loottweaker.LootTweaker;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;

// Add Little Blueprints to Aurora caches
scripts.lib.loot.addLootToPool('twilightforest:structures/aurora_cache/common', 'main', {
 <littletiles:recipeadvanced>      : [1,0,2,6],
});
scripts.lib.loot.addLootToPool('twilightforest:structures/aurora_room/common', 'main', {
 <littletiles:recipeadvanced>      : [1,0,2,6],
});
