/**
 * Ask `mc-icons` whether the `[Item Name]`s in a commit message can be turned
 * into icons, and report the ones that cannot.
 *
 * `dev/make_pack.ts` iconifies `CHANGELOG-latest.md` at release time, and every
 * ambiguous name stops that run for a manual pick. Doing the same check here
 * moves the problem to the moment the name is typed, when the author still
 * remembers which mod they meant.
 *
 * Never fatal: if mc-icons is missing (any machine but the maintainer's, and
 * CI) the check quietly reports nothing.
 */

import { execFileSync } from 'node:child_process'
import { existsSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'
import process from 'node:process'

/** Same checkout `dev/make_pack.ts` iconifies the changelog with. */
const MC_ICONS = process.env.MC_ICONS || 'E:/dev/mc-icons'

/** Same flags as the release run, so a name that passes here passes there too. */
const ARGS = ['--no-short', '--modpack=e2ee', '--treshold=2', '--silent']

/** mc-icons builds a 30k-entry trie on startup; a slow disk must not hold up a commit. */
const TIMEOUT = 20_000

/** `[Item Name]` — but not a markdown link `[text](url)` or an already-made icon. */
const BRACKET_RE = /\[([^[\]\n]{2,60})\](?!\()/g

/**
 * @param {string} message Commit message, comments already stripped.
 * @returns {string[]} Names mc-icons could not resolve on its own.
 */
export function unresolvedIcons(message) {
  const names = extractNames(message)
  if (!names.length) return []

  const cli = resolveCli()
  if (!cli) return []

  const verdicts = ask(cli, names)
  if (!verdicts) return [] // mc-icons failed — say nothing rather than cry wolf

  return names.filter(name => verdicts[name] === false)
}

function extractNames(message) {
  const names = new Set()
  for (const [, name] of message.matchAll(BRACKET_RE)) {
    const trimmed = name.trim()
    // Issue refs, versions and bare numbers are never item names.
    if (!trimmed || /^[\d.\s#v]+$/.test(trimmed)) continue
    names.add(trimmed)
  }
  return [...names]
}

/**
 * The built entry point is preferred — it starts in plain node, where the
 * TypeScript source would need `tsx` and roughly half a second more.
 */
function resolveCli() {
  const built = join(MC_ICONS, 'build/cli.js')
  if (!existsSync(built) || !existsSync(join(MC_ICONS, 'assets/assets.db'))) return null
  return built
}

/**
 * Run one name per line through mc-icons; a line that comes back still wrapped
 * in brackets is a name it refused to guess at.
 */
function ask(cli, names) {
  const dir = mkdtempSync(join(tmpdir(), 'commit-icons-'))
  const file = join(dir, 'names.md')
  try {
    writeFileSync(file, `${names.map(name => `[${name}]`).join('\n')}\n`)
    execFileSync(process.execPath, [cli, file, ...ARGS], {
      timeout    : TIMEOUT,
      stdio      : 'ignore',
      windowsHide: true,
    })
    const lines = readFileSync(file, 'utf8').split(/\r?\n/)
    return Object.fromEntries(names.map((name, i) => [name, !/^\[[^\]]*\]$/.test(lines[i] ?? '')]))
  }
  catch {
    return null
  }
  finally {
    rmSync(dir, { recursive: true, force: true })
  }
}
