#modloaded bibliocraft requious
#priority 950

import mods.requious.SlotVisual;

import scripts.jei.requious.add as addRecipe;

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
val x = <assembly:typewriter>;
x.addJEICatalyst(<bibliocraft:typewriter>);
x.addJEICatalyst(<bibliocraft:desk>);
x.setJEIDurationSlot(8, 2, 'duration', SlotVisual.arrowRight());
scripts.jei.requious.addInsOuts(x, [[4, 0], [0, 2], [2, 2], [4, 2], [2, 4], [4, 4]], [[12, 2]]);

for name, book in scripts.mods.bibliocraft_books.bookWrittenBy {
  addRecipe(x, { [
    <minecraft:name_tag:*>,
    <minecraft:paper>,
    <bibliocraft:typewriter:*>,
    <entity:${scripts.mods.bibliocraft_books.bookWriters[name]}>.asIngr(),
    <bibliocraft:desk:*>,
    <bibliocraft:seat:*>,
  ]: [book] });
}
