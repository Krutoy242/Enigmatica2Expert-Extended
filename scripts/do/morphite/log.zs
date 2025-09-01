#reloadable
#priority -1000

utils.log('Generated indexes for Morphite recipes:');
for i, item in scripts.do.morphite.recipe.result {
  utils.log(i ~ ' ' ~ toString(scripts.do.morphite.util.index_to_array_with_1(i, 4)) ~ ' ' ~ item.displayName);
}