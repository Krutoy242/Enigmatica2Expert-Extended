#modloaded jei
#ignoreBracketErrors
#reloadable

import crafttweaker.item.IItemStack;

val desc = scripts.lib.tooltip.desc;

// Some Quark tooltips from https://github.com/Level-5-Pidgey/FantasTek/tree/master/mods
////////////////////////////////////////////////////////////////////////////////////////

// Add Tooltips for various blocks to explain their uses
for item in [
/* Inject_js(
[...loadText('resources/autotooltips/lang/en_us.lang')
.matchAll(/^tooltips\.lang\.(?<id>[^=]+)=(.*)$/gm)]
.filter(([,,text])=>!text.includes('%s'))
.map(([, id]) => {
  const [reg, ...nbt] = id.split(':{')
  const tag = nbt.join(':{')
  return `  <${reg}>${!tag ? '' : '.withTag({'+tag+')'},`
})
.sort(naturalSort)
) */
  <actuallyadditions:block_farmer>,
  <ae2stuff:visualiser>,
  <bibliocraft:fancysign>,
  <bloodmagic:blood_rune:1>,
  <bloodmagic:blood_rune:3>,
  <bloodmagic:blood_rune:4>,
  <bloodmagic:blood_rune:5>,
  <bloodmagic:blood_rune:6>,
  <bloodmagic:blood_rune:7>,
  <bloodmagic:blood_rune:8>,
  <bloodmagic:blood_rune:9>,
  <bloodmagic:blood_rune:10>,
  <botania:cobblerod>,
  <botania:dirtrod>,
  <botania:diviningrod>,
  <botania:exchangerod>,
  <botania:firerod>,
  <botania:flugeleye>,
  <botania:gravityrod>,
  <botania:infinitefruit>,
  <botania:kingkey>,
  <botania:lokiring>,
  <botania:missilerod>,
  <botania:odinring>,
  <botania:rainbowrod>,
  <botania:skydirtrod>,
  <botania:smeltrod>,
  <botania:terraformrod>,
  <botania:thorring>,
  <botania:tornadorod>,
  <botania:waterrod>,
  <computercraft:printout>,
  <contenttweaker:compressed_coral>,
  <contenttweaker:conglomerate_of_life>,
  <contenttweaker:conglomerate_of_sun>,
  <cyclicmagic:inventory_food>,
  <exnihilocreatio:hammer_diamond>,
  <farmingforblockheads:feeding_trough>,
  <ic2:quantum_chestplate>,
  <ic2:te:48>,
  <ic2:upgrade:4>,
  <ic2:upgrade:6>,
  <immersiveengineering:metal_device1:3>,
  <immersivetech:stone_decoration>,
  <oeintegration:excavatemodifier>,
  <openblocks:tank>,
  <openblocks:trophy>.withTag({entity_id:'minecraft:blaze'}),
  <openblocks:trophy>.withTag({entity_id:'minecraft:cave_spider'}),
  <openblocks:trophy>.withTag({entity_id:'minecraft:cow'}),
  <openblocks:trophy>.withTag({entity_id:'minecraft:creeper'}),
  <openblocks:trophy>.withTag({entity_id:'minecraft:elder_guardian'}),
  <openblocks:trophy>.withTag({entity_id:'minecraft:enderman'}),
  <openblocks:trophy>.withTag({entity_id:'minecraft:evocation_illager'}),
  <openblocks:trophy>.withTag({entity_id:'minecraft:llama'}),
  <openblocks:trophy>.withTag({entity_id:'minecraft:mooshroom'}),
  <openblocks:trophy>.withTag({entity_id:'minecraft:shulker'}),
  <openblocks:trophy>.withTag({entity_id:'minecraft:skeleton'}),
  <openblocks:trophy>.withTag({entity_id:'minecraft:snowman'}),
  <openblocks:trophy>.withTag({entity_id:'minecraft:squid'}),
  <openblocks:trophy>.withTag({entity_id:'minecraft:witch'}),
  <opencomputers:print>,
  <quark:archaeologist_hat>,
  <quark:chain>,
  <quark:chute>,
  <quark:grate>,
  <quark:gravisand>,
  <quark:horse_whistle>,
  <quark:iron_rod>,
  <quark:redstone_inductor>,
  <quark:rope>,
  <quark:slime_bucket>,
  <quark:trowel>,
  <randomthings:peacecandle>,
  <thaumadditions:salt_essence>,
  <thaumcraft:research_table>,
  <thaumcraft:table_wood>,
  <thermalfoundation:upgrade:1>,
  <thermalfoundation:upgrade:2>,
  <thermalfoundation:upgrade:3>,
  <twilightforest:transformation_powder>,
/**/
] as IItemStack[] {
  if (isNull(item)) continue;

  // Special case for Vis Salt, since it would error if doesnt have aspect NBT tag,
  // but if we add NBT tag, only specific one will be described.
  if (<thaumadditions:salt_essence> has item) desc.tooltip(item);
  else desc.both(item);
}

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

