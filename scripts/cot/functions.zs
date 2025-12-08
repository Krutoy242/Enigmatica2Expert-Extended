#modloaded contenttweaker
#reloadable
#ignoreBracketErrors
#priority -100

import crafttweaker.block.IBlockState;
import crafttweaker.data.IData;
import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IFacing;
import crafttweaker.world.IWorld;
import mods.contenttweaker.BlockPos;
import mods.contenttweaker.BlockState;
import mods.contenttweaker.MutableItemStack;
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.World;
import native.net.minecraft.util.EnumParticleTypes;

function abs(n as double) as double { return n < 0 ? -n : n; }

// ------------------------------------------
// Anglesite and Benitoite
// ------------------------------------------
<cotBlock:ore_anglesite>.dropHandler = function (drops, world, position, state, fortune) {
  drops.clear();
  drops.add(<contenttweaker:anglesite>);
  for i in 0 .. fortune { drops.add(<contenttweaker:anglesite> % 50); }
};

<cotBlock:ore_benitoite>.dropHandler = function (drops, world, position, state, fortune) {
  drops.clear();
  drops.add(<contenttweaker:benitoite>);
  for i in 0 .. fortune { drops.add(<contenttweaker:benitoite> % 50); }
};

// ------------------------------------------
// Conglomerates
// ------------------------------------------
function getPlayer(world as IWorld, p as IBlockPos) as IPlayer {
  for pl in world.getAllPlayers() {
    if (abs(pl.x - p.x) > 60 || abs(pl.y - p.y) > 60 || abs(pl.z - p.z) > 60) continue;
    return pl;
  }
  return null;
}

function createParticles(world as IWorld, p as IBlockPos, type as EnumParticleTypes, amount as int = 10) as void {
  if (world.remote) return;
  (world.native as native.net.minecraft.world.WorldServer)
    .spawnParticle(type, 0.5 + p.x, 0.5 + p.y, 0.5 + p.z, amount, 0.25, 0.25, 0.25, 0.02, 0);
}

static lifeRecipes as double[IItemStack][IEntityDefinition] = {
  <entity:betteranimalsplus:goose>      : { <betteranimalsplus:golden_goose_egg>: 0.01, <minecraft:feather>: 4.0, <betteranimalsplus:goose_egg>: 0.25 },
  <entity:betteranimalsplus:lammergeier>: { <minecraft:feather>: 4.0, <minecraft:egg>: 0.25 },
  <entity:betteranimalsplus:pheasant>   : { <minecraft:feather>: 4.0, <betteranimalsplus:pheasant_egg>: 0.25 },
  <entity:betteranimalsplus:songbird>   : { <minecraft:feather>: 4.0, <minecraft:egg>: 0.25 },
  <entity:betteranimalsplus:turkey>     : { <minecraft:feather>: 4.0, <betteranimalsplus:turkey_egg>: 0.25 },
  <entity:emberroot:owl>                : { <minecraft:feather>: 4.0, <emberroot:owl_egg>: 0.25 },
  <entity:excompressum:angry_chicken>   : { <minecraft:feather>: 4.0, <minecraft:egg>: 0.25 },
  <entity:iceandfire:amphithere>        : { <iceandfire:amphithere_feather>: 1.0 },
  <entity:iceandfire:hippogryph>        : { <minecraft:feather>: 4.0 },
  <entity:iceandfire:if_cockatrice>     : { <minecraft:feather>: 4.0 },
  <entity:iceandfire:stymphalianbird>   : { <iceandfire:stymphalian_bird_feather>: 1.0 },
  <entity:minecraft:chicken>            : { <minecraft:feather>: 4.0, <minecraft:egg>: 0.25 },
  <entity:minecraft:ocelot>             : { <actuallyadditions:item_hairy_ball>: 0.25 },
  <entity:minecraft:parrot>             : { <minecraft:feather>: 4.0, <minecraft:egg>: 0.25 },
  <entity:randomthings:goldenchicken>   : { <minecraft:feather>: 4.0, <minecraft:egg>: 0.25 },
  <entity:twilightforest:penguin>       : { <minecraft:feather>: 4.0, <minecraft:egg>: 0.25 },
  <entity:twilightforest:raven>         : { <twilightforest:raven_feather>: 1.0, <minecraft:egg>: 0.25 },
  <entity:twilightforest:tiny_bird>     : { <minecraft:feather>: 4.0, <minecraft:egg>: 0.25 },
} as double[IItemStack][IEntityDefinition];

