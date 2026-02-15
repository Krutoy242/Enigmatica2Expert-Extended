/**
 * @file Bunch of handy utilities for zenscript
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#modloaded zenutils
#priority 4000
#reloadable

import crafttweaker.block.IBlockState;
import crafttweaker.command.ICommandSender;
import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.oredict.IOreDictEntry;
import crafttweaker.recipes.IRecipeFunction;
import crafttweaker.util.Math;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import mods.zenutils.StaticString;
import native.net.minecraft.util.SoundCategory;
import native.net.minecraft.util.SoundEvent;
import native.net.minecraft.util.EnumParticleTypes;
import native.net.minecraft.entity.monster.EntityMob;
import native.crafttweaker.mc1120.data.NBTConverter;
import native.net.minecraft.nbt.JsonToNBT.getTagFromJson;

zenClass Utils {
  var DEBUG as bool = false;

  zenConstructor() { }

  val modPreference as string[] = [
    'minecraft',
    'thermalfoundation',
    'immersiveengineering',
    'ic2',
    'mekanism',
    'appliedenergistics2',
    'actuallyadditions',
    'tconstruct',
    'chisel',
  ];

  function oreToItem(ore as string) as IItemStack { return oreToItem(oreDict[ore]); }
  function oreToItem(ore as IOreDictEntry) as IItemStack {
    val oreItems = ore.items;
    if (oreItems.length <= 0) return null;
    if (oreItems.length == 1 && !isNull(oreItems[0])) return oreItems[0];

    var firstItem = null as IItemStack;
    for preffer in modPreference {
      for item in oreItems {
        if (isNull(item)) {
          logger.logWarning('oredict entry "' ~ ore.name ~ '" content empty items.');
          continue;
        }

        if (item.definition.id.startsWith(preffer ~ ':'))
          return item;
        firstItem = firstItem ?? item;
      }
    }

    return firstItem;
  }

  val getSomething as function(string,string[],int)IItemStack
    = function (oreName as string, entryNames as string[], amount as int) as IItemStack {
      return null;
    };

  // Return result of smelting in vanilla furnace
  function smelt(input as IIngredient) as IItemStack {
    for r in furnace.all {
      if (r.input has input || input has r.input) return r.output;
    }
    return null;
  }

  function firstItem(ingr as IIngredient) as IItemStack {
    if (ingr.itemArray.length <= 0) { return null; }
    val a = ingr.itemArray[0];
    return a.damage == 32767 ? a.withDamage(0) : a;
  }

  function iterateOredict(ore as IOreDictEntry, callback as function(IItemStack)void) as void {
    for item in ore.items {
      if (item.damage == 32767) {
        logger.logWarning(
          'Trying to iterate oredict "' ~ ore.name
          ~ '", but it have wildcarded item ' ~ item.commandString
          ~ '. Script cannot propertly iterate wildcarded items.'
        );
        callback(item.withDamage(0));
      }
      callback(item);
    }
  }

  function compact(small as IIngredient, big as IIngredient) as void {
    if (small.itemArray.length <= 0 || big.itemArray.length <= 0) {
      logger.logWarning('Cannot compact ' ~ small.commandString ~ ' into ' ~ big.commandString);
      return;
    }
    recipes.addShapeless(firstItem(big).anyAmount(), [small, small, small, small, small, small, small, small, small]);
    recipes.addShapeless(firstItem(small) * 9, [big]);
  }

  function ingredientFromArrayByRegex(regex as string) as IIngredient {
    val items = itemUtils.getItemsByRegexRegistryName(regex);
    if (!isNull(items) && items.length > 0) {
      if (items.length == 1) return items[0];

      var result = items[0] as IIngredient;
      for i in 1 .. items.length {
        result |= items[i];
      }
      return result;
    }

    return null;
  }

  function fakeIngredient(displayed as IIngredient, actual as IIngredient) as IIngredient {
    return actual;
    // TODO: Fix not working in recipes
    // return displayed.only(function (item) {
    //   return actual has item;
    // });
  }

  /**
   * Name that only display over ingredient but not actually require it on craft
   * Idea from:
   * https://github.com/DoremySwee/Art-of-Enigma/blob/2465b90209ced64f5a1ca65ffdd17b6d60e2206c/scripts/recipes/libs/Misc.zs#L47-L67
   */
  function tempName(ins as IIngredient, local as string, colorID as int = 6) as IIngredient {
    var result as IIngredient = null;
    for i in ins.items {
      val item = locName(shine(i, colorID), local);
      if (isNull(result)) result = item;
      else result |= item;
    }

    // Guard for uninitialized oredicts
    if (isNull(result)) return ins;

    return fakeIngredient(result, ins);
  }

  function reuse(ins as IIngredient) as IIngredient {
    return tempName(ins, 'description.crt.reuse').reuse();
  }

  function consume(ins as IIngredient) as IIngredient {
    return tempName(ins, 'description.crt.consume').noReturn();
  }

  // ########################
  // Conditional Loging
  // ########################
  function log(a as string) as void { log(a, null, null); }
  function log(a as string, b as string) as void { log(a, b, null); }
  function log(a as string, b as string, c as string) as void {
    if (DEBUG) print(
      (!isNull(a) ? a : '')
      ~ (!isNull(b) ? ' ' ~ b : '')
      ~ (!isNull(c) ? ' ' ~ c : ''));
  }

  function log(arr as string[]) as void {
    if (DEBUG) {
      if (isNull(arr) || arr.length <= 0) {
        print('');
        return;
      }
      var s = '';
      for str in arr {
        s = s ~ ' ' ~ str;
      }
      print(s);
    }
  }

  // ########################
  // Graph
  // ########################
  function graph(map as string[], keys as string[][string]) as string[][double[string]] { return graph(map, null, keys); }
  function graph(map as string[], options as IData, keys as string[][string]) as string[][double[string]] {
    if (isNull(map) || map.length <= 0) {
      logger.logWarning('utils.graph() first argument should be non-empty string[].');
      return {};
    }

    // Determine max dimensions
    val height = map.length;
    var width = 0;
    for line in map {
      width = max(width, line.length);
    }

    if (width <= 0) {
      logger.logWarning('utils.graph() first argument should content at least one non-empty string');
      return {};
    }

    // Compute min-max for each dimension
    val dopt = D(options);
    val minX = dopt.getDouble('x.min', 0.0);
    val maxX = dopt.getDouble('x.max', 1.0);
    val minY = dopt.getDouble('y.min', 0.0);
    val maxY = dopt.getDouble('y.max', 1.0);
    val stepX = dopt.get('x.step');
    val stepY = dopt.get('y.step');

    // Determine doulbe steps
    val intervalX = (maxX - minX) / (max(1, width - 1) as double);
    val intervalY = (maxY - minY) / (max(1, height - 1) as double);

    // Write result
    val result as string[][double[string]] = {};
    var resultLen = 0;
    for y in 0 .. map.length {
      for x in 0 .. map[y].length {
        val c = map[y][x];
        if (c != ' ' && !isNull(keys[c])) {
          var X = intervalX * x + minX;
          var Y = maxY - intervalY * y;
          if (!isNull(stepX)) X = ((X / stepX.asDouble()) as int) as double * stepX.asDouble();
          if (!isNull(stepY)) Y = ((Y / stepY.asDouble()) as int) as double * stepY.asDouble();
          result[{ x: X, y: Y } as double[string]] = keys[c];
          resultLen += 1;
        }
      }
    }

    if (resultLen <= 0) logger.logWarning('utils.graph() graph cant find any valid key');

    return result;
  }

  static defaultEmount as double[string] = {
    Amber              : 2.0,
    Amethyst           : 2.0,
    Apatite            : 10.0,
    Aquamarine         : 4.0,
    CertusQuartz       : 3.0,
    ChargedCertusQuartz: 2.0,
    Coal               : 5.0,
    Diamond            : 2.0,
    DimensionalShard   : 4.0,
    Emerald            : 2.0,
    Glowstone          : 4.0,
    Lapis              : 10.0,
    Malachite          : 2.0,
    Peridot            : 2.0,
    Quartz             : 3.0,
    QuartzBlack        : 2.0,
    quicksilver        : 2.0,
    Redstone           : 10.0,
    Ruby               : 2.0,
    Sapphire           : 2.0,
    Tanzanite          : 2.0,
    Topaz              : 2.0,
  } as double[string];

  function countOutput(item as IItemStack, oreName as string) as IItemStack {
    val def = defaultEmount[oreName];
    if (isNull(def)) return amountClamp(item);

    val d = def as double;
    if (d != 0.0) {
      return item * min(64, (((item.amount as double - 1.0) * (d * 0.75) + d) as int));
    }
    return amountClamp(item);
  }

  function amountClamp(item as IItemStack) as IItemStack {
    if (isNull(item)) return null;
    if (item.amount == 1) return item.anyAmount();
    return item * min(64, item.amount);
  }

  // Turn one item into another but keep all tags
  val upgradeFnc as IRecipeFunction = function (out, ins, cInfo) {
    if (ins has 'marked' && !isNull(ins.marked) && !isNull(ins.marked.tag)) {
      val tag = ins.marked.tag;
      return out.withTag(tag);
    }
    return out;
  };

  // Smart keeping tags, like enchantments and EnderIO upgrades
  val smartUpgradeFnc as IRecipeFunction = function (out, ins, cInfo) {
    if (isNull(ins)) return out;

    // Find origin item with tag
    var originItem as IItemStack = ins.marked;
    if (isNull(originItem)) {
      for key, ingr in ins {
        if (isNull(ingr) || isNull(ingr.tag)) continue;
        originItem = ingr;
        break;
      }
    }
    if (isNull(originItem) || isNull(originItem.tag) || originItem.tag == {} as IData) return out;

    // Copy whitelisted tags
    var newTag = isNull(out.tag) ? {} as IData : out.tag;
    val oldMod = originItem.definition.id.split(':')[0];
    val newMod = out.definition.id.split(':')[0];
    val sameMod = oldMod == newMod;
    for key, value in originItem.tag.asMap() {
      if (
        (sameMod && (
          key.startsWith('enderio.')
        ))
        || key == 'ench'
        || key == 'infench'
        || key == 'ncRadiationResistance'
        || key == 'enchantmentColor'
        || key == 'hasIC2Jetpack'
        || key == 'spectreAnchor'
        || key == 'display'
      )
        newTag += { [key]: value } as IData;
    }

    return out.withTag(newTag);
  };

  // Safe get item with nbt tag and amount
  function get(id as string) as IItemStack { return get(id, 0, 1, null); }
  function get(id as string, meta as short) as IItemStack { return get(id, meta, 1, null); }
  function get(id as string, meta as short, amount as int) as IItemStack { return get(id, meta, amount, null); }
  function get(id as string, meta as short, amount as int, nbt as IData) as IItemStack { return get(itemUtils.getItem(id, meta), amount, nbt); }
  function get(item as IItemStack, amount as int) as IItemStack { return get(item, amount, null); }
  function get(item as IItemStack, amount as int, nbt as IData) as IItemStack {
    if (isNull(item)) return null;

    return isNull(nbt)
      ? (amount > 1 ? item * amount : item)
      : (amount > 1 ? item * amount : item).withTag(nbt);
  }

  // Clear Fluid tag on item preserving other tags
  function oreNameToFluid(oreName as string) as ILiquidStack {
    val spellingVariations = {
      Aluminium: 'Aluminum',
      AstralStarmetal: 'starmetal',
    } as string[string];
    return game.getLiquid((spellingVariations[oreName] ?? oreName).toLowerCase());
  }

  // Clear Fluid tag on item preserving other tags
  function clearFluid(input as IItemStack) as void {
    clearFluid(input, 'Fluid Clearing ' ~ input.definition.id.replaceAll(':', '_') ~ '_' ~ input.damage);
  }

  function clearFluid(input as IItemStack, recipeName as string) as void {
    recipes.addShapeless(recipeName,
      input, [input.marked('marked')],
      function (out, ins, cInfo) {
        if (ins has 'marked' && !isNull(ins.marked) && ins.marked.hasTag) {
          var tag = ins.marked.tag;
          if (!isNull(tag.Fluid)) {
            // Usual tanks
            tag = tag - 'Fluid';
          }
          else
            if (!isNull(tag.tank)) {
            // Open Blocks
              tag = tag - 'tank';
            }
            else
              if (!isNull(tag.FluidName) && !isNull(tag.Amount)) {
                // Black hole or other
                tag = tag - 'FluidName' - 'Amount';
              }

          if (tag == {} as IData) return out;
          return out.withTag(tag);
        }
        return out;
      }, null);
  }

  function sortInt(list as int[]) as int[] {
    if (isNull(list)) return null;
    if (list.length == 1) return [0];

    var sorted = [] as int[];
    for i in 0 .. list.length {
      var g_v = 0;
      var g_i = i;
      for j in 0 .. list.length {
        if (list[j] >= g_v && !(sorted has j)) {
          g_v = list[j];
          g_i = j;
        }
      }
      sorted += g_i;
    }
    return sorted;
  }

  val executeCommandSilent as function(ICommandSender,string)void
    = function (sender as ICommandSender, command as string) as void {};

  val geyser as function(IWorld,IItemStack,float,float,float,int,double,double,double,int)void
  = function (
    world as IWorld, // World where everything happen
    output as IItemStack, // Item that would be spawned
    x as float, y as float, z as float, // Position where new items spawned
    desiredAmount as int, // Number of new items spawned
    mx as double, my as double, mz as double, // Motion of spawned items
    delay as int // Delay between spawning
  ) as void {
  val rnd = world.getRandom();
    val f = desiredAmount as float / 8.0f;
    var total = 0;
    var i = 0;
    val pos = crafttweaker.util.Position3f.create(x, y, z);
    while (total < desiredAmount) {
    val count = max(1, (f * (i + 1) + 0.5f) as int - total);
      total += count;

      val itemEntity = (output * count).createEntityItem(world, x, y, z);
      itemEntity.motionY = my + 0.4;
      itemEntity.motionX = mx + rnd.nextDouble(-0.1, 0.1);
      itemEntity.motionZ = mz + rnd.nextDouble(-0.1, 0.1);
      world.spawnEntity(itemEntity);

      (world.native as native.net.minecraft.world.WorldServer).spawnParticle(
        EnumParticleTypes.FIREWORKS_SPARK,
        x as double, y as double, z as double, 5, 0.0, 0.1, 0.0, 0.1, 0);

      i += 1;
    }
  };

  // Get Shimmer enchant + Random Things colored shining
  val shimmerTag as IData = { ench: [{}] };
  function shiningTag(color as int) as IData {
    return { enchantmentColor: color } as IData + shimmerTag;
  }

  function shine(item as IItemStack, colorID as int = 6) as IItemStack {
    if (isNull(item)) return null;
    return item.withTag(item.tag.deepUpdate(shimmerTag + {
        'Quark:RuneColor'   : colorID,
        'Quark:RuneAttached': 1 as byte,
      }, mods.zenutils.DataUpdateOperation.MERGE));
  }

  function locName(item as IItemStack, local as string) as IItemStack {
    if (isNull(item)) return null;
    return item.withTag(item.tag.deepUpdate(shimmerTag + {
        display: { LocName: local },
      }, mods.zenutils.DataUpdateOperation.MERGE));
  }

  function addEnchRecipe(output as IItemStack, ench as crafttweaker.enchantments.IEnchantmentDefinition, inputs as IIngredient[][]) as void {
    recipes.addShaped(output.definition.id.replaceAll(':', '_') ~ '_' ~ output.damage ~ '_ench',
      output.withTag({ ench: [{ lvl: 1 as short, id: ench.id as short }] }),
      inputs, function (out, ins, cInfo) {
        return output.withTag({ ench: [{ lvl: 1 as short, id: ench.id as short }] });
      }, null
    );
  }

  // Spawn entity with its default equipment
  // Taken from https://github.com/CoFH/ThermalExpansion-1.12-Legacy/blob/92b52710c19f3923f81ece2f580b044d8d8111fc/src/main/java/cofh/thermalexpansion/entity/projectile/EntityMorb.java#L220
  function spawnGenericCreature(worldIn as IWorld, entityID as string, x as double, y as double, z as double, yaw as float) as void {
    val entityResource = native.net.minecraft.util.ResourceLocation(entityID);
    val worldNative = worldIn.native;
    val entity = native.net.minecraft.entity.EntityList.createEntityByIDFromName(entityResource, worldNative);

    val entityliving = entity as native.net.minecraft.entity.EntityLiving;
    entity.setLocationAndAngles(x, y, z, 0.0f, 0.0f);
    entityliving.rotationYawHead = yaw;
    entityliving.renderYawOffset = yaw;
    entityliving.onInitialSpawn(worldIn.native.getDifficultyForLocation(
      crafttweaker.world.IBlockPos.create(x, y, z).native
    ), null);
    worldIn.native.spawnEntity(entity);
    entityliving.playLivingSound();
  }

  // Check if mob is Hostile (Can't spawn in peaceful)
  function isHostile(worldIn as IWorld, entityID as string) as bool {
    val entityResource = native.net.minecraft.util.ResourceLocation(entityID);
    val worldNative = worldIn.native;
    val entity = native.net.minecraft.entity.EntityList.createEntityByIDFromName(entityResource, worldNative);

    if (entity instanceof EntityMob) return true;

    // Excetptions
    if (entityID == "iceandfire:seaserpent") {
      return true;
    }

    return false;
  }

  // Convert item to block.
  // Handle special cases when `asBlock` not propertly working
  function getStateFromItem(item as IItemStack) as IBlockState {
    if (isNull(item)) return null;
    val trueItem = item.damage == 32767 ? item.withDamage(0) : item;
    val block = trueItem.asBlock();
    if (isNull(block)) return null;
    val def = block.definition;
    val state = def.getStateFromMeta(block.meta);
    return state;
  }

  function abs(n as double) as double { return n < 0 ? -n : n; }

  // Server-side sound playing
  function playSound(world as IWorld, sound as string, pos as IBlockPos, volume as float = 1.0f, pitch as float = 1.0f) as void {
    val split = sound.split(':');
    val soundRes = SoundEvent.REGISTRY.getObject(
      native.net.minecraft.util.ResourceLocation(split[0], sound.substring(split[0].length + 1))
    ) as SoundEvent;
    world.native.playSound(null, pos, soundRes, SoundCategory.AMBIENT, volume, pitch);
  }

  // Taken from modpack IsolatedCrystal3
  function toUpperCamelCase(arg as string) as string {
    if (arg.contains("_")) {
      var splitResult = arg.split("_");
      var temp = "";
      for i, j in splitResult {
        if (j.length <= 0) continue;
        temp ~= (temp == '' ? '' : ' ') ~ j[0].toUpperCase() ~ j.substring(1);
      }
      return temp;
    } else if (arg[0].toUpperCase() != arg[0]) {
      return arg[0].toUpperCase() ~ arg.substring(1);
    } else return arg;
  }

  // Convert tags in form of sNBT such as {ench:[{id:26s,lvl:1s}]}
  function sNBT(snbt as string) as IData {
    return NBTConverter.from(getTagFromJson(snbt), false);
  }
}
global utils as Utils = Utils();
