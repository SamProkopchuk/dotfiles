alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'" >> $HOME/.aliases.zsh

requirements=("zsh" "wezterm" "nvim")

for cmd in "${requirements[@]}"
do
    if ! command -v $cmd &> /dev/null;
    then
        echo "$cmd could not be found, please install it and ensure it's in your path."
        exit
    fi
done
