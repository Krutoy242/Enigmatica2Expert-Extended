---
name: cofh-world
description: Applying and verifying changes in the CofhWorld mod's world generation configuration. Use this to verify the integrity of the CofhWorld mod's world generation configuration by comparing logs from debug.log.
---

# CofhWorld Tweaker

This skill helps manage the CoFH World mod's world generation configurations, providing integrity verification and change comparison.

## Core Features

### Integrity Check

Allows you to extract world generation data from `logs/debug.log` and compare it with the previous run. This is useful for confirming that your changes in JSON configs have been applied correctly and haven't caused unexpected shifts in generator registration.

**How to use:**

Execute the check script:

```bash
node check_integrity.cjs
```

**What this tool does:**
1. Looks for `logs/debug.log`.
2. Extracts all lines tagged with `[CoFH World]`.
3. Saves the result to `config/cofh/world/~cofh-worldgen-YY-MM-DD-HH-MM-SS.log`.
4. Compares the new file with the previously created log in the same folder.
5. Outputs the differences (via `diff`), if any.

## Recommended Workflow

1. Make changes to the JSON files in `config/cofh/world/`.
2. Reload changes in game by calling command `/cofhworld reload`.
3. Run the integrity check tool.
4. Analyze the `diff` output. If you added a new resource, you should only see its addition. If existing resources have changed their order or parameters without your knowledge — it's a sign of an error in the configs.