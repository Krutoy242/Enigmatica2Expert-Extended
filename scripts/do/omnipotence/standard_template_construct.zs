/*

Standard Template Construct (STC)

This feature grants players with Omnipotence a special /dank/null,
which contains infinite "blueprints" (resources) for building.

*/

#priority -90
#reloadable
#modloaded zenutils danknull gamestages

import crafttweaker.block.IBlockDefinition;
import crafttweaker.block.IBlockState;
import crafttweaker.data.IData;
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import scripts.do.portal_spread.utils.stateToItem;

// --- CONFIG ---
static INITIAL_STACK_SIZE as int = 4;
static STC_LORE as string = '§5STC Blueprint';
static STC_CORE_TAG as IData = {STC_Core: 1 as byte};
static STC_CORE_NAME as string = '§6STC Core';

// --- ITEM LIST ---

function getSTCItems() as [IItemStack] {
  val items = [] as [IItemStack];

  // --- Existing logic for adding items ---
  modItems('nuclearcraft', items, {
    include: { blockClass: '.*processor.BlockProcessor.*' },
  });
  modItems('libvulpes', items, {
    include: {
      blockClass: '.*Block(Motor|Hatch|MultiMachineBattery|Tile|MultiBlockComponentVisible).*',
      id   : '.*coil.*',
    },
    exclude: { id: '.*creative.*' },
  });
  modItems('advancedrocketry', items, {
    include: { blockClass: '.*Block(MultiblockMachine|MultiBlockComponentVisible)' },
    exclude: { id: '.*creative.*' },
  });
  modItems('mekanism', items, {
    include: { blockClass: '.*BlockMachine.*' },
    exclude: { display: '(.*[cC]reative.*|(Basic|Advanced) .+ (Factory|Fluid Tank))' },
  });

  items.addAll([
    <ae2fc:dual_interface>,
    <ae2fc:fluid_discretizer>,
    <ae2fc:fluid_level_maintainer>,
    <ae2fc:fluid_packet_decoder>,
    <ae2fc:fluid_pattern_encoder>,
    <ae2fc:large_ingredient_buffer>,
    <ae2fc:ultimate_encoder>,
    <ae2stuff:grower>,
    <ae2stuff:inscriber>,
    <ae2stuff:wireless>,
    <aeadditions:certustank>,
    <aeadditions:fluidcrafter>,
    <aeadditions:fluidfiller>,
    <aeadditions:gas_interface>,
    <aeadditions:vibrantchamberfluid>,
    <appliedenergistics2:cell_workbench>,
    <appliedenergistics2:charger>,
    <appliedenergistics2:chest>,
    <appliedenergistics2:condenser>,
    <appliedenergistics2:controller>,
    <appliedenergistics2:crafting_monitor>,
    <appliedenergistics2:crafting_unit>,
    <appliedenergistics2:dense_energy_cell>,
    <appliedenergistics2:drive>,
    <appliedenergistics2:energy_acceptor>,
    <appliedenergistics2:fluid_interface>,
    <appliedenergistics2:grindstone>,
    <appliedenergistics2:interface>,
    <appliedenergistics2:io_port>,
    <appliedenergistics2:molecular_assembler>,
    <appliedenergistics2:quantum_link>,
    <appliedenergistics2:quantum_ring>,
    <appliedenergistics2:quartz_growth_accelerator>,
    <appliedenergistics2:security_station>,
    <appliedenergistics2:spatial_io_port>,
    <appliedenergistics2:spatial_pylon>,
    <appliedenergistics2:vibration_chamber>,
    <appliedenergistics2:wireless_access_point>,
    <nae2:coprocessor_64x>,
    <nae2:storage_crafting_16384k>,
    <bedrockores:bedrock_miner>,
  ]);

  return items;
}

// --- LOGIC ---

