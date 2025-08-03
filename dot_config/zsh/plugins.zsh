# Starship
eval "$(starship init zsh)"

# fzf
[ -f "$HOME/.config/fzf/fzf.zsh" ] && source "$HOME/.config/fzf/fzf.zsh"

# Zoxide
eval "$(zoxide init zsh)"

# GitHub CLI copilot
eval "$(gh copilot alias -- zsh)"

# Direnv
eval "$(direnv hook zsh)"

# Autosuggestions for zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
# ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# ZSH_AUTOSUGGEST_USE_ASYNC=1
# ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(forward-char)
# ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(end-of-line)
# ZSH_AUTOSUGGEST_MANUAL_REBIND=1
# ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(backward-delete-char backward-kill-word delete-char)

# Syntax highlighting for zsh
# NOTE: It must be sourced after the prompt is set and after the
# zsh-autosuggestions plugin. This is to ensure that the syntax highlighting
# does not interfere with the prompt.
[ -f "$HOME/.config/zsh/syntax.zsh" ] && source "$HOME/.config/zsh/syntax.zsh"