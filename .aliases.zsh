alias v=nvim
alias vim=nvim
alias config='/usr/bin/git --git-dir="$HOME/dotfiles/" --work-tree="$HOME"'
alias today='date +%Y%m%d'
alias now='date +%s'
alias mm='micromamba'

touchp() {
    mkdir -p "$(dirname "$1")" && touch "$1"
}
