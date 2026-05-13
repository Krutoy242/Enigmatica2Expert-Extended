# Enigmatica 2: Expert – Extended

## Project type

Modpack for **Minecraft 1.12.2; Forge/Cleanroom**.
Active development = **ZenScript** (CraftTweaker + ContentTweaker + LootTweaker)
plus mod **config files** plus a **TypeScript dev toolchain**.

## Working directories

| Path               | What it is                                                                   |
|--------------------|------------------------------------------------------------------------------|
| `scripts/`         | All ZenScript (`.zs`)                                                        |
| `config/`          | ~444 mod config files/folders.                                               |
| `dev/`             | TypeScript automation (`make_pack.ts`, JEI/JER dumps, manifest, modlist, …). |
| `mc-tools/`        | Git submodule of CLI tools (`errors`, `manifest`, `modlist`, `tcon`, …).     |
| `resources/`       | Resource pack overrides shipped with the pack.                               |
| `patchouli_books/` | Patchouli guidebook content.                                                 |

## Git workflow & repository conventions

### Commit message convention

The project uses **Conventional Commits** with emoji prefixes.

```
<type>(<scope>): <emoji><description>
```

**Common types:**
- `feat`, `fix`, `perf`, `refactor`, `build`, `chore`, `docs`, `style`, `test` / `ci`

**Common scopes:** `recipes`, `quest`, `config`, `balance`, `worldgen`, `mods`, `gear`, `jei`, `hei`, `schematic`, `build_expansion`, `portal_spread`, `difficulty_rework`, etc.

**Emojis** are mandatory in this repo (e.g. `✏️` recipes, `📖` quests, `🧱` build, `🔵` mod updates, `♻️` refactor, `⚡` perf, etc.).

### Submodules

Three submodules are active. **Always check their status before committing.**

| Path                              | Repository                                  | Purpose                                                       |
|-----------------------------------|---------------------------------------------|---------------------------------------------------------------|
| `mc-tools/`                       | `Krutoy242/mc-tools`                        | CLI utilities (`errors`, `manifest`, `modlist`, `tcon`, etc.) |
| `scripts/craft/`                  | `Krutoy242/Craft.zs`                        | Shared ZenScript crafting library                             |
| `Enigmatica2Expert-Extended.wiki` | `Krutoy242/Enigmatica2Expert-Extended.wiki` | Wiki content                                                  |

### Git filters (`.gitattributes`)

Several clean filters normalize config files to avoid noisy diffs. They are defined in the local git config (run `git config --local --list | grep filter` to inspect).

### Git LFS

Git LFS is enabled for this repository. If you clone fresh, ensure LFS files are pulled:
```bash
git lfs pull
```

