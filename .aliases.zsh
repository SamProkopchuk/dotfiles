alias v=nvim
alias vim=nvim
alias config='/usr/bin/git --git-dir="$HOME/dotfiles/" --work-tree="$HOME"'
alias today='date +%Y%m%d'
alias now='date +%s'
alias mm='micromamba'
alias ta='tmux attach || tmux new'
alias gs='git status'

touchp() {
    mkdir -p "$(dirname "$1")" && touch "$1"
}

# Reset terminal after SSH to clear mouse mode / stale escape sequences
ssh() {
    command ssh "$@"
    printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l'
}
