#modloaded immersiveengineering alfinivia redstonearsenal

import mods.alfinivia.ImmersiveEngineering.addChemthrowerEffect;
import mods.alfinivia.ImmersiveEngineering.addRailgunBullet;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.potions.IPotionEffect;

// *======= Railgun rods =======*

// addRailgunBullet(IIngredient item, float damage, float gravity, int[][] colorMap)
// addRailgunBullet(IIngredient item, float damage, float gravity, IRailgunImpact effect, int[][] colorMap)

/* Patchouli_js('Items/Railgui Bullets', paged({
	item: 'immersiveengineering:railgun',
	title: 'New Railgui Bullets',
	type:  'item_list',
},[
	[undefined, ' Damage  |  Gravity'],
  ...match_regex_below(/^addRailgunBullet\(<(.*?)> *, *(.*?), *(.*?), *.*\);/gm)
  .sort((a,b)=>b[2]-a[2])
  .map(m=>[m[1], ` ${m[2].padStart(6)}    |   ${m[3].padStart(4)}`])
])) */

val colorMap = [[0x777777, 0xA4A4A4]] as int[][];
addRailgunBullet(<ore:stickCopper>             , 21, 1.1, colorMap);
addRailgunBullet(<ore:stickTitanium>           , 30, 1.15,colorMap);
addRailgunBullet(<ore:stickTitaniumAluminide>  , 33, 0.9, colorMap);
addRailgunBullet(<redstonearsenal:material:193>, 32, 1.2, colorMap); // Flux-Infused Obsidian Rod
addRailgunBullet(<ore:stickIridium>            , 36, 1.15,colorMap);
addRailgunBullet(<ic2:crafting:29>,              28, 0.8, colorMap); // Shaft (Iron)
addRailgunBullet(<ic2:crafting:42>,              34, 0.8, colorMap); // Shaft (Bronze)
addRailgunBullet(<ic2:crafting:30>,              40, 0.8, colorMap); // Shaft (Steel)
addRailgunBullet(<ore:stickTitaniumIridium>    , 44, 0.8, colorMap);
addRailgunBullet(<extendedcrafting:material:3> , 48, 1.0, colorMap);

// *======= Fertilizers =======*

// addLiquidFertilizer(ILiquidStack liquid, float multiplier)
// addLiquidFertilizer(ILiquidStack liquid, IFluidFertilizerMultiplier multiplier)
// removeLiquidFertilizer(ILiquidStack liquid)
// addItemFertilizer(IIngredient item, float multiplier)
// addItemFertilizer(IIngredient item, IItemFertilizerMultiplier multiplier)
// removeItemFertilizer(IItemStack item)

function addLiquidFertilizer(fluid as ILiquidStack, mult as float) {
  if (fluid.name != 'water') mods.alfinivia.ImmersiveEngineering.addLiquidFertilizer(fluid, mult);
  scripts.jei.mod.immersiveengineering.addGardenClocheFluid(fluid, mult);
}

addLiquidFertilizer(<liquid:water>                , 0.20);
addLiquidFertilizer(<liquid:meat>                 , 0.40);
addLiquidFertilizer(<liquid:sewage>               , 0.45);
addLiquidFertilizer(<liquid:for.honey>            , 0.50);
addLiquidFertilizer(<liquid:short.mead>           , 0.60);
addLiquidFertilizer(<liquid:lifeessence>          , 0.65);
addLiquidFertilizer(<liquid:nutrient_distillation>, 1.20);
addLiquidFertilizer(<liquid:vapor_of_levity>      , 2.00);

// *======= Chemical Thrower liquids =======*

// addChemthrowerEffect(ILiquidStack liquid, boolean isGas, boolean isFlammable, String source, float damage);
// addChemthrowerEffect(ILiquidStack liquid, boolean isGas, boolean isFlammable, String source, float damage, IPotionEffect[] effects)
// addChemthrowerEffect(ILiquidStack liquid, boolean isGas, boolean isFlammable, IChemEntityEffect entityEffect, IChemBlockEffect blockEffect)

/* Patchouli_js('Liquids/Chemical Thrower', {
	icon: "immersiveengineering:chemthrower",
	title: "New Chemicals",
	_text: `
		Many liquids can be used in $(l)Chemical Thrower/$ as ammo.
		$(li)$(#727900)Strong Radiation/$ liquids have low damage, but gave Radiation III effect for 1-6 minutes
		$(li)$(#C01B1B)High damage/$ only do big amount of damage
		$(li)$(#957143)Flammable/$ set things on fire
		$(li)$(#25A2AB)Potion effects/$ damages and adds effects
		$(li)$(#3F1B10)Chocolates/$ gives several strong positive effects
	`,
}) */