for rod in [
  <immersiveengineering:material:1>,
  <immersiveengineering:material:3>,
  <immersiveengineering:material:2>,
] as IItemStack[] {
  desc.jei(rod, 'small_plate_presser');
}

desc.tooltipRaw(<extrautils2:ingredients:13>, '§b' ~ desc.local('not_consumed'));

desc.jei(<extrautils2:bagofholding>, 'removed.instability'); // Bag of Holding
desc.jei(<enderio:item_material:17>, 'enticing_crystal'); // Enticing Crystal
desc.jei(<extendedcrafting:crafting_core>, 'maximum_allowed_input'); // Crafting Core
desc.jei(<astralsorcery:blockinfusedwood>, 'wood_in_starlight'); // Infused Wood
desc.jei(<advancedrocketry:platepress>, 'plate_presser'); // Small Plate Press
desc.jei(<thaumcraft:thaumonomicon>, 'click.bookshelf'); // Thaumonomicon
desc.jei(<thaumcraft:arcane_workbench>, 'click.crafting'); // Arcane Workbench
desc.jei(<thaumcraft:crucible>, 'click.cauldron'); // Crucible
desc.jei(Bucket('xpjuice'), 'obtained.fluid_transposer'); // XP Bucket
desc.jei(<thermalfoundation:material:136>, 'obtained.mithril'); // Mana Infused Ingot
desc.jei(<thermalexpansion:frame:129>, 'requires.rf', '10.000.000'); // Thermal Expansion Casings
desc.jei(<actuallyadditions:block_crystal_empowered>, 'requires.rf', '1.000.000'); // Restonia
desc.jei(<actuallyadditions:block_crystal_empowered:1>, 'requires.rf', '1.000.000'); // Palis
desc.jei(<actuallyadditions:block_crystal_empowered:2>, 'requires.rf', '2.000.000'); // Diamantine
desc.jei(<actuallyadditions:block_crystal_empowered:3>, 'requires.rf', '10.000.000'); // Void
desc.jei(<actuallyadditions:block_crystal_empowered:4>, 'requires.rf', '2.000.000'); // Emeradic
desc.jei(<actuallyadditions:block_crystal_empowered:5>, 'requires.rf', '1.000.000'); // Enori
desc.jei(<mekanism:controlcircuit:3>, 'requires.rf', '2.000.000'); // Mekanism Ultimate Circuit

desc.jei(<thermalexpansion:cache>, 'crescent_hammer');
desc.jei(<mekanism:gaugedropper>, 'gauge_dropper');
desc.jei(<environmentaltech:void_ore_miner_cont_6>, 'miner_tier_6_specializes');
desc.jei(<astralsorcery:blockaltar>, 'astralsorcery.blockaltar');
desc.jei(<extrautils2:ingredients:13>, 'not_consumed');
desc.jei(<liquid:nitrogen>, 'nitrogen_collectors');

// Blood Magic Wills
desc.jei(<bloodmagic:item_demon_crystal:0>, 'obtained.forsaken');
desc.jei(<bloodmagic:item_demon_crystal:1>, 'obtained.resonance');
desc.jei(<bloodmagic:item_demon_crystal:2>, 'obtained.resonance');
desc.jei(<bloodmagic:item_demon_crystal:3>, 'obtained.resonance');
desc.jei(<bloodmagic:item_demon_crystal:4>, 'obtained.resonance');

