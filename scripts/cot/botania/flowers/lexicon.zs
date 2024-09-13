import mods.botania.Lexicon;
import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

//////////////////////
//Generating flowers//
//////////////////////

mods.botania.Lexicon.addEntry("botania.entry.campanimia", "botania.category.generationFlowers", <botania:specialflower>.withTag({type: "campanimia"}));
mods.botania.Lexicon.setEntryKnowledgeType("botania.entry.campanimia", "alfheim");
mods.botania.Lexicon.addTextPage("botania.page.campanimia0", "botania.entry.campanimia", 0);
//mods.botania.Lexicon.addTextPage("botania.page.campanimia1", "botania.entry.campanimia", 1);
//mods.botania.Lexicon.addRecipeMapping(<botania:specialflower>.withTag({type: "campanimia"}), "botania.entry.campanimia", 1);

mods.botania.Lexicon.addEntry("botania.entry.nuclianthus", "botania.category.generationFlowers", <botania:specialflower>.withTag({type: "nuclianthus"}));
mods.botania.Lexicon.setEntryKnowledgeType("botania.entry.nuclianthus", "alfheim");
mods.botania.Lexicon.addTextPage("botania.page.nuclianthus0", "botania.entry.nuclianthus", 0);
//mods.botania.Lexicon.addTextPage("botania.page.nuclianthus1", "botania.entry.nuclianthus", 1);
//mods.botania.Lexicon.addRecipeMapping(<botania:specialflower>.withTag({type: "nuclianthus"}), "botania.entry.nuclianthus", 1);

//////////////////////
//Functional flowers//
//////////////////////

mods.botania.Lexicon.addEntry("botania.entry.rokku_eryngium", "botania.category.functionalFlowers", <botania:specialflower>.withTag({type: "rokku_eryngium"}));
mods.botania.Lexicon.setEntryKnowledgeType("botania.entry.rokku_eryngium", "alfheim");
mods.botania.Lexicon.addTextPage("botania.page.rokku_eryngium0", "botania.entry.rokku_eryngium", 0);
//mods.botania.Lexicon.addTextPage("botania.page.rokku_eryngium1", "botania.entry.rokku_eryngium", 1);
//mods.botania.Lexicon.addRecipeMapping(<botania:specialflower>.withTag({type: "rokku_eryngium"}), "botania.entry.rokku_eryngium", 1);
