/*

Glitch sword perma damage, quick learner + glitch armor pristine drops

*/

#reloadable
#modloaded tconstruct deepmoblearning

import crafttweaker.entity.IEntityEquipmentSlot;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import native.mustapelto.deepmoblearning.common.DMLConfig;
import native.mustapelto.deepmoblearning.common.metadata.MetadataDataModel;
import native.mustapelto.deepmoblearning.common.metadata.MetadataManager;
import native.mustapelto.deepmoblearning.common.util.DataModelHelper;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.nbt.NBTTagCompound;
import native.net.minecraft.nbt.NBTTagList;
import native.net.minecraft.entity.EntityLivingBase;
import native.net.minecraft.entity.player.EntityPlayer;
import native.slimeknights.tconstruct.library.utils.TinkerUtil;

events.onEntityLivingDeathDrops(function (e as crafttweaker.event.EntityLivingDeathDropsEvent) {
  if (e.entity.world.remote) return;
  if (!(e.damageSource.trueSource instanceof IPlayer)) {
    return;
  }
  val player as IPlayer = e.damageSource.trueSource;

  val mainhand = player.mainHandHeldItem;
  if (isNull(mainhand)) {
    return;
  }

  val nPlayer = player.native as EntityPlayer;
  val liveStack = nPlayer.getHeldItemMainhand();
  if (isNull(liveStack)) {
    return;
  }

  val nativeTag = liveStack.getTagCompound();
  if (isNull(nativeTag)) {
    return;
  }
  val hasTrait = TinkerUtil.hasTrait(nativeTag, 'glitch_power');
  if (!hasTrait) return;

  val killedEntity = e.entity.native as EntityLivingBase;

  var foundDeepLearner = false;
  for i in 0 .. player.inventorySize {
    val stack = player.getInventoryStack(i);
    if (isNull(stack)) continue;
    if (stack.definition.id != 'deepmoblearning:deep_learner') continue;

    foundDeepLearner = true;
    val nativeDL = stack.native as ItemStack;
    val dlTag = nativeDL.getTagCompound();
    if (isNull(dlTag) || !dlTag.hasKey('Items', 9)) {
      continue;
    }

    val items = dlTag.getTagList('Items', 10) as NBTTagList;
    for j in 0 .. items.tagCount() - 1 {
      val slotTag = items.getCompoundTagAt(j) as NBTTagCompound;
      if (isNull(slotTag)) continue;
      val itemId = slotTag.getString('id');
      if (itemId != 'deepmoblearning:data_model') {
        continue;
      }

      val modelStack = ItemStack(slotTag);
      if (modelStack.isEmpty()) {
        continue;
      }

      val opt = DataModelHelper.getDataModelMetadata(modelStack);
      if (!opt.isPresent()) {
        continue;
      }
      val metadata = opt.get() as MetadataDataModel;
      val isAssociated = metadata.isAssociatedMob(killedEntity);
      if (!isAssociated) continue;

      val modelDataTag = slotTag.getCompoundTag('tag');
      val tier = modelDataTag.getInteger('tier');
      val currentData = modelDataTag.getInteger('data');
      val newData = currentData + (tier + 1);
      modelDataTag.setInteger('data', newData);
      break;
    }
  }

  val random = e.entity.world.getRandom();
  val swordNbt = liveStack.getTagCompound();
  if (isNull(swordNbt)) {
    return;
  }

  val currentPermDamage = swordNbt.getInteger('permDamage');
  if (currentPermDamage >= 18) {
    return;
  }

  val roll = random.nextInt(100);
  if (roll < 6) {
    var newDamage = currentPermDamage + 2;
    if (newDamage > 18) newDamage = 18;

    player.setItemToSlot(mainHand, mainhand.updateTag({ permDamage: newDamage as int }));

    if (newDamage >= 18) {
      player.sendMessage(
        game.localize('deepmoblearning.glitch_sword.max_damage_reached').replace('%s', mainhand.displayName)
      );
    }
    else {
      player.sendMessage(
        game.localize('deepmoblearning.glitch_sword.damage_increased').replace('%s', mainhand.displayName)
      );
    }
  }
});

events.onEntityLivingDeathDrops(function (e as crafttweaker.event.EntityLivingDeathDropsEvent) {
  if (e.entity.world.remote) return;
  if (!(e.damageSource.trueSource instanceof IPlayer)) return;
  val player as IPlayer = e.damageSource.trueSource;

  var glitchDropCount = 0;
  val slots = [head, chest, legs, feet] as IEntityEquipmentSlot[];

  for slot in slots {
    val armor = player.getItemInSlot(slot);
    if (isNull(armor)) continue;
    val nativeTag = (armor.native as ItemStack).getTagCompound();
    if (!isNull(nativeTag) && TinkerUtil.hasTrait(nativeTag, 'glitch_drop_armor')) {
      glitchDropCount += 1;
    }
  }

  if (glitchDropCount < 4) return;

  val pristineChance = DMLConfig.GLITCH_ARMOR_SETTINGS.GLITCH_ARMOR_PRISTINE_CHANCE as int;
  val pristineCount = DMLConfig.GLITCH_ARMOR_SETTINGS.GLITCH_ARMOR_PRISTINE_COUNT as int;

  if (pristineChance <= 0) return;

  val random = e.entity.world.getRandom();
  if (random.nextInt(100) < pristineChance) {
    val list = MetadataManager.getDataModelMetadataList();

    var pristineItem as IItemStack = null;
    for model in list {
      if (model.isAssociatedMob(e.entity.native as EntityLivingBase)) {
        val nativeStack = model.getPristineMatter(pristineCount);
        if (!isNull(nativeStack) && !nativeStack.isEmpty()) {
          pristineItem = nativeStack.wrapper;
          break;
        }
      }
    }

    if (!isNull(pristineItem)) {
      e.addItem(pristineItem);
    }
  }
});
