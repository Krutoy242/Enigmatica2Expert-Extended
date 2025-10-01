#reloadable
#priority -6000
#ignoreBracketErrors

import crafttweaker.block.IBlock;
import crafttweaker.block.IBlockState;
import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.entity.IEntity;
import crafttweaker.world.IBlockPos;
import native.net.minecraft.item.ItemStack;
import mods.zenutils.StringList;
import scripts.lib.purge.purge;
import scripts.do.portal_spread.utils.stateToItem;

function giveChest(player as IPlayer, items as IItemStack[]) as void {
  var tag = {
    BCTileData: {
      Items: [],
    },
  } as IData;
  for i, item in items {
    tag = tag + { BCTileData: { Items: [item as IData + { Slot: i as short } as IData] } } as IData;
  }
  player.give(<draconicevolution:draconium_chest>.withTag(tag));
}

function forEachBlockState(callback as function(IItemStack,IBlockState)void) as void {
  for item in game.items {
    if (
      // Blacklist because crashing otherwise
      item.id.startsWith('avaritiafurnace:')
      || item.id.startsWith('bithop:screwhop')
    ) continue;

    var lastMeta = -1 as int; // Remember, -1 is not integer by default
    for sub in item.subItems { // Remember - .subItems return different values on server
      if (lastMeta == sub.damage) continue;
      lastMeta = sub.damage;
      val state = utils.getStateFromItem(sub);
      if (isNull(state)) continue;
      callback(sub, state);
    }
  }
}

function dumpOreBlocks() {
  print('##################################################');
  print('#                  Ore Blocks                    #');
  forEachBlockState(function (item as IItemStack, state as IBlockState) as void {
    val def = state.block.definition;
    val tool = def.getHarvestTool(state);
    val harvLevel = def.getHarvestLevel(state);
    if (tool == '' && harvLevel == -1 as int) return;

    // Check if block is ore
    var targetLvl = -1 as int;
    for ore in item.ores {
      if (!(ore.name.startsWith('oreEnd') || ore.name.startsWith('oreNether'))) continue;
      val isEnd = ore.name.startsWith('oreEnd');
      val material = ore.name.replaceAll('^(oreEnd|oreNether)', '');
      val origOre = oreDict['ore' + material];
      for origItem in origOre.items {
        val state = utils.getStateFromItem(origItem);
        if (isNull(state)) continue;
        val origLvl = state.block.definition.getHarvestLevel(state);
        targetLvl = max(3, origLvl) + (isEnd ? 3 : 2);
        break;
      }
      if (targetLvl > 0) break;
    }
    if (targetLvl < 0) return;

    // S:"extrautils2:compressedcobblestone:0"=pickaxe=3

    print('S:"' ~ def.id ~ ':' ~ item.damage ~ '"=' ~ tool ~ '=' ~ targetLvl ~ ' // was: ' ~ harvLevel ~ ' ' ~ item.displayName);
  });
  print('##################################################');
}

