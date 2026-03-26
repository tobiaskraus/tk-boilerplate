# tk-boilerplate/ssh+git

## separe ssh keys

- one ssh key per GitHub, customers GitLab (with passphrase)
- one ssh key for git commit signing (without passphrase)

## git

I split my repos locally into subfolders ('customer-a', 'customer-b', 'private') into `~/dev/{subfolder}`.

I use different git configs for each subfolder. But git reads only a global `~/.gitconfig`.

My `~/.gitconfig`:

```config
[user]
    # kdfj
    name = {my name}
	email = {my private email}
    signingkey = ~/.ssh/git_signing_ed25519.pub
[includeIf "gitdir:~/dev/customer-a/"]
    path = ~/dev/{subfolder}/.gitconfig
# some other stuff
```

And then a create a `.gitconfig` in each of those subfolders with:

```config
[user]
	email = {my business email for this remote repo}
```

If you only have a few repos, it's easier to set the different email only on repo level: `git config user.email your@email.example`.

### Signing git commits

To create a ssh key for signing git commits:

```
ssh-keygen -t ed25519 -C "git-signing ({my name})" -f ~/.ssh/git_signing_ed25519 -N ""
```

Add it to your ~/.gitconfig

## ssh key with passphrase: SSO for SSH keys

I use a passphrase on my ssh key. This is great for security (simply stealing my private key file will not give any access), but it comes with a downside:

- Everytime I verify myself via ssh (e.g. I push changes via `git push`) I am forced to type in my passphrase again.
- VSCode does not expect a command prompt which asks for my passphrase when I use their integrated git features to push my code and therefore fails (I guess there are problems with other programs which use ssh in the background as well).

### solution: with Apple Keychain

Add the following lines to `~/.ssh/config`:

```sh
Host *
    UseKeychain yes
    AddKeysToAgent yes
    IdentityFile ~/.ssh/id_rsa
```

Replace ~/.ssh/id_rsa with the path to your private key if it’s different.

To confirm that your key is loaded in the agent, run:

```sh
ssh-add -l
```

### old solution on my Windows (before I used Apple Keychain)

Add this to your `.profile` file in your user folder:

```sh
# ssh-agent on Git (to save ssh passphrase during session)
alias sshp='eval `ssh-agent -s` && ssh-add'
```

In a new terminal window run `sshp` once. Only the first time of your OS session, you will be asked to type in your passphrase.

For VSCode users: after the terminal session is signed on via `sshp` run `vscode .` to open this folder in VSCode and the VSCode process will be signed on as well.
