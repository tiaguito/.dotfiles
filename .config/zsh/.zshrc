fpath=($DOTFILES/zsh/plugins $fpath)

# +------------+
# | NAVIGATION |
# +------------+

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

source $ZDOTDIR/plugins/bd.zsh

# +---------+
# | ALIASES |
# +---------+

source $ZDOTDIR/.zaliases

# +---------+
# | SCRIPTS |
# +---------+

source $ZDOTDIR/scripts.zsh

# +------------+
# | COMPLETION |
# +------------+

source $ZDOTDIR/completion.zsh

# +--------+
# | PROMPT |
# +--------+

fpath=($ZDOTDIR/prompt $fpath)
source $ZDOTDIR/prompt/prompt_purification_setup

# +-----------+
# | VI KEYMAP |
# +-----------+

bindkey -v
export KEYTIMEOUT=1

source $ZDOTDIR/plugins/cursor_mode

# edit current command line with vim (vim-mode, then CTRL-v)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

# add vi text-objects for brackets and quotes
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# emulation of vim-surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# +---------------------+
# | SYNTAX HIGHLIGHTING |
# +---------------------+

source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
