# Load fzf key bindings and completion
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

if [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]]; then
    source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# Default UI styling with preview (bat + colors)
export FZF_DEFAULT_OPTS="
    --height=40%
    --layout=reverse
    --border
    --color=fg:#839496,bg:#002b36,preview-bg:#073642
    --color=prompt:#2aa198,pointer:#b58900,marker:#d33682,info:#859900
    --preview='bat --style=numbers --color=always --theme=\"Solarized (dark)\" --line-range=:500 {}'
    --preview-window=right:60%
"

# Improved Ctrl+R history search
export FZF_CTRL_R_OPTS="
    --color=fg:#839496,bg:#002b36,preview-bg:#073642
    --preview 'echo {}'
    --preview-window=up:3:hidden:wrap
    --tiebreak=begin,index
    --no-sort
"

# Ctrl+T file search using fd + bat preview
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
    --preview 'bat --style=numbers --color=always --theme=\"Solarized (dark)\" --line-range=:300 {}'
"

# Alternative file search with ripgrep for content
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# FZF file preview with bat (consistent theme)
export FZF_PREVIEW_COMMAND='bat --style=numbers --color=always --theme=\"Solarized (dark)\" --line-range :500 {}'
