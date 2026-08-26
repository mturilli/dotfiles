# Runtime manager
if (( $+commands[pyenv] )); then
    eval "$(pyenv init - zsh)"
fi

# FZF's supported key bindings and completion integration.
if [[ -t 0 && -t 1 ]] && (( $+commands[fzf] )); then
    source <(fzf --zsh)
fi

# Autosuggestions must be loaded before syntax highlighting.
if [[ -t 0 && -t 1 && -n "${HOMEBREW_PREFIX:-}" && -r "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Tool-supported shell hooks. Each is initialized exactly once.
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
fi

if (( $+commands[starship] )) && [[ "$TERM" != dumb ]]; then
    eval "$(starship init zsh)"
else
    PS1='%F{cyan}%1~%f %F{yellow}❯%f '
fi

# direnv should follow prompt integrations.
if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi

# Syntax highlighting must be the final integration loaded.
if [[ -t 0 && -t 1 && -n "${HOMEBREW_PREFIX:-}" && -r "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
