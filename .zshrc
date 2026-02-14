# Ensure SHELL is set correctly (needed for tmux when chsh hasn't taken effect yet)
export SHELL=$(command -v zsh)

# Set up PATH first so tools can be found
export PATH="$PATH:$HOME/.local/bin"

# Ensure emacs keybindings (not vi mode) — set before plugins so they respect it
bindkey -e

eval "$(starship init zsh)"

source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)

# Reload shared history before each prompt so autosuggestions sees other panes' commands
_reload_history() { fc -R }
autoload -Uz add-zsh-hook
add-zsh-hook precmd _reload_history
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY   # Write to history file immediately, not on shell exit
setopt SHARE_HISTORY        # Share history between all sessions
setopt HIST_IGNORE_DUPS     # Don't record duplicate consecutive commands
setopt HIST_IGNORE_SPACE    # Don't record commands starting with a space

# History search with cursor at the end
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end
bindkey '^[OA' history-beginning-search-backward-end
bindkey '^[OB' history-beginning-search-forward-end

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

# Use stable SSH agent socket path (updated by ~/.ssh/rc on each SSH connection)
if [[ -S "$HOME/.ssh/agent_sock" ]]; then
    export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"
fi

export EDITOR="nvim"
export VISUAL="nvim"

eval "$(zoxide init zsh)"
eval "$(micromamba shell hook --shell zsh)"

source "$HOME/.aliases.zsh"
# Source system-specific config if it exists
[[ ! -f "$HOME/.localconf.zsh" ]] || source "$HOME/.localconf.zsh"
