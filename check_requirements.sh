#!/bin/bash

requirements=("zsh" "nvim" "git" "rg" "fzf")

for cmd in "${requirements[@]}"
do
    if ! command -v $cmd &> /dev/null;
    then
        echo "$cmd could not be found, please install it and ensure it's in your path."
        exit
    fi
done

zsh_apps=("/plugins/zsh-autosuggestions" "/plugins/zsh-syntax-highlighting" "/themes/powerlevel10k")
for zsh_app in "${zsh_apps[@]}"
do
  temp=$HOME/.oh-my-zsh/custom$zsh_app
  if [ ! -d $temp ];
  then
    echo "Please install $temp"
  fi
done

echo "You have all the requirements installed!"
