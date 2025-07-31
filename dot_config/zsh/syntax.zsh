# Load the syntax highlighting plugin (must come last in plugin list)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Highlighters to enable
ZSH_HIGHLIGHT_HIGHLIGHTERS=(
    main
    brackets
    pattern
    regexp
    cursor
    root
    line
)

# Main token styling
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[function]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[alias]='fg=green'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=cyan'

# Arguments & literals
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=blue'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=blue'
ZSH_HIGHLIGHT_STYLES[option]='fg=blue'
ZSH_HIGHLIGHT_STYLES[default]='fg=white'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=white'

# Error and unknown tokens
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[error]='fg=red,bold'

# Patterns & regexes
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'sudo')
ZSH_HIGHLIGHT_STYLES[pattern]='fg=red,bold'

ZSH_HIGHLIGHT_REGEXP=('eval .*' 'curl .*|sh')
ZSH_HIGHLIGHT_STYLES[regexp]='fg=red,underline'

# Brackets & cursor
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[cursor-matching]='bg=yellow,fg=black'

# Root and line
ZSH_HIGHLIGHT_STYLES[root]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[line]='bg=black,underline'