function dumpMiningLevelChart(world as IWorld, player as IPlayer, pos as IBlockPos) as void {
  var totalStates as int[] = [0];
  player.sendMessage('§8Counting states...');
  forEachBlockState(function (item as IItemStack, state as IBlockState) as void {
    totalStates[0] = totalStates[0] + 1;
  });
  player.sendMessage('§8Total: §6'~totalStates[0]~' §8looking...');

  val states as IBlockState[] = arrayOf(totalStates[0], null as IBlockState);
  val sorter = StringList.empty();
  forEachBlockState(function (item as IItemStack, state as IBlockState) as void {
    val def = state.block.definition;
    if (def.id.startsWith('pointer:')) return; // erroring

    val tool = def.getHarvestTool(state);
    val harvLevel = def.getHarvestLevel(state);
    if (tool == '' || harvLevel < 1) return;

    if (purge.isPurged(item)) return; // Purged

    states[sorter.size] = state;
    sorter.add(state.commandString~':::'~sorter.size);
    print('~~ found block: '~harvLevel~' '~state.commandString);
  });

  val sorted = sorter.toArray();
  sorted.sort();

  player.sendMessage('§8Building §6'~sorted.length~' §8entries...');
  val stack = intArrayOf(100, 0);
  for str in sorted {
    val separator = str.indexOf(':::');
    val index = str.substring(separator + 3) as int;
    val state = states[index];
    val def = state.block.definition;
    val harvLevel = def.getHarvestLevel(state);

    if (stack[harvLevel] > 256) continue; // skip if too huge bar

    val newPos = pos.north(stack[harvLevel]).east(harvLevel);
    stack[harvLevel] = stack[harvLevel] + 1;

    val present = world.getBlockState(newPos);
    // if (!present.isReplaceable(world, newPos)) {
    //   player.sendMessage('§8Cant replace block on: [§6'~newPos.x~'§8:§6'~newPos.y~'§8:§6'~newPos.z~'§8]');
    //   return;
    // }
    world.native.setBlockState(newPos, state, 2 | 4); // 2 = send to clients, 4 = don't notify neighbors
  }
}

function dumpLightSources(player as IPlayer) as void {
  for light in 13 .. 16 {
    var items = [] as IItemStack[];
    var ids = [] as string[];
    for i, block in game.blocks {
      val ll = block.lightLevel;
      if (ll <= 0) continue;
      utils.log(ll, block.id);

      if (ll == light) {
        ids += block.id;
      }
    }
    ids.sort();
    for id in ids {
      val item = itemUtils.getItem(id);
      if (!isNull(item)) items += item;
      else utils.log('Light without item:', id);
    }
    giveChest(player, items);
  }
}

