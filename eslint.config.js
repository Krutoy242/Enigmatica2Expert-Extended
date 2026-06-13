import { defineMctoolsConfig } from '@mctools/eslint-plugin-zs/config'

// Single source of truth lives in `@mctools/eslint-plugin-zs/config`, shared
// with the mc-tools monorepo — one config, one style. mc-tools/** lints itself
// via its own eslint.config.js (same shared base), so it is ignored here.
export default await defineMctoolsConfig({
  tsconfigPath: 'tsconfig.json',
  ignores     : [
    '.mixin.out/**',
    'asm/**',
    'backups/**',
    'cache/**',
    'caches/**',
    'config/**',
    'crash-reports/**',
    'dumps/**',
    'local/**',
    'logs/**',
    'manifest.json',
    'mc-tools/**',
    'minecraftinstance.json',
    'MODS.md',
    'mods/**',
    'patchouli_books/**',
    'resourcepacks/**',
    'resources/**',
    'schematics/**',
    'shaderpacks/**',
    'structures/**',
    'texturepacks/**',
  ],
})
