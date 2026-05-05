import antfu from '@antfu/eslint-config'
import zs from '@mctools/eslint-plugin-zs'

const tsConfig = await antfu({
  typescript: { tsconfigPath: 'tsconfig.json' },
  gitignore : false,
  ignores   : [
    '.git/**',
    '.mixin.out/**',
    '**/*.log',
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
    'mc-tools/packages/format/src/parser-generated.mjs',
    'minecraftinstance.json',
    'MODS.md',
    'mods/**',
    'node_modules/**',
    'patchouli_books/**',
    'resourcepacks/**',
    'resources/**',
    'schematics/**',
    'shaderpacks/**',
    'structures/**',
    'texturepacks/**',
  ],
  rules: {
    // 'no-console'                   : 'off',
    // 'node/prefer-global/process'   : 'off',
    // 'ts/no-unsafe-assignment'      : 'off',
    // 'ts/no-unsafe-member-access'   : 'off',
    'ts/strict-boolean-expressions'     : 'off',
    'markdown/no-reversed-media-syntax' : 'off',
    'style/jsx-wrap-multilines'         : 'off',
    'style/jsx-closing-tag-location'    : 'off',
    'style/jsx-closing-bracket-location': 'off',

    // // Override @antfu rules to my personal prefferences
    'style/key-spacing'            : ['error', { align: 'colon' }],
    'style/no-extra-parens'        : ['error', 'all', { nestedBinaryExpressions: false, nestedConditionalExpressions: false }],
    'style/no-multi-spaces'        : 'off',
    'style/type-annotation-spacing': 'off',
    'antfu/if-newline'             : 'off',
    // 'style/object-curly-spacing'   : 'off',
    'style/comma-dangle'           : [
      'error',
      {
        functions: 'never',
        imports  : 'always-multiline',
        exports  : 'always-multiline',
        arrays   : 'always-multiline',
        objects  : 'always-multiline',
      },
    ],

    // // Lower error levels
    // 'style/max-statements-per-line': 'warn',

    // // Sort imports
    // 'import/order': 'off',
    // 'sort-imports': 'off',

    // 'unused-imports/no-unused-imports': 'error',
    // 'unused-imports/no-unused-vars'   : 'error',
  },
}, {
  files  : ['**/*.ts', '**/*.tsx'],
  ignores: ['**/*.md/**'],
  rules  : { 'ts/no-floating-promises': 'error' },
}, {
  files: ['**/*.md'],
  rules: {
    'style/no-trailing-spaces': 'off',
  },
})

// Disable type-aware parsing/rules for ZS-derived TS (no real tsconfig project).
const typeAwareTsRulesOff = Object.fromEntries([
  'await-thenable',
  'consistent-return',
  'consistent-type-exports',
  'dot-notation',
  'naming-convention',
  'no-array-delete',
  'no-base-to-string',
  'no-confusing-void-expression',
  'no-deprecated',
  'no-duplicate-type-constituents',
  'no-floating-promises',
  'no-for-in-array',
  'no-implied-eval',
  'no-meaningless-void-operator',
  'no-misused-promises',
  'no-misused-spread',
  'no-mixed-enums',
  'no-redundant-type-constituents',
  'no-unnecessary-boolean-literal-compare',
  'no-unnecessary-condition',
  'no-unnecessary-qualifier',
  'no-unnecessary-template-expression',
  'no-unnecessary-type-arguments',
  'no-unnecessary-type-assertion',
  'no-unnecessary-type-conversion',
  'no-unnecessary-type-parameters',
  'no-unsafe-argument',
  'no-unsafe-assignment',
  'no-unsafe-call',
  'no-unsafe-enum-comparison',
  'no-unsafe-member-access',
  'no-unsafe-return',
  'no-unsafe-type-assertion',
  'no-unsafe-unary-minus',
  'no-useless-default-assignment',
  'non-nullable-type-assertion-style',
  'only-throw-error',
  'prefer-destructuring',
  'prefer-find',
  'prefer-includes',
  'prefer-nullish-coalescing',
  'prefer-optional-chain',
  'prefer-promise-reject-errors',
  'prefer-readonly',
  'prefer-readonly-parameter-types',
  'prefer-reduce-type-parameter',
  'prefer-regexp-exec',
  'prefer-return-this-type',
  'prefer-string-starts-ends-with',
  'promise-function-async',
  'related-getter-setter-pairs',
  'require-array-sort-compare',
  'require-await',
  'restrict-plus-operands',
  'restrict-template-expressions',
  'return-await',
  'strict-boolean-expressions',
  'strict-void-return',
  'switch-exhaustiveness-check',
  'unbound-method',
  'use-unknown-in-catch-callback-variable',
].map(r => [`ts/${r}`, 'off']))

// Shared overrides for ZS-derived TS: plugin's virtual files + CLI's *.zs.ts output.
// To move a rule out of DEBRIS_PREAMBLE (mc-tools/packages/format/src/markers.ts),
// drop it there and add it here. Round-trip-critical rules must stay in the preamble.
const zsOverrides = {
  languageOptions: { parserOptions: { program: null, project: false, projectService: false } },
  rules          : {
    ...typeAwareTsRulesOff,
    'style/comma-spacing'       : 'off',
    'style/key-spacing'         : 'off',
    'style/no-multi-spaces'     : 'off',
    'style/type-generic-spacing': 'off',
    // ZS preserves user-chosen key quoting (`'A'` stays `'A'`, `A` stays `A`).
    // Letting ESLint flip quotes here means the revert pass would have to
    // chase ESLint's decision per-key — historically that's exactly the path
    // that mishandled comments mid-object. The forward pass already quotes
    // anything ZS-illegal-bare (reserved words via `_$_kw_`, negative
    // numerics via the bracket marker), so ESLint has no useful job here.
    'style/quote-props'         : 'off',
  },
}

const zsTsConfig = [
  ...tsConfig,
  { files: ['**/*.ts', '**/*.tsx'], ...zsOverrides },
]

export default [
  ...tsConfig,
  ...zs.defineConfig({ tsConfig: zsTsConfig }),
  // Real *.zs.ts files emitted by the mctools-format CLI.
  { files: ['**/*.zs.ts'], ...zsOverrides },
]
