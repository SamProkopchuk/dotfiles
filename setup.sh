#!/bin/bash

# Compact development environment setup script
set -e

echo "🚀 Setting up dev environment..."

# Check for Homebrew on macOS (install without sudo)
if [[ "$OSTYPE" == "darwin"* ]] && ! command -v brew >/dev/null 2>&1; then
    echo "⚠️  Homebrew is not installed."
    read -p "Install Homebrew to $HOME/.homebrew (no sudo required)? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Installing Homebrew to $HOME/.homebrew..."
        mkdir -p $HOME/.homebrew
        curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip-components=1 -C $HOME/.homebrew

        # Add brew to PATH for this session
        eval "$($HOME/.homebrew/bin/brew shellenv)"
        echo "✅ Homebrew installed to $HOME/.homebrew"
    else
        echo "❌ Homebrew is required for macOS setup. Exiting."
        exit 1
    fi
fi

# Install essential build tools
if command -v apt-get >/dev/null 2>&1; then
    if ! dpkg -l | grep -q "^ii  build-essential"; then
        echo "Installing essential build tools..."
        sudo apt-get update
        sudo apt-get install -y build-essential make
    fi
fi

# Install newer version of git on Linux
if command -v apt-get >/dev/null 2>&1; then
    if ! command -v git >/dev/null 2>&1 || ! grep -qr "git-core/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null; then
        echo "Installing latest git from PPA..."
        sudo add-apt-repository ppa:git-core/ppa -y
        sudo apt-get update
        sudo apt-get install -y git
    fi
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

# Install mosh
command -v mosh >/dev/null 2>&1 || {
    echo "Installing mosh..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install mosh
    else
        echo "Building latest mosh from source..."

        # Install build dependencies
        sudo apt-get install -y automake libtool g++ protobuf-compiler libprotobuf-dev \
            libncurses5-dev zlib1g-dev libssl-dev pkg-config

        # Clone and build
        cd /tmp
        rm -rf mosh
        git clone https://github.com/mobile-shell/mosh.git
        cd mosh
        ./autogen.sh
        ./configure
        make
        sudo make install

        # Clean up
        cd ~
        rm -rf /tmp/mosh

        echo "✅ Mosh installed from source"
    fi
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

# Install zsh (if not already present)
if ! command -v zsh >/dev/null 2>&1; then
    echo "Installing zsh..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zsh
    else
        sudo apt-get install -y zsh
    fi
fi

# Install starship prompt
command -v starship >/dev/null 2>&1 || {
    echo "Installing starship..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install starship
    else
        curl -sS https://starship.rs/install.sh | sh -s -- -b $HOME/.local/bin -y
    fi
}

# Install zsh plugins
echo "Installing zsh plugins..."
[[ ! -d $HOME/.zsh/zsh-autosuggestions ]] && {
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
}
[[ ! -d $HOME/.zsh/zsh-syntax-highlighting ]] && {
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
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

# Install micromamba
command -v micromamba >/dev/null 2>&1 || {
    echo "Installing micromamba..."
    # Accept default bin folder, decline shell init, accept conda-forge default
    echo -e "\nn\n" | "${SHELL}" <(curl -L micro.mamba.pm/install.sh)
}

# Install Rust/Cargo
command -v cargo >/dev/null 2>&1 || {
    echo "Installing Rust/Cargo..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    # Source cargo env for this session
    source $HOME/.cargo/env
}

# Install aichat
command -v aichat >/dev/null 2>&1 || {
    echo "Installing aichat..."
    cargo install aichat
}

if [[ ! -d "$HOME/dotfiles" ]]; then
    echo "Setting up dotfiles..."
    git clone --bare https://github.com/SamProkopchuk/dotfiles.git "$HOME/dotfiles"
    # Use a function instead of alias in scripts
    config() {
        GIT_PATH=$(command -v git)
        "$GIT_PATH" --git-dir=$HOME/dotfiles/ --work-tree=$HOME "$@"
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

echo "DEBUG: About to check tmux plugins..."

# Install tmux plugins (after dotfiles are in place)
if [[ -d $HOME/.tmux/plugins/tpm ]] && [[ -f $HOME/.tmux.conf ]]; then
    echo "Installing tmux plugins..."
    # Run the install script directly with TMUX_PLUGIN_MANAGER_PATH set
    export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins/"
    $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh || echo "⚠️  Tmux plugin installation encountered an error (non-fatal)"
    echo "✅ Tmux plugins install attempted"
fi

echo "DEBUG: About to create localconf..."

# Create .localconf.zsh for system-specific config
if [[ ! -f $HOME/.localconf.zsh ]]; then
    echo "# Add system-specific config to this file" > $HOME/.localconf.zsh
fi

echo "DEBUG: About to create SSH sockets..."

# Create SSH sockets directory for ControlMaster
mkdir -p $HOME/.ssh/sockets

echo "DEBUG: About to check shell..."

# Change default shell to zsh
if [[ "$SHELL" != *"zsh"* ]]; then
    echo "Changing default shell to zsh..."
    ZSH_PATH=$(which zsh)

    # On macOS, ensure zsh is in /etc/shells before changing
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if ! grep -qxF "$ZSH_PATH" /etc/shells; then
            echo "Adding $ZSH_PATH to /etc/shells..."
            echo "$ZSH_PATH" | sudo tee -a /etc/shells
        fi
    fi

    sudo chsh -s "$ZSH_PATH" "$(whoami)"
    echo "✅ Default shell changed to zsh (reconnect to use it)"
fi

echo "✅ Setup complete!"
echo "DEBUG: After setup complete..."

# Check if git config needs to be set
GIT_NAME=$(git config --global user.name 2>/dev/null || true)
GIT_EMAIL=$(git config --global user.email 2>/dev/null || true)

if [[ -z "$GIT_NAME" ]] || [[ -z "$GIT_EMAIL" ]]; then
    echo ""
    echo "Next steps:"
    if [[ -z "$GIT_NAME" ]]; then
        echo "  git config --global user.name \"Your Name\""
    fi
    if [[ -z "$GIT_EMAIL" ]]; then
        echo "  git config --global user.email \"your_email@example.com\""
    fi
fi

# Start zsh if we're currently running bash
echo "DEBUG: BASH_VERSION=[$BASH_VERSION]"
echo "DEBUG: zsh path=$(command -v zsh)"
if [ -n "$BASH_VERSION" ] && command -v zsh >/dev/null 2>&1; then
    echo ""
    echo "🔄 Switching to zsh..."
    sleep 0.5
    exec zsh -i -l
else
    echo "DEBUG: Condition failed, not switching to zsh"
fi
