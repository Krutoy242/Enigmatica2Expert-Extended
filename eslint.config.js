import antfu from '@antfu/eslint-config'

export default antfu({
  // typescript: { tsconfigPath: 'tsconfig.json' },
  gitignore: false,
  rules    : {

    // Override @antfu rules to my personal prefferences
    'style/key-spacing' : ['error', { align: 'colon' }],
    'antfu/if-newline'  : 'off',
    'style/comma-dangle': [
      'error',
      {
        functions: 'never',
        imports  : 'always-multiline',
        exports  : 'always-multiline',
        arrays   : 'always-multiline',
        objects  : 'always-multiline',
      },
    ],

    // Lower error levels
    'style/max-statements-per-line': 'warn',

    // Sort imports
    'import/order': 'off',
    'sort-imports': 'off',

    'unused-imports/no-unused-imports': 'error',
    'unused-imports/no-unused-vars'   : 'error',

    'perfectionist/sort-array-includes'  : 'error',
    'perfectionist/sort-astro-attributes': 'error',
    // 'perfectionist/sort-classes'         : 'error',
    'perfectionist/sort-enums'           : 'error',
    'perfectionist/sort-exports'         : 'error',
    'perfectionist/sort-imports'         : ['error', {
      type  : 'natural',
      groups: [
        'side-effect',
        'side-effect-style',
        'type',
        'builtin',
        'external',
        'internal-type',
        'internal',
        ['parent-type', 'sibling-type', 'index-type'],
        ['parent', 'sibling', 'index'],
        'object',
        'unknown',
      ],
    }],
    'perfectionist/sort-interfaces'       : 'error',
    'perfectionist/sort-jsx-props'        : 'error',
    'perfectionist/sort-maps'             : 'error',
    'perfectionist/sort-named-exports'    : 'error',
    'perfectionist/sort-named-imports'    : 'error',
    'perfectionist/sort-object-types'     : 'error',
    // 'perfectionist/sort-objects': 'error',
    'perfectionist/sort-svelte-attributes': 'error',
    'perfectionist/sort-union-types'      : 'error',
    'perfectionist/sort-vue-attributes'   : 'error',
  },
}, {
  files: ['**/*.md'],
  rules: {
    'style/no-trailing-spaces': 'off',
  },
})
