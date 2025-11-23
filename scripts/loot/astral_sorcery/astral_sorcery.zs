#modloaded loottweaker

import loottweaker.LootTweaker;
import crafttweaker.item.IItemStack;
import loottweaker.vanilla.loot.Functions;
import crafttweaker.data.IData;

// Add garanteed grapple wand in some shrines
loottweaker.LootTweaker.getTable('astralsorcery:chest_shrine').addPool('astralsorcery:itemgrapplewand', 1.0f, 1.0f, 0.0f, 0.0f);
scripts.lib.loot.addLootToPool('astralsorcery:chest_shrine', 'astralsorcery:itemgrapplewand', {
 <astralsorcery:itemgrapplewand>                    : [1,0,1,1],
});
