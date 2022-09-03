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
config checkout
```

Next, you __must__ run the setup_dotfiles.sh script provided:

```bash
chmod +x $HOME/setup_dotfiles.sh && $HOME/setup_dotfiles.sh
```

Among other things, this ensures only the files in this repo are tracked by git (via the `config` alias).

See the Atlassian article for more info.

## Iosevka

To install the custom Iosevka font using `private-build-plans.toml`, follow [these instructions](https://github.com/be5invis/Iosevka/blob/master/doc/custom-build.md).

And build the `.ttf` files using:

```bash
npm run build -- ttf::iosevka-curly
```
