alias v=nvim
alias vim=nvim
alias config='command git --git-dir="$HOME/dotfiles/" --work-tree="$HOME"'
alias today='date +%Y%m%d'
alias now='date +%s'
alias mm='micromamba'
mmake() { micromamba create -n "$1" python="$2" --use-uv -y; }
alias ta='tmux attach || tmux new'
alias gs='git status'
alias k='kubectl'
alias gl='git log --graph --pretty=format:"%C(auto)%h %C(blue)%ar %C(green)%an%C(reset)%C(auto)%d %s" --abbrev-commit'

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
