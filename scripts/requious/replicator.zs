#modloaded requious ic2 roidtweaker
#priority -1400
#reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.util.Math;
import crafttweaker.world.IFacing;
import crafttweaker.world.IVector3d.create as V;
import mods.requious.AssemblyRecipe;
import mods.requious.Color;
import mods.requious.ComponentFace;
import mods.requious.GaugeDirection;
import mods.requious.MachineContainer;
import mods.requious.MachineVisual;
import mods.requious.SlotVisual;
import mods.zenutils.NetworkHandler;
import mods.zenutils.StaticString.format;
import crafttweaker.player.IPlayer;

import scripts.category.uu;

// Replicator RF/t usage
static ENERGY_USAGE as int = 20000;

// [Replicator] from [Energium Ingot][+3]
recipes.addShapeless('old to new replicator', <requious:replicator>, [<ic2:te:63>]);
craft.make(<requious:replicator>, ['pretty',
  'C ▬ C',
  'C ▬ C',
  'M M M'], {
  'C': <ic2:containment_plating>, // Containment Reactor Plating
  '▬': <ore:ingotEnergium>,       // Energium Ingot
  'M': <ic2:te:75>,   // MFSU
});

// Replication statistics
static statReplications as mods.zenutils.PlayerStat = mods.zenutils.PlayerStat.getBasicStat('stat.replications');
scripts.lib.offline.op.getRegistry.set('stat_replications', function(player as IPlayer, value as string) as string {
  val result = player.readStat(statReplications);
  return result as string;
});
scripts.lib.offline.op.setRegistry.set('stat_replications', function(player as IPlayer, value as string) as string {
  val oldValue = player.readStat(statReplications);
  if (oldValue != value as int)
    player.addStat(statReplications, value as int - oldValue);
  return null;
});

// Define offline difficulty get/set
// Required for scripts.lib.offline.get() and set() calls
scripts.lib.offline.op.getRegistry.set('difficulty', function(player as IPlayer, value as string) as string {
  return player.difficulty as string;
});
scripts.lib.offline.op.setRegistry.set('difficulty', function(player as IPlayer, value as string) as string {
  player.difficulty = value; return null;
});

/*
 █████╗ ███████╗███████╗███████╗███╗   ███╗██████╗ ██╗  ██╗   ██╗
██╔══██╗██╔════╝██╔════╝██╔════╝████╗ ████║██╔══██╗██║  ╚██╗ ██╔╝
███████║███████╗███████╗█████╗  ██╔████╔██║██████╔╝██║   ╚████╔╝
██╔══██║╚════██║╚════██║██╔══╝  ██║╚██╔╝██║██╔══██╗██║    ╚██╔╝
██║  ██║███████║███████║███████╗██║ ╚═╝ ██║██████╔╝███████╗██║
╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝     ╚═╝╚═════╝ ╚══════╝╚═╝
 */
val replTexture = 'enigmatica:textures/gui/replicator.png';

val
  x = <assembly:replicator>;

x.setDecorationSlot(1,0, SlotVisual.create(7,5).addPart(replTexture,1,0));

static displX as int = 4;
static displY as int = 2;
x.setItemSlot(displX, displY, ComponentFace.none(), 1)
  .setBackground(SlotVisual.create(1,1).addPart(replTexture, displX, displY))
  .setAccess(false,false)
  .setHandAccess(false,false)
  .noDrop();

static catlX as int = 4;
static catlY as int = 0;
x.setItemSlot(catlX,catlY, ComponentFace.all(), 64)
  .setAccess(true,false)
  .setHandAccess(true,true);
// .setFilter(<*>.only(function (item) { return getCost(item) > 0; })) // Filters not working

static diskX as int = 3;
static diskY as int = 2;
x.setItemSlot(diskX, diskY, ComponentFace.all(), 1)
  .setAccess(true,true)
  .setHandAccess(true,true)
  .setBackground(SlotVisual.create(1,1).addPart(replTexture, diskX, diskY));

static upgrX as int = 7;
static upgrY as int = 2;
x.setItemSlot(upgrX,upgrY, ComponentFace.none(), 64)
  .setAccess(false,false)
  .setHandAccess(true,true)
  // .setFilter(<ic2:upgrade>)
  .setBackground(SlotVisual.create(1,1).addPart(replTexture, upgrX, upgrY));

