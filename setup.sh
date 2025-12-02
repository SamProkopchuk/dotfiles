#!/bin/bash

# Compact development environment setup script
set -e

echo "🚀 Setting up dev environment..."

# Update package list (Ubuntu/Debian)
if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
fi

# Install fzf
if ! command -v fzf >/dev/null 2>&1; then
    echo "Installing fzf..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install fzf
    else
        sudo apt-get install -y fzf || {
            git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
            $HOME/.fzf/install --all
        }
    fi
fi

# Install tmux
command -v tmux >/dev/null 2>&1 || {
    echo "Installing tmux..."
    [[ "$OSTYPE" == "darwin"* ]] && brew install tmux || sudo apt-get install -y tmux
}

# Install TPM
[[ ! -d $HOME/.tmux/plugins/tpm ]] && {
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
}

# Install ripgrep
command -v rg >/dev/null 2>&1 || {
    echo "Installing ripgrep..."
    [[ "$OSTYPE" == "darwin"* ]] && brew install ripgrep || sudo apt-get install -y ripgrep
}

# Install modern Neovim
if ! command -v nvim >/dev/null 2>&1 || ! nvim --version | grep -q "v0\.\(1[1-9]\|[2-9][0-9]\)"; then
    echo "Installing Neovim (>= 0.11)..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install neovim
    else
        # Remove old version if it exists
        sudo apt-get remove -y neovim 2>/dev/null || true

        # Build Neovim from source for Ubuntu 20.04 compatibility
        echo "Building latest stable Neovim from source..."

        # Install build dependencies
        sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential

        # Get latest stable release tag
        NVIM_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
        echo "Building Neovim ${NVIM_VERSION}..."

        # Clone and build
        cd /tmp
        rm -rf neovim
        git clone --depth 1 --branch ${NVIM_VERSION} https://github.com/neovim/neovim.git
        cd neovim
        make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$HOME/.local
        make install

        # Clean up
        cd ~
        rm -rf /tmp/neovim

        echo "✅ Neovim ${NVIM_VERSION} installed to ~/.local/bin/nvim"
    fi
fi

# Install zsh
command -v zsh >/dev/null 2>&1 || {
    echo "Installing zsh..."
    [[ "$OSTYPE" == "darwin"* ]] && brew install zsh || sudo apt-get install -y zsh
    sudo chsh -s $(which zsh) $(whoami)
}

# Install Oh My Zsh
[[ ! -d $HOME/.oh-my-zsh ]] && {
    echo "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# Install zsh plugins
echo "Installing zsh plugins..."
[[ ! -d $HOME/.oh-my-zsh/plugins/zsh-autosuggestions ]] && {
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
}
[[ ! -d $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting ]] && {
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
}
[[ ! -d $HOME/.oh-my-zsh/themes/powerlevel10k ]] && {
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/themes/powerlevel10k
}

# Install zoxide
command -v zoxide >/dev/null 2>&1 || {
    echo "Installing zoxide..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zoxide
    else
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi
}

if [[ ! -d "$HOME/dotfiles" ]]; then
    echo "Setting up dotfiles..."
    git clone --bare https://github.com/SamProkopchuk/dotfiles.git "$HOME/dotfiles"
    # Use a function instead of alias in scripts
    config() {
        /usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME "$@"
    }
    config config --local status.showUntrackedFiles no
    
    # Backup any existing dotfiles that would conflict
    echo "Backing up existing dotfiles..."
    mkdir -p $HOME/.dotfiles-backup
    config checkout 2>&1 | grep -E "^\s+" | awk '{print $1}' | xargs -I{} sh -c 'mkdir -p $(dirname $HOME/.dotfiles-backup/{}) && mv $HOME/{} $HOME/.dotfiles-backup/{}'
    
    # Now checkout should work
    config checkout
    echo "✅ Dotfiles setup complete (backups in ~/.dotfiles-backup if any)"
else
    echo "✅ Dotfiles already exist"
fi

# Install tmux plugins (after dotfiles are in place)
if [[ -d $HOME/.tmux/plugins/tpm ]] && [[ -f $HOME/.tmux.conf ]]; then
    echo "Installing tmux plugins..."
    # Run the install script directly with TMUX_PLUGIN_MANAGER_PATH set
    export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins/"
    $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
    echo "✅ Tmux plugins installed"
fi

touch $HOME/.localconf.zsh
grep -q "local/bin" $HOME/.localconf.zsh || echo 'export PATH="$PATH:$HOME/.local/bin"' >> $HOME/.localconf.zsh
grep -q "zoxide" $HOME/.localconf.zsh || echo 'eval "$(zoxide init zsh)"' >> $HOME/.localconf.zsh

# Create SSH sockets directory for ControlMaster
mkdir -p $HOME/.ssh/sockets

# Change default shell to zsh at the end
if [[ "$SHELL" != *"zsh"* ]]; then
    echo "Changing default shell to zsh..."
    sudo chsh -s $(which zsh) $(whoami)
fi

echo "✅ Setup complete!"
echo "Switching to zsh..."
exec zsh -l
