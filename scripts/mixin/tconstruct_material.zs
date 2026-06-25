#modloaded tconstruct
#loader mixin

/*
  Inject trait-removal methods into Material for use by reloadable scripts.

  Material.traits is a protected final LinkedHashMap<String, List<ITrait>>.
  Because the ZS mixin compiler cannot call Java List/Map methods directly,
  these methods work by removing the map entry entirely and rebuilding via
  the public addTrait API — which creates a fresh entry on next access.
*/
#mixin { targets: 'slimeknights.tconstruct.library.materials.Material' }
zenClass MixinMaterialTraitAccess {
  function crt_removeTrait(traitId as string, partType as string) as void {
    val list = this0.getStatTraits(partType);
    this0.traits.remove(partType);
    for t in list {
      if (!isNull(t) && t.identifier != traitId) {
        this0.addTrait(t, partType);
      }
    }
  }

  function crt_clearTraitsForPart(partType as string) as void {
    this0.traits.remove(partType);
  }
}