<cotBlock:conglomerate_of_life>.onBlockPlace = function (world, p, blockState) {
  if (!world.remote) scripts.do.build.entity.build(world, p, blockState);
  createParticles(world, p, EnumParticleTypes.HEART);
};
<cotBlock:conglomerate_of_life>.onBlockBreak = function (world, p, blockState) { createParticles(world, p, EnumParticleTypes.HEART); };
<cotBlock:conglomerate_of_life>.onRandomTick = function (world, p, blockState) {
  if (world.remote) return;

  val aabb = crafttweaker.util.IAxisAlignedBB.create(p.add(-8, -8, -8), p.add(8, 8, 8));
  for entity in world.getEntitiesWithinAABB(aabb) {
    if (isNull(entity.definition)) continue;
    val output = lifeRecipes[entity.definition];
    if (isNull(output)) continue;

    for outItem, outChance in output {
      val rnd = world.getRandom();
      if (outChance < 1.0 && rnd.nextInt(1.0 / outChance) != 0) continue;
      val w as IWorld = world;
      val amount = outChance < 1.0 ? 1 : rnd.nextInt(outChance) + 1;
      val itemEntity = (outItem * amount).createEntityItem(w, entity.x as float, entity.y as float, entity.z as float);
      itemEntity.motionY = 0.4;
      world.spawnEntity(itemEntity);
      createParticles(world, p, EnumParticleTypes.HEART, 3);
    }
  }
};

<cotBlock:conglomerate_of_sun>.onBlockPlace = function (world, p, blockState) {
  if (!world.remote) scripts.do.build.entity.build(world, p, blockState);
  createParticles(world, p, EnumParticleTypes.END_ROD, 10);
};
<cotBlock:conglomerate_of_sun>.onBlockBreak = function (world, p, blockState) { createParticles(world, p, EnumParticleTypes.END_ROD, 10); };
<cotBlock:conglomerate_of_sun>.onRandomTick = function (world, p, blockState) {
  if (world.remote) return;
  var hadEffect = false;
  for entity in world.getEntities() {
    if (isNull(entity.definition)) continue;
    if (!(entity instanceof crafttweaker.entity.IEntityAgeable)) continue;
    val ageable as crafttweaker.entity.IEntityAgeable = entity;

    // Already grown up
    if (ageable.growingAge >= 0) continue;

    // Speed up growth of ageble mobs
    ageable.addGrowth(300);
    hadEffect = true;
    createParticles(world, ageable.position, EnumParticleTypes.END_ROD, 10);
  }
  if (hadEffect) createParticles(world, p, EnumParticleTypes.END_ROD, 10);
};

// ------------------------------------------
// Coral
// ------------------------------------------
function canPlaceCoral(world as World, p as IBlockPos) as bool {
  val floorBlockId = world.getBlockState(p.down()).block.definition.id;
  return
    (floorBlockId == 'minecraft:sand' || floorBlockId == 'minecraft:gravel' || floorBlockId == 'minecraft:dirt')
    && world.getBlockState(p).block.definition.id == 'minecraft:water'
    && world.getBlockState(p.up()).block.definition.id == 'minecraft:water'
  ;
}
<cotBlock:compressed_coral>.onRandomTick = function (world as World, p as BlockPos, blockState as BlockState) {
  if (world.remote) return;

  if (world.getBlockState(p.up()).block.definition.id != 'minecraft:water') {
    val state as IBlockState = <blockstate:randomthings:biomestone>;
    world.destroyBlock(p, false);
    world.setBlockState(state, p);
    return;
  }

  for face in [east, north, west, south] as IFacing[] {
    if (world.getRandom().nextInt(2) != 0) continue;

    val coral = <blockstate:biomesoplenty:coral>;
    val newPos = p.getOffset(face, 1);
    if (canPlaceCoral(world, newPos)) {
      world.setBlockState(coral, newPos);
      val iworld as IWorld = world;
      (iworld.native as native.net.minecraft.world.WorldServer)
        .spawnParticle(EnumParticleTypes.WATER_DROP, 0.5 + p.x, 0.5 + p.y, 0.5 + p.z, 100, 0.5, 0.5, 0.5, 0.0, 0);
    }
  }
};

