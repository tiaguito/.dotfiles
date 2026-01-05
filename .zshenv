export DOTFILES="$HOME/.dotfiles"

# Homebrew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

# other software
export TMUX_CONFIGDIR="$XDG_CONFIG_HOME/tmux"
export VIMCONFIG="$XDG_CONFIG_HOME/nvim"
export YABAICONFIG="$XDG_CONFIG_HOME/yabai"
export SKHDRC="$XDG_CONFIG_HOME/skhd"

# Man pages
export MANPAGER="nvim +Man!"

# TMUX
export TMUX_TMPDIR="$HOME/.local/tmp"

export FZF_DEFAULT_OPTS="-m --height 50% \
--layout reverse \
--border \
--inline-info \
--preview-window=:hidden \
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200' \
--bind '?:toggle-preview'"

# Golang
export GOPATH="$HOME/go"
export GOBIN="$HOME/go/bin"
export GOCACHE="$XDG_CACHE_HOME/go-build"

# Rust
export RUST_PATH="$HOME/.cargo/env"

# Yarn
export YARN_PATH="$(yarn global bin)"

# GCC
export GCC_PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin"

# PATH
export PATH="$GOBIN:$PATH"                                          # GOBIN
export PATH="$RUST_PATH:$PATH"                                      # RUST
export PATH="$YARN_PATH:$PATH"                                      # YARN
export PATH="$GCC_PATH:$PATH"                                       # GCC
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
