# tk-boilerplate/ssh

## ssh key with passphrase: SSO for SSH keys

I use a passphrase on my ssh key. This is great for security (simply stealing my private key file will not give any access), but it comes with a downside:

-   Everytime I verify myself via ssh (e.g. I push changes via `git push`) I am forced to type in my passphrase again.
-   VSCode does not expect a command prompt which asks my passphrase when I use their integrated git features to push my code and therefore fails (I guess there are problems with other programs which use ssh in the background as well).

To solve this, add this to your `.profile` file in your user folder:

```sh
# ssh-agent on Git (to save ssh passphrase during session)
alias sshp='eval `ssh-agent -s` && ssh-add'
```

in a new terminal window run `sshp` once. Only the first time of your OS session, you will be asked to type in your passphrase.

For VSCode users: after the terminal session is signed on via `sshp` run `vscode .` to open this folder in VSCode and the VSCode process will be signed on as well.
