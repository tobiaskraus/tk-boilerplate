# tk-boilerplate/vscode

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

`cl + TAB:` simple `console.log()`;

```json
"console.log": {
    "prefix": "cl",
    "scope": "javascript,typescript",
    "body": ["console.log(\"$1\");"]
},
```

### React (with TypeScript)

`compfile + TAB:` boilerplate component code for a freshly created `tsx` file

```json
"React Function Component File": {
    "prefix": "compfile",
    "scope": "typescriptreact",
    "body": [
        "import React, { FunctionComponent } from \"react\";",
        "",
        "interface $1Props {",
        "    className?: string;",
        "}",
        "",
        "const $1: FunctionComponent<$1Props> = (props) => {",
        "    return (",
        "        $2",
        "    );",
        "};",
        "",
        "export default $1;"
    ]
},
```

`compp + TAB:` Function Component with props

```json
"React Function Component with props": {
    "prefix": "compp",
    "scope": "typescriptreact",
    "body": [
        "interface $1Props {",
        "    className?: string;",
        "}",
        "",
        "const $1: FunctionComponent<$1Props> = (props) => {",
        "    return (",
        "        $2",
        "    );",
        "};"
    ]
},
```

`comp + TAB:` Function Component without props

```json
"React Function Component without props": {
    "prefix": "comp",
    "scope": "typescriptreact",
    "body": [
        "const $1: FunctionComponent = () => {",
        "    return (",
        "        $2",
        "    );",
        "};"
    ]
},
```
