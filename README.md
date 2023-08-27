# .dotfiles
Simple solution to manage my configuration files for tools used in MacOS or Linux.

The solution used to manage my dotfiles repo comes from this [article](https://news.ycombinator.com/item?id=11071754).

## Install
**Note:** make sure that if you have previous config files in the machine that they are properly backed up. Renaming those files might be enough.
```bash
# Move to home folder
cd ~
# Export the following alias to your `.bashrc` or `.zshrc` file:
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# Make git ignore source repository. This avoids recursion problems
echo ".dotfiles" >> .gitignore
# Clone the repository into `$HOME` directory
git clone --bare https://github.com/tiaguito/.dotfiles $HOME/.dotfiles
# Change git setup to only show tracked files:
dotfiles config --local status.showUntrackedFiles no
```
## Use
From this point any file in the `$HOME` folder can be versioned with commands like the following:
```bash
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles add .i3/config
dotfiles commit -m "Add i3 config"
dotfiles push
dotfiles checkout
```

