setopt complete_aliases

# File Navigation
alias ls='eza --group-directories-first --icons=auto --color=always --classify'
alias ll='eza -l --git --time-style=long-iso --icons=auto'
alias la='eza -la -snew --git --time-style=long-iso --icons=auto'
alias lt='eza -lT --git --level=2 --icons=auto'
alias tree='eza -T --git --icons --color=always'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias c='clear'

# File Preview & Search
alias cat='bat'
alias grep='rg'
alias search='rg'
# alias f='rg --files | fzf' # Replaced by fzf file search
# alias ff='rg --no-heading --line-number' # Replaced by fzf file search

# System
alias brewall='brew update && brew upgrade && brew cleanup'
alias ports='lsof -i -P -n | grep LISTEN'
alias ip='ipconfig getifaddr en0'
alias myip='curl ifconfig.me'
alias please='sudo zsh -c "$(fc -ln -1)"'
alias usage='du -sh * | sort -h'

# Git
# alias gs='git status' # Replaced by git status with fzf
alias ga='git add .'
# alias gc='git commit -m'  # Replaced by git commit fuzzy search
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate'
alias gco='git checkout'
# alias gb='git branch'  # Replaced by git branch fuzzy switcher
alias gcb='git checkout -b'
alias gsh='git stash'
alias gshp='git stash pop'
alias gd='git diff'

# Dev Env
alias serve='python3 -m http.server'
alias reload='source ~/.zshrc'
alias editz='nvim ~/.zshrc'
alias editsh='nvim ~/.bashrc'
alias mkd='mkdir -p'
alias tree='eza --tree'

# Docker
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'
alias dstart='docker start'
alias dstop='docker stop'
alias drm='docker rm'
alias drmi='docker rmi'
alias dexec='docker exec -it'

# Cleanup
alias cl='clear && echo "📦 Clean and ready!"'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias cleanupnode='rm -rf node_modules && rm package-lock.json && npm install'
alias cleanupgit='git clean -fd && git reset --hard'

# Networking
alias pingg='ping google.com'
alias httpserver='python3 -m http.server 8000'

# Productivity
alias now='date +"%T"'
alias today='date +"%A, %B %d, %Y"'
alias wttr='curl wttr.in'
alias cal='cal -3'
alias stopwatch='time read -p "Press enter to stop..."'

# NPM / Node
alias ni='npm install'
alias nr='npm run'
alias ns='npm start'
alias nt='npm test'
alias nb='npm run build'

# Yarn
alias yi='yarn install'
alias ys='yarn start'
alias yt='yarn test'
alias yb='yarn build'

# Java
alias javacompile='javac *.java'
alias javarun='java Main'

# Reload Shell
alias restart-shell='exec $SHELL -l'

# Folders
alias doc="$HOME/Documents"
alias dow="$HOME/Downloads"

# GH CLI
alias ghcr-private='gh repo create --private --source=. --push'
alias ghcr-public='gh repo create --public --source=. --push'

# Editors
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
