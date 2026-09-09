/* eslint-disable regexp/no-super-linear-backtracking */

import type { GetCommitsParams } from '@conventional-changelog/git-client'

import type { Preset } from 'conventional-changelog'
import type { CommitGroup, CommitKnownProps, FinalContext, Options as WriterOptions } from 'conventional-changelog-writer'
import type { ParserStreamOptions } from 'conventional-commits-parser'

import { existsSync, readFileSync } from 'node:fs'

import { dirname, resolve } from 'node:path'
import process from 'node:process'
import { fileURLToPath } from 'node:url'
import { parse } from 'yaml'
import { $ } from 'zx'

import { generateModsList } from '../../../mc-tools/packages/modlist/src/index.js'
import { loadReleaseSnapshots } from '../../build/devonly.js'

// ESM-safe __dirname
const __dirname = dirname(fileURLToPath(import.meta.url))

/**
 * Capitalize the first letter of the string, preserving emoji/punctuation prefix.
 */
function capitalize(str: string) {
  return str.replace(
    /(^\P{L}*)(\p{L})/u,
    (_, prefix: string, letter: string) => prefix + letter.toLocaleUpperCase()
  )
}

interface Config {
  defaultAuthor: string
  discardable  : Record<string, string>
  renames      : Record<string, string>
  scopes       : Record<string, string>
}

/**
 * Read a file shipped alongside this config, failing with the full path.
 * Tool-owned assets resolve from `__dirname`; repo content stays cwd-relative.
 */
function readAsset(...segments: string[]): string {
  const path = resolve(__dirname, ...segments)
  if (!existsSync(path)) {
    throw new Error(`Missing changelog asset: ${path}`)
  }
  return readFileSync(path, 'utf8')
}

const config: Config = parse(readAsset('config.yml')) as Config

/**
 * The `## Mods changes` section.
 *
 * Both sides are filtered by their own `.devonly.ignore`, so the list answers
 * "what changed for players" rather than "what changed in the dev instance" —
 * see {@link loadReleaseSnapshots}.
 */
async function getModChanges() {
  const key = process.env.CF_API_KEY
  if (!key) {
    throw new Error('CF_API_KEY environment variable is required for changelog generation')
  }

  const described = await $`git describe --tags --abbrev=0`.nothrow()
  if (described.exitCode !== 0) {
    throw new Error('Cannot determine the previous release: `git describe --tags` found no tag.\n'
      + '  The mod-changes section compares against the latest tag, so at least one must exist.')
  }
  const oldVersion = described.stdout.trim()

  const { fresh, old, ignore, oldIgnore } = await loadReleaseSnapshots(`tags/${oldVersion}`)

  return generateModsList({
    fresh,
    old,
    ignore,
    oldIgnore,
    key,
    template: readAsset('modlist.md'),
  })
}

const commits: GetCommitsParams = {
  format:
    '%B%n-hash-%n%H%n-gitTags-%n%d%n-committerDate-%n%ci%n-authorName-%n%an%n-authorEmail-%n%ae%n-gpgStatus-%n%G?%n-gpgSigner-%n%GS',
}

interface CommitTemplateAdditionals {
  authorUrl?     : string
  description?   : string[]
  images?        : string[]
  isContribution?: boolean
}

interface CommitUnknownProps {
  authorEmail?: string
  authorName? : string
  gpgSigner?  : string
  gpgStatus?  : string
  raw?        : string
  scope?      : string
  subject?    : string
}

type Commit = CommitKnownProps & CommitTemplateAdditionals & CommitUnknownProps

const writer: WriterOptions = {
  mainTemplate : readAsset('templates', 'template.hbs'),
  commitPartial: readAsset('templates', 'commit.hbs'),

  commitGroupsSort: 'title',
  commitsSort     : (a: Commit, b: Commit) => (a.subject || '').localeCompare(b.subject || ''),

  transform(_commit: Commit, _context: FinalContext<Commit>) {
    const commit: Commit = {
      ..._commit,
    }

    // Discardable type
    if (commit.type && config.discardable[commit.type]) return null

    // Rename types
    commit.type = config.renames[commit.type ?? '']

    if (typeof commit.scope === 'string') {
      commit.scope
        = config.scopes[commit.scope.toLocaleLowerCase()]
          ?? capitalize(commit.scope)
    }

    if (typeof commit.subject === 'string') {
      commit.subject = capitalize(commit.subject)
    }

    if (typeof commit.hash === 'string') {
      commit.hash = commit.hash.substring(0, 7)
    }

    // Extract image links from body
    if (typeof commit.body === 'string') {
      const images: string[] = []
      commit.body = commit.body.replace(
        /(^|\s+)(!\[[^\]]*\]\()?(?<link>https?:\/\/[^\s"')]+?\.(?:png|jpe?g|gif|svg))\)?(?=$|\s)/gim,
        (_, __, ___, link:string) => {
          images.push(link)
          return ''
        }
      )
      if (images.length) commit.images = [...images].reverse()
    }

    // Description: body + footer with indentation
    if (typeof commit.body === 'string' || typeof commit.footer === 'string') {
      const footer = commit.footer ? `\n\n${commit.footer}` : ''
      const description = `${commit.body ?? ''}${footer}`.trim()
      commit.description = (description ? description.split('\n') : [])
        .map((l, i, arr) => l && i !== arr.length - 1 && arr[i + 1] ? `${l.trimEnd()}  ` : l) // add line breaks
    }

    if (typeof commit.header === 'string') {
      commit.header = capitalize(commit.header)
    }

    // Mark contributions
    if (
      commit.authorName
      && commit.authorEmail
      && commit.authorEmail !== config.defaultAuthor
    ) {
      commit.isContribution = true
      const sanitized = commit.authorName
        .trim()
        .toLowerCase()
        .replace(/[^a-z0-9-]/g, '')
      commit.authorUrl = `https://github.com/${sanitized}`
    }

    return commit
  },

  async finalizeContext(context: FinalContext<Commit> & { modschanges?: string }) {
    context.modschanges = await getModChanges()

    // Group commits by scope inside each group
    context.commitGroups?.forEach((group) => {
      if (!group.title) group.title = 'Misc'
      const groupedBy: Record<string, Commit[]> = {}
      group.commits.forEach((c: Commit) => {
        (groupedBy[c.scope || ''] ??= []).push(c)
      })

      // @ts-expect-error dynamically mutate group type
      delete group.commits

      const groupAny = group as CommitGroup<Commit> & { scopes: object }
      groupAny.scopes = Object.entries(groupedBy).map(([scope, commits]) => ({
        scope,
        commits,
      })).sort((a, b) => a.scope.localeCompare(b.scope))
    })

    return context
  },
}

const parser: ParserStreamOptions = {
  headerPattern       : /^(\w*)(?:\((.*)\))?!?: (.*)$/,
  headerCorrespondence: ['type', 'scope', 'subject'],
  noteKeywords        : ['BREAKING CHANGE', 'BREAKING-CHANGE'],
  revertPattern       : /^(?:Revert|revert:)\s"?([\s\S]+?)"?\s*This reverts commit (\w*)\./i,
  revertCorrespondence: ['header', 'hash'],
}

const exportConfig: Preset = {
  commits,
  writer,
  parser,
}

export default exportConfig
