/**
 * Read the commit subjects of a pull request and, if any of them would make a
 * poor changelog line, leave one comment saying so.
 *
 * Deliberately toothless: it never sets a failing exit code and never requests
 * changes. A contributor who gets the shape wrong has still done the work, and
 * a maintainer can reword while squashing — the comment exists to explain why
 * the pack cares, not to stand in the way.
 *
 * Runs on plain `node`: `dev/hooks/commit-lint.mjs` has no dependencies, so the
 * workflow needs no install step at all.
 */

import process from 'node:process'
import { lintCommit, TYPES } from '../../dev/hooks/commit-lint.mjs'

const MARKER = '<!-- commit-lint -->'

const {
  GITHUB_TOKEN,
  GITHUB_REPOSITORY,
  PR_NUMBER,
  DRY_RUN,
} = process.env

const [owner, repo] = (GITHUB_REPOSITORY ?? '/').split('/')

if (!GITHUB_TOKEN || !PR_NUMBER) {
  console.log('No token or pull request number — nothing to do.')
  process.exit(0)
}

const commits = await readCommits()
const reviewed = commits
  .map(commit => ({ ...commit, ...lintCommit(commit.message) }))
  .filter(commit => !commit.skipped && (commit.errors.length || commit.warnings.length))

console.log(`${commits.length} commit(s), ${reviewed.length} with something to say`)

const body = reviewed.length ? render(reviewed, commits.length) : ''
if (DRY_RUN === 'true') {
  console.log(body || '(nothing to post)')
  process.exit(0)
}

await sync(body)

/**
 * Every commit the pull request adds, as metadata — nothing is cloned, which is
 * both why this is quick and why the contributed code never runs here.
 *
 * The API stops at 250 commits; a pull request that long has other problems.
 */
async function readCommits() {
  const commits = []
  for (let page = 1; page <= 3; page++) {
    const batch = await api(`pulls/${PR_NUMBER}/commits?per_page=100&page=${page}`)
    commits.push(...batch.map(entry => ({ sha: entry.sha, message: entry.commit.message })))
    if (batch.length < 100) break
  }
  return commits
}

function render(reviewed, total) {
  const lines = [
    MARKER,
    '### A note on the commit subjects',
    '',
    'Every subject line below is copied into `CHANGELOG-latest.md` word for word,',
    'and that file is what players read in the launcher when the pack updates.',
    'That is the only reason this comment exists — nothing here blocks the merge,',
    'and a maintainer can always reword a subject while squashing.',
    '',
  ]

  for (const commit of reviewed) {
    lines.push(`**\`${commit.sha.slice(0, 8)}\`** — ${escape(firstLine(commit.message))}`)
    for (const error of commit.errors) {
      // An error's later lines are the worked example — the useful half. They
      // are already indented for a terminal, so undo that and fence them.
      const [first, ...example] = error.split('\n')
      lines.push(`- ${escape(first)}`)
      if (example.length)
        lines.push('  ```', ...example.map(line => `  ${line.replace(/^ {4}/, '')}`), '  ```')
    }
    for (const warning of commit.warnings)
      lines.push(`- ${escape(warning)}`)
    lines.push('')
  }

  lines.push(
    '<details><summary>What the pack expects</summary>',
    '',
    '```',
    '<type>(<scope>): <emoji><what changed>',
    '',
    'fix(recipes): ✏️make [Sacred Oak Sapling] craftable without a Botania altar',
    'feat: 🔺add Bixbite gem and ore',
    'chore: 🔵mods updates',
    '```',
    '',
    `- **type** — one of \`${TYPES.join('`, `')}\`.`,
    '- **scope** — optional and free-form; use whatever names the area you touched.',
    '- **emoji** — required, and entirely your pick; it is what makes a changelog line findable.',
    '- **item names** in `[square brackets]`, so the changelog can swap them for icons.',
    '',
    'Cloning the repo and running `pnpm install` sets up a git hook that says all of',
    'this before the commit is made, which is a lot less annoying than a comment.',
    '</details>',
    '',
    `<sub>${reviewed.length} of ${total} commit${total === 1 ? '' : 's'} · this check never fails a build</sub>`
  )

  return lines.join('\n')
}

function firstLine(text) {
  return text.split('\n')[0].trim()
}

/** Angle brackets in a subject would be swallowed by the comment's HTML. */
function escape(text) {
  return text.replace(/[<>]/g, char => char === '<' ? '&lt;' : '&gt;')
}

/** Post, edit or withdraw the single comment this check owns. */
async function sync(body) {
  const existing = (await api(`issues/${PR_NUMBER}/comments?per_page=100`))
    .find(comment => comment.body?.includes(MARKER))

  if (!body) {
    // Everything got fixed up: take the comment down rather than leave a stale scold.
    if (existing) {
      await api(`issues/comments/${existing.id}`, 'DELETE')
      console.log('Withdrew the earlier comment — the subjects read fine now.')
    }
    return
  }

  if (existing) {
    await api(`issues/comments/${existing.id}`, 'PATCH', { body })
    console.log(`Updated comment ${existing.id}`)
  }
  else {
    const created = await api(`issues/${PR_NUMBER}/comments`, 'POST', { body })
    console.log(`Posted comment ${created.id}`)
  }
}

async function api(path, method = 'GET', payload) {
  const response = await fetch(`https://api.github.com/repos/${owner}/${repo}/${path}`, {
    method,
    headers: {
      'accept'       : 'application/vnd.github+json',
      'authorization': `Bearer ${GITHUB_TOKEN}`,
      'content-type' : 'application/json',
    },
    body: payload ? JSON.stringify(payload) : undefined,
  })
  if (!response.ok)
    throw new Error(`${method} ${path} → ${response.status} ${await response.text()}`)
  return response.status === 204 ? null : response.json()
}
