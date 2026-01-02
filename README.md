# .dotfiles
Simple solution to manage my configuration files for tools used in MacOS or Linux.

The solution used to manage my dotfiles repo comes from this [article](https://news.ycombinator.com/item?id=11071754).

## Setup
```bash
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles remote add origin https://github.com/tiaguito/.dotfiles.git
# Make git ignore source repository
echo ".dotfiles" >> .gitignore
```

## Replication
**Note:** make sure that if you have previous config files in the machine that they are properly backed up. Renaming those files might be enough.

```bash
# Clone the worktree to a temporary location and the bare repo to local
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/tiaguito/.dotfiles.git /tmp/dotfiles
# Copy contents from worktree to desired location
rsync --recursive --verbose --exclude '.git' /tmp/dotfiles/ $HOME/
# Delete worktree
rm --recursive /tmp/dotfiles
# Export the following alias to your shell config file
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

## Configuration
```bash
# Set the flag `showUntrackedFiles` to `no` on this specific (local) repository:
dotfiles config --local status.showUntrackedFiles no
dotfiles remote add origin https://github.com/tiaguito/.dotfiles.git
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
