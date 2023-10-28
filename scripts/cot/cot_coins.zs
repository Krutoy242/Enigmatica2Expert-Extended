import crafttweaker.item.IItemStack;
import mods.thermalexpansion.Compactor;
import mods.thermalexpansion.NumisticDynamo;
import crafttweaker.data.IData;

val coinMap = {
	<thermalfoundation:coin:0> : {energyData: 25000, override: true}, //Iron
	<thermalfoundation:coin:1> : {energyData: 60000, override: true}, //Gold
	<thermalfoundation:coin:64> : {energyData: 25000, override: true}, //Copper
	<thermalfoundation:coin:65> : {energyData: 25000, override: true}, //Tin
	<thermalfoundation:coin:66> : {energyData: 70000, override: true}, //Silver
	<thermalfoundation:coin:67> : {energyData: 40000, override: true}, //Lead
	<thermalfoundation:coin:68> : {energyData: 25000, override: true}, //Aluminum
	<thermalfoundation:coin:69> : {energyData: 50000, override: true}, //Nickel
	<thermalfoundation:coin:70> : {energyData: 200000, override: true}, //Platinum
	<thermalfoundation:coin:71> : {energyData: 300000, override: true}, //Iridium
	<thermalfoundation:coin:72> : {energyData: 90000, override: true}, //Mithril
	<thermalfoundation:coin:96> : {energyData: 45000, override: true}, //Steel
	<thermalfoundation:coin:97> : {energyData: 74750, override: true}, //Electrum
	<thermalfoundation:coin:98> : {energyData: 47900, override: true}, //Invar
	<thermalfoundation:coin:99> : {energyData: 28750, override: true}, //Bronze
	<thermalfoundation:coin:100> : {energyData: 43125, override: true}, //Constantan
	
	<jaopca:item_coinardite>: {energyData: 90000, override: true},
	<jaopca:item_coincobalt>: {energyData: 75000, override: true},
	<jaopca:item_coinosmium>: {energyData: 75000, override: true},
	<jaopca:item_coinuranium>: {energyData: 60000, override: true},
	<jaopca:item_cointhorium>: {energyData: 40000, override: true},
	<jaopca:item_coinlithium>: {energyData: 50000, override: true},
	<jaopca:item_coinboron>: {energyData: 40000, override: true},
	<jaopca:item_coinmagnesium>: {energyData: 50000, override: true},
	<jaopca:item_cointungsten>: {energyData: 60000, override: true},
	<jaopca:item_coinastralstarmetal>: {energyData: 45000, override: true},

	<contenttweaker:coin_advancedalloy> : {energyData: 153290, inputItem: {id:"ic2:crafting",Damage:3}},
	<contenttweaker:coin_alchemicalbrass> : {energyData: 14375, inputItem: {id:"thaumcraft:ingot",Damage:2}},
	<contenttweaker:coin_aluminumbrass> : {energyData: 14375, inputItem: {id:"tconstruct:ingots",Damage:5}},
	<contenttweaker:coin_alumite> : {energyData: 105415, inputItem: {id:"plustic:alumiteingot",Damage:0}},
	<contenttweaker:coin_baseessence> : {energyData: 38315, inputItem: {id:"mysticalagriculture:crafting",Damage:32}},
	<contenttweaker:coin_beryllium> : {energyData: 75000, inputItem: {id:"nuclearcraft:ingot",Damage:9}},
	<contenttweaker:coin_conductiveiron> : {energyData: 50000, inputItem: {id:"enderio:item_alloy_ingot",Damage:4}},
	<contenttweaker:coin_darksteel> : {energyData: 118750, inputItem: {id:"enderio:item_alloy_ingot",Damage:6}},
	<contenttweaker:coin_demonmetal> : {energyData: 70000, inputItem: {id:"extrautils2:ingredients",Damage:11}},
	<contenttweaker:coin_electricalsteel> : {energyData: 68750, inputItem: {id:"enderio:item_alloy_ingot",Damage:0}},
	<contenttweaker:coin_enchantedmetal> : {energyData: 118440, inputItem: {id:"extrautils2:ingredients",Damage:12}},
	<contenttweaker:coin_ender> : {energyData: 156250, inputItem: {id:"extendedcrafting:material",Damage:36}},
	<contenttweaker:coin_endorium> : {energyData: 187500, inputItem: {id:"endreborn:item_ingot_endorium",Damage:0}},
	<contenttweaker:coin_energizedalloy> : {energyData: 118750, inputItem: {id:"enderio:item_alloy_ingot",Damage:1}},
	<contenttweaker:coin_evilinfusedmetal> : {energyData: 371875, inputItem: {id:"extrautils2:ingredients",Damage:17}},
	<contenttweaker:coin_extremealloy> : {energyData: 459320, inputItem: {id:"nuclearcraft:alloy",Damage:10}},
	<contenttweaker:coin_fakeiron> : {energyData: 31250, inputItem: {id:"enderio:item_alloy_ingot",Damage:9}},
	<contenttweaker:coin_ferroboron> : {energyData: 59375, inputItem: {id:"nuclearcraft:alloy",Damage:6}},
	<contenttweaker:coin_fierymetal> : {energyData: 150000, inputItem: {id:"twilightforest:fiery_ingot",Damage:0}},
	<contenttweaker:coin_glowstone> : {energyData: 118750, inputItem: {id:"mekanism:ingot",Damage:3}},
	<contenttweaker:coin_graphite> : {energyData: 17500, inputItem: {id:"nuclearcraft:ingot",Damage:8}},
	<contenttweaker:coin_hardcarbon> : {energyData: 271875, inputItem: {id:"nuclearcraft:alloy",Damage:2}},
	<contenttweaker:coin_heavymetal> : {energyData: 19550, inputItem: {id:"mechanics:heavy_ingot",Damage:0}},
	<contenttweaker:coin_hopgraphite> : {energyData: 175000, inputItem: {id:"immersiveengineering:material",Damage:19}},
	<contenttweaker:coin_ironwood> : {energyData: 30000, inputItem: {id:"twilightforest:ironwood_ingot",Damage:0}},
	<contenttweaker:coin_knightmetal> : {energyData: 80000, inputItem: {id:"twilightforest:knightmetal_ingot",Damage:0}},
	<contenttweaker:coin_knightslime> : {energyData: 57500, inputItem: {id:"tconstruct:ingots",Damage:3}},
	<contenttweaker:coin_manasteel> : {energyData: 55000, inputItem: {id:"botania:manaresource",Damage:0}},
	<contenttweaker:coin_manganese> : {energyData: 100000, inputItem: {id:"nuclearcraft:ingot",Damage:11}},
	<contenttweaker:coin_manyullyn> : {energyData: 189750, inputItem: {id:"tconstruct:ingots",Damage:2}},
	<contenttweaker:coin_osgloglas> : {energyData: 577970, inputItem: {id:"plustic:osgloglasingot",Damage:0}},
	<contenttweaker:coin_osmiridium> : {energyData: 234375, inputItem: {id:"plustic:osmiridiumingot",Damage:0}},
	<contenttweaker:coin_pigiron> : {energyData: 57500, inputItem: {id:"tconstruct:ingots",Damage:4}},
	<contenttweaker:coin_pulsatingiron> : {energyData: 75000, inputItem: {id:"enderio:item_alloy_ingot",Damage:5}},
	<contenttweaker:coin_redstonealloy> : {energyData: 50000, inputItem: {id:"enderio:item_alloy_ingot",Damage:3}},
	<contenttweaker:coin_refinedobsidian> : {energyData: 234375, inputItem: {id:"mekanism:ingot",Damage:0}},
	<contenttweaker:coin_soularium> : {energyData: 90625, inputItem: {id:"enderio:item_alloy_ingot",Damage:7}},
	<contenttweaker:coin_spectre> : {energyData: 875000, inputItem: {id:"randomthings:ingredient",Damage:3}},
	<contenttweaker:coin_thaumium> : {energyData: 65000, inputItem: {id:"thaumcraft:ingot",Damage:0}},
	<contenttweaker:coin_toughalloy> : {energyData: 68360, inputItem: {id:"nuclearcraft:alloy",Damage:1}},
	<contenttweaker:coin_unstable> : {energyData: 400000, inputItem: {id:"extrautils2:unstableingots",Damage:2}},
	<contenttweaker:coin_zirconium> : {energyData: 75000, inputItem: {id:"nuclearcraft:ingot",Damage:10}}
} as IData[IItemStack]$orderly;

for coin, coinData in coinMap {
	if (coinData has "override"){
		NumisticDynamo.removeFuel(coin);
	}
	NumisticDynamo.addFuel(coin, coinData.energyData.asInt());
	if (coinData has "inputItem"){
		val ingot = itemUtils.getItem(coinData.inputItem.id.asString(), coinData.inputItem.Damage.asInt());
		if (!isNull(ingot))
			Compactor.addMintRecipe(coin * 3, ingot, 4000);
	}
}