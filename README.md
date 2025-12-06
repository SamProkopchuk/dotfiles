# dotfiles

This is my dotfiles repo, a collection of some configuration files I use.

The structure is inspired by [this article by Atlassian](https://www.atlassian.com/git/tutorials/dotfiles).

## Setting up locally

You can setup on a generic ubuntu LTS machine (may work on other distros but only tested on ubuntu LTS 22.04/24.04) using:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/samprokopchuk/dotfiles/main/setup.sh)"
```

### Manual setup

To clone properly, run the following:

```bash
git clone --bare https://github.com/SamProkopchuk/dotfiles.git $HOME/dotfiles
```

Then run the following to clone the actual content:

```bash
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

Then clone the actual content to home directory:
```bash
config config --local status.showUntrackedFiles no
config checkout
```

See the Atlassian article for more info.

## Iosevka

The font I use is IosevkaTermCurly, which can probably be found at the most recent release [here](https://github.com/be5invis/Iosevka/releases).
