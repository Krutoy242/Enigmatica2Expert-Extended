/**
 * The commit-message rules of this pack, in one place.
 *
 * Two callers share this module and must never disagree:
 *   - `dev/hooks/commit-msg.mjs`        — blocks a local commit on `errors`
 *   - `.github/scripts/commit-lint-pr.ts` — comments on a pull request
 *
 * Plain ESM with zero dependencies on purpose: the hook runs on every commit,
 * so it must start in a bare `node` (~40 ms) instead of a linter framework.
 *
 * Only two things are hard errors — Conventional Commits shape and a leading
 * emoji. Everything else this file knows is advice, because the subject line is
 * read by players in the changelog, not by a parser.
 */

/**
 * Types seen in this repository's history plus the conventional leftovers.
 * The only closed list in the whole check — scopes are deliberately free-form.
 */
export const TYPES = [
  'balance',
  'build',
  'chore',
  'ci',
  'docs',
  'feat',
  'fix',
  'perf',
  'refactor',
  'revert',
  'style',
  'test',
]

/** `type(scope)!: rest` — scope and `!` optional. */
const HEADER_RE = /^(?<type>[a-z]+)(?:\((?<scope>[^()]+)\))?(?<breaking>!)?: (?<rest>.*)$/

/**
 * One emoji as a user sees it: a pictographic base plus whatever the sequence
 * grammar lets follow it — variation selector, skin tone, ZWJ-joined parts.
 *
 * The modifiers in that class are matched one at a time on purpose — the `*`
 * around it is what glues the sequence back together — so the usual "you
 * probably meant a whole grapheme" warning is exactly backwards here.
 */
// eslint-disable-next-line no-misleading-character-class -- see above
const EMOJI_RE = /^\p{Extended_Pictographic}(?:[\uFE0F\u{1F3FB}-\u{1F3FF}]|\u200D\p{Extended_Pictographic}\uFE0F?)*/u

/** Messages git writes itself, or that a rebase replays — never ours to judge. */
const GENERATED_RE = /^(?:Merge\b|Revert "|fixup!|squash!|amend!|Bumps\b)/

/** Subjects so generic that the changelog line would tell a player nothing. */
const VAGUE_RE = /^(?:update|updates|fix|fixes|fixed|change|changes|changed|misc|stuff|wip|tweak|tweaks|cleanup|refactor|small fix(?:es)?|minor fix(?:es)?|various)\.?$/i

/**
 * Header length above which the subject stops fitting a changelog bullet.
 * Set from this repository's own history: 6% of subjects pass 72 characters but
 * only 2% pass 80, so 80 catches the genuinely runaway ones without nagging
 * about the long-but-normal ones.
 */
const MAX_HEADER = 80

/** Below this the subject is almost certainly not a sentence a player can use. */
const MIN_DESC = 12

/**
 * Strip everything git itself would strip before storing the message:
 * comment lines and the `--- >8 ---` scissors section of `--verbose`.
 */
export function stripComments(raw) {
  const scissors = raw.indexOf('\n# ------------------------ >8 ------------------------')
  const body = scissors === -1 ? raw : raw.slice(0, scissors)
  return body
    .split(/\r?\n/)
    .filter(line => !line.startsWith('#'))
    .join('\n')
    .trim()
}

/** Split a raw emoji off the front of the description. */
export function splitEmoji(rest) {
  const match = EMOJI_RE.exec(rest)
  if (!match) return { emoji: '', desc: rest }
  return { emoji: match[0], desc: rest.slice(match[0].length) }
}

/** Parse a header without judging it. Returns `null` when it is not conventional. */
export function parseHeader(header) {
  const match = HEADER_RE.exec(header)
  if (!match) return null
  const { type, scope, breaking, rest } = match.groups
  const { emoji, desc } = splitEmoji(rest)
  return { type, scope: scope ?? '', breaking: !!breaking, emoji, desc, header }
}

/**
 * Check one commit message.
 *
 * @param {string} raw Message as written, comments included.
 * @returns {{ skipped: boolean, parsed: object|null, errors: string[], warnings: string[] }}
 *   `skipped` for messages git wrote itself; `errors` blocks the commit, `warnings` never does.
 */
export function lintCommit(raw) {
  const message = stripComments(raw)
  const errors = []
  const warnings = []

  if (!message)
    return { skipped: false, parsed: null, errors: ['The message is empty.'], warnings }

  const [header, ...rest] = message.split('\n')

  if (GENERATED_RE.test(header))
    return { skipped: true, parsed: null, errors, warnings }

  const parsed = parseHeader(header)

  if (!parsed) {
    errors.push(
      'The subject is not a Conventional Commit.\n'
      + `    Expected  <type>(<scope>): <emoji><what changed>\n`
      + `    Got       ${header}`
    )
    return { skipped: false, parsed: null, errors, warnings }
  }

  if (!TYPES.includes(parsed.type)) {
    errors.push(
      `"${parsed.type}" is not a known type.\n`
      + `    Use one of: ${TYPES.join(', ')}`
    )
  }

  if (!parsed.emoji) {
    errors.push(
      'The description must start with an emoji — any emoji you think fits.\n'
      + `    ${parsed.type}${parsed.scope ? `(${parsed.scope})` : ''}: ✏️${parsed.desc || 'what changed'}`
    )
  }

  const desc = parsed.desc.trim()

  if (!desc)
    errors.push('There is an emoji but nothing after it — say what changed.')

  // ── everything below is advice ──────────────────────────────────────────────

  if (parsed.emoji && /^\s/.test(parsed.desc))
    warnings.push('Drop the space after the emoji — this repo writes them flush (`fix: ✏️text`).')

  if (header.length > MAX_HEADER)
    warnings.push(`The subject is ${header.length} characters; changelog bullets read better under ${MAX_HEADER}.`)

  if (desc.endsWith('.'))
    warnings.push('Subjects here do not end with a full stop.')

  if (desc && desc.length < MIN_DESC)
    warnings.push(`"${desc}" is very short for a changelog line — what would a player want to know?`)
  else if (VAGUE_RE.test(desc))
    warnings.push(`"${desc}" ends up in the changelog verbatim; name what actually changed.`)

  if (rest.length && rest[0].trim())
    warnings.push('Leave a blank line between the subject and the body.')

  return { skipped: false, parsed, errors, warnings }
}
