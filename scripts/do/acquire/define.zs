#reloadable
#priority -1500
#ignoreBracketErrors
#modloaded zenutils scalinghealth

import crafttweaker.item.IItemStack;
import crafttweaker.world.IWorld;

import scripts.do.acquire.forbid.Forbidder;

Forbidder()

.stacks('iron_chest', [
  <ironchest:iron_chest>,
  <ironchest:iron_chest:1>,
  <ironchest:iron_chest:2>,
  <ironchest:iron_chest:5>,
  <ironchest:iron_chest:6>,
  <ironchest:iron_chest:7>,
])
.onOpen('cpw.mods.ironchest.common.gui.chest.ContainerIronChest')
.value(1).events('pickup craft place')

.stacks('duct_connection', [
  <thermaldynamics:servo>,
  <thermaldynamics:servo:1>,
  <thermaldynamics:servo:2>,
  <thermaldynamics:servo:3>,
  <thermaldynamics:servo:4>,
  <thermaldynamics:filter>,
  <thermaldynamics:filter:1>,
  <thermaldynamics:filter:2>,
  <thermaldynamics:filter:3>,
  <thermaldynamics:filter:4>,
  <thermaldynamics:retriever>,
  <thermaldynamics:retriever:1>,
  <thermaldynamics:retriever:2>,
  <thermaldynamics:retriever:3>,
  <thermaldynamics:retriever:4>,
  <thermaldynamics:relay>,
])
.onOpen('cofh.thermaldynamics.gui.container.ContainerDuctConnection')
.value(2)

.stack(<nuclearcraft:water_source>).value(2).events('pickup place interact')
.stack(<openblocks:hang_glider>).value(2).events('use')
.stack(<nuclearcraft:water_source_compact>).value(3).events('pickup place interact craft')
.stack(<nuclearcraft:water_source_dense>).value(4).events('pickup place interact craft')
.stack(<scannable:scanner>).onOpen('li.cil.scannable.common.container.ContainerScanner').value(8)

.stacks('conduits', [
  <enderio:item_item_conduit>,
  <enderio:item_liquid_conduit>,
  <enderio:item_liquid_conduit:1>,
  <enderio:item_liquid_conduit:2>,
  <enderio:item_power_conduit>,
  <enderio:item_power_conduit:1>,
  <enderio:item_power_conduit:2>,
  <enderio:item_redstone_conduit>,
  <enderio:item_me_conduit>,
  <enderio:item_me_conduit:1>,
  <enderio:item_opencomputers_conduit>,
  <enderio:item_data_conduit>,
  <enderio:item_gas_conduit>,
  <enderio:item_gas_conduit:1>,
  <enderio:item_gas_conduit:2>,
  <enderio:item_endergy_conduit>,
  <enderio:item_endergy_conduit:1>,
  <enderio:item_endergy_conduit:2>,
  <enderio:item_endergy_conduit:3>,
  <enderio:item_endergy_conduit:4>,
  <enderio:item_endergy_conduit:5>,
  <enderio:item_endergy_conduit:6>,
  <enderio:item_endergy_conduit:7>,
  <enderio:item_endergy_conduit:8>,
  <enderio:item_endergy_conduit:9>,
  <enderio:item_endergy_conduit:10>,
  <enderio:item_endergy_conduit:11>,
])
.onOpen('crazypants.enderio.conduits.gui.ExternalConnectionContainer')
.value(10).events('place interact', [<blockstate:enderio:block_conduit_bundle>])

// Ender Storage doesnt have container event
.stacks('enderstorage', [
  <enderstorage:ender_storage>,
  <enderstorage:ender_storage:1>,
])
.onOpen('codechicken.enderstorage.container.ContainerEnderItemStorage')
.value(20).events('pickup craft place interact')

.stack(<gendustry:imprinter>).onOpen('net.bdew.gendustry.machines.imprinter.ContainerImprinter').value(40).events('pickup craft')
.stack(<gendustry:replicator>).onOpen('net.bdew.gendustry.machines.replicator.ContainerReplicator').value(60).events('pickup craft')

.stack(<appliedenergistics2:controller>).value(100).events('pickup craft place interact replicate')

.stacks('fluxnetworks', [
  <fluxnetworks:fluxpoint>,
  <fluxnetworks:fluxplug>,
  <fluxnetworks:fluxcontroller>,
  <fluxnetworks:fluxstorage>,
])
.onOpen('sonar.fluxnetworks.common.core.ContainerCore')
.value(200).events('pickup craft')

// .stacks('slings', [
//   <tconstruct:slimesling>,
//   <tconstruct:slimesling:1>,
//   <tconstruct:slimesling:2>,
//   <tconstruct:slimesling:3>,
//   <tconstruct:slimesling:4>,
// ])
// .value(1).events('pickup craft use')

;
