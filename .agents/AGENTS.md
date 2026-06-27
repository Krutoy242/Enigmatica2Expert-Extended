# Enigmatica 2: Expert – Extended

Modpack, Minecraft 1.12.2 Forge/Cleanroom. Active dev: ZenScript, mod configs, TS toolchain.

## Directories
`scripts/` ZenScript · `config/` 400+ mod configs · `dev/` TS automation · `mc-tools/` CLI submodule (errors, manifest, modlist, tcon) · `resources/` pack overrides · `patchouli_books/` guidebook.

## Commits — Conventional Commits + mandatory emoji
Format: `<type>(<scope>): <emoji><desc>` → blank → why (1 sentence, audience = players) → `Related: <hash>` if it fixes another commit's fallout.
- Scopes: recipes quest config balance worldgen mods gear jei …
- Pick the emoji used before for that file: `git log -n5 --pretty=%B -- <path>`.
- Wrap item names in `[]`; resolve an ID with `.agents/find-item.sh mod:item:meta`.

## Submodules
`mc-tools` · `scripts/craft` (Craft.zs) · `Enigmatica2Expert-Extended.wiki` — see `.gitmodules`.

## Git filters
Clean filters normalize configs to avoid noisy diffs: `git config --local --list | grep filter`.

## Dev toolchain (hard-won)
- Typecheck one `.ts`: not `tsc file` (TS5112 + phantom TS7006). Make repo-root temp `{ "extends":"./tsconfig.json", "include":["file.ts"] }`, run `tsc --noEmit --project` it. Iterate `find-process` with `for…of`, not `.filter` (implicit-any).
- `.agents/` is ESLint-ignored — don't chase `--no-ignore`.
- PowerShell with `$vars` (`Get-Process`, `Get-CimInstance`): use the PowerShell tool, not Bash (Bash expands `$` first).
