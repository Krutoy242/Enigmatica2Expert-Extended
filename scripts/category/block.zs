/*
Configure harvest level and hardness/resistance progression of blocks
*/

#reloadable
#ignoreBracketErrors
#priority -1000

import crafttweaker.item.IIngredient;
import crafttweaker.block.IBlockDefinition;
import crafttweaker.item.IItemStack;

function isWildcarded(item as IItemStack) as bool {
  return item.damage == 32767;
}

function warnItem(item as IItemStack, text as string) as void {
  if (!utils.DEBUG) return;
  logger.logWarning('§3┌ §8'~text~':\n§3└ §6'~item.commandString~' §8"§7'~item.displayName~'§8"');
}

function set(level as int, tool as string, ingr as IIngredient, hardness as int = -1, supressHardnessWarn as bool = false) as bool {
  if (isNull(ingr)) return false;
  var success = false;
  for item in ingr.items {
    if (scripts.lib.purge.purge.isPurged(item)) {
      warnItem(item, 'Trying to change block properties for purged item');
      continue;
    }

    val state = utils.getStateFromItem(item);

    if (isNull(state) || isNull(state.block)) {
      warnItem(item, 'Trying to change block properties, but this item cant be converted to block');
      continue;
    }

    val def = state.block.definition;
    print('Setting harvest level for <'~def.id~':'~item.damage~'> "'~tool~'" '~level~' ['~hardness~']');

    if (isWildcarded(item)) {
      def.setHarvestLevel(tool, level);
    } else {
      def.setHarvestLevel(tool, level, state);
      if (hardness >= 0 && !supressHardnessWarn) {
        val statesCount = def.native.blockState.validStates.length;
        if (statesCount > 1)
          warnItem(item, 'Trying to rewrite hardness §3'~def.hardness~'→'~hardness~' §8for block with §5'~statesCount~' §8states');
      }
    }
    if (hardness >= 0) {
      def.hardness = hardness;
    }
    success = true;
  }
  return success;
}

function harder(hardness as int) as int {
  if (hardness < 0) return hardness;
  return hardness + pow(1.2, hardness / 2);
}

function softer(hardness as int) as int {
  if (hardness < 0) return hardness;
  return max(0, hardness - pow(1.2, hardness / 2));
}

/*
Tip:
Wildcarding is not necessary but recommended if possible

Arguments is rotated for easy natural sorting
*/

