# dotfiles

This is my dotfiles repo, the structure is inspired by [this article by Atlassan](https://www.atlassian.com/git/tutorials/dotfiles).

## Setting up locally

To clone properly, run the following:

```bash
git clone --bare https://github.com/SamProkopchuk/dotfiles.git $HOME/dotfiles
```

Then run the following to clone the actual content:

```bash
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
config checkout
```

Next, you __must__ run the setup_dotfiles.sh script provided:

```bash
chmod +x $HOME/setup_dotfiles.sh && $HOME/setup_dotfiles.sh
```