// Pumpjack
desc.jei(Bucket('oil'), 'pumpjack');
desc.jei(<liquid:oil>, 'pumpjack');

// Thermal Expansion Coils
desc.jei(<thermalfoundation:material:513>, 'requires.redstone160');
desc.jei(<thermalfoundation:material:514>, 'requires.redstone160');
desc.jei(<thermalfoundation:material:515>, 'requires.redstone160');

// Reinforced Cell Frame (full)
desc.jei(<thermalexpansion:frame:146>, 'reinforced_cell_frame');

// IC2 Wrenches
desc.jei(<ic2:electric_wrench>, 'ic2wrench');
desc.jei(<ic2:wrench>, 'ic2wrench');

// Thermal Expansion Resonant Machine Frame (Full)
desc.jei(<thermalexpansion:frame:148>, 'requires.rf', '100.000.000');

// Tool Forge
desc.tooltipRaw(<tconstruct:toolforge>.anyDamage(), desc.local('forge_from_metal'));
desc.tooltipRaw(<conarm:armorforge>.anyDamage(), desc.local('forge_from_metal'));

// Mekanism Factories
desc.both(<mekanism:machineblock:5>, 'mekanism_factories');
desc.both(<mekanism:machineblock:6>, 'mekanism_factories');
desc.both(<mekanism:machineblock:7>, 'mekanism_factories');
desc.both(<libvulpes:productingot:7>, 'obtained.fabricator_or_excavator'); // Titanium Ingot
desc.both(<mekanism:tierinstaller:3>, 'mekanism_t_ultimate');

// Remove the TMG Death List from the inventory and drop it on the ground. This prevents a nested NBT issue.
scripts.lib.tooltip.desc.both(<tombmanygraves:death_list>, 'dropper_into_world');

desc.tooltip(<industrialforegoing:mob_relocator>, 'industrialforegoing:mob_relocator',
/* Inject_js(config('config/industrialforegoing.cfg').machines.mob_relocator.damage) */
100
/**/
);

// Mystical Agriculture Seeds Tier 6
desc.tooltipRaw(<mysticalagriculture:enderium_seeds>, desc.local('tier') ~ ': §56§r');
desc.tooltipRaw(<mysticalagriculture:iridium_seeds>, desc.local('tier') ~ ': §56§r');
desc.tooltipRaw(<mysticalagriculture:terrasteel_seeds>, desc.local('tier') ~ ': §56§r');

// Solar Panels
val or_above = ' ' ~ desc.local('et.or_above');
for i, a in [
  [4, 16, 9],
  [4, 24, 25],
  [8, 32, 49],
  [8, 40, 81],
  [12, 48, 121],
  [12, 56, 169],
] as int[][] {
  desc.jei(
    itemUtils.getItem('environmentaltech:solar_cont_' ~ (i + 1)),
    'solar_cont', a[0], a[1], (i + 1) as string ~ (i == 5 ? '' : or_above), a[2]
  );
}

// Void Ore Miner
desc.jei(<environmentaltech:void_ore_miner_cont_1>, 'et_cont_1', 24, 20, 2);

for i, a in [
  [4, 32, 16, 3],
  [8, 56, 52, 4],
  [12, 56, 56, 5],
  [16, 72, 36, 6],
  [20, 92, 56, 6],
] as int[][] {
  desc.jei(
    itemUtils.getItem('environmentaltech:void_ore_miner_cont_' ~ (i + 2)),
    'et_miner_cont_any', a[0], a[1], (i + 2) as string ~ (i == 4 ? '' : or_above), a[2], a[3]
  );
}

// Void Resource Miner
desc.jei(<environmentaltech:void_res_miner_cont_1>, 'et_cont_1', 24, 20, 2);
for i, a in [
  [4, 32, 16, 3],
  [8, 56, 52, 4],
  [12, 56, 56, 5],
  [16, 72, 36, 6],
  [20, 92, 56, 6],
] as int[][] {
  desc.jei(
    itemUtils.getItem('environmentaltech:void_res_miner_cont_' ~ (i + 2)),
    'et_miner_cont_any', a[0], a[1], (i + 2) as string ~ (i == 4 ? '' : or_above), a[2], a[3]
  );
}

