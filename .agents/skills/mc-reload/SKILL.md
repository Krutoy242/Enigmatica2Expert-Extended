---
name: mc-reload
description: (Re)start Minecraft instance from CLI. Kills MC, re-launches via PrismLauncher, monitors debug.log for stall/crash, reports CraftTweaker errors. Load when need to test new changes that require MC restarting.
---

## `restart.ts`

Kills the running Minecraft instance (graceful WM_CLOSE, then force kill), detects the PrismLauncher instance ID from the PrismLauncher data dir, launches with `prismlauncher --launch <instance> --alive`, then **monitors** `logs/debug.log` via a single 1 s poll loop. It tracks process liveness and log growth — if the log stalls for 30 s (MC reached idle / finished loading) it reports CraftTweaker `ERROR`/`FATAL` lines and exits; if the process dies or a crash report appears it prints the crash summary and exits non-zero.

```bash
npx tsx .agents/skills/mc-reload/restart.ts
npx tsx .agents/skills/mc-reload/restart.ts --dry                                  # dry-run: no kill, no launch, only report
npx tsx .agents/skills/mc-reload/restart.ts --until_ctlog "pattern"                # stop when regex matches a new line in crafttweaker.log
npx tsx .agents/skills/mc-reload/restart.ts --until_debuglog "pattern"             # stop when regex matches a new line in logs/debug.log
npx tsx .agents/skills/mc-reload/restart.ts --until_debuglog "Done" --stop         # ...and kill MC once the pattern matches
```

**Flags:**
- `--dry` — report `crafttweaker.log` errors only; no kill, no launch.
- `--until_ctlog <regex>` / `--until_debuglog <regex>` — exit `0` on the first new matching line.
- `--stop` — kill MC when the `--until*` pattern matches (or on timeout). Requires an `--until*` flag.

**Exit behavior:**
- Pattern matched (`--until*`) → exit `0`, printing the matched line + the following line.
- No pattern → waits until MC goes idle (`debug.log` quiet 30 s), then reports `ERROR`/`FATAL` and exits (`1` if any, else `0`).
- Crash report found, or MC process dies, or MC never starts within 120 s → prints crash summary, exit `1`.
- Overall ceiling 5 min: with `--until*` and no match → exit `1`; without → final error report.

**Output (live):**
- One-line header: `cwd=…  instance=…  mc=…  world=…`
- Progress dots `.` printed during monitor phase (every 5 seconds)
- Event lines: kill, launch, MC process start, stall/idle, crash report path + summary
- Final: `ERROR`/`FATAL` lines from `crafttweaker.log` (capped, with `…and N more`)
- `--until_*`: matched line (with line number) + next line

**Log tailing:**
- Each session truncates `debug.log` / `crafttweaker.log`; the poller tails from the new start and handles truncation/rotation and partial (mid-write) lines.
- A single read per file per tick — no double-consumption races.

**Instance detection:**
Auto-detects by scanning `InstanceDir` from `prismlauncher.cfg` and `{dataDir}/instances/` for an instance whose `.minecraft` symlink/junction resolves to the current directory (case-insensitive, handles relative links).

**World detection:**
Launches `--world <latest>` using the save with the newest `level.dat` mtime.

**Requirements:**
- `prismlauncher` in PATH
- Running from the modpack's root directory (the `.minecraft` folder)