set(-1, '?shears', <exnihilocreatio:block_infested_leaves:*>, 0);
set(-1, '?shears', <minecraft:web>);
set(-1, '?shovel', <minecraft:snow_layer:*>);
set(-1, '?shovel', <minecraft:snow>);
set(0, 'pickaxe', <appliedenergistics2:sky_stone_chest:*>);
set(0, 'pickaxe', <chisel:limestone:*>);
set(0, 'pickaxe', <chisel:limestone1:*>);
set(0, 'pickaxe', <chisel:limestone2:*>);
set(0, 'pickaxe', <chisel:marble:*>);
set(0, 'pickaxe', <chisel:marble1:*>);
set(0, 'pickaxe', <chisel:marble2:*>);
set(0, 'pickaxe', <ore:stoneBasalt>);
set(0, 'pickaxe', <thermalfoundation:ore:4>);
set(0, 'pickaxe', <thermalfoundation:ore>);
set(1, 'axe', <thaumcraft:log_greatwood:*>);
set(1, 'axe', <thaumcraft:log_silverwood:*>);
set(1, 'pickaxe', <appliedenergistics2:quartz_ore:*>);
set(1, 'shovel', <exnihilocreatio:block_endstone_crushed>);
set(2, 'pickaxe', <actuallyadditions:block_crystal:*>, 1);
set(2, 'pickaxe', <actuallyadditions:block_misc:2>);
set(2, 'pickaxe', <chisel:redstone:*>);
set(2, 'pickaxe', <chisel:redstone1:*>);
set(2, 'pickaxe', <environmentaltech:modifier_null:*>, 4);
set(2, 'pickaxe', <extrautils2:compresseddirt>);
set(2, 'pickaxe', <extrautils2:compressedgravel>);
set(2, 'pickaxe', <extrautils2:compressednetherrack>);
set(2, 'pickaxe', <extrautils2:compressedsand>);
set(2, 'pickaxe', <minecraft:gold_ore>);
set(2, 'pickaxe', <minecraft:iron_ore>);
set(2, 'pickaxe', <minecraft:lapis_block>);
set(2, 'pickaxe', <rftools:modular_storage:*>);
set(2, 'pickaxe', <thermalfoundation:ore:1>);
set(2, 'pickaxe', <thermalfoundation:storage>);
set(3, '?axe', <astralsorcery:blockinfusedwood:*>, 4);
set(3, 'pickaxe', <actuallyadditions:block_crystal_empowered:*>, 2);
set(3, 'pickaxe', <actuallyadditions:block_misc:3>);
set(3, 'pickaxe', <biomesoplenty:gem_block:*>, 4);
set(3, 'pickaxe', <extrautils2:compressedcobblestone>);
set(3, 'pickaxe', <minecraft:end_stone:*>, 2);
set(3, 'pickaxe', <minecraft:gold_block:*>, 4);
set(3, 'pickaxe', <minecraft:hopper:*>);
set(3, 'pickaxe', <minecraft:iron_block:*>, 2);
set(3, 'pickaxe', <minecraft:netherrack:*>);
set(3, 'pickaxe', <minecraft:redstone_block:*>, 3);
set(3, 'pickaxe', <psi:psi_decorative:*>, 4);
set(3, 'pickaxe', <rftools:crafter1:*>, 4);
set(3, 'pickaxe', <thermalfoundation:ore:2>);
set(3, 'pickaxe', <thermalfoundation:ore:3>);
set(3, 'pickaxe', <thermalfoundation:storage_alloy:1>);
set(3, 'pickaxe', <thermalfoundation:storage:1>);
set(3, 'pickaxe', <thermalfoundation:storage:4>);
set(3, 'shovel', <iceandfire:chared_dirt:*>, 4);
set(3, 'shovel', <iceandfire:chared_grass_path:*>, 4);
set(3, 'shovel', <iceandfire:chared_grass:*>, 4);
set(4, 'axe', <botania:livingwood:*>, 8);
set(4, 'axe', <botania:livingwood0slab:*>, 8);
set(4, 'axe', <botania:livingwood0slabfull:*>, 8);
set(4, 'axe', <botania:livingwood0stairs:*>, 8);
set(4, 'axe', <botania:livingwood0wall:*>, 8);
set(4, 'axe', <botania:livingwood1slab:*>, 8);
set(4, 'axe', <botania:livingwood1slabfull:*>, 8);
set(4, 'axe', <botania:livingwood1stairs:*>, 8);
set(4, 'axe', <ore:logSequoia>);
set(4, 'pickaxe', <biomesoplenty:gem_ore:*>, 8);
set(4, 'pickaxe', <botania:livingrock:*>, 8);
set(4, 'pickaxe', <botania:pool:*>, 8);
set(4, 'pickaxe', <chisel:endstone:*>, 8);
set(4, 'pickaxe', <chisel:endstone1:*>, 8);
set(4, 'pickaxe', <chisel:endstone2:*>, 8);
set(4, 'pickaxe', <chisel:quartz:*>, 1);
set(4, 'pickaxe', <chisel:quartz1:*>, 1);
set(4, 'pickaxe', <endreborn:block_lormyte_crystal:*>);
set(4, 'pickaxe', <endreborn:dragon_essence:*>);
set(4, 'pickaxe', <environmentaltech:aethium:*>, 12);
set(4, 'pickaxe', <environmentaltech:modifier_piezo:*>, 12);
set(4, 'pickaxe', <excompressum:compressed_block:7>);
set(4, 'pickaxe', <iceandfire:chared_gravel:*>, 8);
set(4, 'pickaxe', <mekanism:oreblock:*>);
set(4, 'pickaxe', <minecraft:diamond_block:*>, 8);
set(4, 'pickaxe', <minecraft:diamond_ore:*>, 4);
set(4, 'pickaxe', <minecraft:emerald_ore:*>, 5);
set(4, 'pickaxe', <minecraft:ender_chest:*>, 4);
set(4, 'pickaxe', <minecraft:quartz_block:*>, 1);
set(4, 'pickaxe', <ore:blockCobalt>);
set(4, 'pickaxe', <plustic:invarblock:*>, 8);
set(4, 'pickaxe', <rftools:crafter2:*>, 8);
set(4, 'pickaxe', <thaumcraft:paving_stone_barrier:*>, 8);
set(4, 'pickaxe', <thaumcraft:paving_stone_travel:*>, 8);
set(4, 'pickaxe', <thaumcraft:pedestal_ancient:*>, 8);
set(4, 'pickaxe', <thaumcraft:pedestal_arcane:*>, 8);
set(4, 'pickaxe', <thaumcraft:pedestal_eldritch:*>, 8);
set(4, 'pickaxe', <thaumcraft:pillar_ancient:*>, 8);
set(4, 'pickaxe', <thaumcraft:pillar_arcane:*>, 8);
set(4, 'pickaxe', <thaumcraft:pillar_eldritch:*>, 8);
set(4, 'pickaxe', <thaumcraft:stone_ancient_rock:*>, 8);
set(4, 'pickaxe', <thermalfoundation:storage_alloy:3>);
set(4, 'pickaxe', <thermalfoundation:storage:2>);
set(4, 'pickaxe', <thermalfoundation:storage:3>);
set(5, 'pickaxe', <appliedenergistics2:sky_stone_block:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:sky_stone_brick_double_slab:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:sky_stone_brick_slab:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:sky_stone_brick_stairs:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:sky_stone_brick:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:sky_stone_double_slab:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:sky_stone_slab:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:sky_stone_small_brick_double_slab:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:sky_stone_small_brick_slab:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:sky_stone_small_brick_stairs:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:sky_stone_small_brick:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:sky_stone_stairs:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:smooth_sky_stone_block:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:smooth_sky_stone_chest:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:smooth_sky_stone_double_slab:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:smooth_sky_stone_slab:*>, 12);
set(5, 'pickaxe', <appliedenergistics2:smooth_sky_stone_stairs:*>, 12);
set(5, 'pickaxe', <biomesoplenty:gem_block>);
set(5, 'pickaxe', <chisel:blockuranium:*>, 4);
set(5, 'pickaxe', <endreborn:block_wolframium_ore:*>, 2);
set(5, 'pickaxe', <environmentaltech:erodium:*>, 18);
set(5, 'pickaxe', <environmentaltech:modifier_accuracy:*>, 18);
set(5, 'pickaxe', <environmentaltech:modifier_speed:*>, 18);
set(5, 'pickaxe', <environmentaltech:structure_frame_1:*>, 18);
set(5, 'pickaxe', <extrautils2:compresseddirt:1>);
set(5, 'pickaxe', <extrautils2:compressedgravel:1>);
set(5, 'pickaxe', <extrautils2:compressednetherrack:1>);
set(5, 'pickaxe', <extrautils2:compressedsand:1>);
set(5, 'pickaxe', <iceandfire:chared_cobblestone:*>, 12);
set(5, 'pickaxe', <immersiveengineering:storage:5>);
set(5, 'pickaxe', <minecraft:emerald_block:*>, 3);
set(5, 'pickaxe', <minecraft:glowstone:*>, 2);
set(5, 'pickaxe', <minecraft:magma:*>, 3);
set(5, 'pickaxe', <minecraft:obsidian:*>);
set(5, 'pickaxe', <chisel:obsidian:*>);
set(5, 'pickaxe', <bloodmagic:path:*>);
set(5, 'pickaxe', <minecraft:quartz_ore>, 2);
set(5, 'pickaxe', <minecraft:quartz_stairs:*>, 2);
set(5, 'pickaxe', <mysticalagriculture:nether_inferium_ore>, 32);
set(5, 'pickaxe', <mysticalagriculture:nether_prosperity_ore>, 32);
set(5, 'pickaxe', <mysticalagriculture:prosperity_ore:*>, 12);
set(5, 'pickaxe', <netherendingores:ore_end_modded_2:1>);
set(5, 'pickaxe', <netherendingores:ore_end_modded_2:2>);
set(5, 'pickaxe', <netherendingores:ore_end_modded_2:3>);
set(5, 'pickaxe', <netherendingores:ore_nether_modded_2:1>);
set(5, 'pickaxe', <netherendingores:ore_nether_modded_2:2>);
set(5, 'pickaxe', <netherendingores:ore_nether_modded_2:3>);
set(5, 'pickaxe', <netherendingores:ore_other_1>);
set(5, 'pickaxe', <tconstruct:metal:7>);
set(5, 'pickaxe', <redstonearsenal:storage:*>, 12);
set(5, 'pickaxe', <rftools:crafter3:*>, 12);
set(5, 'pickaxe', <rftools:matter_receiver:*>, 12);
set(5, 'pickaxe', <rftools:matter_transmitter:*>, 12);
set(5, 'pickaxe', <thaumcraft:amber_block:*>, 4);
set(5, 'pickaxe', <thaumcraft:amber_brick:*>, 4);
set(5, 'pickaxe', <thaumcraft:metal_brass:*>, 12);
set(5, 'pickaxe', <thaumcraft:ore_amber:*>, 4);
set(5, 'pickaxe', <thaumcraft:ore_quartz>, 2);
set(5, 'pickaxe', <thaumcraft:stone_arcane_brick:*>, 12);
set(5, 'pickaxe', <thaumcraft:stone_arcane:*>, 12);
set(5, 'pickaxe', <thermalfoundation:ore:5>);
set(5, 'pickaxe', <thermalfoundation:storage_alloy:2>);
set(5, 'pickaxe', <thermalfoundation:storage_alloy:4>);
set(5, 'pickaxe', <thermalfoundation:storage_alloy>);
set(5, 'pickaxe', <xnet:connector:*>, 12);
set(5, null, <additionalcompression:charcoal_compressed:1>);
set(5, null, <twilightforest:underbrick:*>, 12);
set(6, 'pickaxe', <appliedenergistics2:charged_quartz_ore:*>, 3);
set(6, 'pickaxe', <biomesoplenty:gem_ore>);
set(6, 'pickaxe', <botania:pylon:*>, 18);
set(6, 'pickaxe', <endreborn:block_essence_ore:*>, 18);
set(6, 'pickaxe', <environmentaltech:ionite:*>, 24);
set(6, 'pickaxe', <environmentaltech:laser_lens_colored:*>, 24);
set(6, 'pickaxe', <environmentaltech:solar_cell_aethium:*>, 24);
set(6, 'pickaxe', <environmentaltech:solar_cont_1:*>, 24);
set(6, 'pickaxe', <environmentaltech:structure_frame_2:*>, 24);
set(6, 'pickaxe', <environmentaltech:void_ore_miner_cont_1:*>, 24);
set(6, 'pickaxe', <environmentaltech:void_res_miner_cont_1:*>, 24);
set(6, 'pickaxe', <extendedcrafting:storage:5>);
set(6, 'pickaxe', <extrautils2:compressedcobblestone:1>);
set(6, 'pickaxe', <extrautils2:compresseddirt:2>);
set(6, 'pickaxe', <extrautils2:compressednetherrack:2>);
set(6, 'pickaxe', <iceandfire:chared_stone:*>, 18);
set(6, 'pickaxe', <immersiveengineering:ore:5>);
set(6, 'pickaxe', <mechanics:crushing_block:*>, 19);
set(6, 'pickaxe', <mysticalagriculture:end_inferium_ore>, 48);
set(6, 'pickaxe', <mysticalagriculture:end_prosperity_ore>, 48);
set(6, 'pickaxe', <netherendingores:ore_other_1:1>);
set(6, 'pickaxe', <ore:blockBoron>);
set(6, 'pickaxe', <ore:blockLithium>);
set(6, 'pickaxe', <ore:blockMagnesium>);
set(6, 'pickaxe', <ore:blockThorium>);
set(6, 'pickaxe', <quark:crystal:*>, 18);
set(6, 'pickaxe', <thaumcraft:metal_alchemical_advanced:*>, 18);
set(6, 'pickaxe', <thaumcraft:metal_alchemical:*>, 18);
set(6, 'pickaxe', <thaumcraft:metal_thaumium:*>, 18);
set(6, 'pickaxe', <thaumcraft:ore_cinnabar:*>, 6);
set(6, 'pickaxe', <thermalfoundation:storage:5>);
set(6, 'pickaxe', <twilightforest:aurora_pillar:*>, 18);
set(6, 'pickaxe', <twilightforest:aurora_slab:*>, 18);
set(6, 'pickaxe', <xnet:controller:*>, 18);
set(7, '?pickaxe', <draconicevolution:energy_crystal:*>, 5);
set(7, 'axe', <advancedrocketry:alienwood:*>, 24);
set(7, 'pickaxe', <biomesoplenty:biome_block:*>, 10);
set(7, 'pickaxe', <botania:runealtar:*>, 24);
set(7, 'pickaxe', <chisel:blockplatinum:*>, 4);
set(7, 'pickaxe', <environmentaltech:kyronite:*>, 32);
set(7, 'pickaxe', <environmentaltech:solar_cell_erodium:*>, 32);
set(7, 'pickaxe', <environmentaltech:solar_cont_2:*>, 32);
set(7, 'pickaxe', <environmentaltech:structure_frame_3:*>, 32);
set(7, 'pickaxe', <environmentaltech:void_ore_miner_cont_2:*>, 32);
set(7, 'pickaxe', <environmentaltech:void_res_miner_cont_2:*>, 32);
set(7, 'pickaxe', <extendedcrafting:storage:6>);
set(7, 'pickaxe', <extendedcrafting:table_basic:*>, 24);
set(7, 'pickaxe', <extrautils2:compressedcobblestone:2>);
set(7, 'pickaxe', <extrautils2:compresseddirt:3>);
set(7, 'pickaxe', <extrautils2:compressednetherrack:3>);
set(7, 'pickaxe', <netherendingores:ore_end_modded_1:12>);
set(7, 'pickaxe', <netherendingores:ore_nether_modded_1:12>);
set(7, 'pickaxe', <nuclearcraft:material_block:4>);
set(7, 'pickaxe', <rftools:dialing_device:*>, 24);
set(7, 'pickaxe', <thermalfoundation:storage:6>);
set(7, 'pickaxe', <thermalfoundation:storage:8>);
set(7, 'pickaxe', <twilightforest:aurora_block:*>, 24);
set(7, 'pickaxe', <xnet:advanced_connector:*>, 24);
set(8, 'pickaxe', <appliedenergistics2:controller:*>, 32);
set(8, 'pickaxe', <botania:terraplate:*>, 32);
set(8, 'pickaxe', <draconicevolution:dislocator_pedestal:*>, 32);
set(8, 'pickaxe', <draconicevolution:dislocator_receptacle:*>, 32);
set(8, 'pickaxe', <draconicevolution:draconic_spawner:*>, 32);
set(8, 'pickaxe', <draconicevolution:grinder:*>, 32);
set(8, 'pickaxe', <enderio:block_alloy_endergy:1>);
set(8, 'pickaxe', <environmentaltech:laser_core:*>, 40);
set(8, 'pickaxe', <environmentaltech:laser_lens:*>, 40);
set(8, 'pickaxe', <environmentaltech:litherite:*>, 40);
set(8, 'pickaxe', <environmentaltech:solar_cell_ionite:*>, 40);
set(8, 'pickaxe', <environmentaltech:solar_cont_3:*>, 40);
set(8, 'pickaxe', <environmentaltech:structure_frame_4:*>, 40);
set(8, 'pickaxe', <environmentaltech:void_ore_miner_cont_3:*>, 40);
set(8, 'pickaxe', <environmentaltech:void_res_miner_cont_3:*>, 40);
set(8, 'pickaxe', <extendedcrafting:compressor:*>, 60);
set(8, 'pickaxe', <extendedcrafting:storage:7>);
set(8, 'pickaxe', <extrautils2:compressedcobblestone:3>);
set(8, 'pickaxe', <extrautils2:compressednetherrack:4>);
set(8, 'pickaxe', <plustic:osgloglasblock:*>, 32);
set(8, 'pickaxe', <rftools:builder:*>, 32);
set(8, 'pickaxe', <thermalfoundation:ore:6>);
set(8, 'pickaxe', <thermalfoundation:ore:8>);
set(8, 'pickaxe', <thermalfoundation:storage_alloy:6>);
set(8, 'pickaxe', <thermalfoundation:storage:8>);
set(8, 'pickaxe', <twilightforest:deadrock:*>, 32);
set(9, 'pickaxe', <appliedenergistics2:condenser:*>, 40);
set(9, 'pickaxe', <enderio:block_alloy_endergy:4>);
set(9, 'pickaxe', <environmentaltech:lonsdaleite:*>, 50);
set(9, 'pickaxe', <environmentaltech:pladium:*>, 50);
set(9, 'pickaxe', <environmentaltech:solar_cell_kyronite:*>, 50);
set(9, 'pickaxe', <environmentaltech:solar_cont_4:*>, 50);
set(9, 'pickaxe', <environmentaltech:structure_frame_5:*>, 50);
set(9, 'pickaxe', <environmentaltech:void_ore_miner_cont_4:*>, 50);
set(9, 'pickaxe', <environmentaltech:void_res_miner_cont_4:*>, 50);
set(9, 'pickaxe', <extendedcrafting:table_advanced:*>, 40);
set(9, 'pickaxe', <extrautils2:compressedcobblestone:4>);
set(9, 'pickaxe', <extrautils2:compressednetherrack:5>);
set(9, 'pickaxe', <libvulpes:metal0:7>);
set(9, 'pickaxe', <libvulpes:metal0:10>);
set(9, 'pickaxe', <netherendingores:ore_end_modded_1:4>);
set(9, 'pickaxe', <netherendingores:ore_end_modded_1:6>);
set(9, 'pickaxe', <netherendingores:ore_nether_modded_1:4>);
set(9, 'pickaxe', <netherendingores:ore_nether_modded_1:6>);
set(9, 'pickaxe', <plustic:osmiridiumblock:*>, 40);
set(9, 'pickaxe', <thermalfoundation:storage_alloy:5>);
set(9, 'pickaxe', <thermalfoundation:storage:6>);
set(9, 'pickaxe', <thermalfoundation:storage:7>);
set(9, 'pickaxe', <wificharge:wirelesscharger:*>, 40);
set(9, 'shovel', <advancedrocketry:moonturf_dark:*>, 40);
set(9, 'shovel', <advancedrocketry:moonturf:*>, 40);
set(10, 'pickaxe', <avaritia:extreme_crafting_table:*>, 50);
set(10, 'pickaxe', <draconicevolution:crafting_injector:*>, 20);
set(10, 'pickaxe', <draconicevolution:draconium_block:*>, 30);
set(10, 'pickaxe', <enderio:block_alloy_endergy:2>);
set(10, 'pickaxe', <environmentaltech:solar_cell_litherite:*>, 60);
set(10, 'pickaxe', <environmentaltech:solar_cont_5:*>, 60);
set(10, 'pickaxe', <environmentaltech:structure_frame_6:*>, 60);
set(10, 'pickaxe', <environmentaltech:void_ore_miner_cont_5:*>, 60);
set(10, 'pickaxe', <environmentaltech:void_res_miner_cont_5:*>, 60);
set(10, 'pickaxe', <extrautils2:compressedcobblestone:5>);
set(10, 'pickaxe', <jaopca:block_blockdilithium>, 15);
set(10, 'pickaxe', <jaopca:block_blockdimensionalshard:*>, 10);
set(10, 'pickaxe', <libvulpes:ore0:8>);
set(10, 'pickaxe', <thermalfoundation:ore_fluid:2>);
set(10, 'pickaxe', <thermalfoundation:ore_fluid:3>);
set(10, 'pickaxe', <thermalfoundation:ore_fluid:4>);
set(10, 'pickaxe', <thermalfoundation:ore:7>);
set(10, 'pickaxe', <thermalfoundation:storage_alloy:7>);
set(10, 'pickaxe', <trinity:solid_trinitite>, 15);
set(10, 'pickaxe', <twilightforest:castle_brick:*>, 50);
set(10, 'pickaxe', <twilightforest:castle_door:*>, 50);
set(10, 'pickaxe', <twilightforest:castle_pillar:*>, 50);
set(10, 'pickaxe', <twilightforest:castle_rune_brick:*>, 50);
set(10, 'pickaxe', <twilightforest:castle_stairs_brick:*>, 50);
set(10, 'pickaxe', <twilightforest:castle_stairs_cracked:*>, 50);
set(10, 'pickaxe', <twilightforest:castle_stairs_mossy:*>, 50);
set(10, 'pickaxe', <twilightforest:castle_stairs_worn:*>, 50);
set(10, 'pickaxe', <twilightforest:castle_stairs:*>, 50);
set(10, 'pickaxe', <twilightforest:castle_unlock:*>, 50);
set(10, 'pickaxe', <twilightforest:force_field:*>, 50);
set(11, 'pickaxe', <biomesoplenty:crystal:*>, 60);
set(11, 'pickaxe', <draconicevolution:diss_enchanter:*>, 60);
set(11, 'pickaxe', <draconicevolution:draconium_ore:*>, 60);
set(11, 'pickaxe', <draconicevolution:infused_obsidian:*>, 60);
set(11, 'pickaxe', <enderio:block_alloy_endergy:3>);
set(11, 'pickaxe', <environmentaltech:solar_cell_pladium:*>, 72);
set(11, 'pickaxe', <environmentaltech:solar_cont_6:*>, 72);
set(11, 'pickaxe', <environmentaltech:void_ore_miner_cont_6:*>, 72);
set(11, 'pickaxe', <environmentaltech:void_res_miner_cont_6:*>, 72);
set(11, 'pickaxe', <extendedcrafting:table_elite:*>, 60);
set(11, 'pickaxe', <extrautils2:compressedcobblestone:6>);
set(11, 'pickaxe', <libvulpes:ore0>);
set(11, 'pickaxe', <netherendingores:ore_end_modded_1:2>);
set(11, 'pickaxe', <netherendingores:ore_nether_modded_1:2>);
set(11, 'pickaxe', <trinity:trinitite>, 30);
set(11, 'shovel', <advancedrocketry:hotturf:*>, 60);
set(12, 'pickaxe', <additionalcompression:cobblestone_compressed:8>);
set(12, 'pickaxe', <additionalcompression:cobblestone_compressed:9>);
set(12, 'pickaxe', <advancedrocketry:crystal:*>, 72);
set(12, 'pickaxe', <advancedrocketry:geode:*>, 200);
set(12, 'pickaxe', <advancedrocketry:vitrifiedsand:*>, 200);
set(12, 'pickaxe', <avaritia:block_resource:*>, 84);
set(12, 'pickaxe', <avaritia:block_resource:1>);
set(12, 'pickaxe', <avaritia:block_resource:2>);
set(12, 'pickaxe', <avaritia:neutron_collector:*>, 72);
set(12, 'pickaxe', <avaritia:neutronium_compressor:*>, 72);
set(12, 'pickaxe', <draconicevolution:celestial_manipulator:*>, 72);
set(12, 'pickaxe', <draconicevolution:draconic_block:*>, 72);
set(12, 'pickaxe', <draconicevolution:draconium_block:1>);
set(12, 'pickaxe', <draconicevolution:draconium_ore:1>);
set(12, 'pickaxe', <draconicevolution:draconium_ore:2>);
set(12, 'pickaxe', <extendedcrafting:storage:1>);
set(12, 'pickaxe', <extendedcrafting:storage:2>);
set(12, 'pickaxe', <extendedcrafting:storage:3>);
set(12, 'pickaxe', <extendedcrafting:storage:4>);
set(12, 'pickaxe', <extendedcrafting:storage>);
set(12, 'pickaxe', <extendedcrafting:table_ultimate:*>, 72);
set(12, 'pickaxe', <extrautils2:compressedcobblestone:7>);
set(12, 'pickaxe', <netherendingores:ore_end_modded_1:14>);
set(12, 'pickaxe', <netherendingores:ore_nether_modded_1:14>);
set(12, 'pickaxe', <wificharge:personalcharger:*>, 72);
