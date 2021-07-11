# tk-boilerplate/vscode

## Setup Snippets

Configuring code snippets in VSCode can speed up coding big times.

There are 2 options:

1. Add snippets on user level (file in some OS user folder: `languageScope.json}`)
2. Add snippets on project level (file `.vscode/{someName}.code-snippets`)

Both can be done easily with `CMD+SHIFT+P > Configure User Snippets`.

Or just copy the `*.code-snippets` files from this folder.

## Usage

Just type the shortcut, accept the autocomplete with TAB key and fill wherever the Snippet cursor brings you.

![snippet demo](../.docu-assets/vscode-snippet-compfile.gif)

## Snippets

### TypeScript

`cl`: simple `console.log();`

### React (with TypeScript)

`compfile`: boilerplate component code for a freshly created `tsx` file

`compp`: Function Component with props

`comp`: Function Component without props
