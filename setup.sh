#!/bin/bash

# Compact development environment setup script
set -e

IS_MAC=$([[ "$OSTYPE" == "darwin"* ]] && echo 1 || echo 0)

pkg_install() {
    if [[ "$IS_MAC" -eq 1 ]]; then
        brew install "$@"
    else
        sudo apt-get install -y "$@"
    fi
}

need_cmd() {
    command -v "$1" >/dev/null 2>&1
}

echo "🚀 Setting up dev environment..."

# Check for Homebrew on macOS (install without sudo)
if [[ "$IS_MAC" -eq 1 ]] && ! need_cmd brew; then
    echo "⚠️  Homebrew is not installed."
    read -p "Install Homebrew to $HOME/.homebrew (no sudo required)? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Installing Homebrew to $HOME/.homebrew..."
        mkdir -p "$HOME/.homebrew"
        curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip-components=1 -C "$HOME/.homebrew"
        eval "$("$HOME/.homebrew/bin/brew" shellenv)"
        echo "✅ Homebrew installed to $HOME/.homebrew"
    else
        echo "❌ Homebrew is required for macOS setup. Exiting."
        exit 1
    fi
fi

# Linux-only: build tools and latest git
if [[ "$IS_MAC" -eq 0 ]] && need_cmd apt-get; then
    if ! dpkg -l | grep -q "^ii  build-essential"; then
        echo "Installing essential build tools..."
        sudo apt-get update
        sudo apt-get install -y build-essential make
    fi

    if ! need_cmd git || ! grep -qr "git-core/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null; then
        echo "Installing latest git from PPA..."
        sudo apt-get install -y software-properties-common
        sudo add-apt-repository ppa:git-core/ppa -y
        sudo apt-get update
        sudo apt-get install -y git
    fi
fi

# Simple package installs
need_cmd fzf    || pkg_install fzf
need_cmd tmux   || pkg_install tmux
need_cmd rg     || pkg_install ripgrep
need_cmd zsh    || pkg_install zsh

# Install mosh
if ! need_cmd mosh; then
    echo "Installing mosh..."
    if [[ "$IS_MAC" -eq 1 ]]; then
        brew install mosh
    else
        echo "Building mosh from source..."
        sudo apt-get install -y automake libtool g++ protobuf-compiler libprotobuf-dev \
            libncurses5-dev zlib1g-dev libssl-dev pkg-config
        (
            cd /tmp
            rm -rf mosh
            git clone https://github.com/mobile-shell/mosh.git
            cd mosh
            ./autogen.sh
            ./configure
            make
            sudo make install
        )
        rm -rf /tmp/mosh
        echo "✅ Mosh installed from source"
    fi
fi

# Install modern Neovim
NVIM_MIN_VERSION="0.11"
nvim_version_ok() {
    local ver
    ver=$(nvim --version | head -1 | sed -E 's/NVIM v([0-9]+\.[0-9]+).*/\1/')
    local min_major="${NVIM_MIN_VERSION%%.*}" min_minor="${NVIM_MIN_VERSION##*.}"
    local cur_major="${ver%%.*}" cur_minor="${ver##*.}"
    [[ "$cur_major" -gt "$min_major" ]] || { [[ "$cur_major" -eq "$min_major" ]] && [[ "$cur_minor" -ge "$min_minor" ]]; }
}
if ! need_cmd nvim || ! nvim_version_ok; then
    echo "Installing Neovim..."
    if [[ "$IS_MAC" -eq 1 ]]; then
        brew install neovim
    else
        sudo apt-get remove -y neovim 2>/dev/null || true
        echo "Building latest stable Neovim from source..."
        sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential
        NVIM_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
        echo "Building Neovim ${NVIM_VERSION}..."
        (
            cd /tmp
            rm -rf neovim
            git clone --depth 1 --branch "${NVIM_VERSION}" https://github.com/neovim/neovim.git
            cd neovim
            make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX="$HOME/.local"
            make install
        )
        rm -rf /tmp/neovim
        echo "✅ Neovim ${NVIM_VERSION} installed to ~/.local/bin/nvim"
    fi
fi

# Install starship
if ! need_cmd starship; then
    echo "Installing starship..."
    if [[ "$IS_MAC" -eq 1 ]]; then
        brew install starship
    else
        curl -sS https://starship.rs/install.sh | sh -s -- -b "$HOME/.local/bin" -y
    fi
fi

# Install zoxide
if ! need_cmd zoxide; then
    echo "Installing zoxide..."
    if [[ "$IS_MAC" -eq 1 ]]; then
        brew install zoxide
    else
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi
fi

# Install TPM
if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
fi

