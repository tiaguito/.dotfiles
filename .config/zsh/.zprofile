# Setup fzf
#
# if M1 chip
if [ -d /opt/homebrew/ ]
then
    # ---------
    if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; 
    then
      PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
    fi

    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

    # Key bindings
    # ------------
    source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
else
    source "/usr/local/opt/fzf/shell/completion.zsh"
    source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi
