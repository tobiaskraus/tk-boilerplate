// see https://react-svgr.com/docs/custom-templates/
const template = (variables, { tpl }) => {
    // remove "Svg" prefix from component name
    const componentName = variables.componentName.replace(/^Svg/, "");

    return tpl`
        import type { SVGProps } from "react";

        const SvgComponent = (props: SVGProps<SVGSVGElement>) => (
            ${variables.jsx}
        );

        export { SvgComponent as ${componentName} };
    `;
};

// see https://react-svgr.com/docs/options
export default {
    icon: true,
    expandProps: "end",
    typescript: true,
    ignoreExisting: false, // override if name exists already
    template,
    index: false, // don't create an index.ts file (cause it always overrides previous one with its exports)
    replaceAttrValues: {
        "#606060": "currentColor",
    },
    outDir: "./src/components/icons",
};
