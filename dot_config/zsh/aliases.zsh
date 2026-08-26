# Listings
if (( $+commands[eza] )); then
    alias ls='eza --group-directories-first --icons=auto --color=auto --classify=auto'
    alias ll='eza -l --git --time-style=long-iso --icons=auto'
    alias la='eza -la --sort=newest --git --time-style=long-iso --icons=auto'
    alias lt='eza -lT --git --level=2 --icons=auto'
    alias tree='eza -T --git --icons=auto --color=auto'
elif [[ "$OSTYPE" == darwin* ]]; then
    alias ls='ls -G'
    alias ll='ls -lG'
    alias la='ls -laG'
    alias lt='ls -laG'
else
    alias ls='ls --color=auto'
    alias ll='ls -l --color=auto'
    alias la='ls -la --color=auto'
    alias lt='ls -la --color=auto'
fi

# Navigation and shell lifecycle
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias reload='exec "$SHELL"'
alias restart-shell='exec "$SHELL" -l'
alias doc='cd "$HOME/Documents"'
alias dow='cd "$HOME/Downloads"'

# Search and inspection
alias search='rg'
alias ports='lsof -i -P -n | grep LISTEN'
alias usage='du -sh -- * | sort -h'
alias serve='python3 -m http.server'

# Git
alias gs='git status'
alias ga='git add --all'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate'
alias gco='git checkout'
alias gcb='git switch -c'
alias gsh='git stash'
alias gshp='git stash pop'
alias gd='git diff'

# Containers
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'
alias dstart='docker start'
alias dstop='docker stop'
alias dexec='docker exec -it'

# Editors
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# Package managers
alias ni='npm install'
alias nr='npm run'
alias nt='npm test'
alias nb='npm run build'
alias cleanupnode='npm ci'
alias pip='noglob pip'

(( $+commands[gtimeout] )) && alias timeout='gtimeout'
