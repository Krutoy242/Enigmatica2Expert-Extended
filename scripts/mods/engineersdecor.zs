#modloaded engineersdecor

// Oredicting recipe
// [Treated Wood Crafting Table] from [Treated Wood Planks]
craft.remake(<engineersdecor:treated_wood_crafting_table>, ['pretty',
  '# #',
  '# #'], {
  '#': <ore:plankTreatedWood>, // Treated Wood Planks
});

// Cheaper decorative blocks for building
recipes.removeByRecipeName("engineersdecor:dependent/gas_concrete_block_recipe");
craft.make(<engineersdecor:gas_concrete> * 32, ['pretty',
  's c',
  'c s'], {
  's': <ore:sand>,
  'c': <ore:concrete>,
});
recipes.removeByRecipeName("engineersdecor:dependent/rebar_concrete_block_recipe");
craft.make(<engineersdecor:rebar_concrete> * 64, ['pretty',
  '╱ ■ ╱',
  '■ ╱ ■',
  '╱ ■ ╱'], {
  '╱': <ore:stickSteel>,
  '■': <engineersdecor:gas_concrete>,
});
