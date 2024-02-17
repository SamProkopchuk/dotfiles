alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no

requirements=("zsh" "wezterm" "nvim" "git" "rg" "fzf" "z")

for cmd in "${requirements[@]}"
do
    if ! command -v $cmd &> /dev/null;
    then
        echo "$cmd could not be found, please install it and ensure it's in your path."
        exit
    fi
done

if [[ -z $ZSH_CUSTOM ]]; then
    echo "ZSH_CUSTOM is not set, please ensure you have oh-my-zsh installed."
    exit
fi

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

