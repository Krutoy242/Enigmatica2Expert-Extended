#ignoreBracketErrors
#modloaded botania
#reloadable

import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.entity.IEntityLiving;
import crafttweaker.entity.AttributeModifier;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;

import native.net.minecraft.item.ItemStack;
import native.net.minecraft.tileentity.TileEntity;
import native.net.minecraft.util.ResourceLocation;
import native.net.minecraft.util.math.BlockPos;
import native.net.minecraft.world.WorldServer;
import native.net.minecraft.world.storage.loot.LootContext;
import native.vazkii.botania.api.BotaniaAPI;
import native.vazkii.botania.common.block.subtile.functional.SubTileLoonuim;

static mobList as [IEntityDefinition] = [
  // Default Loonium list
  <entity:minecraft:cave_spider>,
  <entity:minecraft:creeper>,
  <entity:minecraft:enderman>,
  <entity:minecraft:evocation_illager>,
  <entity:minecraft:husk>,
  <entity:minecraft:skeleton>,
  <entity:minecraft:spider>,
  <entity:minecraft:stray>,
  <entity:minecraft:vindication_illager>,
  <entity:minecraft:zombie>,

  // Enhanced
  <entity:betteranimalsplus:tarantula>,
  <entity:betteranimalsplus:zotzpyre>,
  <entity:iceandfire:dread_beast>,
  <entity:iceandfire:dread_ghoul>,
  <entity:iceandfire:dread_knight>,
  <entity:iceandfire:dread_lich>,
  <entity:iceandfire:dread_scuttler>,
  <entity:nuclearcraft:feral_ghoul>,
  <entity:quark:ashen>,
  <entity:quark:dweller>,
  <entity:rats:feral_ratlantean>,
  <entity:thaumcraft:cultistcleric>,
  <entity:thaumcraft:cultistknight>,
  <entity:thaumcraft:inhabitedzombie>,
  <entity:thaumcraft:taintacle>,
  <entity:thaumicaugmentation:eldritch_guardian>,
  <entity:twilightforest:adherent>,
  <entity:twilightforest:snow_guardian>,
  <entity:twilightforest:troll>,
];

scripts.mixin.botania.shared.Op.looniumOnUpdate =
  function (flower as SubTileLoonuim, supertile as TileEntity, lootTableStr as string) as void {
    val world as IWorld = supertile.getWorld() as IWorld;
    val rand = world.random;

    if (world.remote || flower.redstoneSignal != 0 || flower.ticksExisted % 100 != 0 || flower.mana < 35000) return;

    val nativeWorld = world.native;
    val nativeRand = nativeWorld.rand;
    var stack as ItemStack = ItemStack.EMPTY;

    while stack.isEmpty() || BotaniaAPI.looniumBlacklist.contains(stack.getItem()) {
      val lootTable = nativeWorld.getLootTableManager().getLootTableFromLocation(ResourceLocation(lootTableStr));
      val stacks = lootTable.generateLootForPools(nativeRand, LootContext.Builder(nativeWorld as WorldServer).build());
      if (stacks.isEmpty()) return;
      val stacksArr = stacks as [ItemStack];
      stack = stacksArr[rand.nextInt(stacksArr.length)];
    }

    val bound = 5 * 2 + 1;
    val flowerPos = IBlockPos.create(supertile.getPos().getX(), supertile.getPos().getY(), supertile.getPos().getZ());
    val xp = flowerPos.x - 5 + rand.nextInt(bound);
    val yp = flowerPos.y;
    val zp = flowerPos.z - 5 + rand.nextInt(bound);

    var nativePos = BlockPos(xp, yp - 1, zp);
    while nativeWorld.getBlockState(nativePos).causesSuffocation() {
      nativePos = nativePos.up();
      if (nativePos.getY() >= 254) return;
    }
    nativePos = nativePos.up();

    val x = rand.nextDouble() + nativePos.getX();
    val y = rand.nextDouble() + nativePos.getY();
    val z = rand.nextDouble() + nativePos.getZ();

    val entityDef = mobList[rand.nextInt(mobList.length)];
    val entity = entityDef.createEntity(world);
    val entityLiving as IEntityLiving = entity;

    entity.posX = x;
    entity.posY = y;
    entity.posZ = z;
    entity.rotationYaw = rand.nextFloat() * 360.0f;
    entity.rotationPitch = 0;
    entity.motionX = 0.0;
    entity.motionY = 0.0;
    entity.motionZ = 0.0;

    entityLiving.getAttribute("generic.maxHealth").applyModifier(AttributeModifier.createModifier("Loonium Modifier Health", 2, 1));
    entityLiving.getAttribute("generic.attackDamage").applyModifier(AttributeModifier.createModifier("Loonium Modifier Damage", 1.5, 1));
    entityLiving.health = entityLiving.maxHealth;

    val isCreeper = entityDef.id == "minecraft:creeper";
    val effectDuration = isCreeper ? 100 : 2000000;
    entityLiving.addPotionEffect(<potion:minecraft:fire_resistance>.makePotionEffect(effectDuration, 0));
    entityLiving.addPotionEffect(<potion:minecraft:regeneration>.makePotionEffect(effectDuration, 0));

    val cmp = stack.writeToNBT(native.net.minecraft.nbt.NBTTagCompound());
    entity.native.getEntityData().setTag("botania:looniumItemStackToDrop", cmp);

    (entity.native as native.net.minecraft.entity.EntityLiving).onInitialSpawn(
      nativeWorld.getDifficultyForLocation(nativePos), null);
    world.spawnEntity(entity);
    entityLiving.spawnExplosionParticle();

    flower.mana -= 35000;
    flower.sync();
  };
