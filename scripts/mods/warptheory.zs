#modloaded warptheory

// [Hunk of something] gives random amount of curioses (exept alchemy and auromancy progress) and 1/100 chance for pech wand
events.onEntityLivingUseItemFinish(function (event as crafttweaker.event.EntityLivingUseItemEvent.Finish) {
  if (isNull(event.player) || isNull(event.player.world)) return;
  val world = event.player.world;
  if (world.remote || isNull(event.item) || event.item.definition.id != <warptheory:item_something>.definition.id) return;

  event.player.give(<thaumcraft:curio:2> * world.random.nextInt(2, 9));
  event.player.give(<thaumcraft:curio:3> * world.random.nextInt(2, 9));
  event.player.give(<thaumcraft:curio:4> * world.random.nextInt(2, 9));
  event.player.give(<thaumcraft:curio:5> * world.random.nextInt(2, 9));
  if (world.random.nextInt(100) == 0) event.player.give(<thaumcraft:pech_wand>);
});

// [Pure tear]
mods.thaumcraft.Infusion.removeRecipe(<warptheory:item_cleanser>);
mods.thaumcraft.Infusion.registerRecipe(
  'pure_tear', // Name
  'PURE_TEAR', // Research
  <warptheory:item_cleanser>, // Output
  3, // Instability
  Aspects('50🔷 30✨ 100🧠'),
  <minecraft:ghast_tear>, // CentralItem
  [<thaumcraft:sanity_soap>, <thaumcraft:sanity_soap>, <botania:manaresource:5>, <thaumcraft:sanity_soap>, <thaumcraft:sanity_soap>]
);

// [Cleansing amulet]
mods.thaumcraft.Infusion.removeRecipe(<warptheory:item_cleansing_amulet>);
mods.thaumcraft.Infusion.registerRecipe(
  'cleansing_amulet', // Name
  'CLEANSING_AMULET', // Research
  <warptheory:item_cleansing_amulet>, // Output
  5, // Instability
  Aspects('100🔷 200🧠 50🔄 69ඞ'),
  <thaumadditions:fragnant_pendant> ?? <deepmoblearning:pristine_matter_enderman>, // CentralItem
  [<thaumcraft:bath_salts>, <warptheory:item_cleanser>, <thaumcraft:bath_salts>, <thaumcraft:sanity_soap>, <thaumcraft:bath_salts>, <thaumicwonders:cleansing_charm>, <thaumcraft:bath_salts>, <thaumcraft:sanity_soap>]
);

mods.thaumcraft.Infusion.removeRecipe('warptheory:item_cleanser_minor');