static outX as int = 4;
static outY as int = 4;
x.setItemSlot(outX,outY, ComponentFace.all(), 64)
  .setAccess(false,true)
  .setHandAccess(false,true);

static mattX as int = 0;
static mattY as int = 0;
x.setFluidSlot(mattX, mattY, ComponentFace.all(), 16000)
  .setAccess(true /* input */, true /* output */)
  .setFilter(function (liquid/*  as ILiquidStack */) { return liquid.name == 'ic2uu_matter'; })
  .setBackground(SlotVisual.create(1,5).addPart(replTexture, /* x */  0,/* y */ 0))
  .setForeground(SlotVisual.create(1,5).addPart(replTexture, /* x */ 10,/* y */ 0));

static powX as int = 8;
static powY as int = 0;
x.setEnergySlot(powX, powY, ComponentFace.all(), 2000000000)
  .setAccess(true,false)
  .setUnit('rf')
  .setBackground(SlotVisual.create(1,5))
  .setForeground(SlotVisual.createGauge(
    replTexture, // texture
    /* x1 */ 8, /* y1 */ 0, /* x2 */ 9, /* y2 */ 0,
    GaugeDirection.up(), // direction
    false, // inverse
    1, // width
    5, // height
    [255,255,255] // rgb
  ));

x.setTextSlot(1,1).setVisual(SlotVisual.create(3,1)).setRenderText('§7%s  \n§8%s  ', ['goal','buffer']).alignRight();
x.setTextSlot(5,3).setVisual(SlotVisual.create(3,1)).setRenderText(' %s',['error']);
x.setTextSlot(1,3).setVisual(SlotVisual.create(3,1)).setRenderText('§8✪Cost: \n§7x§8%s ', ['penalty']).alignRight();

x.addVisual(MachineVisual.displayFluid(
  /* active */ 1.0,
  /* fluidStack */ <fluid:ic2uu_matter>,
  /* capacity */ 1,
  /* facing */ IFacing.up(),
  /* start */ V(2.1 / 16.0, 2.0 / 16.0,  2.1 / 16.0),
  /* end */ V(13.8 / 16.0, 5.9 / 16.0, 13.8 / 16.0),
  /* global */ false
));

x.addVisual(MachineVisual.smoke(
  /* active */ 'active'.asVariable(),
  /* begin */ V(0.5, 0.40, 0.5),
  /* end */ V(0.5, 0.45, 0.5),
  /* velocity */ V(0, 0, 0),
  /* color */ Color.normal([105, 0, 105]),
  /* lifetime */ 20,
  /* fullBright */ true,
  /* global */ false
));

/*
██╗      ██████╗  ██████╗ ██╗ ██████╗
██║     ██╔═══██╗██╔════╝ ██║██╔════╝
██║     ██║   ██║██║  ███╗██║██║
██║     ██║   ██║██║   ██║██║██║
███████╗╚██████╔╝╚██████╔╝██║╚██████╗
╚══════╝ ╚═════╝  ╚═════╝ ╚═╝ ╚═════╝
*/

// ========================================================
// Variables
// ========================================================
function pushErr(m as MachineContainer, reason as string) as void {
  if (isNull(reason)) return m.setString('error', '');
  m.setString('error', reason);
}

function updatePenaltyText(m as MachineContainer, dfclty as double) as void {
  m.setString('penalty', format('%,.3f', 0.0001 * uu.difficultCost(10000, dfclty)).replace('.', '§7.').replaceAll(',', '§7,§8'));
}

function defineVars(m as MachineContainer) as void {
  // Skip init if already initialized
  if (!isNull(m.getString('error'))) return;

  m.setString('error', ''); // Error line
  m.setInteger('goal', 0); // how much UU need. -1 if just trying to push output
  m.setInteger('buffer', 0); // stored UU in internal
  m.setInteger('tick', 0);
  m.setString('penalty', 0);
}