// Nanobot Beacon
for i, a in [
  [4, 20, 12],
  [8, 36, 24],
  [12, 56, 40],
  [16, 80, 60],
  [20, 108, 84],
  [24, 140, 112],
] as int[][] {
  desc.jei(
    itemUtils.getItem('environmentaltech:nano_cont_personal_' ~ (i + 1)),
    'nano_cont_personal', a[0], a[1], (i + 1) as string ~ (i == 5 ? '' : or_above), a[2]
  );
}

// Lightning Rod
for i, a in [
  [4, 3, 3],
  [4, 4, 4],
  [4, 5, 5],
  [13, 4, 16],
  [13, 6, 22],
  [13, 8, 28],
] as int[][] {
  desc.jei(
    itemUtils.getItem('environmentaltech:nano_cont_personal_' ~ (i + 1)),
    'nano_cont_personal', a[0], (i + 1) as string ~ (i == 5 ? '' : or_above), a[1], a[2]
  );
}

// Antimatter
desc.tooltipRaw(Bucket('blockfluidantimatter'), '§b' ~ desc.local('strike_with_lightning'));

// Thaumcraft Curiocity
val lp = desc.local('thaum.progress').toLowerCase();
desc.tooltipRaw(<thaumcraft:curio:0>, '§f+ §5' ~ desc.local('thaum.auromancy') ~ '§f ' ~ lp);
desc.tooltipRaw(<thaumcraft:curio:1>, '§f+ §5' ~ desc.local('thaum.alchemy') ~ '§f ' ~ lp);
desc.tooltipRaw(<thaumcraft:curio:2>, '§f+ §5' ~ desc.local('thaum.golemancy') ~ '§f ' ~ lp);
desc.tooltipRaw(<thaumcraft:curio:3>, '§f+ §5' ~ desc.local('thaum.eldritch') ~ '§f ' ~ lp);
desc.tooltipRaw(<thaumcraft:curio:4>, '§f+ §5' ~ desc.local('thaum.arcane') ~ '§f ' ~ lp);
desc.tooltipRaw(<thaumcraft:curio:5>, '§f+ §5' ~ desc.local('thaum.artifice') ~ '§f ' ~ lp);

desc.tooltip(Bucket('corium'), 'fluid.corium');
desc.tooltip(<actuallyadditions:item_crystal_empowered:2>, 'tcon.diamond');
desc.tooltip(<scalinghealth:heartdust>, 'tcon.speedy');
desc.tooltip(<botania:specialflower>.withTag({ type: 'endoflame' }), 'botania.decay1hour');
desc.tooltip(<conarm:resist_mat>, 'tcon.slot_each');
desc.tooltip(<conarm:resist_mat_fire>, 'tcon.slot_first');
desc.tooltip(<conarm:resist_mat_proj>, 'tcon.slot_first');
desc.tooltip(<conarm:resist_mat_blast>, 'tcon.slot_first');
desc.tooltip(<travelersbackpack:travelers_backpack:2>, 'backpack.Bat');
desc.tooltip(<travelersbackpack:travelers_backpack:15>, 'backpack.Bookshelf');
desc.tooltip(<travelersbackpack:travelers_backpack:17>, 'backpack.Cactus');
desc.tooltip(<travelersbackpack:travelers_backpack:28>, 'backpack.Chicken');
desc.tooltip(<travelersbackpack:travelers_backpack:64>, 'backpack.Creeper');
desc.tooltip(<travelersbackpack:travelers_backpack:22>, 'backpack.Dragon');
desc.tooltip(<travelersbackpack:travelers_backpack:8>, 'backpack.Emerald');
desc.tooltip(<travelersbackpack:travelers_backpack:53>, 'backpack.Pig');
desc.tooltip(<travelersbackpack:travelers_backpack:51>, 'backpack.Pigman');
desc.tooltip(<travelersbackpack:travelers_backpack:57>, 'backpack.Rainbow');
desc.tooltip(<travelersbackpack:travelers_backpack:67>, 'backpack.Slime');
desc.tooltip(<travelersbackpack:travelers_backpack:62>, 'backpack.Squid');
desc.tooltip(<travelersbackpack:travelers_backpack:63>, 'backpack.Sunflower');
desc.tooltip(<travelersbackpack:travelers_backpack:73>, 'backpack.Wolf');
desc.tooltip(<ic2:jetpack_electric:26>, 'sponge.removed_with');
desc.tooltip(<minecraft:sponge>, 'sponge.can_remove');

