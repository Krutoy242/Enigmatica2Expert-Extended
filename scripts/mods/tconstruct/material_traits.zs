#modloaded tconstruct conarm
#loader tconstruct_traits reloadable
#priority -10

import scripts.mods.tconstruct.traitsbuilder.TraitsBuilder;

TraitsBuilder()

  .forMaterials(['boron'])
  .forParts(['head', 'bow', 'projectile'])
  .overwriteParts(['excompressum:compressing', 'dense', 'stiff'])
  .forParts(['handle', 'extra'])
  .overwriteParts(['excompressum:compressing', 'stiff'])
  .forParts(['plates', 'trim'])
  .overwriteParts(['indomitable_armor'])
  .forParts(['core'])
  .overwriteParts(['dense_armor', 'indomitable_armor'])

  .forMaterials(['pink_metal'])
  .forParts(['head', 'handle', 'extra', 'bow', 'projectile'])
  .overwriteParts(['excompressum:compressing', 'excompressum:smashingii', 'tconevo.mortal_wounds', 'unnatural'])
  .forParts(['core', 'plates', 'trim'])
  .overwriteParts(['tconevo.divine_grace_armor', 'vengeful_armor'])

  .forMaterials(['magnesium'])
  .forParts(['head', 'bow', 'projectile'])
  .overwriteParts(['exnihilo_smashing', 'holy', 'lightweight'])
  .forParts(['handle', 'extra'])
  .overwriteParts(['exnihilo_smashing', 'lightweight'])
  .forParts(['core'])
  .overwriteParts(['blessed_armor', 'featherweight_armor'])
  .forParts(['plates', 'trim'])
  .overwriteParts(['featherweight_armor'])

  .forMaterials(['conductive_iron'])
  .forParts(['head', 'handle', 'extra', 'bow', 'projectile'])
  .overwriteParts(['exnihilo_smashing', 'heavy', 'magnetic1'])
  .forParts(['core', 'plates', 'trim'])
  .overwriteParts(['steady_armor', 'magnetic1_armor'])

  .forMaterials(['xu_demonic_metal'])
  .forParts(['head'])
  .overwriteParts(['exnihilo_smashing', 'xu_whispering', 'vaporizer'])
  .forParts(['handle', 'extra', 'bow', 'projectile'])
  .overwriteParts(['exnihilo_smashing', 'heavy_metal', 'vaporizer'])
  .forParts(['core', 'plates', 'trim'])
  .overwriteParts(['xu_whispering'])

;
print('[material_traits] Done assigning traits for 5 materials (boron, pink_metal, magnesium, conductive_iron, xu_demonic_metal)');