// Increase player owner difficulty, no matter online he or not
function increaseDifficulty(m as MachineContainer, bufferConsumed as int, dfclty as double) as void {
  // Determine cost
  val increase = scripts.category.uu.diffIncrease(0.01 * bufferConsumed);
  val ownerUUID = m.getString('ownerUUID');
  val newDifficulty = dfclty + increase;
  scripts.lib.offline.op.set(ownerUUID, 'difficulty', newDifficulty);

  // ⭐ FX effect
  if (m.getInteger('tick') % 20 == 0)
    NetworkHandler.sendToAllAround('acquire_star_and_flare',
      m.pos.x, m.pos.y, m.pos.z, 30, m.world.getDimension(), function (b) {
        b.writeData({
          x    : m.world.random.nextDouble(0, 1.0) + m.pos.x,
          y    : 1.0 + m.pos.y,
          z    : m.world.random.nextDouble(0, 1.0) + m.pos.z,
          value: increase });
      });
}

// ========================================================
// Consumptions
// ========================================================
function calcConsumption(upgrAmount as int, tick as double) as int {
  val s = pow(1.3, upgrAmount);
  val resid = s - (s as int) as double;
  if (resid == 0) return s as int;
  val bonus = (tick % (1.0 / resid) + 0.5) as int == 0 ? 1 : 0;
  return s as int + bonus;
}

function calcPowerConsumption(upgrAmount as int) as int {
  val powerUsage = pow(1.6, upgrAmount);
  return (powerUsage * ENERGY_USAGE as double) as int;
}

// ========================================================
// States
// ========================================================
function getUpgrAmount(m as MachineContainer) as double {
  val upgr = m.getItem(upgrX, upgrY);
  return (
    isNull(upgr)
    || upgr.definition.id != 'ic2:upgrade'
    || upgr.damage != 0
  )
    ? 0.0
    : upgr.amount as double;
}

function getReplicateItem(m as MachineContainer, disk as IItemStack) as IItemStack {
  if (
    isNull(disk)
    || isNull(disk.tag)
    || isNull(disk.tag.Pattern)
    || isNull(disk.tag.Pattern.id)
    || isNull(disk.tag.Pattern.Damage)
  ) return null;

  return itemUtils.getItem(disk.tag.Pattern.id, disk.tag.Pattern.Damage);
}

function consumeEnergy(m as MachineContainer, amount as int) as void {
  val energy = m.getEnergy(powX, powY);
  m.setEnergy(powX, powY, energy - amount);
  m.setInteger('active', 10);
}

// Machine completed it task and could start new one
function succes(m as MachineContainer, powr as int, output as IItemStack, dfclty as double) as void {
  m.setItem(outX, outY, output);
  increaseDifficulty(m, uu.getCost(output, -1), dfclty);
  consumeEnergy(m, powr);
  m.setInteger('goal', 0);
  pushErr(m, null);
}

function consumeMatter(m as MachineContainer, consumeAmount as int) as bool {
  val fluid = m.getFluid(mattX, mattY);
  if (isNull(fluid) || fluid.amount <= 0) return false;
  m.setFluid(mattX, mattY, fluid.amount > consumeAmount
    ? fluid * (fluid.amount - consumeAmount)
    : null
  );
  val uuid = m.getString('ownerUUID');
  val oldValue = scripts.lib.offline.op.get(uuid, 'stat_replications', 0) as int;
  scripts.lib.offline.op.set(uuid, 'stat_replications', max(0, oldValue) + consumeAmount);
  return true;
}

// Try to add target item to output
// If succes, set goal to 0
// If failed, goal would be set to -1
function pushOutput(m as MachineContainer, powr as int, dfclty as double) as void {
  val out = m.getItem(outX, outY);
  val item = m.getItem(displX, displY);

  // Slot is empty
  if (isNull(out)) return succes(m, powr, item, dfclty);

  // Slot partially occupied with same item
  if (isNull(item)) return logger.logError('Replicator malfunction: must output item that lost.');
  if (
    item.definition.id == out.definition.id
    && item.damage == out.damage
    && out.amount < out.maxStackSize
  ) return succes(m, powr, out * (out.amount + item.amount), dfclty);

  // Unable to output
  m.setInteger('goal', -1);
  pushErr(m, '§fNo output\n§f space');
}

function spentBuffer(m as MachineContainer, powr as int, buffer as int, goal as int, dfclty as double) as bool {
  if (buffer < goal) return false;
  m.setInteger('buffer', buffer - goal);
  pushOutput(m, powr, dfclty);
  return true;
}

