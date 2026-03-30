import antfu from '@antfu/eslint-config'

export default antfu({
  typescript: { tsconfigPath: 'tsconfig.json' },
  gitignore : false,
  rules     : {
    // 'no-console'                   : 'off',
    // 'node/prefer-global/process'   : 'off',
    'ts/strict-boolean-expressions': 'off',
    // 'ts/no-unsafe-assignment'      : 'off',
    // 'ts/no-unsafe-member-access'   : 'off',

    // // Override @antfu rules to my personal prefferences
    'style/key-spacing'            : ['error', { align: 'colon' }],
    // 'style/no-extra-parens'        : ['error', 'all', {nestedBinaryExpressions: false, nestedConditionalExpressions: false }],
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
  files: ['**/*.ts', '**/*.tsx'],
  rules: { 'ts/no-floating-promises': 'error' },
}, {
  files: ['**/*.md'],
  rules: {
    'style/no-trailing-spaces': 'off',
  },
})
