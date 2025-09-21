import type { Element} from 'xml-js'

import {consola} from 'consola'
import fg from 'fast-glob'
import fs from 'fs-extra'
import {join, relative} from 'pathe'
import { js2xml, xml2js } from 'xml-js'

// Assuming the script is run from the project root.
const PROJECT_ROOT = process.cwd()
const RECIPES_DIR = join(PROJECT_ROOT, 'config/enderio/recipes')
const USER_RECIPES_FILE = join(RECIPES_DIR, 'user/user_recipes.xml')

// fg.sync('config/enderio/recipes/user/*.xml')
//   .map((f) => {
//     let x
//     try {
//       x = xml2js(fs.readFileSync(f, 'utf8'), { compact: false })
//     }
//     catch {
//       return undefined
//     }

//     return [f, x] as const
//   })
//   .filter(Boolean)
//   .forEach(([f, x]) => fs.writeFileSync(f, js2xml(x, { compact: false, spaces: 2 })))

// process.exit(0)

/**
 * Reads and parses an XML file into a JavaScript object.
 * @param filePath The path to the XML file.
 * @returns A promise that resolves to the parsed XML object or null on error.
 */
async function parseXmlFile(filePath: string): Promise<Element | null> {
  try {
    if (!await fs.pathExists(filePath)) {
      consola.error(`File not found: ${filePath}`)
      return null
    }
    const xmlString = String(await fs.readFile(filePath, 'utf-8'))
    // `compact: false` preserves the structure, including comments and whitespace.
    return xml2js(xmlString, { compact: false }) as Element
  }
  catch (error) {
    consola.error(`Error parsing ${filePath}:`, error)
    return null
  }
}

/**
 * Writes a JavaScript object to an XML file.
 * @param filePath The path to write the file to.
 * @param data The JavaScript object representing the XML.
 */
async function writeXmlFile(filePath: string, data: Element) {
  const xmlString = js2xml(data, { compact: false, spaces: 2 })
  await fs.writeFile(filePath, xmlString, 'utf-8')
}

/**
 * Extracts all recipes and grinding balls from a parsed XML object.
 * @param xmlObject The parsed XML object.
 * @returns An array of objects, each containing a recipe's name and its XML element.
 */
function getRecipes(xmlObject: Element): { element: Element, name: string }[] {
  const recipes: { element: Element, name: string }[] = []
  const root = xmlObject.elements?.find(e => e.name === 'enderio:recipes')
  if (!root?.elements) {
    return []
  }

  for (const element of root.elements) {
    if (element.type === 'element' && (element.name === 'recipe' || element.name === 'grindingball')) {
      const nameAttr = element.attributes?.name
      if (nameAttr) {
        recipes.push({ name: String(nameAttr), element })
      }
    }
  }
  return recipes
}

async function main() {
  consola.start('Starting EnderIO recipe de-duplication...')

  // 1. Parse user_recipes.xml to get the prioritized recipes.
  const userRecipesObject = await parseXmlFile(USER_RECIPES_FILE)
  if (!userRecipesObject) {
    consola.error(`Could not parse ${USER_RECIPES_FILE}. Aborting.`)
    return
  }

  const userRecipes = getRecipes(userRecipesObject)
  const userRecipesMap = new Map<string, Element>(userRecipes.map(r => [r.name, r.element]))
  consola.info(`Found ${userRecipesMap.size} recipes in user_recipes.xml.`)

  // 2. Scan all other .xml files to find original recipe locations.
  const otherXmlFiles = await fg(join(RECIPES_DIR, '**/*.xml').replace(/\\/g, '/'), {
    ignore: [USER_RECIPES_FILE.replace(/\\/g, '/')],
  })
  consola.info(`Found ${otherXmlFiles.length} other recipe files to scan.`)

  // 3. Build a map of recipe names to their file paths.
  const recipeLocationMap = new Map<string, string>()
  for (const file of otherXmlFiles) {
    const xmlObject = await parseXmlFile(file)
    if (xmlObject) {
      for (const recipe of getRecipes(xmlObject)) {
        if (recipeLocationMap.has(recipe.name)) {
          consola.warn(`Duplicate recipe name "${recipe.name}" found in multiple source files. The last one found (${relative(PROJECT_ROOT, file)}) will be used.`)
        }
        recipeLocationMap.set(recipe.name, file)
      }
    }
  }

  // 4. Identify which user recipes are overwrites and which are unique.
  const recipesToMove = new Map<string, { recipeElement: Element, targetFile: string }>()
  const recipesToRemoveFromUserFile = new Set<string>()

  for (const [recipeName, recipeElement] of userRecipesMap.entries()) {
    if (recipeLocationMap.has(recipeName)) {
      const targetFile = recipeLocationMap.get(recipeName)!
      recipesToMove.set(recipeName, { targetFile, recipeElement })
      recipesToRemoveFromUserFile.add(recipeName)
      consola.log(`Recipe "${recipeName}" is an overwrite. Will be moved to ${relative(PROJECT_ROOT, targetFile)}.`)
    }
    else {
      consola.log(`Recipe "${recipeName}" is unique to user_recipes.xml.`)
    }
  }

  if (recipesToMove.size === 0) {
    consola.success('No recipes to move. Your configuration is already clean!')
    return
  }

  // 5. Group moves by file to perform batch updates.
  const movesByFile = new Map<string, { element: Element, name: string }[]>()
  for (const [name, move] of recipesToMove.entries()) {
    movesByFile.set(move.targetFile, [...movesByFile.get(move.targetFile) || [], { name, element: move.recipeElement }])
  }

  // 6. Perform the recipe moves.
  for (const [file, recipesToUpdate] of movesByFile.entries()) {
    consola.start(`Updating ${relative(PROJECT_ROOT, file)}...`)
    const targetXmlObject = await parseXmlFile(file)
    const root = targetXmlObject?.elements?.find(e => e.name === 'enderio:recipes')
    if (!root?.elements) {
      consola.error(`Invalid XML structure in ${file}. Skipping.`)
      continue
    }

    for (const { name, element } of recipesToUpdate) {
      const recipeIndex = root.elements.findIndex(el => el.type === 'element' && el.attributes?.name === name)
      if (recipeIndex !== -1) {
        root.elements[recipeIndex] = element // Replace existing recipe
        consola.log(`  - Replaced recipe "${name}"`)
      }
    }
    await writeXmlFile(file, targetXmlObject!)
  }

  // 7. Clean up user_recipes.xml by removing the recipes that were moved.
  consola.start(`Cleaning up ${relative(PROJECT_ROOT, USER_RECIPES_FILE)}...`)
  const userRoot = userRecipesObject.elements?.find(e => e.name === 'enderio:recipes')
  if (userRoot?.elements) {
    let nextElementIsRecipeToRemove = false
    userRoot.elements = [...userRoot.elements].reverse().filter((el) => {
      if (el.type === 'element' && el.attributes?.name && recipesToRemoveFromUserFile.has(String(el.attributes.name))) {
        nextElementIsRecipeToRemove = true
        return false // Remove recipe
      }
      if (nextElementIsRecipeToRemove && el.type === 'text' && el.text?.toString().trim() === '') {
        nextElementIsRecipeToRemove = false
        return false // Remove preceding whitespace node
      }
      nextElementIsRecipeToRemove = false
      return true
    }).reverse()
    await writeXmlFile(USER_RECIPES_FILE, userRecipesObject)
  }

  consola.success('EnderIO recipe de-duplication completed successfully!')
}

main().catch(e => consola.error(e))
