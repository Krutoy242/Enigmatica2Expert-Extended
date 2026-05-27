---
name: lang
description: Working with Minecraft .lang localization files. Use when editing any .lang file under resources/.
metadata:
  audience: modpack-devs
  workflow: editing-lang
---

## Replace a line by key

Use always when need to change any lang entry (instead of default edit tool).

```bash
f=path/to/file.lang && node -e 'const fs=require("fs"),f=process.argv[1],k=process.argv[2],v=process.argv[3];let c=fs.readFileSync(f,"utf8");c=c.replace(new RegExp("^"+k+"=.*","m"),k+"="+v);fs.writeFileSync(f,c);' "$f" i18n.key.id 'new value\nwith newlines' && git diff --color "$f"
```
