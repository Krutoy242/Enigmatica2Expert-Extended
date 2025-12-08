#priority 5000
#ignoreBracketErrors
#reloadable

import crafttweaker.data.IData;
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;

import native.com.feed_the_beast.ftblib.lib.data.ForgePlayer;
import native.com.feed_the_beast.ftblib.lib.data.Universe;
import native.com.feed_the_beast.ftbutilities.data.FTBUtilitiesPlayerData;
import native.net.minecraft.entity.player.EntityPlayer;
import native.net.minecraft.entity.player.EntityPlayerMP;
import native.net.minecraft.nbt.NBTBase;
import native.net.minecraftforge.common.capabilities.ICapabilitySerializable;

$expand IEntityDefinition$asSoul() as IItemStack {
  // Rendering Emberoot Fairies causing crashes on AMD cards
  // Do not render fairies at all then
  // Related:
  //  https://github.com/Krutoy242/Enigmatica2Expert-Extended/commit/a5ef59c8c5d1e16c6598732e7fff14d33927ed90
  //  https://github.com/EnigmaticaModpacks/Enigmatica2Expert/issues/2079
  //  https://github.com/Lothrazar/ERZ/pull/41
  if (this.id == 'emberroot:fairies') return null;

  return <draconicevolution:mob_soul>.withTag({EntityName: this.id});
}

$expand IEntityDefinition$asEgg() as IItemStack {
  return <minecraft:spawn_egg>.withTag({EntityTag: {id: this.id}});
}

$expand IEntityDefinition$asStack() as IItemStack {
  val soul = this.asSoul();
  if (isNull(soul)) return this.asEgg();
  return soul;
}

$expand IEntityDefinition$asIngr() as IIngredient {
  val soul = this.asSoul();
  val egg = this.asEgg();
  if (isNull(soul)) return egg;
  return soul | egg;
}

$expand IItemStack$toData() as IData {
  val nativeItem as ICapabilitySerializable = this.native;
  val tag as NBTBase = nativeItem.serializeNBT();
  return tag.wrapper;
}

$expand IItemStack$toSNBT() as string {
  return this.toData().native.toString();
}

$expand IData$toSNBT() as string {
  return this.native.toString();
}

$expand IData$toItemStack() as IItemStack {
  if (isNull(this.id)) {
    logger.logError('Cannot convert NBT into item: ' ~ this);
    return null;
  }
  var item = itemUtils.getItem(this.id, this.Damage ?? 0 as short);
  if (!isNull(this.tag)) item = item.withTag(this.tag);
  if (!isNull(this.ForgeCaps)) item = item.withCapNBT(this.ForgeCaps);
  if (!isNull(this.Count)) item = item.withAmount(this.Count);
  return item;
}

$expand IPlayer$nickname() as string {
  val data = getFTBUPlayerData(this);
  if (isNull(data)) return this.name;

  val nickname = data.nickname;
  return nickname.isEmpty() ? this.name : nickname;
}

$expand IPlayer$nicknameChat() as string {
  val data = getFTBUPlayerData(this);
  if (isNull(data)) return this.name;

  val mcPlayer = this.native as EntityPlayerMP;
  return data.getNameForChat(mcPlayer).unformattedText;
}

function getFTBUPlayerData(player as IPlayer) as FTBUtilitiesPlayerData {
  val mcPlayer as EntityPlayer = player.native;
  // Nickname logic is server-side
  if (mcPlayer.world.isRemote) return null;

  val universe = Universe.get();
  if (isNull(universe)) return null;

  val forgePlayer = universe.getPlayer(mcPlayer);
  if (isNull(forgePlayer)) return null;

  return FTBUtilitiesPlayerData.get(forgePlayer);
}

