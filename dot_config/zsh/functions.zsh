mkcd() {
    [[ $# -eq 1 ]] || { print -u2 'usage: mkcd directory'; return 2; }
    mkdir -p -- "$1" && cd -- "$1"
}

mktouch() {
    [[ $# -eq 1 ]] || { print -u2 'usage: mktouch path/to/file'; return 2; }
    mkdir -p -- "${1:h}" && touch -- "$1"
}

# Interactive directory selection backed by zoxide.
fcd() {
    (( $+functions[zi] )) || { print -u2 'fcd: zoxide is unavailable'; return 1; }
    zi "$@"
}

# Select one file and preview it with bat.
fp() {
    local file
    file=$(fzf --preview 'bat --style=numbers --color=always --line-range=:500 -- {}') || return
    [[ -n "$file" ]] && bat -- "$file"
}
