# dotfiles

This is my dotfiles repo, a collection of some configuration files I use.

The structure is inspired by [this article by Atlassian](https://www.atlassian.com/git/tutorials/dotfiles).

## Setting up locally

To clone properly, run the following:

```bash
git clone --bare https://github.com/SamProkopchuk/dotfiles.git $HOME/dotfiles
```

Then run the following to clone the actual content:

```bash
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout
```

Next, run the `check_requirements.sh` script to make sure you have installed the required apps:

```bash
./check_requirements.sh
```

Among other things, this ensures only the files in this repo are tracked by git (via the `config` alias).

See the Atlassian article for more info.

## Iosevka

The font I use is IosevkaTermCurly, which can probably be found at the most recent release [here](https://github.com/be5invis/Iosevka/releases).