desc.both(<netherendingores:ore_nether_modded_1:7>, 'worldgen.disabled_use_sub');
desc.both(<netherendingores:ore_end_modded_1:7>, 'worldgen.disabled_use_sub');
desc.both(<thermalfoundation:ore:2>, 'worldgen.disabled_use_sub');
desc.both(<rftools:syringe>, 'syringe_craftable');
desc.both(<rftools:spawner>, 'syringe_craftable');
desc.both(<tconstruct:shard>.withTag({ Material: 'fusewood' }), 'tcon.fusewood');
desc.both(<tconstruct:shard>.withTag({ Material: 'darkwood' }), 'tcon.darkwood');
desc.both(<tconstruct:shard>.withTag({ Material: 'bloodwood' }), 'tcon.bloodwood');
desc.both(<tconstruct:shard>.withTag({ Material: 'ghostwood' }), 'tcon.ghostwood');

/* Inject_js(
[...loadText('config/enderio/recipes/user/capacitor_machines.xml')
.matchAll(/(enderio:block_inventory_chest_\w+)\/size"\s*base="(\d+)"/g)]
.map(([,id,size])=>`desc.tooltip(<${id}>, 'store_x_stacks', ${size});`)
) */
desc.tooltip(<enderio:block_inventory_chest_tiny>, 'store_x_stacks', 200);
desc.tooltip(<enderio:block_inventory_chest_small>, 'store_x_stacks', 400);
desc.tooltip(<enderio:block_inventory_chest_medium>, 'store_x_stacks', 600);
desc.tooltip(<enderio:block_inventory_chest_big>, 'store_x_stacks', 1000);
desc.tooltip(<enderio:block_inventory_chest_large>, 'store_x_stacks', 1400);
desc.tooltip(<enderio:block_inventory_chest_huge>, 'store_x_stacks', 1800);
desc.tooltip(<enderio:block_inventory_chest_enormous>, 'store_x_stacks', 2600);
desc.tooltip(<enderio:block_inventory_chest_warehouse>, 'store_x_stacks', 3600);
desc.tooltip(<enderio:block_inventory_chest_warehouse13>, 'store_x_stacks', 5000);
/**/

for lang, items in {
  ae_lag: [
    <cyclicmagic:storage_bag>,
    <extrautils2:bagofholding>,
    <forestry:adventurer_bag_t2>,
    <forestry:adventurer_bag>,
    <forestry:apiarist_bag>,
    <forestry:builder_bag_t2>,
    <forestry:builder_bag>,
    <forestry:digger_bag_t2>,
    <forestry:digger_bag>,
    <forestry:forester_bag_t2>,
    <forestry:forester_bag>,
    <forestry:hunter_bag_t2>,
    <forestry:hunter_bag>,
    <forestry:lepidopterist_bag>,
    <forestry:miner_bag_t2>,
    <forestry:miner_bag>,
    <minecraft:written_book>,
  ],
  dont_put_into_ae: [
    <danknull:dank_null_0>,
    <danknull:dank_null_1>,
    <danknull:dank_null_2>,
    <danknull:dank_null_3>,
    <danknull:dank_null_4>,
    <danknull:dank_null_5>,
    <danknull:dank_null_6>,
  ],
  power_tier_7: [
    <ic2:te:24>,
    <ic2:te:22>,
  ],
} as IItemStack[][string] {
  for item in items {
    desc.jei(item, lang);
  }
}
