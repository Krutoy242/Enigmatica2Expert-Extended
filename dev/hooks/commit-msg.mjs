/**
 * The `commit-msg` hook: refuse a message that is not `type(scope): <emoji>…`,
 * and say out loud — without refusing — everything else that would make the
 * changelog line worse.
 *
 * Run through `node` directly (no tsx, no linter framework) because this is on
 * the path of every single commit.
 *
 * Escape hatch: `git commit --no-verify`.
 */

import { readFileSync } from 'node:fs'
import process from 'node:process'
import { unresolvedIcons } from './commit-icons.mjs'
import { lintCommit, stripComments } from './commit-lint.mjs'

// VS Code shows hook output in a plain text pane, where escape codes would be
// read as text — so colour only when something is actually a terminal.
const ESC = String.fromCharCode(27)
const paint = process.stderr.isTTY && !process.env.NO_COLOR
const sgr = code => paint ? `${ESC}[${code}m` : ''
const RED = sgr(31)
const YELLOW = sgr(33)
const DIM = sgr(2)
const BOLD = sgr(1)
const OFF = sgr(0)

// Wrapped in a function only because the icon check awaits mc-icons, and
// top-level await is off-limits in this repo's lint config.
main().catch((err) => {
  console.error(`commit-msg: ${err?.message ?? err}`)
  process.exit(1)
})

async function main() {
  const file = process.argv[2]
  if (!file) {
    console.error('commit-msg: no message file given')
    process.exit(1)
  }

  const raw = readFileSync(file, 'utf8')
  const { skipped, errors, warnings } = lintCommit(raw)

  if (skipped) process.exit(0)

  const message = stripComments(raw)
  for (const problem of await iconProblems(message))
    warnings.push(iconWarning(problem))

  for (const warning of warnings)
    console.error(`${YELLOW}!${OFF} ${warning}`)

  if (!errors.length) {
    if (warnings.length)
      console.error(`${DIM}  Committed anyway — these are suggestions.${OFF}`)
    process.exit(0)
  }

  console.error('')
  for (const error of errors)
    console.error(`${RED}✖${OFF} ${error}`)

  console.error(`
${BOLD}This line becomes a CHANGELOG bullet that players read.${OFF}
  ${DIM}<type>(<scope>): <emoji><what changed>${OFF}

  fix(recipes): ✏️make [Sacred Oak Sapling] craftable without a Botania altar
  feat: 🔺add Bixbite gem and ore
  chore: 🔵mods updates

  ${DIM}scope is optional · emoji is not · item names go in [brackets]
  Bypass once with:  git commit --no-verify${OFF}
`)

  process.exit(1)
}

/** Only runs when the message actually names something. */
async function iconProblems(message) {
  if (!message.includes('[')) return []
  try {
    return await unresolvedIcons(message)
  }
  catch {
    return []
  }
}

/** An ambiguous name is worth more than a complaint: show what to write instead. */
function iconWarning({ query, hints, total, guessed }) {
  if (!hints.length)
    return `mc-icons doesn't know ${query} — it will stay plain text in the changelog.`

  const lines = hints.map(h => `    ${h}`)
  if (total > hints.length) lines.push(`    …and ${total - hints.length} more`)

  const head = guessed
    ? `mc-icons doesn't know ${query} — did you mean:`
    : `${query} means ${total} different items — it will stop the release run `
      + `for a manual pick. Write one of:`

  return `${head}\n${DIM}${lines.join('\n')}${OFF}`
}
