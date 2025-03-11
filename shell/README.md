# shell

Terminal: [Ghostty](https://github.com/ghostty-org/ghostty)

## shell tools

I use and love:

-   [Oh My Zsh](https://ohmyz.sh/)
    -   an open source, community-driven framework for managing your Zsh configuration
-   [fzf](https://github.com/junegunn/fzf)
    -   fzf is a general-purpose command-line fuzzy finder
-   [Zsh-z](https://github.com/agkozak/zsh-z)
    -   command line tool that allows you to jump quickly to directories that you have visited frequently in the past, or recently -- but most often a combination of the two (a concept known as "frecency").
-   [lazydocker](https://github.com/jesseduffield/lazydocker)
    -   A simple terminal UI for both docker and docker-compose
-   [ripgrep (rg)](https://github.com/BurntSushi/ripgrep)
    -   search tool that recursively searches the current directory for a regex pattern
-   [nvm](https://github.com/nvm-sh/nvm)
    -   allows you to quickly install and use different versions of node via the command line
        (cause sometimes it sucks to work in docker containers)
    -   useful:
        -   `nvm alias default 18.12` (set a default Node version to be used in any new shell)
        -   create `.nvmrc` in project with a node version in it. Then `nvm install` and `nvm use` will use this version
        -   create a file `$NVM_DIR/default-packages` with default packages to get installed each time you install a new node version.
            [more infos](https://github.com/nvm-sh/nvm?tab=readme-ov-file#default-global-packages-from-file-while-installing)
