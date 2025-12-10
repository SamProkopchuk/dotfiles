eval "$(starship init zsh)"

source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Ensure emacs keybindings (not vi mode)
bindkey -e

bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# Word navigation
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$PATH:$HOME/.local/bin"

eval "$(zoxide init zsh)"
eval "$(micromamba shell hook --shell zsh)"

source $HOME/.aliases.zsh
# Source system-specific config if it exists
[[ ! -f $HOME/.localconf.zsh ]] || source $HOME/.localconf.zsh
