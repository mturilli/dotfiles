# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Default UI styling with preview (bat + colors)
export FZF_DEFAULT_OPTS="
    --height=40%
    --layout=reverse
    --border
    --color=fg:#839496,bg:#002b36,preview-bg:#073642
    --color=prompt:#2aa198,pointer:#b58900,marker:#d33682,info:#859900
    --preview='bat --style=numbers --color=always --theme=Solarized-dark --line-range=:500 {}'
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
    --preview 'bat --style=numbers --color=always --theme=Solarized-dark --line-range=:300 {}'
"

# FZF file preview with bat
export FZF_PREVIEW_COMMAND='bat --style=numbers --color=always --theme="Solarized (dark)" --line-range :500 {}'
