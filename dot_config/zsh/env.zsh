# XDG base directories
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

mkdir -p "$XDG_STATE_HOME/zsh" "$XDG_CACHE_HOME/zsh"

# History and completion state
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=1000000
export SAVEHIST=1000000
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Tool configuration
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export COLIMA_HOME="$XDG_CONFIG_HOME/colima"

# Keep PATH ordered and duplicate-free. Detect Homebrew without spawning a
# process so non-login shells remain portable and fast.
typeset -U path PATH
path=(
    "$XDG_DATA_HOME/bin"
    "$HOME/.local/bin"
    "$HOME/bin"
    "${path[@]}"
)

if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
    if [[ -x /opt/homebrew/bin/brew ]]; then
        export HOMEBREW_PREFIX=/opt/homebrew
    elif [[ -x /usr/local/bin/brew ]]; then
        export HOMEBREW_PREFIX=/usr/local
    fi
fi

if [[ -n "${HOMEBREW_PREFIX:-}" ]]; then
    path=(
        "$HOMEBREW_PREFIX/bin"
        "$HOMEBREW_PREFIX/sbin"
        "$HOMEBREW_PREFIX/opt/openjdk@21/bin"
        "${path[@]}"
    )
fi

# Java 21, when installed
if [[ -x /usr/libexec/java_home ]]; then
    _java_home=$(/usr/libexec/java_home -v 21 2>/dev/null) || _java_home=""
    if [[ -n "$_java_home" ]]; then
        export JAVA_HOME="$_java_home"
        export CPPFLAGS="-I$JAVA_HOME/include${CPPFLAGS:+ $CPPFLAGS}"
        path=("$JAVA_HOME/bin" "${path[@]}")
    fi
    unset _java_home
fi

# Editor
if (( $+commands[nvim] )); then
    export EDITOR=nvim
    export VISUAL=nvim
elif (( $+commands[vim] )); then
    export EDITOR=vim
    export VISUAL=vim
else
    export EDITOR=nano
    export VISUAL=nano
fi

# Pagers. `man` is colorized once; regular paging stays predictable.
export LESS='-R -F -i -S -x4 -w'
export LESSHISTFILE=-
export PAGER=less
export MANPAGER='sh -c "col -bx | bat -plman"'

# FZF defaults. File previews are scoped to file selection so history search
# does not try to interpret commands as filenames.
export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border --color=fg:#839496,bg:#002b36,preview-bg:#073642 --color=prompt:#2aa198,pointer:#b58900,marker:#d33682,info:#859900'
export FZF_CTRL_T_OPTS="--walker-skip=.git,node_modules,target,.venv --preview 'bat --style=numbers --color=always --line-range=:300 -- {}' --preview-window=right:60%"
export FZF_ALT_C_OPTS="--walker-skip=.git,node_modules,target,.venv --preview 'eza --tree --level=2 --color=always -- {}' --preview-window=right:60%"
