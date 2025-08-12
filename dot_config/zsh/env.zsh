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

# Deafault editor
export EDITOR=nvim

# Colima and docker containers
export COLIMA_HOME="$HOME/.config/colima"
export DOCKER_HOST="unix://${COLIMA_HOME}/default/docker.sock"

# Less
# NOTE: We want to have both syntax highlighting (not coloring) and editing
# capabilities in less for both files and piped input. This led me down a
# rabbithole of aliases to bat, wrappers, and preprocessors. Not elegant,
# likely not worth it.
#
# Arguments for less
# --incsearch   incremental search, showing matches as you type
# --LONG-PROMPT display a long, informative prompt
# -F    quit if output fits on one screen
# -R    interpret raw ANSI colors (required for bat highlighting)
# -S    chop long lines instead of wrapping
# -i    case-insensitive search unless uppercase letters are used
# -x4   set tab stops every 4 columns
# -w    briefly highlight first “new” line after a movement
export LESS="--incsearch --LONG-PROMPT -F -R -S -i -x4 -w"
export LESSHISTFILE=-
export LESSKEYIN="$HOME/.config/less/lesskey"  # compiled keymap
export LESS_REAL="$(command -v less)"   # real less binary
export LESSOPEN="| ~/.local/bin/lesspreproc %s" # preprocessor for less

# Pagers
export PAGER="$HOME/.local/bin/lesswrap"    # wrapper for less
export GIT_PAGER="$HOME/.local/bin/lesswrap" # wrapper for less

# Man pages
# Use bat to render man pages, then page with less
# col -bx   strips the backspace overstrike formatting that man uses
# -l man    tells bat to use its manpage syntax
# --paging=always   keeps paging
# -p        removes bat’s header/ruler
export MANPAGER='sh -c "col -bx | bat -l man --paging=always -p"'