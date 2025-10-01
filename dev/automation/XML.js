/**
 * @file Collect all XML files with recipes that cant be handled by
 * zenscripts itself. This is usually EnderIO and AdvRocketry xml's
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

// @ts-check

import { writeFileSync } from 'node:fs'
import { relative } from 'node:path'

import detectIndent from 'detect-indent'
import fast_glob from 'fast-glob'
import _ from 'lodash'
import { js2xml, xml2js } from 'xml-js'
import yargs from 'yargs'

import { defaultHelper, loadText, naturalSort } from '../lib/utils.js'

/** @typedef {import("xml-js").Element} XMLElement */

const argv = yargs(process.argv.slice(2))
  .alias('dryrun', 'd')
  .describe('dryrun', 'Do not add/remove recipes, just format files')
  .parseSync()

export async function init(h = defaultHelper) {
  // List of curated files and folders
  const curatedFiles = fast_glob.sync([
    'config/advRocketry/*.xml',
    'config/enderio/recipes/user/user_recipes.xml',
  ], { dot: true }).map(p => relative(process.cwd(), p).replace(/\\/g, '/'))

  await h.begin('Curating XML files', curatedFiles.length)

  const automaticComment
    = ' Recipe below generated automatically. Do not make changes or they gonna be rewritten. '

  const changes = !argv.dryrun
    ? (await h.begin('Reading crafttweaker.log'), getChanges())
    : {}

  let totalNewRecipes = 0

  for (const filePath of curatedFiles) {
    mutateXml(filePath, (xml_obj) => {
      const recipes = xml_obj.elements.find(
        o => o.name === 'Recipes' || o.name === 'enderio:recipes'
      )
      if (!recipes) return

      const recipeList = recipes.elements
      if (!recipeList) return

      let j = recipeList.length
      while (j--) {
        const commentElement = recipeList[j]
        if (
          commentElement.type === 'comment'
          && commentElement.comment === automaticComment
        ) {
          const elemsToRemove
            = recipeList[j + 1] && recipeList[j + 1].type === 'comment' ? 3 : 2
          recipeList.splice(j, elemsToRemove)
        }
      }

      // Add recipes to this list
      if (!changes[filePath]) return
      for (const recipeXml of changes[filePath]) {
        recipeList.push({ type: 'comment', comment: automaticComment })
        recipeXml.elements.forEach((e) => {
          recipeList.push(e)
        })
        totalNewRecipes++
      }
    })
    h.step()
  }

  h.result(`Total automatic XML recipes: ${totalNewRecipes}`)
}
if (
  // eslint-disable-next-line antfu/no-top-level-await
  import.meta.url === (await import('node:url')).pathToFileURL(process.argv[1]).href
)
  init()

/** @param {string} xmlString */
function xml_to_js(xmlString) {
  try {
    return /** @type {XMLElement} */ xml2js(xmlString, { compact: false })
  }
  catch (error) {

  }
}

/** @return {{[filePath: string]: XMLElement[]}} */
function getChanges(h = defaultHelper) {
  /** @type {{[filePath: string]: string[]}} */
  const changesText = {}

  for (const { groups } of loadText('crafttweaker.log').matchAll(
    /^\[INITIALIZATION\]\[CLIENT\]\[INFO\] Put this recipe in file \[(\.\/)?(?<filename>[^\]]*)\] manually.\n\r?(?<recipe>(\s*<!--(.*)-->\n\r?)?([\s\S]*?<\/[rR]ecipe>))/gm
  ))
    (changesText[groups.filename] ??= []).push(groups.recipe)

  /** @param {XMLElement} a */
  function countInputs(a) {
    const recipe = a.elements.find(
      o => o.name?.toLowerCase() === 'recipe'
    ).elements
    const inputs
      = recipe.find(o => o.name?.toLowerCase() === 'input')?.elements
        ?? recipe
          .find(o => o.type === 'element')
          ?.elements
          .filter(
            e => e.type === 'element' && e.name.includes('input')
          )

    return inputs.length
  }

  // Sort recipes inside changes to prevent object shuffling
  return _(changesText)
    .mapValues(arr =>
      arr
        .map(xml_to_js)
        .filter(Boolean)
        .sort(
          (a, b) =>
            countInputs(b) - countInputs(a)
            || naturalSort(JSON.stringify(a), JSON.stringify(b))
        )
    )
    .value()
}

/**
 * @param {string} filePath
 * @param {{ (xml_obj: XMLElement): void }} xmlObjectMutationCB
 */
function mutateXml(filePath, xmlObjectMutationCB) {
  const xml = loadText(filePath)
  const obj = xml_to_js(xml)
  if (xmlObjectMutationCB) xmlObjectMutationCB(obj)
  const XML = js2xml(obj, { spaces: detectIndent(xml).indent || '	' })
  writeFileSync(filePath, XML)
}
