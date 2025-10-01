#modloaded tconstruct thaumcraft
#reloadable

// Add applying of Infusion Enchantments to make them be possible to match Excavate modifier
for aspect, id in ({
  aer  : 0, // Collector
  terra: 2, // Borrowing
} as short[string]) {
  for i, item in scripts.mods.tconstruct.vars.tools.items {
    recipes.addShapeless(
      `infench_${aspect}_${i}`,
      item.withTag({infench: [{lvl: 1 as short, id: id as short}]}),
      [
        <thaumcraft:crystal_essence>.withTag({Aspects: [{amount: 1, key: aspect}]}),
        item.marked('m'),
      ],
      function (out, ins, cInfo) {
        if (isNull(ins) || isNull(ins.m) || isNull(ins.m.tag)) return null;
        if (!isNull(ins.m.tag.infench)) {
          for enchTag in ins.m.tag.infench.asList() {
            if (enchTag.id.asShort() == id) return null;
          }
        }
        return ins.m.withTag(ins.m.tag.deepUpdate(
          {infench: [{lvl: 1 as short, id: id as short}]},
          mods.zenutils.DataUpdateOperation.MERGE));
      },
      null
    );
  }
}
