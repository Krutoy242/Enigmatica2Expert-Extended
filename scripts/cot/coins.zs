// Used for $orderly
#modloaded zenutils thermalexpansion

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import mods.thermalexpansion.Compactor;
import mods.thermalexpansion.NumisticDynamo;

val coinMap = {
  <thermalfoundation:coin:0>  : { energyData: 25000, override: true }, // Iron
  <thermalfoundation:coin:1>  : { energyData: 55000, override: true }, // Gold
  <thermalfoundation:coin:64> : { energyData: 25000, override: true }, // Copper
  <thermalfoundation:coin:65> : { energyData: 25000, override: true }, // Tin
  <thermalfoundation:coin:66> : { energyData: 75000, override: true }, // Silver
  <thermalfoundation:coin:67> : { energyData: 40000, override: true }, // Lead
  <thermalfoundation:coin:68> : { energyData: 25000, override: true }, // Aluminum
  <thermalfoundation:coin:69> : { energyData: 50000, override: true }, // Nickel
  <thermalfoundation:coin:70> : { energyData: 200000, override: true }, // Platinum
  <thermalfoundation:coin:71> : { energyData: 300000, override: true }, // Iridium
  <thermalfoundation:coin:72> : { energyData: 100000, override: true }, // Mithril
  <thermalfoundation:coin:96> : { energyData: 45000, override: true }, // Steel
  <thermalfoundation:coin:97> : { energyData: 78000, override: true }, // Electrum
  <thermalfoundation:coin:98> : { energyData: 40000, override: true }, // Invar
  <thermalfoundation:coin:99> : { energyData: 30000, override: true }, // Bronze
  <thermalfoundation:coin:100>: { energyData: 45000, override: true }, // Constantan
  <thermalfoundation:coin:101>: { energyData: 198750, override: true }, // Signalum
  <thermalfoundation:coin:102>: { energyData: 116250, override: true }, // Lumium
  <thermalfoundation:coin:103>: { energyData: 885000, override: true }, // Enderium

  <jaopca:item_coinardite>         : { energyData: 90000, override: true },
  <jaopca:item_coincobalt>         : { energyData: 75000, override: true },
  <jaopca:item_coindraconium>      : { energyData: 225000, override: true },
  <jaopca:item_coinosmium>         : { energyData: 75000, override: true },
  <jaopca:item_coinuranium>        : { energyData: 60000, override: true },
  <jaopca:item_cointhorium>        : { energyData: 45000, override: true },
  <jaopca:item_coinlithium>        : { energyData: 55000, override: true },
  <jaopca:item_coinboron>          : { energyData: 45000, override: true },
  <jaopca:item_coinmagnesium>      : { energyData: 55000, override: true },
  <jaopca:item_cointitanium>       : { energyData: 125000, override: true },
  <jaopca:item_cointungsten>       : { energyData: 65000, override: true },
  <jaopca:item_coinastralstarmetal>: { energyData: 45000, override: true },

  <redstonerepository:material:9>: { energyData: 8060250, override: true },

  <contenttweaker:coin_advancedalloy>   : { energyData: 156000, inputItem: { id: 'ic2:crafting', Damage: 3 } },
  <contenttweaker:coin_alchemicalbrass> : { energyData: 15000, inputItem: { id: 'thaumcraft:ingot', Damage: 2 } },
  <contenttweaker:coin_aluminumbrass>   : { energyData: 30000, inputItem: { id: 'tconstruct:ingots', Damage: 5 } },
  <contenttweaker:coin_alumite>         : { energyData: 110000, inputItem: { id: 'tconstruct:ingots', Damage: 6 } },
  <contenttweaker:coin_baseessence>     : { energyData: 62530, inputItem: { id: 'mysticalagriculture:crafting', Damage: 32 } },
  <contenttweaker:coin_beryllium>       : { energyData: 75000, inputItem: { id: 'nuclearcraft:ingot', Damage: 9 } },
  <contenttweaker:coin_conductiveiron>  : { energyData: 58500, inputItem: { id: 'enderio:item_alloy_ingot', Damage: 4 } },
  <contenttweaker:coin_darksteel>       : { energyData: 123500, inputItem: { id: 'enderio:item_alloy_ingot', Damage: 6 } },
  <contenttweaker:coin_demonmetal>      : { energyData: 65000, inputItem: { id: 'extrautils2:ingredients', Damage: 11 } },
  <contenttweaker:coin_electricalsteel> : { energyData: 78000, inputItem: { id: 'enderio:item_alloy_ingot', Damage: 0 } },
  <contenttweaker:coin_enchantedmetal>  : { energyData: 127400, inputItem: { id: 'extrautils2:ingredients', Damage: 12 } },
  <contenttweaker:coin_ender>           : { energyData: 149500, inputItem: { id: 'extendedcrafting:material', Damage: 36 } },
  <contenttweaker:coin_endorium>        : { energyData: 187500, inputItem: { id: 'endreborn:item_ingot_endorium', Damage: 0 } },
  <contenttweaker:coin_energizedalloy>  : { energyData: 97500, inputItem: { id: 'enderio:item_alloy_ingot', Damage: 1 } },
  <contenttweaker:coin_evilinfusedmetal>: { energyData: 178750, inputItem: { id: 'extrautils2:ingredients', Damage: 17 } },
  <contenttweaker:coin_extremealloy>    : { energyData: 331665, inputItem: { id: 'nuclearcraft:alloy', Damage: 10 } },
  <contenttweaker:coin_fakeiron>        : { energyData: 32500, inputItem: { id: 'enderio:item_alloy_ingot', Damage: 9 } },
  <contenttweaker:coin_ferroboron>      : { energyData: 58500, inputItem: { id: 'nuclearcraft:alloy', Damage: 6 } },
  <contenttweaker:coin_fierymetal>      : { energyData: 150000, inputItem: { id: 'twilightforest:fiery_ingot', Damage: 0 } },
  <contenttweaker:coin_glowstone>       : { energyData: 136500, inputItem: { id: 'mekanism:ingot', Damage: 3 } },
  <contenttweaker:coin_graphite>        : { energyData: 30000, inputItem: { id: 'nuclearcraft:ingot', Damage: 8 } },
  <contenttweaker:coin_hardcarbon>      : { energyData: 147335, inputItem: { id: 'nuclearcraft:alloy', Damage: 2 } },
  <contenttweaker:coin_heavymetal>      : { energyData: 46500, inputItem: { id: 'mechanics:heavy_ingot', Damage: 0 } },
  <contenttweaker:coin_hopgraphite>     : { energyData: 300000, inputItem: { id: 'immersiveengineering:material', Damage: 19 } },
  <contenttweaker:coin_ironwood>        : { energyData: 15250, inputItem: { id: 'twilightforest:ironwood_ingot', Damage: 0 } },
  <contenttweaker:coin_knightmetal>     : { energyData: 80000, inputItem: { id: 'twilightforest:knightmetal_ingot', Damage: 0 } },
  <contenttweaker:coin_knightslime>     : { energyData: 60000, inputItem: { id: 'tconstruct:ingots', Damage: 3 } },
  <contenttweaker:coin_manasteel>       : { energyData: 60000, inputItem: { id: 'botania:manaresource', Damage: 0 } },
  <contenttweaker:coin_manganese>       : { energyData: 100000, inputItem: { id: 'nuclearcraft:ingot', Damage: 11 } },
  <contenttweaker:coin_manyullyn>       : { energyData: 198000, inputItem: { id: 'tconstruct:ingots', Damage: 2 } },
  <contenttweaker:coin_osgloglas>       : { energyData: 455250, inputItem: { id: 'plustic:osgloglasingot', Damage: 0 } },
  <contenttweaker:coin_osmiridium>      : { energyData: 243750, inputItem: { id: 'plustic:osmiridiumingot', Damage: 0 } },
  <contenttweaker:coin_pigiron>         : { energyData: 57500, inputItem: { id: 'tconstruct:ingots', Damage: 4 } },
  <contenttweaker:coin_pulsatingiron>   : { energyData: 91000, inputItem: { id: 'enderio:item_alloy_ingot', Damage: 5 } },
  <contenttweaker:coin_redstonealloy>   : { energyData: 58500, inputItem: { id: 'enderio:item_alloy_ingot', Damage: 3 } },
  <contenttweaker:coin_refinedobsidian> : { energyData: 243750, inputItem: { id: 'mekanism:ingot', Damage: 0 } },
  <contenttweaker:coin_soularium>       : { energyData: 87750, inputItem: { id: 'enderio:item_alloy_ingot', Damage: 7 } },
  <contenttweaker:coin_spectre>         : { energyData: 1001000, inputItem: { id: 'randomthings:ingredient', Damage: 3 } },
  <contenttweaker:coin_thaumium>        : { energyData: 65000, inputItem: { id: 'thaumcraft:ingot', Damage: 0 } },
  <contenttweaker:coin_toughalloy>      : { energyData: 73775, inputItem: { id: 'nuclearcraft:alloy', Damage: 1 } },
  <contenttweaker:coin_unstable>        : { energyData: 450000, inputItem: { id: 'extrautils2:unstableingots', Damage: 2 } },
  <contenttweaker:coin_zirconium>       : { energyData: 75000, inputItem: { id: 'nuclearcraft:ingot', Damage: 10 } },

  <contenttweaker:coin_blackiron>                : { energyData: 162670, inputItem: { id: 'extendedcrafting:material', Damage: 0 } },
  <contenttweaker:coin_cookedmeat>               : { energyData: 97500, inputItem: { id: 'tconevo:edible', Damage: 1 } },
  <contenttweaker:coin_crystallinealloy>         : { energyData: 1383010, inputItem: { id: 'enderio:item_alloy_endergy_ingot', Damage: 1 } },
  <contenttweaker:coin_crystallinepinkslimealloy>: { energyData: 3538815, inputItem: { id: 'enderio:item_alloy_endergy_ingot', Damage: 4 } },
  <contenttweaker:coin_ebonypsimetal>            : { energyData: 498750, inputItem: { id: 'psi:material', Damage: 3 } },
  <contenttweaker:coin_elementium>               : { energyData: 180000, inputItem: { id: 'botania:manaresource', Damage: 7 } },
  <contenttweaker:coin_endsteel>                 : { energyData: 218585, inputItem: { id: 'enderio:item_alloy_ingot', Damage: 8 } },
  <contenttweaker:coin_energium>                 : { energyData: 1254500, inputItem: { id: 'tconevo:metal', Damage: 35 } },
  <contenttweaker:coin_enhancedender>            : { energyData: 561750, inputItem: { id: 'extendedcrafting:material', Damage: 48 } },
  <contenttweaker:coin_essenceinfused>           : { energyData: 390000, inputItem: { id: 'tconevo:metal', Damage: 15 } },
  <contenttweaker:coin_firedragonsteel>          : { energyData: 635625, inputItem: { id: 'iceandfire:dragonsteel_fire_ingot', Damage: 0 } },
  <contenttweaker:coin_fluixsteel>               : { energyData: 335000, inputItem: { id: 'threng:material', Damage: 0 } },
  <contenttweaker:coin_fluxedelectrum>           : { energyData: 149500, inputItem: { id: 'redstonearsenal:material', Damage: 32 } },
  <contenttweaker:coin_hslasteel>                : { energyData: 41250, inputItem: { id: 'nuclearcraft:alloy', Damage: 15 } },
  <contenttweaker:coin_icedragonsteel>           : { energyData: 635625, inputItem: { id: 'iceandfire:dragonsteel_ice_ingot', Damage: 0 } },
  <contenttweaker:coin_inferium>                 : { energyData: 82530, inputItem: { id: 'mysticalagriculture:crafting', Damage: 33 } },
  <contenttweaker:coin_insanium>                 : { energyData: 5472510, inputItem: { id: 'mysticalagradditions:insanium', Damage: 2 }, coins: 15 },
  <contenttweaker:coin_intermedium>              : { energyData: 482530, inputItem: { id: 'mysticalagriculture:crafting', Damage: 35 } },
  <contenttweaker:coin_ivorypsimetal>            : { energyData: 398755, inputItem: { id: 'psi:material', Damage: 4 } },
  <contenttweaker:coin_lithiummanganesedioxide>  : { energyData: 153750, inputItem: { id: 'nuclearcraft:alloy', Damage: 4 } },
  <contenttweaker:coin_magnesiumdiboride>        : { energyData: 62835, inputItem: { id: 'nuclearcraft:alloy', Damage: 3 } },
  <contenttweaker:coin_manganesedioxide>         : { energyData: 150000, inputItem: { id: 'nuclearcraft:ingot', Damage: 15 } },
  <contenttweaker:coin_manganeseoxide>           : { energyData: 75000, inputItem: { id: 'nuclearcraft:ingot', Damage: 14 } },
  <contenttweaker:coin_melodicalloy>             : { energyData: 6799375, inputItem: { id: 'enderio:item_alloy_endergy_ingot', Damage: 2 } },
  <contenttweaker:coin_mirion>                   : { energyData: 1020000, inputItem: { id: 'plustic:mirioningot', Damage: 0 }, coins: 1 },
  <contenttweaker:coin_pinkmetal>                : { energyData: 318500, inputItem: { id: 'industrialforegoing:pink_slime_ingot', Damage: 0 } },
  <contenttweaker:coin_prudentium>               : { energyData: 162530, inputItem: { id: 'mysticalagriculture:crafting', Damage: 34 } },
  <contenttweaker:coin_psimetal>                 : { energyData: 82500, inputItem: { id: 'psi:material', Damage: 1 } },
  <contenttweaker:coin_sentient>                 : { energyData: 536250, inputItem: { id: 'tconevo:metal', Damage: 30 } },
  <contenttweaker:coin_soulium>                  : { energyData: 330000, inputItem: { id: 'mysticalagriculture:crafting', Damage: 38 } },
  <contenttweaker:coin_superium>                 : { energyData: 1762530, inputItem: { id: 'mysticalagriculture:crafting', Damage: 36 } },
  <contenttweaker:coin_supremium>                : { energyData: 6882530, inputItem: { id: 'mysticalagriculture:crafting', Damage: 37 } },
  <contenttweaker:coin_terrasteel>               : { energyData: 2480000, inputItem: { id: 'botania:manaresource', Damage: 4 } },
  <contenttweaker:coin_thermoconductingalloy>    : { energyData: 502415, inputItem: { id: 'nuclearcraft:alloy', Damage: 11 } },
  <contenttweaker:coin_uumetal>                  : { energyData: 18737235, inputItem: { id: 'tconevo:metal', Damage: 40 }, coins: 60 },
  <contenttweaker:coin_vibrantalloy>             : { energyData: 119940, inputItem: { id: 'enderio:item_alloy_ingot', Damage: 2 } },
  <contenttweaker:coin_zircaloy>                 : { energyData: 103125, inputItem: { id: 'nuclearcraft:alloy', Damage: 12 } },
  <contenttweaker:coin_zirconiummolybdenum>      : { energyData: 428910, inputItem: { id: 'nuclearcraft:alloy', Damage: 16 } },

  <contenttweaker:coin_adaminite>         : { energyData: 3600000, inputItem: { id: 'thaumadditions:adaminite_ingot', Damage: 0 } },
  <contenttweaker:coin_awakeneddraconium> : { energyData: 10009725, inputItem: { id: 'draconicevolution:draconic_ingot', Damage: 0 }, coins: 60 },
  <contenttweaker:coin_bloodglitchinfused>: { energyData: 944625, inputItem: { id: 'deepmoblearningbm:blood_infused_glitch_ingot', Damage: 0 } },
  <contenttweaker:coin_bound>             : { energyData: 622500, inputItem: { id: 'tconevo:metal', Damage: 25 } },
  <contenttweaker:coin_calcium>           : { energyData: 225000, inputItem: { id: 'qmd:ingot', Damage: 13 } },
  <contenttweaker:coin_chaoticmetal>      : { energyData: 14586905, inputItem: { id: 'tconevo:metal', Damage: 12 }, coins: 54 },
  <contenttweaker:coin_chromium>          : { energyData: 250000, inputItem: { id: 'qmd:ingot', Damage: 2 } },
  <contenttweaker:coin_crystalmatrix>     : { energyData: 2425500, inputItem: { id: 'avaritia:resource', Damage: 1 } },
  <contenttweaker:coin_crystaltine>       : { energyData: 4271210, inputItem: { id: 'extendedcrafting:material', Damage: 24 } },
  <contenttweaker:coin_doublesmore>       : { energyData: 184255, inputItem: { id: 'nuclearcraft:moresmore', Damage: 0 } },
  <contenttweaker:coin_draconicmetal>     : { energyData: 11628115, inputItem: { id: 'tconevo:metal', Damage: 5 }, coins: 9 },
  <contenttweaker:coin_elektron60>        : { energyData: 185625, inputItem: { id: 'contenttweaker:elektron60_ingot', Damage: 0 } },
  <contenttweaker:coin_gaiaspirit>        : { energyData: 7920000, inputItem: { id: 'botania:manaresource', Damage: 14 } },
  <contenttweaker:coin_glitchinfused>     : { energyData: 825000, inputItem: { id: 'deepmoblearning:glitch_infused_ingot', Damage: 0 } },
  <contenttweaker:coin_hafnium>           : { energyData: 275000, inputItem: { id: 'qmd:ingot', Damage: 6 } },
  <contenttweaker:coin_infinity>          : { energyData: 9999999 },
  <contenttweaker:coin_mithminite>        : { energyData: 9900000, inputItem: { id: 'thaumadditions:mithminite_ingot', Damage: 0 } },
  <contenttweaker:coin_mithrillium>       : { energyData: 2400000, inputItem: { id: 'thaumadditions:mithrillium_ingot', Damage: 0 } },
  <contenttweaker:coin_neodymium>         : { energyData: 450000, inputItem: { id: 'qmd:ingot2', Damage: 1 } },
  <contenttweaker:coin_neutronium>        : { energyData: 7500000, inputItem: { id: 'avaritia:resource', Damage: 4 } },
  <contenttweaker:coin_nichrome>          : { energyData: 225000, inputItem: { id: 'qmd:ingot_alloy', Damage: 5 } },
  <contenttweaker:coin_niobium>           : { energyData: 350000, inputItem: { id: 'qmd:ingot', Damage: 1 } },
  <contenttweaker:coin_niobiumtin>        : { energyData: 403125, inputItem: { id: 'qmd:ingot_alloy', Damage: 1 } },
  <contenttweaker:coin_niobiumtitanium>   : { energyData: 356250, inputItem: { id: 'qmd:ingot_alloy', Damage: 3 } },
  <contenttweaker:coin_potassium>         : { energyData: 165000, inputItem: { id: 'qmd:ingot', Damage: 12 } },
  <contenttweaker:coin_primalmetal>       : { energyData: 1200000, inputItem: { id: 'tconevo:metal', Damage: 20 } },
  <contenttweaker:coin_foursmore>         : { energyData: 284430, inputItem: { id: 'nuclearcraft:foursmore', Damage: 0 } },
  <contenttweaker:coin_smore>             : { energyData: 76800, inputItem: { id: 'nuclearcraft:smore', Damage: 0 } },
  <contenttweaker:coin_sodium>            : { energyData: 165000, inputItem: { id: 'qmd:ingot', Damage: 11 } },
  <contenttweaker:coin_stainlesssteel>    : { energyData: 125000, inputItem: { id: 'qmd:ingot_alloy', Damage: 2 } },
  <contenttweaker:coin_stellaralloy>      : { energyData: 7005420, inputItem: { id: 'enderio:item_alloy_endergy_nugget', Damage: 3 }, coins: 30 },
  <contenttweaker:coin_strontium>         : { energyData: 375000, inputItem: { id: 'qmd:ingot', Damage: 14 } },
  <contenttweaker:coin_superalloy>        : { energyData: 443440, inputItem: { id: 'qmd:ingot_alloy', Damage: 6 } },
  <contenttweaker:coin_titaniumaluminide> : { energyData: 151250, inputItem: { id: 'advancedrocketry:productingot', Damage: 0 } },
  <contenttweaker:coin_titaniumiridium>   : { energyData: 175315, inputItem: { id: 'advancedrocketry:productingot', Damage: 1 } },
  <contenttweaker:coin_tungstencarbide>   : { energyData: 61750, inputItem: { id: 'qmd:ingot_alloy', Damage: 0 } },
  <contenttweaker:coin_ultimate>          : { energyData: 5703170, inputItem: { id: 'extendedcrafting:material', Damage: 33 }, coins: 60 },
  <contenttweaker:coin_vividalloy>        : { energyData: 6252585, inputItem: { id: 'enderio:item_alloy_endergy_ingot', Damage: 6 } },
  <contenttweaker:coin_voidmetal>         : { energyData: 600000, inputItem: { id: 'thaumcraft:ingot', Damage: 1 } },
  <contenttweaker:coin_wyvernmetal>       : { energyData: 4859250, inputItem: { id: 'tconevo:metal', Damage: 0 } },
  <contenttweaker:coin_yttrium>           : { energyData: 450000, inputItem: { id: 'qmd:ingot2', Damage: 0 } },
  <contenttweaker:coin_zinc>              : { energyData: 225000, inputItem: { id: 'qmd:ingot', Damage: 7 } },
} as IData[IItemStack]$orderly;

