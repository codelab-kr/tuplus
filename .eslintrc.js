module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  extends: [
    'airbnb-base',
    'plugin:prettier/recommended',
    'plugin:@typescript-eslint/eslint-recommended',
    'plugin:@typescript-eslint/recommended',
  ],
  plugins: ['jest'],
  env: {
    browser: true,
    es6: true,
    node: true,
    'jest/globals': true,
  },

  rules: {
    'max-len': [
      'error',
      {
        code: 80,
        tabWidth: 2,
        ignoreComments: true,
        ignoreTrailingComments: true,
        ignoreStrings: true,
        ignoreUrls: true,
        ignoreTemplateLiterals: true,
        ignorePattern: '^import\\s.+\\sfrom\\s.+;$',
      },
    ],
    'no-use-before-define': 'off',
    'linebreak-style': 'off',
    camelcase: 'warn',
    'max-classes-per-file': 'off',
    'class-methods-use-this': 'off',
    'import/prefer-default-export': 'off',
    'import/extensions': [
      'error',
      'ignorePackages',
      {
        js: 'never',
        ts: 'never',
        jsx: 'never',
        tsx: 'never',
      },
    ],
    'no-console': 'off',
    'no-underscore-dangle': 0,
    'no-require-imports': 'off',
    // typescript
    '@typescript-eslint/no-use-before-define': 2,
    '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
  },
  ignorePatterns: ['generated/**/*.tsx'],
  settings: {
    'import/resolver': {
      node: {
        extensions: ['.js', '.ts', '.jsx', '.tsx'],
      },
    },
  },
  overrides: [
    {
      files: ['./**/test/**'],
      plugins: ['jest'],
      extends: ['plugin:jest/recommended'],
      rules: { 'jest/prefer-expect-assertions': 'off' },
    },
  ],
};
