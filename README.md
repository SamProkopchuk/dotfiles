# dotfiles

This is my dotfiles repo, the structure is inspired by [this article by Atlassan](https://www.atlassian.com/git/tutorials/dotfiles).

## Setting up locally

To clone properly, run the following:

```bash
git clone --bare <git-repo-url> $HOME/dotfiles
```

This will ensure the repo is cloned as a bare repo.

Next, you must __immediately__ run the setup.sh script provided:

```bash
$HOME/setup_dotfiles.sh
```

