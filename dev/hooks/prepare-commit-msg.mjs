/**
 * The `prepare-commit-msg` hook: open the editor with the shape of the message
 * already spelled out, so the rules arrive before the commit, not after it.
 *
 * Only ever touches an otherwise empty message, and only when git is about to
 * open an editor. `git commit -m …`, merges, squashes, `--amend` and templates
 * are left exactly as they are.
 *
 * In VS Code this shows up with `git.useEditorAsCommitInput` (on by default):
 * committing with an empty Source Control box opens `COMMIT_EDITMSG`, which is
 * this file's output. The Source Control box itself is not reachable from a git
 * hook — nothing but an extension can write into it.
 */

import { readFileSync, writeFileSync } from 'node:fs'
import process from 'node:process'
import { stripComments, TYPES } from './commit-lint.mjs'

const [, , file, source] = process.argv

// `source` is empty only for a plain `git commit`; anything else already has a
// message the author or git chose.
if (!file || source) process.exit(0)

const raw = readFileSync(file, 'utf8')
if (stripComments(raw)) process.exit(0)

writeFileSync(file, `
${[
  '# ── this pack: <type>(<scope>): <emoji><what changed> ───────────────────',
  '#',
  '# The subject line is copied into CHANGELOG-latest.md as-is, so write it',
  '# for a player: what changed for them, not which file you touched.',
  '#',
  `# types: ${TYPES.join(' ')}   scope: optional, free-form   emoji: your pick`,
  '# Wrap item names in [brackets] so the changelog can turn them into icons.',
  '#',
].join('\n')}
${raw.trimStart()}`)