for coin, coinData in coinMap {
  if (coinData has 'override') {
    NumisticDynamo.removeFuel(coin);
  }
  NumisticDynamo.addFuel(coin, coinData.energyData.asInt());
  if (coinData has 'inputItem') {
    val ingot = itemUtils.getItem(coinData.inputItem.id.asString(), coinData.inputItem.Damage.asInt());
    if (!isNull(ingot)) {
      if (coinData has 'coins') {
        Compactor.addMintRecipe(coin * coinData.coins.asInt(), ingot, 4000);
      }
      else {
        Compactor.addMintRecipe(coin * 3, ingot, 4000);
      }
    }
  }
}

// now only usable as gem
NumisticDynamo.removeFuel(<minecraft:emerald>);

// will be rehandled by new gem fuel
NumisticDynamo.removeGemFuel(<tconstruct:metal:6>);
NumisticDynamo.removeGemFuel(<biomesoplenty:gem:7>);

val gemMap = {
  <biomesoplenty:gem:3>: { override: true, energyData: 500000, blockItem: { id: 'biomesoplenty:gem', Damage: 3 }}, // Topaz
  <biomesoplenty:gem:5>: { override: true, energyData: 500000, blockItem: { id: 'biomesoplenty:gem', Damage: 5 }}, // Malachite
  <biomesoplenty:gem:4>: { override: true, energyData: 650000, blockItem: { id: 'biomesoplenty:gem', Damage: 4 }}, // Tanzanite
  <biomesoplenty:gem:6>: { override: true, energyData: 500000, blockItem: { id: 'biomesoplenty:gem', Damage: 6 }}, // Sapphire
  <biomesoplenty:gem:2>: { override: true, energyData: 500000, blockItem: { id: 'biomesoplenty:gem', Damage: 2 }}, // Peridot
  <biomesoplenty:gem:1>: { override: true, energyData: 500000, blockItem: { id: 'biomesoplenty:gem', Damage: 1 }}, // Ruby
  <biomesoplenty:gem:0>: { override: true, energyData: 900000, blockItem: { id: 'biomesoplenty:gem', Damage: 0 }}, // Amethyst

  <appliedenergistics2:material:1>       : { override: true, energyData: 100000}, // Charged Certus Quartz
  <minecraft:emerald>                    : { override: true, energyData: 85000, blockItem: { id: 'minecraft:emerald_block', Damage: 0 }}, // Emerald
  <actuallyadditions:item_misc:5>        : { override: true, energyData: 90000, blockItem: { id: 'actuallyadditions:block_misc', Damage: 2 }}, // Black Quartz
  <minecraft:quartz>                     : { override: true, energyData: 55000, blockItem: { id: 'minecraft:quartz_block', Damage: 0 }, blockModifier: 5}, // Nether Quartz
  <minecraft:diamond>                    : { override: true, energyData: 500000, blockItem: { id: 'minecraft:diamond_block', Damage: 0 }}, // Diamond
  <appliedenergistics2:material:10>      : { override: true, energyData: 50625}, // Pure Certus Quartz
  <tconstruct:materials:16>              : { override: true, energyData: 900000, blockItem: { id: 'tconstruct:metal', Damage: 6 }}, // Silky Jewel
  <appliedenergistics2:material:0>       : { override: true, energyData: 75000, blockItem: { id: 'appliedenergistics2:quartz_block', Damage: 0 }, blockModifier: 5}, // Certus Quartz
  <forestry:apatite>                     : { override: true, energyData: 25000, blockItem: { id: 'forestry:resource_storage', Damage: 0 }}, // Apatite
  <redstonearsenal:material:0>           : { override: true, energyData: 306670, blockItem: { id: 'redstonearsenal:storage', Damage: 0 }}, // Flux Crystal
  <thaumcraft:amber>                     : { override: true, energyData: 55000, blockItem: { id: 'thaumcraft:amber_block', Damage: 0 }}, // Amber
  <astralsorcery:itemcraftingcomponent:0>: { override: true, energyData: 45000, blockItem: { id: 'jaopca:block_aquamarine', Damage: 0 }}, // Aquamarine
  <minecraft:prismarine_shard>           : { override: true, energyData: 90000, blockItem: { id: 'minecraft:prismarine', Damage: 0 }, blockModifier: 5}, // Prismarine Shard
  <darkutils:shulker_pearl>              : { override: true, energyData: 50000 }, // Shulker Pearl
  <minecraft:dye:4>                      : { override: true, energyData: 60000, blockItem: { id: 'minecraft:lapis_block', Damage: 0 }}, // Lapis Lazuli

  <appliedenergistics2:material:7> : { energyData: 87500, blockItem: { id: 'appliedenergistics2:fluix_block', Damage: 0 }}, // Fluix
  <appliedenergistics2:material:12>: { energyData: 59065 }, // Pure Fluix
  <appliedenergistics2:material:11>: { energyData: 37125 }, // Pure Quartz
  <rats:rat_diamond>               : { energyData: 166670 }, // Rat Diamond
  <mysticalagriculture:crafting:5> : { energyData: 400000, blockItem: { id: 'mysticalagriculture:storage', Damage: 5 }}, // Prosperity Shard
  <nuclearcraft:gem:5>             : { energyData: 320000}, // Boron Arsenide

  <enderio:item_material:14>: { energyData: 546000}, // Pulsating Crystal
  <enderio:item_material:15>: { energyData: 759815}, // Vibrant Crystal
  <enderio:item_material:16>: { energyData: 1329675}, // Ender Crystal
  <enderio:item_material:17>: { energyData: 200000}, // Enticing Crystal
  <enderio:item_material:18>: { energyData: 4926630}, // Weather Crystal
  <enderio:item_material:19>: { energyData: 1709585}, // Prescient Crystal

  <libvulpes:productgem:0>: { energyData: 750000, blockItem: { id: 'jaopca:block_dilithium', Damage: 0 }}, // Dilithium

  <botania:manaresource:2>: { energyData: 333335, blockItem: { id: 'botania:storage', Damage: 3 }}, // Mana Diamond
  <botania:manaresource:9>: { energyData: 500000, blockItem: { id: 'botania:storage', Damage: 4 }}, // Dragonstone

  <environmentaltech:litherite_crystal>  : { energyData: 500000, blockItem: { id: 'environmentaltech:litherite', Damage: 0 }}, // Litherite
  <environmentaltech:erodium_crystal>    : { energyData: 550000, blockItem: { id: 'environmentaltech:erodium', Damage: 0 }}, // Erodium
  <environmentaltech:kyronite_crystal>   : { energyData: 600000, blockItem: { id: 'environmentaltech:kyronite', Damage: 0 }}, // Kyronite
  <environmentaltech:litherite_crystal>  : { energyData: 675000, blockItem: { id: 'environmentaltech:pladium', Damage: 0 }}, // Pladium
  <environmentaltech:ionite_crystal>     : { energyData: 800000, blockItem: { id: 'environmentaltech:ionite', Damage: 0 }}, // Ionite
  <environmentaltech:aethium_crystal>    : { energyData: 1000000, blockItem: { id: 'environmentaltech:aethium', Damage: 0 }}, // Aethium
  <environmentaltech:lonsdaleite_crystal>: { energyData: 700000, blockItem: { id: 'environmentaltech:lonsdaleite', Damage: 0 }}, // Lonsdaleite

  <extrautils2:suncrystal>               : { energyData: 735940}, // Sun Crystal
  <astralsorcery:itemcraftingcomponent:4>: { energyData: 112500}, // Resonant Gem
  <redstonerepository:material:5>        : { energyData: 112500, blockItem: { id: 'redstonerepository:storage', Damage: 1 }}, // Gelid Crystal
  <rats:gem_of_ratlantis>                : { energyData: 114750}, // Gem of Ratlantis
  <psi:material:2>                       : { energyData: 675000, blockItem: { id: 'psi:decorative', Damage: 2 }}, // Psigem
  <biomesoplenty:crystal_shard>          : { energyData: 105080, blockItem: { id: 'biomesoplenty:crystal', Damage: 0 }, blockModifier: 5}, // Celestial Crystal
  <endreborn:item_lormyte_crystal>       : { energyData: 45000, blockItem: { id: 'endreborn:block_decorative_lormyte', Damage: 0 }}, // Lormyte

  <nuclearcraft:gem:0>: { energyData: 250000}, // Rhodochrosite
  <nuclearcraft:gem:1>: { energyData: 300000}, // Boron Nitride
  <nuclearcraft:gem:2>: { energyData: 225000}, // Fluorite
  <nuclearcraft:gem:3>: { energyData: 250000}, // Villiaumite
  <nuclearcraft:gem:4>: { energyData: 250000}, // Carobbiite

  <actuallyadditions:item_crystal:0>          : { energyData: 25000, blockItem: { id: 'actuallyadditions:block_crystal', Damage: 0 }}, // Restonia Crystal
  <actuallyadditions:item_crystal:1>          : { energyData: 75000, blockItem: { id: 'actuallyadditions:block_crystal', Damage: 1 }}, // Palis Crystal
  <actuallyadditions:item_crystal:2>          : { energyData: 625000, blockItem: { id: 'actuallyadditions:block_crystal', Damage: 2 }}, // Diamatine Crystal
  <actuallyadditions:item_crystal:3>          : { energyData: 112500, blockItem: { id: 'actuallyadditions:block_crystal', Damage: 3 }}, // Void Crystal
  <actuallyadditions:item_crystal:4>          : { energyData: 106250, blockItem: { id: 'actuallyadditions:block_crystal', Damage: 4 }}, // Emeradic Crystal
  <actuallyadditions:item_crystal:5>          : { energyData: 93750, blockItem: { id: 'actuallyadditions:block_crystal', Damage: 5 }}, // Enori Crystal
  <actuallyadditions:item_crystal_empowered:0>: { energyData: 203890, blockItem: { id: 'actuallyadditions:block_crystal_empowered', Damage: 0 }, blockModifier: 9}, // Restonia Crystal Empowered
  <actuallyadditions:item_crystal_empowered:1>: { energyData: 333335, blockItem: { id: 'actuallyadditions:block_crystal_empowered', Damage: 1 }, blockModifier: 9}, // Palis Crystal Empowered
  <actuallyadditions:item_crystal_empowered:2>: { energyData: 1030815, blockItem: { id: 'actuallyadditions:block_crystal_empowered', Damage: 2 }, blockModifier: 9}, // Diamatine Crystal Empowered
  <actuallyadditions:item_crystal_empowered:3>: { energyData: 1715500, blockItem: { id: 'actuallyadditions:block_crystal_empowered', Damage: 3 }, blockModifier: 9}, // Void Crystal Empowered
  <actuallyadditions:item_crystal_empowered:4>: { energyData: 367920, blockItem: { id: 'actuallyadditions:block_crystal_empowered', Damage: 4 }, blockModifier: 9}, // Emeradic Crystal Empowered
  <actuallyadditions:item_crystal_empowered:5>: { energyData: 282640, blockItem: { id: 'actuallyadditions:block_crystal_empowered', Damage: 5 }, blockModifier: 9}, // Enori Crystal Empowered

  <scalinghealth:crystalshard>        : { energyData: 175000}, // Heart Crystal Shard
  <minecraft:prismarine_crystals>     : { energyData: 95000}, // Prismarine Crystals
  <biomesoplenty:terrestrial_artifact>: { energyData: 1321365, blockItem: { id: 'contenttweaker:terrestrial_artifact_block', Damage: 0 }, blockModifier: 9}, // Terrestrial Artifact
  <threng:material:5>                 : { energyData: 2432955}, // Resonating Crystal

} as IData[IItemStack]$orderly;

for gem, gemData in gemMap {
  if (gemData has 'override') {
    NumisticDynamo.removeGemFuel(gem);
  }
  NumisticDynamo.addGemFuel(gem, gemData.energyData.asInt());
  if (gemData has 'blockItem') {
    val gemBlock = itemUtils.getItem(gemData.blockItem.id.asString(), gemData.blockItem.Damage.asInt());
    if (!isNull(gemBlock)) {
      if (gemData has 'blockModifier') {
        NumisticDynamo.addGemFuel(gemBlock, gemData.energyData.asInt() * gemData.blockModifier.asInt());
      }
      else {
        NumisticDynamo.addGemFuel(gemBlock, gemData.energyData.asInt() * 10);
      }
    }
  }
}
