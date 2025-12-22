#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Uninstalling dotfiles...${NC}"
echo -e "${RED}This will remove all symlinks created by the dotfiles installer.${NC}"
echo -e "${YELLOW}Your original files (if any) should have been backed up during installation.${NC}"
echo ""
read -p "Are you sure you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Uninstall cancelled."
    exit 1
fi

# Function to safely remove symlinks
remove_symlink() {
    local target="$1"
    if [[ -L "$target" ]]; then
        echo -e "${GREEN}Removing symlink: $target${NC}"
        rm "$target"
    elif [[ -f "$target" ]] || [[ -d "$target" ]]; then
        echo -e "${YELLOW}Skipping non-symlink: $target${NC}"
    fi
}

# Remove shell configurations
remove_symlink ~/.bashrc
remove_symlink ~/.profile
remove_symlink ~/.bash_aliases
remove_symlink ~/.bash_colors
remove_symlink ~/.zshrc

# Remove git configurations
remove_symlink ~/.gitconfig
remove_symlink ~/.gitconfig_template
remove_symlink ~/.git_template

# Remove other configurations
remove_symlink ~/.tmux.conf
remove_symlink ~/.ssh/config
remove_symlink ~/.vim
remove_symlink ~/.vimrc
remove_symlink ~/.gvimrc
remove_symlink ~/.config/nvim/init.lua
remove_symlink ~/.config/bat/config
remove_symlink ~/.cargo/config.toml
remove_symlink ~/.pythonrc
remove_symlink ~/.npmrc

# Remove starship config (if it was created by our installer)
if [[ -L ~/.config/starship.toml ]]; then
    remove_symlink ~/.config/starship.toml
fi

echo ""
echo -e "${GREEN}Dotfiles uninstalled successfully!${NC}"
echo -e "${YELLOW}Note: This script only removes symlinks. Installed packages and tools remain.${NC}"
echo -e "${YELLOW}Check for .backup files in your home directory for original configurations.${NC}"