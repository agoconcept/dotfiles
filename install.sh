#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Install eza from binary
install_eza_linux() {
    if command -v eza &> /dev/null; then
        return
    fi

    echo -e "${GREEN}Installing eza...${NC}"
    
    if command -v apt-get &> /dev/null; then
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo apt update
        sudo apt install -y eza
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y eza
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm eza
    else
        # Fallback to binary download
        cd /tmp
        wget -q https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz
        tar -xzf eza_x86_64-unknown-linux-gnu.tar.gz
        sudo mv eza /usr/local/bin/
        rm eza_x86_64-unknown-linux-gnu.tar.gz
        cd -
    fi
}

# Install modern CLI tools on Linux
install_modern_tools_linux() {
    echo -e "${GREEN}Installing modern CLI tools...${NC}"

    # Try to install from package manager first
    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y bat ripgrep fd-find fzf 2>/dev/null || true
        # Create bat symlink if batcat exists (Ubuntu/Debian naming)
        [[ -x /usr/bin/batcat ]] && sudo ln -sf /usr/bin/batcat /usr/local/bin/bat
        # Create fd symlink if fdfind exists (Ubuntu/Debian naming)
        [[ -x /usr/bin/fdfind ]] && sudo ln -sf /usr/bin/fdfind /usr/local/bin/fd
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y bat ripgrep fd-find fzf 2>/dev/null || true
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm bat ripgrep fd fzf 2>/dev/null || true
    fi

    # Install eza from binary
    install_eza_linux

    # Install delta
    install_delta_linux
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

# Install packages based on OS
install_packages() {
    local os=$(detect_os)

    case $os in
        "macos")
            if ! command -v brew &> /dev/null; then
                echo -e "${YELLOW}Installing Homebrew...${NC}"
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install zsh tmux git vim curl fontconfig git-delta bat ripgrep fd fzf eza
            ;;
        "linux")
            if command -v apt-get &> /dev/null; then
                sudo apt-get update
                sudo apt-get install -y zsh tmux git vim curl fontconfig build-essential
                # Install modern tools
                install_modern_tools_linux
            elif command -v dnf &> /dev/null; then
                sudo dnf install -y zsh tmux git vim curl fontconfig gcc
                install_modern_tools_linux
            elif command -v pacman &> /dev/null; then
                sudo pacman -S --noconfirm zsh tmux git vim curl fontconfig base-devel
                install_modern_tools_linux
            else
                echo -e "${RED}Unsupported package manager${NC}"
                exit 1
            fi
            ;;
        *)
            echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
            exit 1
            ;;
    esac
}

# Install delta on Linux systems
install_delta_linux() {
    if command -v delta &> /dev/null; then
        return
    fi

    echo -e "${GREEN}Installing delta...${NC}"
    cd /tmp
    local delta_url=$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest | grep "browser_download_url.*x86_64-unknown-linux-gnu.tar.gz" | cut -d '"' -f 4)
    if [[ -n "$delta_url" ]]; then
        curl -L "$delta_url" -o delta.tar.gz
        tar -xzf delta.tar.gz
        sudo mv delta-*/delta /usr/local/bin/
        rm -rf delta*
    else
        echo -e "${YELLOW}Could not download delta binary${NC}"
    fi
    cd -
}

# Create symlinks safely
create_symlink() {
    local source="$1"
    local target="$2"

    if [[ -L "$target" ]]; then
        echo -e "${YELLOW}Removing existing symlink: $target${NC}"
        rm "$target"
    elif [[ -f "$target" ]] || [[ -d "$target" ]]; then
        echo -e "${YELLOW}Backing up existing file: $target${NC}"
        mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    ln -sf "$source" "$target"
    echo -e "${GREEN}Created symlink: $target -> $source${NC}"
}

# Install Oh My Zsh and plugins
install_zsh_setup() {
    # Install Oh My Zsh if not present
    if [[ ! -d ~/.oh-my-zsh ]]; then
        echo -e "${GREEN}Installing Oh My Zsh...${NC}"
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Install zsh-autosuggestions
    if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
        echo -e "${GREEN}Installing zsh-autosuggestions...${NC}"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi

    # Install zsh-syntax-highlighting
    if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then
        echo -e "${GREEN}Installing zsh-syntax-highlighting...${NC}"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi
}

# Install vim plugins
install_vim_plugins() {
    # Create vim directories
    mkdir -p ~/.vim/tmp/backup ~/.vim/tmp/swap ~/.vim/tmp/undo

    # Install vim-plug if not present
    if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
        echo -e "${GREEN}Installing vim-plug...${NC}"
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # Install plugins
    echo -e "${GREEN}Installing vim plugins...${NC}"
    vim +PlugInstall +qall
}

# Install Tmux Plugin Manager
install_tmux_plugins() {
    if [[ ! -d ~/.tmux/plugins/tpm ]]; then
        echo -e "${GREEN}Installing Tmux Plugin Manager...${NC}"
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        echo -e "${YELLOW}After tmux starts, press Ctrl-a + I to install plugins${NC}"
    else
        echo -e "${YELLOW}TPM already installed${NC}"
    fi

    echo -e "${GREEN}Tmux Plugin Manager ready!${NC}"
    echo -e "${YELLOW}Restart tmux and press Ctrl-a + I to install Catppuccin theme${NC}"
}