// ----------------------------------------
// ☢️ Strong radiation
/* Patchouli_js('Liquids/Chemical Thrower', {
	title: "Strong radiation",
	type:  "grid",
	...match_block_below(/^addChemthrowerEffect\(<liquid:(.+?)>/gm)
    .reduce((o, m, i) => Object.assign(o, {
      [`item${i}`]: wrap_bucket(m[1])
    }),{}),
}) */
addChemthrowerEffect(<liquid:californium_250>, false, false, 'chemicals' , 2, [<potion:ic2:radiation>.makePotionEffect(130, 2, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:plutonium_241>  , false, false, 'chemicals' , 2, [<potion:ic2:radiation>.makePotionEffect(120, 2, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:curium_243>     , false, false, 'chemicals' , 2, [<potion:ic2:radiation>.makePotionEffect(110, 2, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:plutonium_238>  , false, false, 'chemicals' , 2, [<potion:ic2:radiation>.makePotionEffect(90, 2, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:americium_242>  , false, false, 'chemicals' , 2, [<potion:ic2:radiation>.makePotionEffect(80, 2, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:berkelium_248>  , false, false, 'chemicals' , 2, [<potion:ic2:radiation>.makePotionEffect(60, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:californium_249>, false, false, 'chemicals' , 2, [<potion:ic2:radiation>.makePotionEffect(50, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:americium_241>  , false, false, 'chemicals' , 2, [<potion:ic2:radiation>.makePotionEffect(40, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:californium_251>, false, false, 'chemicals' , 2, [<potion:ic2:radiation>.makePotionEffect(30, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:berkelium_247>  , false, false, 'chemicals' , 2, [<potion:ic2:radiation>.makePotionEffect(20, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:curium_246>     , false, false, 'chemicals' , 2, [<potion:ic2:radiation>.makePotionEffect(10, 1, false, true)] as IPotionEffect[]);

// ----------------------------------------
// ⚡ Just high damage liquids
/* Patchouli_js('Liquids/Chemical Thrower', {
	title: "High Damage",
	type:  "grid_description",
	...match_block_below(/^addChemthrowerEffect\(<liquid:(.+?)>.*?(\d+)\);$/gm)
    .sort((a,b)=>b[2]-a[2]).reduce((o, m, i) => Object.assign(o, {
      [`item${i}`]: wrap_bucket(m[1]),
      [`text${i}`]: m[2],
    }),{}),
}) */
addChemthrowerEffect(<liquid:ic2superheated_steam> ,true , false, 'chemicals', 14);
addChemthrowerEffect(<liquid:ic2uu_matter>         ,false, false, 'ic2uu_matter', 50);
addChemthrowerEffect(<liquid:ic2hot_coolant>       ,false, false, 'chemicals', 11);
addChemthrowerEffect(<liquid:crystal>              ,false, false, 'chemicals', 20);
addChemthrowerEffect(<liquid:plasma>               ,true , false, 'chemicals', 28);
addChemthrowerEffect(<liquid:liquid_death>         ,false, false, 'chemicals', 30);
addChemthrowerEffect(<liquid:high_pressure_mercury>,true , false, 'chemicals', 68);
addChemthrowerEffect(<liquid:neutronium>           ,false, false, 'chemicals', 360);

// ----------------------------------------
// 🔥 Flammable fuels that only do damage
/* Patchouli_js('Liquids/Chemical Thrower', {
	title: "Flammable",
	type:  "grid_description",
	...match_block_below(/^addChemthrowerEffect\(<liquid:(.+?)>.*?(\d+)\);$/gm)
    .sort((a,b)=>b[2]-a[2]).reduce((o, m, i) => Object.assign(o, {
      [`item${i}`]: wrap_bucket(m[1]),
      [`text${i}`]: m[2],
    }),{}),
}) */
addChemthrowerEffect(<liquid:oil>          ,false, true, 'chemicals', 2);
addChemthrowerEffect(<liquid:canolaoil>    ,false, true, 'chemicals', 3);
addChemthrowerEffect(<liquid:crystaloil>   ,false, true, 'chemicals', 6);
addChemthrowerEffect(<liquid:empoweredoil> ,false, true, 'chemicals', 12);
addChemthrowerEffect(<liquid:biomass>      ,false, true, 'chemicals', 3);
addChemthrowerEffect(<liquid:biofuel>      ,false, true, 'chemicals', 4);
addChemthrowerEffect(<liquid:rocket_fuel>  ,false, true, 'chemicals', 13);
addChemthrowerEffect(<liquid:refined_fuel> ,false, true, 'chemicals', 10);
addChemthrowerEffect(<liquid:rocketfuel>   ,false, true, 'chemicals', 35);
addChemthrowerEffect(<liquid:perfect_fuel> ,false, true, 'chemicals', 350);

// ----------------------------------------
// 🎇 Liquids with potion effects
/* Patchouli_js('Liquids/Chemical Thrower',
  match_block_below(/^addChemthrowerEffect\(<liquid:(.+?)>.*?(\d+), \[<potion:\w+:(\w+\.)?(\w+)>.*$/gm)
    .sort((a,b)=>b[2]-a[2])
    .reduce((o, m, i) => {
      var j = ~~(i/7);
      o[j] = o[j]||{};
      o[j][`item${i%7}`] = wrap_bucket(m[1])
      o[j][`text${i%7}`] = `${m[2]}, ${m[4]}`
      return o;
    },[])
    .map(o=>Object.assign(o, {
      title: "Potion Effects",
      type:  "item_list",
    }))
) */
addChemthrowerEffect(<liquid:cloud_seed_concentrated>, false, false, 'chemicals',  2, [<potion:minecraft:levitation>.makePotionEffect(20, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:vapor_of_levity>        , false, false, 'chemicals',  9, [<potion:minecraft:levitation>.makePotionEffect(200, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:hydrofluoric_acid>      , false, false, 'chemicals', 17, [<potion:minecraft:poison>.makePotionEffect(20, 3, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:blockfluiddirt>         , false, false, 'chemicals',  2, [<potion:immersiveengineering:sticky>.makePotionEffect(20, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:mutagen>                , false, false, 'chemicals',  8, [<potion:biomesoplenty:curse>.makePotionEffect(20, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:if.pink_slime>          , false, false, 'chemicals',  2, [<potion:immersiveengineering:sticky>.makePotionEffect(20, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:menrilresin>            , false, false, 'chemicals',  4, [<potion:immersiveengineering:sticky>.makePotionEffect(20, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:liquidchorus>           , false, false, 'chemicals',  6, [<potion:cyclicmagic:potion.bounce>.makePotionEffect(20, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:xpjuice>                , false, false, 'chemicals',  1, [<potion:quark:white>.makePotionEffect(20, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:lifeessence>            , false, false, 'chemicals', 11, [<potion:potioncore:love>.makePotionEffect(20, 1, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:fire_water>             , false, false, 'chemicals', 14, [<potion:potioncore:fire>.makePotionEffect(20, 3, false, true)] as IPotionEffect[]);
addChemthrowerEffect(<liquid:ic2hot_water>           , false, false, 'chemicals',  0, [<potion:minecraft:regeneration>.makePotionEffect(20, 5, false, true)] as IPotionEffect[]);

// ----------------------------------------
// 🍫 Chocolates
/* Patchouli_js('Liquids/Chemical Thrower', {
	title: "Chocolates",
	type:  "grid",
	...match_block_below(/^addChemthrowerEffect\(<liquid:(.+?)>/gm)
    .reduce((o, m, i) => Object.assign(o, {
      [`item${i}`]: wrap_bucket(m[1])
    }),{}),
}) */
val chocPotions = [
  <potion:randomthings:imbue_experience>.makePotionEffect(20, 1, false, true),
  <potion:scalinghealth:bandaged>.makePotionEffect(20, 1, false, true),
] as IPotionEffect[];
addChemthrowerEffect(<liquid:chocolate_liquor>       , false, false, 'chemicals', 0, chocPotions);
addChemthrowerEffect(<liquid:unsweetened_chocolate>  , false, false, 'chemicals', 0, chocPotions);
addChemthrowerEffect(<liquid:dark_chocolate>         , false, false, 'chemicals', 0, chocPotions);
addChemthrowerEffect(<liquid:milk_chocolate>         , false, false, 'chemicals', 0, chocPotions);

// addChemthrowerEffect(<liquid:liquid_sunshine>, false /*isGas*/, true /*isFlammable*/,
// 	# IChemEntityEffect
// 	function(target,shooter,throwerstack,fluid) {

// 	},

// 	# IChemBlockEffect
// 	function(world,pos,side,shooter,throwerstack,fluid) {
// 	}
// );
