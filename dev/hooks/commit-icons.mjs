/**
 * Ask `mc-icons` whether the `[Item Name]`s in a commit message can be turned
 * into icons, and report the ones that cannot — with the exact text that would
 * fix them.
 *
 * `dev/make_pack.ts` iconifies `CHANGELOG-latest.md` at release time, and every
 * ambiguous name stops that run for a manual pick. Doing the same check here
 * moves the problem to the moment the name is typed, when the author still
 * remembers which mod they meant.
 *
 * mc-icons is used as a library, not as a CLI: no process spawn, no temp file,
 * and a name that already exists is answered in single-digit milliseconds.
 *
 * Never fatal: if mc-icons is missing (any machine but the maintainer's, and
 * CI) the check quietly reports nothing.
 */

import { loadIcons } from '../tools/mc-icons.mjs'

/** How many ways to spell one name we are willing to print. */
const MAX_HINTS = 4

/** `[Item Name] (mod)` — but not a markdown link `[text](url)`. Mirrors mc-icons' own regex. */
const BRACKET_RE = /\[(?<capture>[^[\]\n]{2,60})\](?!\()(?<tail>\s+\((?<option>[^)\n]+)\))?/g

/**
 * @typedef {object} IconProblem
 * @property {string} query Reference as written, e.g. `[Scanner]`.
 * @property {string[]} hints Replacements that each resolve to exactly one item.
 * @property {number} total How many items the name could mean, `0` when unknown.
 * @property {boolean} guessed Whether the hints are near misses rather than meanings.
 */

/**
 * @param {string} message Commit message, comments already stripped.
 * @returns {Promise<IconProblem[]>} References mc-icons could not resolve on its own.
 */
export async function unresolvedIcons(message) {
  const queries = extractQueries(message)
  if (!queries.length) return []

  const icons = await loadIcons({ maxCandidates: MAX_HINTS })
  if (!icons) return []

  const problems = []

  for (const query of queries) {
    const res = await icons.resolve(query)
    if (res.status === 'resolved') continue
    const ambiguous = res.status === 'ambiguous'
    // `via: 'fuzzy'` means nothing matched and these are the nearest names — a
    // "did you mean", not a list of what the name could mean.
    const guessed = ambiguous && res.via === 'fuzzy'
    problems.push({
      query,
      hints: ambiguous ? res.candidates.map(icons.describe) : [],
      total: ambiguous && !guessed ? res.total : 0,
      guessed,
    })
  }

  return problems
}

/**
 * Every item reference in the message, its `(option)` included — dropping that
 * would report `[Scanner] (EU2)` as ambiguous when it is the very fix suggested.
 */
function extractQueries(message) {
  const queries = new Set()
  for (const { groups } of message.matchAll(BRACKET_RE)) {
    const capture = groups.capture.trim()
    // Issue refs, versions, bare numbers and markdown's own brackets — a task
    // list `[x]`, a `[!WARNING]` alert — are never item names.
    if (!capture || /^(?:[\d.\s#v]+|x|!\w+)$/i.test(capture)) continue
    queries.add(`[${capture}]${groups.tail ?? ''}`)
  }
  return [...queries]
}
