#!/usr/bin/env zsh

# Extract files
extract() {
    for file in "$@"
    do
        if [ -f $file ]; then
            _ex $file
        else
            echo "'$file' is not a valid file"
        fi
    done
}

# Extract files in their own directories
mkextract() {
    for file in "$@"
    do
        if [ -f $file ]; then
            local filename=${file%\.*}
            mkdir -p $filename
            cp $file $filename
            cd $filename
            _ex $file
            rm -f $file
            cd -
        else
            echo "'$1' is not a valid file"
        fi
    done
}

# Internal function to extract any archive
_ex() {
    case $1 in
        *.tar.bz2)  tar xjf $1      ;;
        *.tar.gz)   tar xzf $1      ;;
        *.bz2)      bunzip2 $1      ;;
        *.gz)       gunzip $1       ;;
        *.tar)      tar xf $1       ;;
        *.tbz2)     tar xjf $1      ;;
        *.tgz)      tar xzf $1      ;;
        *.zip)      unzip $1        ;;
        *.7z)       7z x $1         ;; # require p7zip
        *.rar)      7z x $1         ;; # require p7zip
        *.iso)      7z x $1         ;; # require p7zip
        *.Z)        uncompress $1   ;;
        *)          echo "'$1' cannot be extracted" ;;
    esac
}

# Compress a file 
# TODO to improve to compress in any possible format
# TODO to improve to compress multiple files
compress() {
    local DATE="$(date +%Y%m%d-%H%M%S)"
    tar cvzf "$DATE.tar.gz" "$@"
}

gtrm() {
    git tag -d $1

    if [ ! -z "$2" ]; then
        git push $2 :refs/tags/$1
    else
        git push origin :refs/tags/$1
    fi
}

ssh-create() {
    if [ ! -z "$1" ]; then
        ssh-keygen -f $HOME/.ssh/$1 -t rsa -N '' -C "$1"
        chmod 700 $HOME/.ssh/$1*
    fi
}

mkcd() {
    local dir="$*";
    local mkdir -p "$dir" && cd "$dir";
}

mkcp() {
    local dir="$2"
    local tmp="$2"; tmp="${tmp: -1}"
    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -d "$dir" ] ||
        mkdir -p "$dir" &&
        cp -r "$@"
}

mkmv() {
    local dir="$2"
    local tmp="$2"; tmp="${tmp: -1}"
    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -d "$dir" ] ||
        mkdir -p "$dir" &&
        mv "$@"
    }

cdl() { 
    cd $1; ls
}

gfind() { 
    find / -iname $@ 2>/dev/null 
}

lfind() { 
    find . -iname $@ 2>/dev/null 
}

rtfm() { 
    help $@ || man $@  
}

historystat() {
    history 0 | awk '{print $2}' | sort | uniq -c | sort -n -r | head
}

promptspeed() {
    for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
}

# Silly little script to understand zstyle
names() {
    local user_name user_surname user_nickname computer_name

    zstyle -s ':name:' set_user_name user_name || user_name="LEELA"
    zstyle -s ':name:surname:' set_user_name user_surname || user_surname="TURANGA"
    zstyle -s ':name:nickname::' set_user_name user_nickname || user_nickname="CYCLOPE"
    zstyle -s ':name:' set_computer_name computer_name || computer_name="BENDER"

    echo "You're $user_name $user_surname $user_nickname and you're computer is called $computer_name"
}

# --restrict-filenames replace special characters like spaces in filenames.
ydlp() {
    if ; then
        youtube-dl --restrict-filenames -f 22 -o "%(autonumber)s-%(title)s.%(ext)s" "$1"
    else
        echo "You need to specify a playlist url as argument"
    fi
}

ydl() {
    if [ ! -z $1 ]; then
        youtube-dl --restrict-filenames -f 22 -o "%(title)s.%(ext)s" "$1"
    else
        echo "You need to specify a video url as argument"
    fi
}

zshcomp() {
    for command completion in ${(kv)_comps:#-*(-|-,*)}
    do
        printf "%-32s %s\n" $command $completion
    done | sort
}

back() {
    for file in "$@"; do
        cp "$file" "$file".bak
    done
}

calcul() {
    bc -l <<< "$@"
}

# Launch a program in a terminal without getting any output,
# and detache the process from terminal
# (can then close the terminal without terminating process)
-echo() {
    "$@" &> /dev/null & disown
}

# Generate a password - default 20 characters
pass() {
    local size=${1:-20}
    cat /dev/random | tr -dc '[:graph:]' | head -c$size
}
