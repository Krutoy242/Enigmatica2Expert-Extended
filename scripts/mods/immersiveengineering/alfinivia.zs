#modloaded immersiveengineering alfinivia redstonearsenal

import mods.alfinivia.ImmersiveEngineering.addChemthrowerEffect;
import mods.alfinivia.ImmersiveEngineering.addRailgunBullet as _addRailgunBullet;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.potions.IPotionEffect;
import crafttweaker.item.IIngredient;

// *======= Railgun rods =======*

function addRailgunBullet(item as IIngredient, damage as float, gravity as float, colorMap as int[][]) {
  _addRailgunBullet(item, damage, gravity, colorMap);
  scripts.jei.mod.alfinivia.addRailgunBulletJEI(item, damage, gravity);
}

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

// *======= Chemical Thrower ☢️ Strong radiation =======*

function addRadiationEffect(liquid as ILiquidStack, damage as float, effects as IPotionEffect[]) {
  addChemthrowerEffect(liquid, false, false, 'chemicals', damage, effects);
  scripts.jei.mod.alfinivia.addChemthrowerRadiationJEI(liquid, damage, effects);
}

addRadiationEffect(<liquid:californium_250>, 2, [<potion:ic2:radiation>.makePotionEffect(130, 2, false, true)] as IPotionEffect[]);
addRadiationEffect(<liquid:plutonium_241>  , 2, [<potion:ic2:radiation>.makePotionEffect(120, 2, false, true)] as IPotionEffect[]);
addRadiationEffect(<liquid:curium_243>     , 2, [<potion:ic2:radiation>.makePotionEffect(110, 2, false, true)] as IPotionEffect[]);
addRadiationEffect(<liquid:plutonium_238>  , 2, [<potion:ic2:radiation>.makePotionEffect(90, 2, false, true)] as IPotionEffect[]);
addRadiationEffect(<liquid:americium_242>  , 2, [<potion:ic2:radiation>.makePotionEffect(80, 2, false, true)] as IPotionEffect[]);
addRadiationEffect(<liquid:berkelium_248>  , 2, [<potion:ic2:radiation>.makePotionEffect(60, 1, false, true)] as IPotionEffect[]);
addRadiationEffect(<liquid:californium_249>, 2, [<potion:ic2:radiation>.makePotionEffect(50, 1, false, true)] as IPotionEffect[]);
addRadiationEffect(<liquid:americium_241>  , 2, [<potion:ic2:radiation>.makePotionEffect(40, 1, false, true)] as IPotionEffect[]);
addRadiationEffect(<liquid:californium_251>, 2, [<potion:ic2:radiation>.makePotionEffect(30, 1, false, true)] as IPotionEffect[]);
addRadiationEffect(<liquid:berkelium_247>  , 2, [<potion:ic2:radiation>.makePotionEffect(20, 1, false, true)] as IPotionEffect[]);
addRadiationEffect(<liquid:curium_246>     , 2, [<potion:ic2:radiation>.makePotionEffect(10, 1, false, true)] as IPotionEffect[]);

// *======= Chemical Thrower ⚡ high damage =======*

function addDamageEffect(liquid as ILiquidStack, isGas as bool, damage as float, source as string = 'chemicals') {
  addChemthrowerEffect(liquid, isGas, false, source, damage);
  scripts.jei.mod.alfinivia.addChemthrowerDamageJEI(liquid, damage);
}

addDamageEffect(<liquid:ic2superheated_steam> ,true , 14);
addDamageEffect(<liquid:ic2uu_matter>         ,false, 50, 'ic2uu_matter');
addDamageEffect(<liquid:ic2hot_coolant>       ,false, 11);
addDamageEffect(<liquid:crystal>              ,false, 20);
addDamageEffect(<liquid:plasma>               ,true , 28);
addDamageEffect(<liquid:liquid_death>         ,false, 30);
addDamageEffect(<liquid:high_pressure_mercury>,true , 68);
addDamageEffect(<liquid:neutronium>           ,false, 360);

// *======= Chemical Thrower 🔥 Flammable =======*

function addFlammableEffect(liquid as ILiquidStack, damage as float) {
  addChemthrowerEffect(liquid, false, true, 'chemicals', damage);
  scripts.jei.mod.alfinivia.addChemthrowerFlammableJEI(liquid, damage);
}

addFlammableEffect(<liquid:oil>          , 2);
addFlammableEffect(<liquid:canolaoil>    , 3);
addFlammableEffect(<liquid:crystaloil>   , 6);
addFlammableEffect(<liquid:empoweredoil> , 12);
addFlammableEffect(<liquid:biomass>      , 3);
addFlammableEffect(<liquid:biofuel>      , 4);
addFlammableEffect(<liquid:rocket_fuel>  , 13);
addFlammableEffect(<liquid:refined_fuel> , 10);
addFlammableEffect(<liquid:rocketfuel>   , 35);
addFlammableEffect(<liquid:perfect_fuel> , 350);

// *======= Chemical Thrower 🎇 Potion effects =======*

function addPotionEffect(liquid as ILiquidStack, damage as float, effects as IPotionEffect[]) {
  addChemthrowerEffect(liquid, false, false, 'chemicals', damage, effects);
  scripts.jei.mod.alfinivia.addChemthrowerPotionJEI(liquid, damage, effects);
}

addPotionEffect(<liquid:cloud_seed_concentrated>,  2, [<potion:minecraft:levitation>.makePotionEffect(20, 1, false, true)]);
addPotionEffect(<liquid:vapor_of_levity>        ,  9, [<potion:minecraft:levitation>.makePotionEffect(200, 1, false, true)]);
addPotionEffect(<liquid:hydrofluoric_acid>      , 17, [<potion:minecraft:poison>.makePotionEffect(20, 3, false, true)]);
addPotionEffect(<liquid:blockfluiddirt>         ,  2, [<potion:immersiveengineering:sticky>.makePotionEffect(20, 1, false, true)]);
addPotionEffect(<liquid:mutagen>                ,  8, [<potion:biomesoplenty:curse>.makePotionEffect(20, 1, false, true)]);
addPotionEffect(<liquid:if.pink_slime>          ,  2, [<potion:immersiveengineering:sticky>.makePotionEffect(20, 1, false, true)]);
addPotionEffect(<liquid:menrilresin>            ,  4, [<potion:immersiveengineering:sticky>.makePotionEffect(20, 1, false, true)]);
addPotionEffect(<liquid:liquidchorus>           ,  6, [<potion:cyclicmagic:potion.bounce>.makePotionEffect(20, 1, false, true)]);
addPotionEffect(<liquid:xpjuice>                ,  1, [<potion:quark:white>.makePotionEffect(20, 1, false, true)]);
addPotionEffect(<liquid:lifeessence>            , 11, [<potion:potioncore:love>.makePotionEffect(20, 1, false, true)]);
addPotionEffect(<liquid:fire_water>             , 14, [<potion:potioncore:fire>.makePotionEffect(20, 3, false, true)]);
addPotionEffect(<liquid:ic2hot_water>           ,  0, [<potion:minecraft:regeneration>.makePotionEffect(20, 5, false, true)]);

// *======= Chemical Thrower 🍫 Chocolates =======*
val chocPotions = [
  <potion:randomthings:imbue_experience>.makePotionEffect(20, 1, false, true),
  <potion:scalinghealth:bandaged>.makePotionEffect(20, 1, false, true),
] as IPotionEffect[];
addPotionEffect(<liquid:chocolate_liquor>       , 0, chocPotions);
addPotionEffect(<liquid:unsweetened_chocolate>  , 0, chocPotions);
addPotionEffect(<liquid:dark_chocolate>         , 0, chocPotions);
addPotionEffect(<liquid:milk_chocolate>         , 0, chocPotions);
