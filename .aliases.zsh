alias v=nvim
alias vim=nvim
alias config='command git --git-dir="$HOME/dotfiles/" --work-tree="$HOME"'
alias today='date +%Y%m%d'
alias now='date +%s'
alias mm='micromamba'
mmake() { micromamba create -n "$1" python="$2" --use-uv -y; }
alias ta='tmux attach || tmux new'

# Git
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias gp='git push'
alias gl='git log --graph --pretty=format:"%C(auto)%h %C(blue)%ar %C(green)%an%C(reset)%C(auto)%d %s" --abbrev-commit'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
mkcd() { mkdir -p "$1" && cd "$1"; }

# Docker / k8s
alias k='kubectl'
alias kgp='kubectl get pods'
alias d='docker'
alias dc='docker compose'

# Modern CLI replacements
alias cat='bat --plain'
alias ls='eza'
alias ll='eza -la'
alias tree='eza --tree --git-ignore'
alias find='fd'

touchp() {
    mkdir -p "$(dirname "$1")" && touch "$1"
}

# Reset terminal after SSH to clear mouse mode and application cursor mode
ssh() {
    command ssh "$@"
    local ret=$?
    printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l\e[?1049l\e[?25h\e>'
    return $ret
}
