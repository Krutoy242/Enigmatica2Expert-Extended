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

<why>

<related_commits>
```

- **Common types:** `feat`, `fix`, `perf`, `refactor`, `build`, `chore`, `docs`, `style`, `test` / `ci`
- **Common scopes:** `recipes`, `quest`, `config`, `balance`, `worldgen`, `mods`, `gear`, `jei`, `hei`, `schematic`, `build_expansion`, `portal_spread`, `difficulty_rework`, etc.
- **Emojis:** mandatory in this repo (e.g. `✏️` recipes, `📖` quests, `🧱` build, `🔵` mod updates, `♻️` refactor, `⚡` perf, etc.).
  Before commit check what emoji was used for the file
  ```sh
  git log -n 5 --pretty=format:%B -- path/to/file
  ```
- **Why:** should answer why change was made. Audience: modpack players. One sentence.
- **Related commits:** if commit changes/fixes another commit consequences, it should be referenced as `Related: <commit_short_hash>`.
- **Item names:** all actual item names must be encapsulated in `[]`. How to find item name `<ic2:dust:22>` example:
  ```sh
  grep -ohP 'ic2:dust",\d+,22,[^,]*,"\K[^"]+' config/tellme/items-csv_*.csv | tail -1 # Tiny Pile of Lapis Dust
  ```

### Submodules

Three submodules are active.

| Path                              | Repository                                  | Purpose                                                       |
|-----------------------------------|---------------------------------------------|---------------------------------------------------------------|
| `mc-tools/`                       | `Krutoy242/mc-tools`                        | CLI utilities (`errors`, `manifest`, `modlist`, `tcon`, etc.) |
| `scripts/craft/`                  | `Krutoy242/Craft.zs`                        | Shared ZenScript crafting library                             |
| `Enigmatica2Expert-Extended.wiki` | `Krutoy242/Enigmatica2Expert-Extended.wiki` | Wiki content                                                  |

### Git filters (`.gitattributes`)

Several clean filters normalize config files to avoid noisy diffs. They are defined in the local git config (run `git config --local --list | grep filter` to inspect).

