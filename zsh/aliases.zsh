# Modern shell aliases
# Better defaults
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS - use gls from coreutils for GNU ls features
    alias ls='gls --color=auto --group-directories-first'
else
    # Linux - use standard ls
    alias ls='ls --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Modern replacements (if available)
command -v bat > /dev/null && alias cat='bat'
command -v rg > /dev/null && alias grep='rg'
command -v fd > /dev/null && alias find='fd'
command -v eza > /dev/null && alias l='eza --icons --group-directories-first'
command -v eza > /dev/null && alias ll='eza -lag --icons --git --group-directories-first'
command -v eza > /dev/null && alias la='eza -A --icons --group-directories-first'
command -v eza > /dev/null && alias tree='eza --tree --icons'

# Git aliases (complement to gitconfig)
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'

# Kubernetes aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'

# Network and system
alias ports='netstat -tulanp'
alias myip='curl -s https://ipinfo.io/ip'
alias weather='curl -s wttr.in'

# Development
alias serve='python3 -m http.server'
alias jsonpp='python3 -m json.tool'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Quick navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Reload shell
alias reload='source ~/.zshrc'