// Consume fluid and add it to buffer
// Goal always bigger than 0 here
function work(m as MachineContainer, tick as int, upgrAmount as int, powr as int, dfclty as double) as void {
  var buffer = m.getInteger('buffer');
  val goal = m.getInteger('goal');

  // Buffer still left from previous run, just output item
  if (spentBuffer(m, powr, buffer, goal, dfclty)) return;

  // Consume to increase buffer
  val toConsume = calcConsumption(upgrAmount, tick);
  if (!consumeMatter(m, toConsume))
    return pushErr(m, '§dNeed UU\n§d matter');
  buffer += 100 * toConsume;

  // Instantly drop result if cost below 1mb
  if (spentBuffer(m, powr, buffer, goal, dfclty)) return;

  // Just add to buffer, skip
  m.setInteger('buffer', buffer);
  consumeEnergy(m, powr);
  pushErr(m, null);
}

/*
████████╗██╗ ██████╗██╗  ██╗
╚══██╔══╝██║██╔════╝██║ ██╔╝
   ██║   ██║██║     █████╔╝
   ██║   ██║██║     ██╔═██╗
   ██║   ██║╚██████╗██║  ██╗
   ╚═╝   ╚═╝ ╚═════╝╚═╝  ╚═╝
*/
function tick(m as MachineContainer) as void {
  defineVars(m);
  val tick = m.getInteger('tick');
  m.setInteger('tick', tick + 1);

  // 🧍 Check if player
  val ownerUUID = m.getString('ownerUUID');
  if (isNull(ownerUUID) || ownerUUID == '') return pushErr(m, '§0Need\n§0 player ☻');

  // Get difficulty based on player's one + dimension changes
  val dfclty = scripts.lib.mod.scalinghealth.getPlayerDimDifficulty(ownerUUID, m.world.dimension);

  // 🎯 Update penalty text each tick
  if (dfclty < 0 || !isNull(scripts.lib.fake.userUUIDs[ownerUUID]))
    return pushErr(m, '§0No fakes\n§0 allowed ☹');
  updatePenaltyText(m, dfclty);

  // ⚡ Check energy
  val upgrAmount = getUpgrAmount(m);
  val energy = m.getEnergy(powX, powY);
  val powr = calcPowerConsumption(upgrAmount);
  if (energy < powr) return pushErr(m, '§cNeed\n§c energy');

  // 📦 Output is stuck
  val goal = m.getInteger('goal');
  if (goal < 0) return pushOutput(m, powr, dfclty);

  // ⚙️ Check if we already working
  if (goal > 0) return work(m, tick, upgrAmount, powr, dfclty);

  // ❔ Find what item we should replicate
  val disk = m.getItem(diskX, diskY);
  if (isNull(disk) || disk.definition.id != 'ic2:crystal_memory') {
    m.setItem(displX, displY, null);
    return pushErr(m, '§bInsrt Crstl\n§b Memory');
  }
  val item = getReplicateItem(m, disk);
  if (isNull(item)) {
    m.setItem(displX, displY, null);
    return pushErr(m, '§3Write data\n§3 to memory');
  }
  m.setItem(displX, displY, item); // Set item is display slot

  // Acquire item when player trying to replicate it
  scripts.do.acquire.events.checkAcquire('replicate', server.getPlayerByUUID(ownerUUID), item);

  // 🥼 Check if we can consume catalyst
  val catl = m.getItem(catlX, catlY);
  if (isNull(catl)) return pushErr(m, '§6Need\n§6 catalyst');
  val catlCost = uu.getCost(catl, -1);
  if (catlCost <= 0) return pushErr(m, '§7Unusable\n§7 catalyst');

  // 💲 Calculate cost and penalty based on difficulty
  if (uu.getCost(item, dfclty) >= catlCost) return pushErr(m, '§5Catalyst\n§5 too simple');

  // ✔️ Consume catalyst and start operation
  m.setItem(catlX, catlY, catl.amount > 1 ? catl * (catl.amount - 1) : null);
  m.setInteger('goal', catlCost);
  work(m, tick, upgrAmount, powr, dfclty);
}

x.addRecipe(AssemblyRecipe.create(function (c) {})
  .requireWorldCondition('tick', function (m) {
    if (m.world.remote) return false;
    tick(m);
    return true;
    // Note: this number should be negative to
    // be able speed up machine with Time In Bottle
  }, -2000000));
