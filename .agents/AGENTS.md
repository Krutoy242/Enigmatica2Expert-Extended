# AGENTS.md — Enigmatica 2: Expert – Extended

## Project type

Modpack for **Minecraft 1.12.2 / Forge** ("Enigmatica 2: Expert – Extended").
Active development = **ZenScript** (CraftTweaker + ContentTweaker + LootTweaker)
plus mod **config files** plus a **TypeScript dev toolchain**.

This is **not** a Java mod project. There is no Gradle build for game code.
The "build" produces a distributable pack archive via `pnpm 🧱build`.

## Working directories

| Path                   | What it is                                                                    |
| ---------------------- | ----------------------------------------------------------------------------- |
| `scripts/`             | All ZenScript (`.zs`). Primary work area. ~22 sub-categories.                 |
| `config/`              | ~444 mod config files/folders. Edit only the ones you intend to ship.         |
| `dev/`                 | TypeScript automation (`make_pack.ts`, JEI/JER dumps, manifest, modlist, …).  |
| `mc-tools/`            | Git submodule of CLI tools (`errors`, `manifest`, `modlist`, `tcon`, …).      |
| `resources/`           | Resource pack overrides shipped with the pack.                                |
| `patchouli_books/`     | Patchouli guidebook content.                                                  |
| `crafttweaker.log`     | **Source of truth for ZS errors.** Generated each game launch.                |


