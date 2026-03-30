/*

Save programmatic values into localized keys
for later use in quest book

*/

#reloadable
#modloaded zenutils ftbutilities

import native.com.feed_the_beast.ftblib.events.ServerReloadEvent;
import native.com.feed_the_beast.ftbutilities.ranks.Ranks;

/*
Dump all rank permissions into localizations

Examples:
  ftbutilities.chunkloader.max_chunks.conflux_ii=25
  ftbutilities.claims.max_chunks.conflux_ii=150

FIXME: ⚠️ Not actually working yet
The localisations is set correctly, but
• Its on server side only, since `ServerReloadEvent` is server-side event
• Other ZS localizations for some reason doesnt working in FTBQuests, only resourceloader ones works
*/
events.register(function(e as ServerReloadEvent) {
  if (!Ranks.isActive()) return;

  for rankKey, rank in Ranks.INSTANCE.ranks {
    val rankId = rank.getId();
    for permissionNode in Ranks.INSTANCE.getPermissionNodes() as [string] {
      val configValue = rank.getPermissionValue(permissionNode);

      if (!configValue.isNull()) {
        val value = configValue.getString();
        if (!value.isEmpty()) {
          val key = permissionNode ~ '.' ~ rankId;
          game.setLocalization(key, value);
        }
      }
    }
  }
}, mods.zenutils.EventPriority.low());
