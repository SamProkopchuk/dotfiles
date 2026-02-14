# Set up PATH first so tools can be found
export PATH="$PATH:$HOME/.local/bin"

eval "$(starship init zsh)"

source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Ensure emacs keybindings (not vi mode)
bindkey -e

# History search with cursor at the end
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end

# Word navigation
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

export EDITOR="nvim"
export VISUAL="nvim"

eval "$(zoxide init zsh)"
eval "$(micromamba shell hook --shell zsh)"

source "$HOME/.aliases.zsh"
# Source system-specific config if it exists
[[ ! -f "$HOME/.localconf.zsh" ]] || source "$HOME/.localconf.zsh"