function getPortableCellItems() as [IItemStack] {
  return [
    <appliedenergistics2:part:16>,
    <appliedenergistics2:part:56>,
    <appliedenergistics2:part:76>,
    <appliedenergistics2:part:120>,
    <appliedenergistics2:part:140>,
    <appliedenergistics2:part:220>,
    <appliedenergistics2:part:221>,
    <appliedenergistics2:part:222>,
    <appliedenergistics2:part:240>,
    <appliedenergistics2:part:241>,
    <appliedenergistics2:part:260>,
    <appliedenergistics2:part:261>,
    <appliedenergistics2:part:300>,
    <appliedenergistics2:part:516>,
    <nae2:storage_cell_16384k>,
    <nae2:storage_cell_fluid_16384k>,
  ] as [IItemStack];
}

function getPortableCell() as IItemStack {
  val cellItems = getPortableCellItems();
  var cellNbt = {
    internalMaxPower: 20000.0,
    internalCurrentPower: 20000.0,
    it: cellItems.length as short,
    SORT_BY: 'NAME',
    SORT_DIRECTION: 'ASCENDING',
    VIEW_MODE: 'ALL'
  } as IData + STC_CORE_TAG;

  for i, item in cellItems {
    val key1 = '#'~i;
    val key2 = '@'~i;
    cellNbt += {[key1]: {id: item.definition.id, Damage: item.damage as short, Count: 1, Cnt: 200L, Craft: 0 as byte, Req: 0L}} as IData;
    cellNbt += {[key2]: 200L} as IData;
  }
  
  return <appliedenergistics2:portable_cell>.withTag(cellNbt);
}

function giveDankNull(player as IPlayer, inventoryData as IData) as void {
  val dankNullTag = STC_CORE_TAG + {
    display    : {Name: STC_CORE_NAME},
    DankNullCap: {
      selectedIndex       : 0,
      'danknull-inventory': inventoryData,
    },
  } as IData + utils.shiningTag(5); // Pink shine for the core

  val dankNull = <danknull:dank_null_5>.withTag(dankNullTag);
  player.give(dankNull);
}

function getSatchel() as IItemStack {
  val thermalItems = [] as [IItemStack];
  
  modItems('thermalexpansion', thermalItems, { include: { id: '.*:(machine|cell|tank|device)' } });
  modItems('thermalexpansion', thermalItems, { include: { id: '.*:augment' } });
  thermalItems.add(<thermalfoundation:upgrade:35>);

  var inventoryTag = {} as IData;
  for i, item in thermalItems {
    var itemData = item.toData();
    itemData += {Count: item.maxStackSize};
    val key = "Slot"~i;
    inventoryTag += {[key]: itemData};
  }

  val satchelTag = {
    Accessible: 1 as byte,
    Inventory: inventoryTag,
    ench: [{lvl: 10 as short, id: <enchantment:cofhcore:holding>.id as short}]
  } as IData;

  return <thermalexpansion:satchel:4>.withTag(satchelTag);
}

function grant(player as IPlayer) as void {
  if (player.hasGameStage('stc_granted')) return;

  // Remove existing STC items
  for i in 0 .. player.inventorySize {
    val item = player.getInventoryStack(i);
    if (!isNull(item) && !isNull(item.tag) && !isNull(item.tag.STC_Core)) {
      item.mutable().shrink(item.amount);
    }
  }

  val stcItems = getSTCItems();
  var i = 0;
  while(i < stcItems.length) {
    var inventoryData = [] as IData;
    var slot = 0;
    for j in 0 .. 54 {
        if(i >= stcItems.length) break;
        val item = stcItems[i];
        
        val itemWithLore = item.withLore([STC_LORE]);
        val existingTag = isNull(itemWithLore.tag) ? {} as IData : itemWithLore.tag;
        val finalTag = existingTag + utils.shiningTag(6); // default color

        var itemNbt = itemWithLore.toData();
        // Remove extra data to keep NBT clean
        itemNbt = {id: itemNbt.id, Damage: itemNbt.Damage, Count: INITIAL_STACK_SIZE, Slot: slot, tag: finalTag};
        inventoryData += [itemNbt];
        slot += 1;
        i += 1;
    }
    if(inventoryData.length > 0) {
        giveDankNull(player, inventoryData);
    }
  }

  player.give(getPortableCell());
  player.give(scripts.mods.omniwand.superwand.withTag(scripts.mods.omniwand.superwand.tag + STC_CORE_TAG));
  player.give(getSatchel());

  player.addGameStage('stc_granted');
  player.sendRichTextMessage(crafttweaker.text.ITextComponent.fromTranslation('e2ee.stc.granted'));
}

