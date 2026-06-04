#modloaded botania
#loader mixin

import mixin.CallbackInfo;
import mixin.CallbackInfoReturnable;
import mixin.Operation;
import native.com.google.common.collect.HashMultimap;
import native.com.google.common.collect.Multimap;
import native.java.awt.Color;
import native.java.util.Collections;
import native.java.util.Random;
import native.net.minecraft.entity.SharedMonsterAttributes;
import native.net.minecraft.entity.ai.attributes.AttributeModifier;
import native.net.minecraft.entity.monster.EntityCreeper;
import native.net.minecraft.entity.monster.EntityMob;
import native.net.minecraft.init.MobEffects;
import native.net.minecraft.item.ItemStack;
import native.net.minecraft.nbt.NBTTagCompound;
import native.net.minecraft.potion.PotionEffect;
import native.net.minecraft.util.EnumFacing;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.World;
import native.net.minecraft.world.WorldServer;
import native.net.minecraft.world.storage.loot.LootContext;
import native.net.minecraftforge.event.terraingen.DecorateBiomeEvent.Decorate;
import native.thaumcraft.common.entities.monster.cult.EntityCultistKnight;
import native.vazkii.botania.api.BotaniaAPI;
import native.vazkii.botania.api.item.IExoflameHeatable;
import native.vazkii.botania.api.mana.IManaPool;
import scripts.mixin.botania.looniumMobs;

#mixin { targets: 'vazkii.botania.client.integration.jei.manapool.ManaPoolRecipeWrapper' }
zenClass MixinManaPoolRecipeWrapper {
  #mixin Shadow
  #mixin Final
  var mana as int;

  #mixin Inject { method: 'getTooltipStrings', at: { value: 'HEAD' }, cancellable: true }
  function showManaNumericalValue(mouseX as int, mouseY as int, cir as CallbackInfoReturnable) as void {
    if (mouseX > 20 && mouseX < 125 && mouseY > 50 && mouseY < 54) {
      cir.setReturnValue([mana ~ ' mana'] as [string]);
    }
  }
}

#mixin { targets: 'vazkii.botania.client.integration.jei.runicaltar.RunicAltarRecipeWrapper' }
zenClass MixinRunicAltarRecipeWrapper {
  #mixin Shadow
  #mixin Final
  var manaUsage as int;

  function getTooltipStrings(mouseX as int, mouseY as int) as [string] {
    if (mouseX > 6 && mouseX < 111 && mouseY > 98 && mouseY < 102) {
      return [manaUsage ~ ' mana'];
    }
    return [];
  }
}

#mixin { targets: 'vazkii.botania.common.block.subtile.functional.SubTileOrechidIgnem' }
zenClass MixinSubTileOrechidIgnem {
  #mixin Inject { method: 'canOperate', at: { value: 'HEAD' }, cancellable: true }
  function showManaNumericalValue(cir as CallbackInfoReturnable) as void {
    cir.setReturnValue(true);
  }
}

// Fix crash on fighting Gaia II on server
// https://github.com/Krutoy242/Enigmatica2Expert-Extended/issues/344
#mixin { targets: 'vazkii.botania.common.entity.EntityDoppleganger' }
zenClass MixinEntityDoppleganger {
  #mixin Inject
  #{
  #  method: 'func_70636_d',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lvazkii/botania/common/entity/EntityDoppleganger;func_70106_y()V',
  #    shift: 'AFTER'
  #  },
  #  cancellable: true
  #}
  function stopUpdatingEntityWhenNoPlayerNearby(ci as CallbackInfo) as void {
    ci.cancel();
  }
}

#mixin { targets: 'vazkii.botania.common.brew.ModBrews' }
zenClass MixinModBrews {
  #mixin Static
  #mixin ModifyConstant { method: 'initTC', constant: { intValue: 12000 } }
  function increaseDuration(value as int) as int {
    return 1728000;
  }
}

#mixin { targets: 'vazkii.botania.common.core.handler.BiomeDecorationHandler' }
zenClass MixinBiomeDecorationHandler {
  #mixin Static
  #mixin Inject
  #{
  #  method: 'onWorldDecoration',
  #  at: {
  #    value: 'FIELD',
  #    target: 'Lvazkii/botania/common/core/handler/ConfigHandler;mushroomQuantity:I',
  #    opcode: 178
  #  },
  #  cancellable: true
  #}
  function doNotSpawnMushroomsInNoOrganicDimensions(event as Decorate, ci as CallbackInfo) as void {
    val dim = event.world.provider.dimension as int;
    for d in scripts.lib.dim.Op.tagsMap['NO_ORGANIC'] {
      if (d == dim) {
        ci.cancel();
        return;
      }
    }
  }
}