function dumpTraits() as void {
  val traits = ['prosperous', 'duritos', 'tconevo.executor', 'tconevo.corrupting', 'tconevo.celestial_armor', 'tconevo.spectral_armor', 'mirabile', 'mana', 'tconevo.relentless', 'tconevo.aftershock1', 'lightweight_armor', 'invigorating_armor', 'tconevo.crystalline', 'magnetic1', 'heavy_armor', 'magnetic1_armor', 'tconevo.luminiferous', 'tconevo.opportunist', 'tconevo.radiant_armor', 'indomitable_armor', 'sharp', 'bloodymary', 'haorans_cult_armor', 'apocalypse', 'tconevo.modifiable1', 'crude1', 'mundane1_armor', 'coldblooded', 'tconevo.deadly_precision', 'prideful_armor', 'tconevo.divine_grace_armor', 'shocking', 'voltaic_armor', 'anticorrosion', 'devilsstrength', 'cheapskate', 'cheap_armor', 'tconevo.piezoelectric', 'xu_withering', 'chunky', 'lightweight', 'established', 'ambitious_armor', 'jagged', 'aquadynamic', 'aquaspeed_armor', 'rough_armor', 'xu_whispering', 'tconevo.sundering', 'tconevo.stifling_armor', 'tconevo.slimey_pink', 'tconevo.slimey_pink_armor', 'bouncy_armor', 'writable1', 'ecological', 'ecological_armor', 'xu_xp_boost', 'steady_armor', 'stonebound', 'tconevo.stonebound_armor', 'writable2', 'ratty', 'tasty', 'spectre', 'spectre_armor', 'alpha_fur', 'alpha_fur_armor', 'brownmagic', 'sassy', 'global', 'tconevo.eternal_density1', 'tconevo.culling', 'tconevo.staggering', 'tconevo.superdense_armor', 'dense_armor', 'infernal_armor', 'tconevo.eternal_density2', 'tconevo.juggernaut', 'tconevo.overwhelm', 'tconevo.ultradense_armor', 'tconevo.hearth_embrace_armor', 'tconevo.fertilizing', 'absorbent_armor', 'cheapskate_armor', 'crumbling', 'alien_armor', 'tconevo.mortal_wounds', 'enderference', 'vengeful_armor', 'enderport_armor', 'twilit', 'stalwart', 'dramatic_armor', 'synergy', 'endorium', 'tconevo.blasting', 'tconevo.vampiric', 'tconevo.foot_fleet', 'precipitate', 'autosmelt', 'superheat', 'flammable', 'superhot_armor', 'veiled', 'unnatural', 'petramor', 'holy', 'enderport-4', 'enderpickup', 'crude2', 'enderport-0', 'poisonous', 'enderport-2', 'enderport-3', 'enderport-1', 'dense', 'shielding_armor', 'hellish', 'splinters', 'alien', 'cheap', 'mundane2_armor', 'prickly', 'spiky', 'spiny_armor', 'splintering', 'fractured', 'splitting', 'calcic_armor', 'skeletal_armor', 'duritos_ranch_armor', 'squeaky', 'combustible_armor', 'magnetic2', 'magnetic2_armor', 'baconlicious', 'baconlicious_armor', 'tasty_armor', 'slimey_green', 'slimey_green_armor', 'slimey_blue', 'slimey_blue_armor', 'autoforge_armor', 'aridiculous', 'aridiculous_armor', 'momentum', 'featherweight_armor', 'subterranean_armor', 'petravidity_armor', 'insatiable', 'heavy', 'blessed_armor', 'stiff', 'hovering', 'breakable', 'freezing', 'endspeed', 'grinding_armor', 'splintering2', 'fractured2', 'splitting2', 'hive_defender', 'flame2', 'frost2', 'antigravity', 'arrow_knockback', 'in_the_garage', 'sweater_song', 'surf_wax_america', 'wolframium', 'magical_modifier', 'brittle', 'depthdigger', 'tconevo.photosynthetic', 'tconevo.photosynthetic_armor', 'tconevo.astral', 'tconevo.astral_armor', 'im_a_superstar', 'tconevo.aftershock3', 'tconevo.will_strength_armor', 'tconevo.condensing1', 'tconevo.reactive_armor', 'tconevo.omnipotence', 'tconevo.infinitum', 'tconevo.null_almighty_armor', 'tconevo.eternity_armor', 'tconevo.gale_force1_armor', 'tconevo.crystalys', 'tconevo.bloodbound', 'tconevo.soul_guard_armor', 'tconevo.bloodbound_armor', 'tconevo.sentient', 'tconevo.willful', 'tconevo.sentient_armor', 'tconevo.willful_armor', 'tconevo.aura_siphon', 'tconevo.aura_infused_armor', 'tconevo.mana_infused', 'tconevo.mana_infused_armor', 'tconevo.mana_affinity1_armor', 'tconevo.gaia_wrath', 'tconevo.mana_affinity2_armor', 'tconevo.second_wind_armor', 'tconevo.fae_voice', 'tconevo.cascading', 'tconevo.fae_voice_armor', 'tconevo.soul_rend1', 'tconevo.evolved', 'tconevo.evolved_armor', 'tconevo.soul_rend2', 'tconevo.soul_rend3', 'tconevo.gale_force2_armor', 'tconevo.chain_lightning', 'tconevo.thundergod_wrath', 'tconevo.battle_furor', 'tconevo.bulwark_armor', 'tconevo.shadowstep_armor', 'tconevo.modifiable2', 'tconevo.rejuvenating', 'tconevo.thundergod_favour_armor', 'tconevo.impact_force', 'tconevo.electric', 'tconevo.electric_armor', 'tconevo.ruination', 'tconevo.phoenix_aspect_armor', 'tconevo.energized1', 'tconevo.energized1_armor', 'tconevo.energized2', 'tconevo.energized2_armor', 'tconevo.chilling_touch_armor', 'tconevo.aftershock2', 'tconevo.warping', 'tconevo.warping_armor', 'thundering', 'tconevo.aura_affinity1_armor', 'withering', 'withering_armor', 'poisonous_armor', 'moldable2', 'moldable1', 'uplifting', 'moldable_armor2', 'moldable_armor1', 'uplifting_armor', 'explosive', 'camdaibay_armor', 'dunanstransport_armor', 'naturesblessing', 'tom_and_jerry_armor', 'natureswrath', 'naturespower', 'light', 'psicological', 'portly', 'disease', 'plague_shot', 'exhausting2', 'feasting', 'exhausting1', 'torporic_armor', 'nourishing_armor', 'elemental', 'terrafirma1', 'goodfridayagreement_armor',
  ] as string[];
  for trait in traits {
    var traitRef = trait;
    var name = game.localize('modifier.' ~ traitRef ~ '.name');
    if (name.matches('\\w+\\.\\w+\\.\\w+.*')) {
      traitRef = traitRef.replaceAll('\\d+', '');
      name = game.localize('modifier.' ~ traitRef ~ '.name');
    }

    print(traitRef ~ '===' ~ name ~ '===' ~ game.localize('modifier.' ~ traitRef ~ '.desc'));
  }
}

