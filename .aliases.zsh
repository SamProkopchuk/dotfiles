alias v=nvim
alias vim=nvim
alias config='command git --git-dir="$HOME/dotfiles/" --work-tree="$HOME"'
alias today='date +%Y%m%d'
alias now='date +%s'
alias mm='micromamba'
alias ff='fastfetch'
# Create a python env. `mmake foo 3.11.12` => env named foo with python 3.11.12.
mmake() { micromamba create -n "$1" python="$2" -y; }
# Shortcut: env name == python version. `mc 3.11.12` => env named 3.11.12 with python 3.11.12.
mc() { micromamba create -n "$1" python="$1" -y; }
alias ta='tmux attach || tmux new'

# Git
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias gp='git push'
alias gl='git log --graph --pretty=format:"%C(auto)%h %C(blue)%ar %C(green)%an%C(reset)%C(auto)%d %s" --abbrev-commit'
alias gt='git-branchless'
# Push dotfiles from this repo, then sync $HOME via the bare-repo checkout
alias dpush='git push && config pull'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
mkcd() { mkdir -p "$1" && cd "$1"; }

# Docker / k8s
alias k='kubecolor'
alias kns='kubens'
alias kctx='kubectx'
alias kgp='kubectl get pods'
alias d='docker'
alias dc='docker compose'

# Modern CLI replacements
alias cat='bat --plain'
alias ls='eza'
alias ll='eza -la'
alias tree='eza --tree --git-ignore'

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
