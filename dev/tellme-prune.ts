import { readdirSync, unlinkSync } from 'node:fs'
import { join } from 'node:path'

const dir = join(import.meta.dirname, '..', 'config', 'tellme')

const files = readdirSync(dir).filter(f => f.endsWith('.csv'))
const groups = new Map<string, string[]>()

for (const f of files) {
  const prefix = f.replace(/_\d{4}-\d{2}-\d{2}_[\d.]+\.csv$/, '')
  if (!groups.has(prefix)) groups.set(prefix, [])
  groups.get(prefix)!.push(f)
}

for (const [prefix, group] of groups) {
  if (group.length <= 1) continue
  group.sort().reverse() // newest first (ISO dates sort lexicographically)
  const toDelete = group.slice(1)
  for (const f of toDelete) {
    unlinkSync(join(dir, f))
    console.log(`Deleted: ${f}`)
  }
}