# Install zsh plugins
echo "Installing zsh plugins..."
if [[ ! -d "$HOME/.zsh/zsh-autosuggestions" ]]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
fi
if [[ ! -d "$HOME/.zsh/zsh-syntax-highlighting" ]]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.zsh/zsh-syntax-highlighting"
fi

# Install micromamba (binary only — shell hook is in .zshrc)
if ! need_cmd micromamba; then
    echo "Installing micromamba..."
    mkdir -p "$HOME/.local/bin"
    ARCH=$(uname -m)
    case "${OSTYPE}-${ARCH}" in
        darwin*-arm64)   MAMBA_PLATFORM="osx-arm64" ;;
        darwin*-*)       MAMBA_PLATFORM="osx-64" ;;
        *-aarch64)       MAMBA_PLATFORM="linux-aarch64" ;;
        *)               MAMBA_PLATFORM="linux-64" ;;
    esac
    curl -fsSL "https://micro.mamba.pm/api/micromamba/${MAMBA_PLATFORM}/latest" | tar -xj -C "$HOME/.local/bin" --strip-components=1 bin/micromamba
fi

# Install Rust/Cargo
if ! need_cmd cargo; then
    echo "Installing Rust/Cargo..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# Install aichat
if ! need_cmd aichat; then
    echo "Installing aichat..."
    cargo install aichat
fi

# Set up dotfiles
if [[ ! -d "$HOME/dotfiles" ]]; then
    echo "Setting up dotfiles..."
    git clone --bare https://github.com/SamProkopchuk/dotfiles.git "$HOME/dotfiles"
    config() {
        "$(command -v git)" --git-dir="$HOME/dotfiles/" --work-tree="$HOME" "$@"
    }
    config config --local status.showUntrackedFiles no

    # Back up any files that would be overwritten
    mkdir -p "$HOME/.dotfiles-backup"
    config checkout 2>&1 | grep -E "^\s+" | awk '{print $1}' | while read -r file; do
        mkdir -p "$(dirname "$HOME/.dotfiles-backup/$file")"
        mv "$HOME/$file" "$HOME/.dotfiles-backup/$file"
    done || true
    config checkout
    echo "✅ Dotfiles setup complete (backups in ~/.dotfiles-backup if any)"
else
    echo "✅ Dotfiles already exist"
fi

# Install tmux plugins (after dotfiles are in place)
if [[ -d "$HOME/.config/tmux/plugins/tpm" ]] && [[ -f "$HOME/.config/tmux/tmux.conf" ]]; then
    echo "Installing tmux plugins..."
    export TMUX_PLUGIN_MANAGER_PATH="$HOME/.config/tmux/plugins/"
    "$HOME/.config/tmux/plugins/tpm/scripts/install_plugins.sh" || echo "⚠️  Tmux plugin installation encountered an error (non-fatal)"
    echo "✅ Tmux plugins install attempted"
fi

# Create .localconf.zsh for system-specific config
if [[ ! -f "$HOME/.localconf.zsh" ]]; then
    echo "# Add system-specific config to this file" > "$HOME/.localconf.zsh"
fi

# Create SSH sockets directory for ControlMaster
mkdir -p "$HOME/.ssh/sockets"

# Change default shell to zsh
if [[ "$SHELL" != *"zsh"* ]]; then
    echo "Changing default shell to zsh..."
    ZSH_PATH=$(command -v zsh)

    if [[ "$IS_MAC" -eq 1 ]]; then
        if ! grep -qxF "$ZSH_PATH" /etc/shells; then
            echo "Adding $ZSH_PATH to /etc/shells..."
            echo "$ZSH_PATH" | sudo tee -a /etc/shells
        fi
    fi

    sudo chsh -s "$ZSH_PATH" "$(whoami)"
    echo "✅ Default shell changed to zsh (reconnect to use it)"
fi

echo "✅ Setup complete!"

# Check if git config needs to be set
GIT_NAME=$(git config --global user.name 2>/dev/null || true)
GIT_EMAIL=$(git config --global user.email 2>/dev/null || true)

if [[ -z "$GIT_NAME" ]] || [[ -z "$GIT_EMAIL" ]]; then
    echo ""
    echo "Next steps:"
    [[ -z "$GIT_NAME" ]] && echo "  git config --global user.name \"Your Name\""
    [[ -z "$GIT_EMAIL" ]] && echo "  git config --global user.email \"your_email@example.com\""
fi

# Start zsh if we're currently running bash
if [ -n "$BASH_VERSION" ] && need_cmd zsh; then
    echo ""
    echo "🔄 Switching to zsh..."
    exec zsh -i -l
fi
