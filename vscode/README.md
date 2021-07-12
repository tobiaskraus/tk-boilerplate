# tk-boilerplate/vscode

## Setup Snippets

Configuring code snippets in VSCode can speed up coding big times.

There are 2 options:

1. Add snippets on user level (file in some OS user folder: `languageScope.json}`)
2. Add snippets on project level (file `.vscode/{someName}.code-snippets`)

Both can be done easily with `CMD+SHIFT+P > Configure User Snippets`.

Copy what you need from the `*.code-snippets` files of this folder.

You can remove the `scope` props if you paste it in your user-level snippets (langauge specific).

## Usage

Just type the shortcut, accept the autocomplete with TAB key and fill wherever the Snippet cursor brings you.

![snippet demo](../.docu-assets/vscode-snippet-compfile.gif)

## Snippets

### TypeScript

`cl`: simple `console.log();`

### React (with TypeScript)

`comp`: Function Component without props

`compfile`: boilerplate component code for a freshly created `tsx` file

`compp`: Function Component with props

`slicefile`: Redux (toolkik) slice file (with its reducers and state)