# Install and configure Starship
install_starship() {
    if ! command -v starship &> /dev/null; then
        echo -e "${GREEN}Installing Starship prompt...${NC}"
        curl -sS https://starship.rs/install.sh | sh -s -- -y

        # Add starship to PATH if needed
        if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
            export PATH="$HOME/.local/bin:$PATH"
        fi
    fi

    # Set the Catppuccin Powerline preset
    if command -v starship &> /dev/null; then
        echo -e "${GREEN}Setting Catppuccin Powerline preset...${NC}"
        starship preset catppuccin-powerline -o ~/.config/starship.toml
    else
        echo -e "${YELLOW}Starship not found in PATH, using custom config...${NC}"
        create_symlink "$dotfiles_dir/starship/starship.toml" ~/.config/starship.toml
    fi
}

# Setup git configuration
setup_git_config() {
    create_symlink "$dotfiles_dir/git/gitconfig" ~/.gitconfig
    create_symlink "$dotfiles_dir/git/gitconfig_template" ~/.gitconfig_template
    create_symlink "$dotfiles_dir/git/git_template" ~/.git_template

    # Check if delta is installed and include delta config
    if command -v delta &> /dev/null; then
        echo -e "${GREEN}Delta found, enabling enhanced git diff...${NC}"
        # Edit the source file directly since ~/.gitconfig is a symlink
        sed -i.bak 's|# Delta config will be added here by install script if delta is available|path = '"$dotfiles_dir"'/git/gitconfig_delta|' "$dotfiles_dir/git/gitconfig"
        rm "$dotfiles_dir/git/gitconfig.bak" 2>/dev/null || true
    else
        echo -e "${YELLOW}Delta installation failed, using standard git diff${NC}"
        # Remove the comment line if delta is not available
        sed -i.bak '/# Delta config will be added here by install script if delta is available/d' "$dotfiles_dir/git/gitconfig"
        rm "$dotfiles_dir/git/gitconfig.bak" 2>/dev/null || true
    fi
}

main() {
    local dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    echo -e "${GREEN}Installing dotfiles from: $dotfiles_dir${NC}"

    # Install packages
    echo -e "${GREEN}Installing packages...${NC}"
    install_packages

    # Install zsh setup
    echo -e "${GREEN}Setting up Zsh...${NC}"
    install_zsh_setup

    # Create necessary directories
    mkdir -p ~/.ssh ~/.local/share/konsole ~/.config

    # Create symlinks
    create_symlink "$dotfiles_dir/bash/bashrc" ~/.bashrc
    create_symlink "$dotfiles_dir/bash/profile" ~/.profile
    create_symlink "$dotfiles_dir/bash/bash_aliases" ~/.bash_aliases
    create_symlink "$dotfiles_dir/bash/bash_colors" ~/.bash_colors
    create_symlink "$dotfiles_dir/zsh/zshrc" ~/.zshrc

    # Install and configure Starship
    install_starship

    # Setup git with conditional delta support
    setup_git_config

    # Setup git with conditional delta support
    setup_git_config
    create_symlink "$dotfiles_dir/tmux/tmux.conf" ~/.tmux.conf
    create_symlink "$dotfiles_dir/ssh/config" ~/.ssh/config
    create_symlink "$dotfiles_dir/vim" ~/.vim
    create_symlink "$dotfiles_dir/vim/vimrc" ~/.vimrc
    create_symlink "$dotfiles_dir/vim/gvimrc" ~/.gvimrc

    # Install vim plugins
    echo -e "${GREEN}Setting up Vim...${NC}"
    install_vim_plugins

    # Install tmux plugins
    echo -e "${GREEN}Setting up Tmux...${NC}"
    install_tmux_plugins

    echo -e "${GREEN}Dotfiles installation complete!${NC}"
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Install a Nerd Font from https://www.nerdfonts.com/"
    echo "2. Configure your GitHub token in ~/.github_token"
    echo "3. Restart your terminal or run: source ~/.zshrc"
    echo "4. In tmux, press Ctrl-a + I to install plugins and activate Catppuccin theme"
    echo "5. For VS Code: cat $dotfiles_dir/vscode/extensions.txt | xargs -L 1 code --install-extension"
    echo ""
    echo -e "${GREEN}Modern CLI tools installed:${NC}"
    command -v bat &> /dev/null && echo "  ✓ bat (better cat)"
    command -v rg &> /dev/null && echo "  ✓ ripgrep (better grep)"
    command -v fd &> /dev/null && echo "  ✓ fd (better find)"
    command -v fzf &> /dev/null && echo "  ✓ fzf (fuzzy finder)"
    command -v eza &> /dev/null && echo "  ✓ eza (better ls)"
    command -v delta &> /dev/null && echo "  ✓ delta (better git diff)"
    echo ""
    echo -e "${GREEN}Enjoy your enhanced development environment! 🚀${NC}"
}

main "$@"