events.onPlayerLeftClickBlock(function (e as crafttweaker.event.PlayerLeftClickBlockEvent) {
  if (e.player.world.remote) return;
  if (isNull(e.player.currentItem)) return;

  if (<minecraft:arrow> has e.player.currentItem) {
    dumpMiningLevelChart(e.world, e.player, e.position.up(1));
    e.cancel();
    return;
  }

  if (
    !(<minecraft:stick> has e.player.currentItem)
    // || e.block.definition.id != 'minecraft:bedrock'
  ) return;

  val data = e.world.getBlock(e.position).data;
  if (
    !isNull(data)
    && !isNull(data.variables)
  ) {
    e.world.setBlockState(e.world.getBlockState(e.position),
    data.deepUpdate(
      { variables: { owner: "TrashboxBobylev", ownerUUID: "00c79cbd-42b7-4397-92ac-e269113e2d37" } },
      mods.zenutils.DataUpdateOperation.MERGE)
    , e.position);
    e.cancel();
    return;
  }

  e.player.sendMessage('§eLeft Clicked§r');
  // val chunkProvider = e.player.world.native.chunkProvider;
  // if (chunkProvider instanceof native.net.minecraft.world.gen.ChunkProviderServer) {
  //   val provider = chunkProvider as native.net.minecraft.world.gen.ChunkProviderServer;
  //   e.player.sendMessage('§3Loaded: '~provider.loadedChunks.length~'§r');
  //   for chunk in provider.loadedChunks {
  //     var teCount = 0;
  //     for pos, te in chunk.tileEntities {
  //       teCount += 1;
  //     }
  //     if(teCount > 0)
  //       e.player.sendMessage(`§7[${chunk.x}:${chunk.z}] TEs: ${teCount}`);
  //   }
  // }
  // dumpLightSources(e.player);
  // e.player.give(<thaumicaugmentation:morphic_tool>.withCapNBT({Parent:{
  //   'functional':{id:"openblocks:dev_null",Count:1,Damage:0 as short,tag:{ench:[{}],enchantmentColor:4408131,Unbreakable:1 as byte,infinite:{id:"chisel:cobblestone",Count:1,Damage:1 as short},inventory:{size:1,Items:[{Slot:0 as byte,id:"chisel:cobblestone",Count:64,Damage:1 as short}]}}},
  //   display:{id:"minecraft:golden_hoe",Count:1,Damage:0 as short}
  // }}));
  // dumpOreBlocks();
  // var i = 0;
  // val map as ItemStack[ItemStack] = native.com.github.alexthe666.rats.server.items.RatsNuggetRegistry.ORE_TO_INGOTS as ItemStack[ItemStack];
  // for k,v in map {
  //   print(i);
  //   i += 1;
  // }

  e.player.sendMessage('§8Done!§r');
});
