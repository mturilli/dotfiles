# History Configuration
export HISTFILE=~/.zsh_history  # Path to history file
export HISTSIZE=1000000         # Number of commands to remember in the session
export HISTFILESIZE=1000000     # Maximum number of lines in the history file
export SAVEHIST=1000000         # Number of lines to save in history file

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"

# Eza
export EZA_TIME_STYLE='long-iso'  # Use long ISO format for timestamps
export EZA_COLORS='exfxcxdxbxegedabagacad'  # Custom color scheme for eza

# Brew
export PATH="/opt/homebrew/opt/man-db/libexec/bin:$PATH"