// ------------------------------------------
// Singularities
// ------------------------------------------
// Pairs of x:y coords sorted by distance from 0:0
static slotSurroundings as int[] = [
  0, 0, 0, 1, 0, -1, 1, 0, -1, 0, 1, 1, -1, 1, 1, -1, -1, -1,
  0, 2, 0, -2, 2, 0, -2, 0, 1, 2, -1, 2, 1, -2, -1, -2, 2, 1,
  -2, 1, 2, -1, -2, -1, 2, 2, -2, 2, 2, -2, -2, -2, 0, 3, 0,
  -3, 3, 0, -3, 0, 1, 3, -1, 3, 1, -3, -1, -3, 3, 1, -3, 1, 3,
  -1, -3, -1, 2, 3, -2, 3, 2, -3, -2, -3, 3, 2, -3, 2, 3, -2,
  -3, -2, 4, 0, -4, 0, 4, 1, -4, 1, 4, -1, -4, -1, 3, 3, -3,
  3, 3, -3, -3, -3, 4, 2, -4, 2, 4, -2, -4, -2, 4, 3, -4, 3,
  4, -3, -4, -3, 5, 0, -5, 0, 5, 1, -5, 1, 5, -1, -5, -1, 5,
  2, -5, 2, 5, -2, -5, -2, 5, 3, -5, 3, 5, -3, -5, -3, 6, 0,
  -6, 0, 6, 1, -6, 1, 6, -1, -6, -1, 6, 2, -6, 2, 6, -2, -6,
  -2, 6, 3, -6, 3, 6, -3, -6, -3, 7, 0, -7, 0, 7, 1, -7, 1, 7,
  -1, -7, -1, 7, 2, -7, 2, 7, -2, -7, -2, 7, 3, -7, 3, 7, -3,
  -7, -3, 8, 0, -8, 0, 8, 1, -8, 1, 8, -1, -8, -1, 8, 2, -8,
  2, 8, -2, -8, -2, 8, 3, -8, 3, 8, -3, -8, -3,
] as int[];

// Return slot index based on x:y coordinates
// Assume that first hotbar slot is 0:0
function coordToSlot(x as int, y as int) as int {
  return y == 0 ? x : (x + (4 - y) * 9);
}

function slotToCoord(slot as int) as int[] {
  return slot < 9 ? [slot, 0] : [slot % 9, 4 - slot / 9];
}

function getSingularityUpdateFunc(
  allIngredients as IIngredient,
  recipeFunction as function(IItemStack[string],bool)IItemStack
) as function(MutableItemStack,World,IEntity,int,bool)void {
  return function (stack as MutableItemStack, world as World, owner as IEntity, slot as int, isSelected as bool) as void {
    // skip each second frame to prevent item duping
    if (world.provider.worldTime % 2 == 0) return;

    // Singularity already charged
    if (stack.damage <= 0) return;

    if !(owner instanceof IPlayer) return;
    val player as IPlayer = owner;

    val result = player.fake
      ? consumeFromFake(slot, stack, player, allIngredients, recipeFunction)
      : consumeFromPlayer(slot, stack, player, allIngredients, recipeFunction);

    if (!isNull(result)) {
      val mutable = stack.mutable().withDamage(result.damage);
      if (result.hasTag) mutable.withTag(result.tag);
      else mutable.withTag(null);
    }
  };
}

function consumeFromFake(
  tickingSlot as int,
  stack as IItemStack,
  player as IPlayer,
  allIngredients as IIngredient,
  recipeFunction as function(IItemStack[string],bool)IItemStack
) as IItemStack {
  var result = stack;
  var consumed = 0;
  for i in 0 .. player.inventorySize {
    if (i == tickingSlot) continue;
    val item = consumeSingle(i, result, player, allIngredients, recipeFunction);
    if (isNull(item)) continue;
    result = item;
    consumed += 1;
  }

  return consumed > 0 ? result : null;
}

function consumeFromPlayer(
  tickingSlot as int,
  stack as IItemStack,
  player as IPlayer,
  allIngredients as IIngredient,
  recipeFunction as function(IItemStack[string],bool)IItemStack
) as IItemStack {
  val xy = slotToCoord(tickingSlot);
  val x = xy[0];
  val y = xy[1];

  var consumed = 0;
  var result = stack;
  for i in 0 .. slotSurroundings.length / 2 {
    val u = x + slotSurroundings[i * 2];
    val v = y + slotSurroundings[i * 2 + 1];
    if (0 > u || u > 8 || 0 > v || v > 3) continue;

    val nextSlot = coordToSlot(u, v);

    val item = consumeSingle(nextSlot, result, player, allIngredients, recipeFunction);
    if (isNull(item)) continue;
    result = item;

    consumed += 1;
    if (result.damage <= 0 || consumed >= 4) break;
  }

  // Set item result
  return consumed > 0 ? result : null;
}

