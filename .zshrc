# Ensure SHELL is set correctly (needed for tmux when chsh hasn't taken effect yet)
export SHELL=$(command -v zsh)

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

# Only alphanumerics are word characters (makes Option+B/F stop at punctuation like vim's w/b)
WORDCHARS=''

# Word navigation (Option+B/F, Ctrl+Arrow)
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# WORD navigation - whitespace-delimited (Option+Shift+B/F)
bindkey '^[B' vi-backward-blank-word
bindkey '^[F' vi-forward-blank-word

export EDITOR="nvim"
export VISUAL="nvim"

eval "$(zoxide init zsh)"
eval "$(micromamba shell hook --shell zsh)"

source "$HOME/.aliases.zsh"
# Source system-specific config if it exists
[[ ! -f "$HOME/.localconf.zsh" ]] || source "$HOME/.localconf.zsh"
