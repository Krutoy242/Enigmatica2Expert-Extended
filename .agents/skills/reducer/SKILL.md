---
name: reducer
description: Toggle mods and restart/monitor Minecraft from the CLI. Use to enable/disable mods, reboot the instance after script/config/mod changes, locate a mod's jar, or auto-bisect which mod causes a load bug. Backed by `@mctools/reducer`.
---

Run via `pnpm reducer <command>` (alias for `mctools-reducer`). The CLI is the
robot surface; humans do fine-grained toggling in the interactive TUI (bare
`pnpm reducer`). Add `-y`/`--dry` to any mutating command to log intended changes
as "assumed". Full docs: `pnpm reducer --help` / `pnpm reducer <cmd> --help`.

## The agent loop (use this)
Two commands cover the normal cycle — change something, reboot, confirm it loaded:
```sh
pnpm reducer restart --detach              # (optionally change mods first) reboot, return in ~5s
pnpm reducer ready --wait                  # block until the game is loaded & ready for commands
npx tsx .agents/skills/zs/run-cmd.ts 'say hi'   # now run in-game commands (see the `zs` skill)
```
- `restart --detach` launches and returns immediately — **use it for a full-pack
  boot** (minutes, longer than the shell timeout). `ready`/`ready --wait` then
  reports loadedness; poll it or block on it.
- **Prefer testing with few mods** (`restart --only "Mod A"`): a reduced set boots
  in ~40s, so a plain blocking `restart` finishes inside a normal tool timeout.

### Readiness is mod-agnostic
`ready` and `restart` never assume ProbeZS, RMI, or CraftTweaker exist. A pack
declares its own extra signals in `reducer.config.yml` (`ready.logPattern`,
`ready.tcpPort`); without them a **bare Forge launch with zero mods** is still
detected via the universal "FML loaded + log quiet" fallback. Cascade: pack
`logPattern` → pack `tcpPort` open → universal FML+quiet → crash/exit/ceiling.

World auto-join (and thus `logPattern: joined the game` readiness) requires
**both** `probezs` + `custommainmenu` mods loaded. Without Custom Main Menu,
the GUI init mixin (`gui_custommainmenu.zs`) is skipped and the world is never
entered — the pack still reaches readiness via `tcpPort` (ProbeZS RMI) or the
FML+quiet fallback, but stays at the main menu, unable to execute commands.

## Restart (blocking form)
```sh
pnpm reducer restart                       # reboot, keep mod set, monitor to "loaded"
pnpm reducer restart --full                # reboot with every mod enabled
pnpm reducer restart --strict              # fail on post-load log ERROR/FATAL (default: warn)
pnpm reducer kill                          # just kill the running game
```
A blocking `restart` prints two separate results — **read them independently**:
- `LOAD ✔ …` / `LOAD ✗ …` — did the game come up? The **exit code follows this**.
- `SCRIPTS ✔ …` / `SCRIPTS ⚠ …` — ERROR/FATAL in the configured `scan:` logs
  (default `crafttweaker.log`, skipped if absent). **Warning only** unless `--strict`.

**Ceiling**: gives up after 15 min if no ready signal appears (`LOAD ✗ ceiling`).
Tune via `reducer.config.yml` (`ready.maxMs`, `ready.quietMs`) or env
`REDUCER_MONITOR_MAX_MS` / `REDUCER_MONITOR_QUIET_MS`. A killed `restart` is safe:
a plain reboot holds no session lock, so it can't leave an "interrupted" state.

## Change the mod set (folded into restart)
Names are fuzzy — accept CF id, addon name, or jar filename.
```sh
pnpm reducer restart --disable "Mod A" "Mod B"   # disable mods + dependents, then reboot
pnpm reducer restart --enable  "Mod A"           # enable mods + dependencies, then reboot
pnpm reducer restart --only    "Mod A"           # enable only Mod A (+deps), disable everything else
pnpm reducer restart --except  "Mod A"           # disable Mod A (+dependents), enable everything else
pnpm reducer restart --disable A --enable B      # combined; refuses self-excluding requests
```
No-reboot toggling lives in the **TUI** (bare `pnpm reducer`), not the CLI.

## Find / inspect
```sh
pnpm reducer ready                         # answer once: loaded & ready right now? (exit 0/1)
pnpm reducer status                        # liveness first line, then roster / diagnostics / weight
pnpm reducer find jei thaum 1234           # → "jei: ./mods/jei_….jar" per query
pnpm reducer find --dependencies "Mod A"   # also list the dependency closure (-u for dependents)
```

## Automated binary search
Pass a conditions file (any existing `*.ts`/`*.mjs`/`*.js` path auto-selects this mode):
```sh
pnpm reducer ./conditions.ts                       # bisect; restart between iterations, read verdict from logs
pnpm reducer --dry ./conditions.ts                 # simulate offline; validate config; report one culprit
pnpm reducer ./conditions.ts -t "Some Lib" -i "Keep Me"   # trusted (kept disabled) / ignored (kept enabled)
pnpm reducer --force ./conditions.ts               # bypass config-validation errors
```
The config exports two log-inspecting functions, checked every tick:
```ts
// conditions.ts
export function isTestEnded(ctx) { return /MixinService .+ was successfully booted/.test(ctx.debugText) || ctx.elapsed > 120_000 }
export function isBugFound(ctx)  { return /Enqueued coremod CrashAssistantEntrypoint/.test(ctx.debugText) }
```
`ctx`: `{ debugLog[], craftTweakerLog[], debugText, elapsed, crashed }`. The loader
checks both functions for **reachability** (replays the current full `debug.log`)
and **performance** (errors if a call averages > 2 s) — fix the config or pass
`--force`. Sanity ceilings (per-test 5 min, total 10 min, crash/exit) end the
search even if the config never fires.

## Crash-safe sessions
Only mod-set changes (renaming jars) are checkpointed to a lock file — a plain
`restart` holds no lock. If a change is killed mid-rename, the next mutating
`restart --…` refuses to proceed and asks you to choose. `--continue`/`--new` work
on `restart --disable …` (and `binary`):
```sh
pnpm reducer restart --new                      # discard the interrupted record and reboot
pnpm reducer restart --disable "Mod A" --continue  # resume after freeing a locked jar
pnpm reducer --continue / --new                 # bare form acts on the stored bisect session
```
If the environment changed (a different jar renamed) `--continue` aborts and tells
you to use `--new`. If a jar is locked (game still holding it), the run stops with
a clear message and leaves the session open for `--continue` after you free it. A
plain `pnpm reducer restart` always proceeds (it only warns about a stale record).

## Launcher override
Default launcher is PrismLauncher (Windows). To use another, set
`launcher: { kind: command, launch: "<shell cmd>", processName: "javaw.exe" }`
in `<mc>/reducer.config.yml`, or `REDUCER_LAUNCHER=command`.
