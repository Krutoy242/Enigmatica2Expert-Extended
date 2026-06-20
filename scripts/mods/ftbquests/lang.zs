/**
 * @file Bridge between ZenScript and FTBQuests localization.
 *
 * ZS dynamically generates lang keys that FTBQuests picks up when rendering
 * quest descriptions/titles via `{key}` recursive resolution.
 *
 * Usage in .lang files:
 *   q.rftools.spawner.desc=...\n{q.zs.living_matter}
 *
 * The pattern:
 *   1. ZS reads runtime data (native Java fields, configs, registries)
 *   2. Formats it into a localized string with § color codes
 *   3. Registers it via setLocalizationClient() — writes directly to the
 *      client-side I18n locale map.
 *   4. FTBQuests resolves {q.zs.*} references recursively at render time
 *      via I18n.format() -> Locale.formatMessage().
 *
 * WHY game.setLocalization() doesn't work for FTBQuests:
 *   game.setLocalization() writes to LanguageMap.instance.languageList
 *   (crafttweaker.mc1120.game.MCGame, line 34).  But FTBQuests reads from
 *   I18n.i18nLocale.properties (net.minecraft.client.resources.I18n,
 *   MCP stable-39: field_135054_a / field_135032_a).  These are separate
 *   objects in MC 1.12.2 — LanguageMap (server-side/legacy) vs Locale
 *   (client-side resource-pack loader).  The former is what
 *   game.setLocalization mutates; the latter is what I18n.format() consults.
 */

#modloaded rftools zenutils ftbquests
#priority -1000
#reloadable

import mods.zenutils.StaticString;
import mods.zenutils.StringList;

import native.mcjty.rftools.blocks.spawner.SpawnerConfiguration;
import native.net.minecraft.util.ResourceLocation;
import native.net.minecraft.client.resources.I18n;
import native.net.minecraftforge.fml.common.registry.ForgeRegistries;
import native.net.minecraft.block.Block;

// ─── Living Matter list ────────────────────────────────────────────────

/**
 * Reads SpawnerConfiguration.livingMatter map, sorts by value descending,
 * formats as "§d<value>§7: §c<name>" with ♥ bullets.
 * Stores result in lang key "q.zs.living_matter".
 */
function buildLivingMatterList() as string {
  // Build entries with zero-padded sort key for numeric descending sort
  val entries = StringList.empty();

  for rl, value in SpawnerConfiguration.livingMatter {
    val displayName = getItemDisplayName(rl as ResourceLocation);

    val formattedValue = StaticString.format('%,.1f', [value]);
    val rawValue = value as int;
    val padded = StaticString.repeat('0', 12 - toString(rawValue).length()) ~ toString(rawValue);

    entries.add(padded ~ ';' ~ formattedValue ~ ';' ~ displayName);
  }

  if (entries.size() == 0) return '<empty>';

  val sorted = entries.toArray();
  sorted.sort();
  sorted.reverse(); // descending by value

  // Build formatted result
  var result = '';
  var first = true;
  for entry in sorted {
    if (first) first = false;
    else result ~= '\n';

    val parts = entry.split(';');
    val valueStr = parts[1] as string;
    val nameStr = parts[2] as string;
    result ~= '§7♥ §d' ~ valueStr ~ '§7: §c' ~ nameStr ~ '§r';
  }

  return result;
}

/**
 * Resolve a ResourceLocation to a localized item/block display name —
 * exactly the name shown in the tooltip when hovering the item in-game.
 *
 * WHY not guess the lang key from the id:
 *   A registry name (`namespace:path`) does NOT map to a predictable lang
 *   key. Vanilla apple is `item.apple.name` (no namespace!), and modded
 *   items set arbitrary unlocalized names unrelated to their id. The only
 *   reliable name is the one the live game object reports, so we resolve
 *   through the real Item/Block instead of constructing a key.
 *
 * Strategy:
 *   1. Item registry (includes ItemBlocks): build the stack and read its
 *      display name — byte-for-byte identical to the hover tooltip.
 *      Covers virtually every entry (all `I` and most `B` config rows).
 *   2. Block-only entries with no standard item form (e.g. minecraft:cocoa,
 *      whose item is `minecraft:dye:3`): fall back to Block.getLocalizedName().
 *   3. Last resort: the raw `namespace:path` id, flagged in the debug log.
 */
function getItemDisplayName(rl as ResourceLocation) as string {
  val id = rl.toString();

  // 1. Item (and block-item) — exact tooltip display name.
  val item = itemUtils.getItem(id, 0);
  if (!isNull(item) && item.definition.id != 'minecraft:air') {
    if (utils.DEBUG) print('[living_matter] item  ' ~ id ~ ' -> ' ~ item.displayName);
    return item.displayName;
  }

  // 2. Block without a normal item form (e.g. cocoa, portal, fire).
  val blockObj = ForgeRegistries.BLOCKS.getValue(rl);
  if (!isNull(blockObj)) {
    val block = blockObj as Block;
    if (utils.DEBUG) print('[living_matter] block ' ~ id ~ ' -> ' ~ block.localizedName);
    return block.localizedName;
  }

  // 3. Nothing resolved — keep the raw id and surface it for debugging.
  if (utils.DEBUG) print('[living_matter] UNRESOLVED ' ~ id);
  return id;
}

// ─── Client-side I18n writer ───────────────────────────────────────────

/**
 * Write to the client-side I18n locale map directly (instead of the
 * LanguageMap that game.setLocalization targets).
 *
 * References:
 *   - crafttweaker/mc1120/game/MCGame.java:34
 *     targets LanguageMap.instance.languageList (server-side map)
 *   - net/minecraft/client/resources/I18n.java
 *     static i18nLocale (Locale singleton) — MCP stable-39 field_135054_a
 *   - net/minecraft/client/resources/Locale.java
 *     var properties (string[string]) — MCP stable-39 field_135032_a
 *   - net/minecraft/client/resources/I18n.java
 *     I18n.format() used by FTBQuests reads from
 *     I18n.i18nLocale.properties — exact same map we write to.
 *
 * The two maps are separate objects in MC 1.12.2.
 */
function setLocalizationClient(key as string, value as string) as void {
  val localeInst = I18n.i18nLocale;
  if (isNull(localeInst)) return;
  localeInst.properties[key] = value;
}

// ─── Registration ──────────────────────────────────────────────────────

val livingMatterText = buildLivingMatterList();
setLocalizationClient('q.zs.living_matter', livingMatterText);