// Boost Exoflame to 10x speed (5x cookTime increment every 2 ticks)
// priority 1 so this applies AFTER MagicultureIntegrations' mixin
#mixin { targets: 'vazkii.botania.common.block.subtile.functional.SubTileExoflame', priority: 1 }
zenClass MixinSubTileExoflame {
  #mixin WrapOperation
  #{
  #  method: 'onUpdate',
  #  at: {
  #    value: 'INVOKE',
  #    target: 'Lvazkii/botania/api/item/IExoflameHeatable;boostCookTime()V'
  #  }
  #}
  function buffHeatable(heatable as IExoflameHeatable, op as Operation) as void {
    for i in 0 .. 5 {
      op.call(heatable);
    }
  }

  // Replace all int constant 1 with 5 across every method in this class.
  // This safely covers:
  //   - vanilla furnace cookTime +1 -> +5
  //   - MI IHeatableTile.boostCookTimeHeatable(1) -> (5)
  //   - MI IBoostableTile.boostCookTimeBoostable(1) -> (5)
  //   - boolean true assignments (5 is still true in JVM)
  //   - canFurnaceSmelt() boolean returns (5 is still true)
  #mixin ModifyConstant { method: '*', constant: { intValue: 1 } }
  function buffCookTime(value as int) as int {
    return 5;
  }
}

#mixin {targets: "vazkii.botania.common.block.subtile.functional.SubTileLoonuim"}
zenClass MixinSubTileLoonuim {

	#mixin Inject {method: "onUpdate", at: {value: "INVOKE", target: "Lnet/minecraft/tileentity/TileEntity;func_145831_w()Lnet/minecraft/world/World;", shift: "BEFORE"}, cancellable: true}
	function afterSuperUpdate(ci as CallbackInfo) as void {
		val world as World = this0.supertile.getWorld();
		val rand as Random = world.rand;
		if(!world.isRemote && this0.redstoneSignal == 0 && this0.ticksExisted % 100 == 0 && this0.mana >= 35000) {
			
            
			var stack as ItemStack = ItemStack.EMPTY;
			while(stack.isEmpty() || BotaniaAPI.looniumBlacklist.contains(stack.getItem())){
				var stacks as [ItemStack] = world.getLootTableManager().getLootTableFromLocation(this0.lootTable).generateLootForPools(rand, LootContext.Builder(world as WorldServer).build());
				if (stacks.isEmpty()){
					return;
				} else {
					stack = stacks[rand.nextInt(stacks.length)];
				}
			}
            
			val bound as int = 5 * 2 + 1;
			val xp as int = this0.supertile.getPos().getX() - 5 + rand.nextInt(bound);
			val yp as int = this0.supertile.getPos().getY();
			val zp as int = this0.supertile.getPos().getZ() - 5 + rand.nextInt(bound);
			
			var pos as BlockPos = BlockPos(xp, yp - 1, zp);
			while(world.getBlockState(pos).causesSuffocation()) {
				pos = pos.up();
				if(pos.getY() >= 254) return;
			}
			pos = pos.up();

			val x as double = rand.nextDouble() + pos.getX();
			val y as double = rand.nextDouble() + pos.getY();
			val z as double = rand.nextDouble() + pos.getZ();
			val entity as EntityMob = looniumMobs.mobList[rand.nextInt(looniumMobs.mobList.length)].getMob(world);
            
			entity.setPositionAndRotation(x, y, z, world.rand.nextFloat() * 360.0f, 0);
			entity.motionX = 0.0;
            entity.motionY = 0.0;
            entity.motionZ = 0.0;
			
			val map as Multimap = HashMultimap.create();
			map.put(SharedMonsterAttributes.MAX_HEALTH.getName(), AttributeModifier("Loonium Modififer Health", 2, 1));
			map.put(SharedMonsterAttributes.ATTACK_DAMAGE.getName(), AttributeModifier("Loonium Modififer Damage", 1.5, 1));
			entity.getAttributeMap().applyAttributeModifiers(map);

			entity.addPotionEffect(PotionEffect(MobEffects.FIRE_RESISTANCE, entity instanceof EntityCreeper ? 100 : 2000000, 0));
			entity.addPotionEffect(PotionEffect(MobEffects.REGENERATION, entity instanceof EntityCreeper ? 100 : 2000000, 0));

			val cmp as NBTTagCompound = stack.writeToNBT(NBTTagCompound());
			entity.getEntityData().setTag("botania:looniumItemStackToDrop", cmp);

			entity.onInitialSpawn(world.getDifficultyForLocation(pos), null);
			world.spawnEntity(entity);
			entity.spawnExplosionParticle();
			
			this0.mana = this0.mana - 35000;
			this0.sync();
            
		}
  ci.cancel();
	}
}