// Replenishes resources in the STC
function handleBlockEvent(player as IPlayer, blockState as IBlockState) as void {
  if (isNull(player) || player.world.remote || isNull(blockState) || blockState == <blockstate:minecraft:air>) return;
  if (!scripts.do.omnipotence.op.op.isPlayerOmnipotent(player)) return;

  val invItem = player.mainHandHeldItem;
  if (isNull(invItem) || invItem.definition.id != 'danknull:dank_null_5' || isNull(invItem.tag.STC_Core)) {
    return;
  }

  val blockItem = stateToItem(blockState);
  if (isNull(blockItem)) return;

  // Found STC Core
  val dankNBT = invItem.tag;
  val oldInventory as [IData] = dankNBT.DankNullCap.memberGet('danknull-inventory').asList();
  var newInventory = [] as [IData];
  var inventoryUpdated = false;

  for j, slotItemData in oldInventory {
    if (!inventoryUpdated && slotItemData.id == blockItem.definition.id && slotItemData.Damage == blockItem.damage) {
      val currentCount = slotItemData.Count as int;
      if (currentCount < INITIAL_STACK_SIZE) {
        newInventory.add(slotItemData + {Count: currentCount + 1} as IData);
        inventoryUpdated = true;
      }
    }
    newInventory.add(slotItemData);
  }

  if (inventoryUpdated) {
    val updatedNBT = dankNBT.deepUpdate({DankNullCap: {'danknull-inventory': IData.createDataList(newInventory)}}, mods.zenutils.DataUpdateOperation.MERGE);
    player.setItemToSlot(mainHand, invItem.withTag(updatedNBT));
    if (player.world.remote)
      player.sendPlaySoundPacket('openblocks:bottler.signal', 'ambient', player.position, 0.2f, 1.5f + player.world.random.nextFloat() * 0.5);
    return; // Finish after processing one STC
  }
}

// --- EVENT HANDLERS ---

// Replenish resources on block place
events.register(function (e as crafttweaker.event.BlockPlaceEvent) {
  handleBlockEvent(e.player, e.blockState);
});

// --- HELPER FUNCTIONS ---

function testItemCondition(item as IItemStack, filter as string[string]) as bool {
  if (isNull(filter) || isNull(item)) return false;

  // Item-based filters
  if (!isNull(filter.id) && item.definition.id.matches(filter.id)) return true;
  if (!isNull(filter.display) && item.displayName.matches(filter.display)) return true;
  if (!isNull(filter.class)) {
    val className = toString(item.native.class);
    if (className.matches(filter.class)) return true;
  }

  // Block-based filters
  if (!isNull(filter.blockClass) || !isNull(filter.blockId)) {
    val state = utils.getStateFromItem(item);
    if (!isNull(state) && state.block.definition.id != 'minecraft:air') {
      val block = state.block;
      if (!isNull(filter.blockId) && block.definition.id.matches(filter.blockId)) return true;
      if (!isNull(filter.blockClass)) {
        val blockClassName = toString(block.definition.native.class);
        if (blockClassName.matches(filter.blockClass)) return true;
      }
    }
  }

  return false;
}

function modItems(mod as string, list as [IItemStack], filters as string[string][string]) as void {
  for item in loadedMods[mod].items {
    if (
      !testItemCondition(item, filters.exclude)
      && (isNull(filters.include) || testItemCondition(item, filters.include))
    ) {
      list.add(item);
    }
  }
}
