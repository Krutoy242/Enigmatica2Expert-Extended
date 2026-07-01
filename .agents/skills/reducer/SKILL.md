---
name: reducer
description: Toggle mods and restart/monitor Minecraft from the CLI. Use to enable/disable mods, reboot the instance after script/config/mod changes, locate a mod's jar, or auto-bisect which mod causes a load bug. Backed by `@mctools/reducer`.
---

Run via `pnpm reducer <command>` (alias for `mctools-reducer`). All flags have a
short single-letter form. Add `-y`/`--dry` to any mutating command to log
intended changes as "assumed" without touching files or processes. Full,
example-rich docs live in `pnpm reducer --help` and `pnpm reducer <cmd> --help`.

## Restart (replaces the old `restart.ts`)
```sh
pnpm reducer restart                       # reboot MC, keep current mod set, monitor logs, report CraftTweaker errors
pnpm reducer restart --full                # reboot with every mod enabled
pnpm reducer kill                          # just kill the running game
```
`restart` kills the game, relaunches it (PrismLauncher by default), tails
`logs/debug.log` until idle/crash/timeout, then prints `crafttweaker.log`
ERROR/FATAL lines. Exit `0` when clean, `1` on crash/errors.

## Change the mod set
Names are fuzzy — accept CF id, addon name, or jar filename.
```sh
pnpm reducer restart --disable "Mod A" "Mod B"   # disable mods + dependents, then reboot
pnpm reducer restart --enable  "Mod A"           # enable mods + dependencies, then reboot
pnpm reducer restart --only    "Mod A"           # enable only Mod A (+deps), disable everything else
pnpm reducer restart --except  "Mod A"           # disable Mod A (+dependents), enable everything else
pnpm reducer restart --disable A --enable B      # combined; refuses self-excluding requests
pnpm reducer disable "Mod A"                      # ⚠ same as a mode flag but WITHOUT reboot (prefer restart --disable)
```
Mirror verbs without reboot: `disable` / `enable` / `only` / `except` (each warns
that the combined `restart --…` form is usually better).

## Find / inspect
```sh
pnpm reducer find jei thaum 1234           # → "jei: ./mods/jei_….jar" per query
pnpm reducer find --dependencies "Mod A"   # also list the dependency closure (-u for dependents)
pnpm reducer status                        # roster, diagnostics, weight metrics (one-liners)
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
Work is checkpointed to a lock file. If a run is killed mid-operation, the next
run refuses to proceed and asks you to choose:
```sh
pnpm reducer --continue    # resume (only if no jar was renamed/removed since)
pnpm reducer --new         # discard the interrupted session and start over
```
If the environment changed (a different jar renamed) `--continue` aborts and tells
you to use `--new`. If a jar is locked (game still holding it), the run stops with
a clear message and leaves the session open for `--continue` after you free it.

## Launcher override
Default launcher is PrismLauncher (Windows). To use another, set
`launcher: { kind: command, launch: "<shell cmd>", processName: "javaw.exe" }`
in `<mc>/reducer.config.yml`, or `REDUCER_LAUNCHER=command`.
