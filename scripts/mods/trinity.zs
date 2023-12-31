#modloaded trinity

scripts.process.fill(<trinity:empty_fusion_bomb>, <fluid:liquidfusionfuel> * 1000, <trinity:fusion_bomb>, 'only: NCInfuser Transposer');
scripts.process.fill(<trinity:empty_fusion_bomb>, <fluid:deuterium-tritium_mixture> * 1000, <trinity:fusion_bomb>, 'only: Transposer');

// Contaminated Food alt
craft.make(<rats:contaminated_food> * 8, [
  'ooo',
  'oio',
  'ooo'], {
  o: <minecraft:apple>,
  i: <trinity:radioactive_earth>,
});

// Contaminated Food alt
craft.make(<rats:contaminated_food> * 64, [
  'ooo',
  'oio',
  'ooo'], {
  o: <ore:compressedCropApple1x>,
  i: <trinity:radioactive_earth2>,
});

// Replace Trinitite drop with Luck one
// DOESNT WORK - trinitite still drop nothing.
// scripts.lib.dropt.addDrop(<trinity:trinitite>, <trinity:trinitite_shard>);
