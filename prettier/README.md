# tk-boilerplate/prettier

Prettier is a code formatter for JavaScript, TypeScript, JSON, HTML, CSS, ...

## I use them all: ESlint, prettier and editorconfig

Even though [ESLint](https://eslint.org/) can also do some formatting, ESLint still focuses on linting and there are many reasons why it's best to work with both of them.

[Editorconfig](https://editorconfig.org/) has also overlapping features as prettier. It has less features than prettier as it doesn't understand specific language syntax, but therefore has benefits:

- it's better understood by IDEs (faster). A fresh created file, gets the editorconfig format immediately (no prettier process which overrides the file)
- not limited to certain languages - just define indentation etc. per file extension

### How to avoid rule conflicts?

Editorconfig <-> prettier

- don't define rules in prettier which can be done in editorconfig, as prettier automatically checks for `editorconfig` files as well
- e.g. don't write `tabWidth: 4` in `prettierrc` and `indent_size = 2` in `.editorconfig` - just define it in `.editorconfig`

prettier <-> ESLint

- there is a pre-made ESLint rules config which can be imported to turn of conflicting rules with prettier: [eslint-config-prettier](https://github.com/prettier/eslint-config-prettier)

## Usage

- Copy the `.prettierrc` of this folder in the root of your project
- Setup prettier in your IDE, that it formats automatically when you save a file
- Format existing code in your project: `npx prettier -w .`

## Setup in VSCode

- install `esbenp.prettier-vscode` extension
- settings (user or project):

```json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnPaste": true,
  "editor.formatOnSave": true
}
```

## Explanation of this prettier settings

Most default values are fine for me, and therefore can be left out.

- printWidth: 100
  - default is 80. But I use indentation (Tab size) 4 instead of 2 and therefore like to use more width

## My personal experience why I like prettier

It's insane with how much energy dev teams can argue about certain formatting rules.
We should spend our time on different stuff.
Go with the standard, let the IDE format your code for you, get ALWAYS consistent code formatting, and you will get used to a new formatting style faster than you thought.
