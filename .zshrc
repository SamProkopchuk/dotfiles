eval "$(starship init zsh)"

source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$PATH:$HOME/.local/bin"

eval "$(zoxide init zsh)"
eval "$(micromamba shell hook --shell zsh)"

source $HOME/.aliases.zsh
# Source system-specific config if it exists
[[ ! -f $HOME/.localconf.zsh ]] || source $HOME/.localconf.zsh