function consumeSingle(
  slot as int,
  stack as IItemStack,
  player as IPlayer,
  allIngredients as IIngredient,
  recipeFunction as function(IItemStack[string],bool)IItemStack
) as IItemStack {
  val item = player.getInventoryStack(slot);

  if (isNull(item) || !(allIngredients has item)) return null;
  item.mutable().shrink(1);

  return recipeFunction({ '0': stack, '1': item }, false);
}

val singularIDs = scripts.cot.def.Op.singularIDs;
val singularOres = scripts.cot.def.Op.singularOres;
val singularCharges = scripts.cot.def.Op.singularCharges;

for i, id in singularIDs {
  val fullId = `${id}_singularity`;
  val item = <item:contenttweaker:${fullId}>;
  val ore = oreDict[singularOres[i]];
  val charge = singularCharges[i];
  val emptyIngr = <avaritia:singularity> ?? <minecraft:nether_star>;

  val recipeFunction as function(IItemStack[string],bool)IItemStack = scripts.do.diverse.addRecipe(
    fullId,
    emptyIngr,
    item,
    ore,
    charge
  );

  val needPowerStr = mods.zenutils.StaticString
    .format('%,d', charge)
    .replaceAll(',', '§8,§6');

  // Simulate crafting to find when "N types == N items each type"
  var middlePoint = 0;
  for i in 1 .. 100 {
    val power = scripts.do.diverse.getPower(intArrayOf(i, i));
    if (power > charge) {
      middlePoint = i;
      break;
    }
  }

  // Simulate crafting to find "1 item of each N types"
  var endPoint = 0;
  for i in 1 .. 100 {
    val power = scripts.do.diverse.getPower(intArrayOf(i, 1));
    if (power > charge) {
      endPoint = i;
      break;
    }
  }

  scripts.lib.tooltip.desc.jei(item,
    'singularity',
    ore.name,
    needPowerStr,
    middlePoint == 0 ? '?' : middlePoint,
    endPoint == 0 ? '?' : endPoint
  );

  val cotItem = native.youyihj.zenutils.api.cotx.brackets.BracketHandlerCoTItem.getItemRepresentation(fullId);
  cotItem.onItemUpdate = getSingularityUpdateFunc(ore, recipeFunction);
}

// Special crafting case for Garbage Singularity
mods.extendedcrafting.CompressionCrafting.addRecipe(<contenttweaker:garbage_singularity>.withTag({ completed: 1 as byte }),
  <rats:garbage_pile>, 10000, <rats:idol_of_ratlantis>, 2000000, 100000);

// ------------------------------------------
function createBedrockOre(world as World, contentId as string, contentProp as string, amount as int, pos as BlockPos) as void {
  val state = IBlockState.getBlockState(contentId, contentProp);
  if (isNull(state) || isNull(state.block) || isNull(state.block.definition)) {
    logger.logWarning('[Cot TE]: trying to create Bedrock Ore with wrong content: id: "'~contentId~'" prop: "'~toString(contentProp)~'"');
  }
  world.setBlockState(IBlockState.getBlockState('bedrockores:bedrock_ore', []), {
    oreId: state.block.definition.numericalId,
    oreMeta: state.meta,
    amount: amount,
  }, pos);
}

VanillaFactory.putTileEntityTickFunction(1, function(tileEntity, world, pos) {
  if (world.remote) return;
  val data as IData = tileEntity.data;

  // TE spawned wrongly
  if (!(data has 'name')) {
    // logger.logWarning(
    //   '[Cot TE]: Tile entity appear to have no required NBT tags! pos: '
    //   ~ '[' ~ pos.x~':'~pos.z~'] data: '~ data as string ~'');
    // world.setBlockState(<blockstate:minecraft:bedrock>, pos);
    val states = [
      'variant=energetic_alloy',
      'variant=redstone_alloy',
      'variant=conductive_iron',
      'variant=soularium',
      'variant=dark_steel',
      'variant=electrical_steel',
    ] as string[];
    createBedrockOre(world, 'enderio:block_alloy', states[world.random.nextInt(states.length)], 1, pos);
    return;
  }

  if (!isNull(data) && data has 'time') {
    val time = data.time.asInt();
    if (time <= 0) {
      createBedrockOre(world, data.name, data.prop, isNull(data.amount) ? 1 : data.amount, pos);
      return;
    }
    tileEntity.updateCustomData({time: time - 1});
  } else {
    tileEntity.updateCustomData({time: world.random.nextInt(5) + 5});
  }
});