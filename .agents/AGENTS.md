# Enigmatica 2: Expert – Extended

## Project type

Modpack for **Minecraft 1.12.2; Forge/Cleanroom**.
Active development = **ZenScript**, mod **config files**, **TypeScript dev toolchain**.

## Working directories

| Path               | What it is                                                                   |
|--------------------|------------------------------------------------------------------------------|
| `scripts/`         | All ZenScript (`.zs`)                                                        |
| `config/`          | 400+ mod configs.                                                            |
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

- **Common scopes:** `recipes`, `quest`, `config`, `balance`, `worldgen`, `mods`, `gear`, `jei`, etc.
- **Emojis:** mandatory (e.g. `✏️` recipes, `📖` quests, `🧱` build, `🔵` mod updates, `♻️` refactor, `⚡` perf, etc.).
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

## Dev toolchain how-to

Hard-won notes; check here before fighting these again.

- **Typecheck a single `.ts` against the project config.** `tsc <file>` errors `TS5112` ("tsconfig present but will not be loaded"), and passing `--module`/`--strict` flags standalone mis-resolves some dep types (e.g. `find-process` becomes `any`, giving phantom `TS7006` implicit-any errors that don't exist in-project). Instead make a temp config in the repo root and point `--project` at it:
  ```sh
  echo '{ "extends": "./tsconfig.json", "include": ["path/to/file.ts"] }' > tsconfig.check.tmp.json
  npx tsc --noEmit --project tsconfig.check.tmp.json; rm -f tsconfig.check.tmp.json
  ```
  Side note: a `find-process` result iterated with `.filter(p => …)` triggers implicit-any under `strict`; use `for (const p of list)` instead.
- **Linting under `.agents/`.** These files are ESLint-ignored; `eslint --no-ignore` fails with "not found by the project service / `allowDefaultProject`". Don't chase it — rely on the temp-tsconfig typecheck above.
- **PowerShell from the Bash tool mangles `$vars`.** Bash expands `$p` before `powershell.exe` sees it. For anything with `$variable`/`Get-Process`/`Get-CimInstance`, use the PowerShell tool directly.
