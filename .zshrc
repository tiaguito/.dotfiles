# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    colored-man-pages
    pip
    git
    brew
    zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

mcd() { mkdir -p $1; cd $1 }
cdl() { cd $1; ls}
gfind() { find / -iname $@ 2>/dev/null }
lfind() { find . -iname $@ 2>/dev/null }
rtfm() { help $@ || man $@  }

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
