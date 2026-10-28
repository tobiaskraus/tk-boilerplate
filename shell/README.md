# shell

Terminal: [Ghostty](https://github.com/ghostty-org/ghostty)

## shell tools

I use and love:

-   [Oh My Zsh](https://ohmyz.sh/)
    -   an open source, community-driven framework for managing your Zsh configuration
-   [fzf](https://github.com/junegunn/fzf)
    -   fzf is a general-purpose command-line fuzzy finder
    -   it overrides the default Zsh `Ctrl + R` reverse incremental history search with superior fzf-history-widget
-   [Zsh-z](https://github.com/agkozak/zsh-z)
    -   command line tool that allows you to jump quickly to directories that you have visited frequently in the past, or recently -- but most often a combination of the two (a concept known as "frecency").
-   [lazydocker](https://github.com/jesseduffield/lazydocker)
    -   A simple terminal UI for both docker and docker-compose
-   [ripgrep (rg)](https://github.com/BurntSushi/ripgrep)
    -   search tool that recursively searches the current directory for a regex pattern
-   [mise](https://mise.jdx.dev/)
    -   manages versions of node (and python, go, java, ...) with one tool; replaces nvm. Faster than nvm (no slow shell startup, no `nvm use`) and switches versions automatically per directory
    -   install: `brew install mise`, then add `eval "$(mise activate zsh)"` to `~/.zshrc`
    -   useful:
        -   `mise use -g node@22` (set a global default Node version for any new shell)
        -   `mise use node@22` (pin a version in the project: creates `mise.toml`). Existing `.nvmrc` / `.node-version` files are also read (enable with `mise settings add idiomatic_version_file_enable_tools node`)
        -   `mise install` installs everything the project pins; `mise ls-remote node` lists available versions
-   [ni](https://github.com/antfu-collective/ni) (`@antfu/ni`)
    -   uses the right package manager (npm, yarn, pnpm, bun, deno) for a project by looking at its lockfile / `packageManager` field, so you don't have to remember which one a project uses
    -   install: `npm i -g @antfu/ni` (or `brew install ni`)
    -   useful:
        -   `ni` (install), `ni vue` (add a dependency), `ni -D vitest` (add a dev dependency)
        -   `nr dev` (run a script), `nlx vitest` (execute a package), `nun vue` (uninstall), `nci` (clean install)
