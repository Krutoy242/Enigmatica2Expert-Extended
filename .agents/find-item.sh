#!/usr/bin/env bash
# find-item.sh — resolve a Minecraft item ID to its display name.
#
# Usage:   .agents/find-item.sh <mod:item:meta>
# Examples:
#   .agents/find-item.sh ic2:dust:22        -> Tiny Pile of Lapis Dust
#   .agents/find-item.sh '<ic2:dust:22>'    -> Tiny Pile of Lapis Dust   (ZenScript form ok)
#   .agents/find-item.sh minecraft:stone    -> lists every meta (no meta given)
#   .agents/find-item.sh ic2:dust:*         -> lists every meta (explicit wildcard)
#
# Deliberately forgiving: strips < > brackets / quotes / surrounding junk,
# case-insensitive, defaults meta to "list all", and on any miss prints
# actionable hints instead of failing silently.

set -uo pipefail

# ---- pretty stderr helpers -------------------------------------------------
err()  { printf '\033[31m✘ %s\033[0m\n'  "$*" >&2; }
hint() { printf '\033[33m  ↳ %s\033[0m\n' "$*" >&2; }
ok()   { printf '%s\n' "$*"; }

CSV_GLOB='config/tellme/items-csv_*.csv'

# ---- 1. locate the data dump ----------------------------------------------
# Resolve relative to the repo root (one level above this script's dir),
# so the tool works no matter the current working directory.
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"

csv="$(ls -t "$repo_root"/$CSV_GLOB 2>/dev/null | head -1)"
if [[ -z "$csv" ]]; then
  err "No item dump found ($CSV_GLOB)."
  hint "These CSVs are produced by the TellMe mod. In-game run: /tellme dump items csv"
  hint "Then look under config/tellme/ for the freshest items-csv_*.csv."
  exit 3
fi

# ---- 2. read & sanitise input ---------------------------------------------
raw="${1:-}"
if [[ -z "${raw// }" ]]; then
  err "No item ID given."
  hint "Usage: .agents/find-item.sh <mod:item:meta>   e.g. ic2:dust:22"
  exit 2
fi

# Pull the first token that looks like an ID out of arbitrarily noisy input
# (handles <ic2:dust:22>, \"ic2:dust:22\", '* ic2:dust:22 // foo', etc.).
id="$(printf '%s' "$raw" | grep -oiP '[a-z0-9_.-]+:[a-z0-9_/.-]+(:(\*|[0-9]+))?' | head -1)"
if [[ -z "$id" ]]; then
  err "Could not find a 'mod:item' pattern in: $raw"
  hint "Expected something like  mod:item:meta  (meta optional). e.g. thermalfoundation:material:1"
  exit 2
fi
[[ "$id" != "$raw" ]] && hint "Parsed ID as '$id' from '$raw'."

# ---- 3. split into registry (namespace:path) + meta ------------------------
# Minecraft registry names are always exactly  namespace:path  (one colon),
# so the meta — if present — is whatever follows the SECOND colon.
ns="${id%%:*}"                 # before first colon
rest="${id#*:}"               # after  first colon
path="${rest%%:*}"            # up to second colon
meta=""
if [[ "$rest" == *:* ]]; then
  meta="${rest#*:}"          # after second colon
fi
registry="$ns:$path"

# Validate meta: must be a number or wildcard; anything else is forgiven (-> list all).
if [[ -n "$meta" && ! "$meta" =~ ^([0-9]+|\*|all)$ ]]; then
  hint "Meta '$meta' is not a number — ignoring it and listing all metas."
  meta=""
fi
[[ "$meta" == "all" ]] && meta='*'

# ---- 4. query the CSV (FPAT handles commas inside quoted names) ------------
# Columns: 1 Mod | 2 Registry | 3 ItemID | 4 Meta | 5 Subtypes | 6 Display | 7 OreDict
result="$(
  awk -v FPAT='([^,]*)|("[^"]*")' \
      -v reg="$registry" -v meta="$meta" '
    function unq(s){ gsub(/^"/,"",s); gsub(/"$/,"",s); return s }
    NR==1 { next }
    {
      r = tolower(unq($2))
      if (r != tolower(reg)) next
      m = unq($4); name = unq($6)
      if (meta == "" || meta == "*") {           # wildcard -> collect all
        print m "\t" name
      } else if (m == meta) {                      # exact meta hit
        print name
        exit
      }
    }
  ' "$csv"
)"

# ---- 5. report -------------------------------------------------------------
if [[ -n "$result" ]]; then
  if [[ -z "$meta" || "$meta" == "*" ]]; then
    # No specific meta requested.
    count="$(printf '%s\n' "$result" | grep -c '')"
    if [[ "$count" -eq 1 ]]; then
      ok "$(printf '%s' "$result" | cut -f2-)"        # single subtype -> just the name
    else
      hint "$registry has $count metas (give mod:item:META to pick one):"
      printf '%s\n' "$result" | awk -F'\t' '{printf "  %-5s %s\n", $1, $2}' >&2
    fi
  else
    ok "$result"                                        # exact match
  fi
  exit 0
fi

# ---- 6. nothing matched -> diagnose & suggest ------------------------------
# Does the registry exist at all (any meta)?
metas="$(
  awk -v FPAT='([^,]*)|("[^"]*")' -v reg="$registry" '
    function unq(s){ gsub(/^"/,"",s); gsub(/"$/,"",s); return s }
    NR==1 { next }
    tolower(unq($2)) == tolower(reg) { printf "  %-5s %s\n", unq($4), unq($6) }
  ' "$csv"
)"

if [[ -n "$metas" ]]; then
  err "'$registry' exists, but meta $meta was not found."
  hint "Available metas for $registry:"
  printf '%s\n' "$metas" >&2
  exit 1
fi

# Registry unknown -> fuzzy suggestions by path, then by namespace.
err "No item registered as '$registry'."
sugg="$(
  awk -v FPAT='([^,]*)|("[^"]*")' -v p="$(printf '%s' "$path" | tr '[:upper:]' '[:lower:]')" '
    function unq(s){ gsub(/^"/,"",s); gsub(/"$/,"",s); return s }
    NR==1 { next }
    { r = unq($2); if (index(tolower(r), p)) { print "  " r; seen[r]=1 } }
  ' "$csv" | sort -u | head -10
)"
if [[ -n "$sugg" ]]; then
  hint "Did you mean (registry contains '$path'):"
  printf '%s\n' "$sugg" >&2
else
  hint "No registry contains '$path'. Check the namespace '$ns' and spelling."
  hint "Browse names with:  grep -iP '$path' $CSV_GLOB"
fi
exit 1
