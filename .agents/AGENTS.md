# Enigmatica 2: Expert – Extended

Modpack, Minecraft 1.12.2 Forge/Cleanroom. Active dev: ZenScript, mod configs, TS toolchain.

## Directories
`scripts/` ZenScript · `config/` 400+ mod configs · `dev/` TS automation · `mc-tools/` CLI submodule (errors, manifest, modlist, tcon) · `resources/` pack overrides · `patchouli_books/` guidebook.

`minecraftinstance.json` is one huge line — never `git log -p` it.

## Commits — Conventional Commits + mandatory emoji
Format: `<type>(<scope>): <emoji><desc>` → blank → why (1 sentence, audience = players) → `Related: <hash>` if it fixes another commit's fallout.
- Scopes: recipes quest config balance worldgen mods gear jei …
- Pick the emoji used before for that file: `git log -n20 --pretty=%B -- <path>`.
- Wrap item names in `[]`; resolve an ID with `.agents/find-item.sh mod:item:meta`.
- After committing an issue fix: `gh issue edit <N> --add-label fixed-pending-release`.

## Local test server
`pnpm server` — dedicated server on this instance's mods/configs, own game dir `~server/`, runs alongside the client. It is reducer's `--server` target (`reducer restart --server --only "ZenUtils"`, `reducer.config.yml`) — see the `reducer` skill.

## Submodules
`mc-tools` · `scripts/craft` (Craft.zs) · `Enigmatica2Expert-Extended.wiki` — see `.gitmodules`.

## Git filters
Clean filters normalize configs to avoid noisy diffs: `git config --local --list | grep filter`.
