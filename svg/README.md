# tk-boilerplate/svg

## svg-to-react

copy svg files in your project and transform them to react components.

### Requirements

-   Node.js installed

### Option A: Use it directly in your JS project

If your project needs often to import svg assets, then I recommend this option.

**Preparation**

Copy the `svg-to-react` folder into your project root. Manually or with this command:

```sh
git clone --depth 1 --filter=blob:none --sparse https://github.com/tobiaskraus/tk-boilerplate.git && \
cd tk-boilerplate && \
git sparse-checkout set svg/svg-to-react && \
cd .. && \
mv tk-boilerplate/svg/svg-to-react ./ && \
rm -rf tk-boilerplate
```

Install `@svgr/cli` with npm or whatever package-manager you use.

Add this to your package.json:

```sh
"transform-svgs": "npx @svgr/cli --config-file svg-to-react/svgr.config.js -- svg-to-react/inbox && mv svg-to-react/inbox/* svg-to-react/finished/ && prettier --write src/components/icons",
```

-   adjust to your needs
    -   output directory: change `src/components/icons` in your package.json script and in svgr.config.js in `outDir`
    -   remove the prettier part in package.json script, if you don't have prettier
    -   make other changes svgr.config: Documentation can be found here: https://react-svgr.com/docs/options

**Transform svgs to react components**

-   paste svg file(s) into `/svg-to-react/inbox/` (files are .gitignored)
-   run `npm run "transform-svgs`
-   DONE!
    -   all .svg files in /inbox are converted and placed inside `/src/components/icons/`
    -   the .svg files itself are moved to `/svg-to-react/finished` (files .gitignored) (you can delete the filed if you want)

### Option B: Use it somewhere outside your projects

Same as above, besides:

-   place the folder somewhere where you want
-   create there a new package.json (`npm init -y`) and install there "@svgr/cli"
-   adjust the ouput directory

### Limitations

#### Other elements in template, needs to be in AST syntax

Wrapping the icon in another element in JSX syntax breaks the transformer.

WRONG example: wrapping in MUI's `SvgIcon`:

```tsx
return tpl`
    import { SvgIcon, type SvgIconOwnProps } from "@mui/material";

    const SvgComponent = (props: SvgIconOwnProps) => (
        <SvgIcon {...props}>
            ${variables.jsx}
        </SvgIcon>
    );

    export { SvgComponent as ${componentName} };
`;
```

Problem: The `<SvgIcon>` cannot be used inside `tpl` template:

```error
Error: /Users/username/path/to/project/svg-transformer/inbox/icon-name.svg: Unknown substitution "$$BABEL_TPL$0" given
    at /Users/username/path/to/project/node_modules/@babel/template/lib/populate.js:33:
```

But replacing `tpl` template with a normal string literal causes error:

```error
 ...icon-name.svg: unknown node of type undefined with constructor "String"
 ...@babel/generator/lib/printer.js:366:13)
```

Solution:

```js
// Create SvgIcon wrapper as AST
const svgIconJsx = {
    type: "JSXElement",
    openingElement: {
        type: "JSXOpeningElement",
        name: { type: "JSXIdentifier", name: "SvgIcon" },
        attributes: [
            {
                type: "JSXSpreadAttribute",
                argument: { type: "Identifier", name: "props" },
            },
        ],
        selfClosing: false,
    },
    closingElement: {
        type: "JSXClosingElement",
        name: { type: "JSXIdentifier", name: "SvgIcon" },
    },
    children: [variables.jsx],
    selfClosing: null,
};

return tpl`
    import { SvgIcon, type SvgIconOwnProps } from "@mui/material";

    const SvgComponent = (props: SvgIconOwnProps) => ${svgIconJsx};

    export { SvgComponent as ${componentName} };
`;
```

There should be a more elegeant solution to write JSX in the template but I couldn't find any way.
Check https://github.com/gregberge/svgr/issues
