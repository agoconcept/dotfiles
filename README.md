# Dotfiles

A modern, cross-platform dotfiles configuration for developers that works seamlessly on macOS and Linux.

## Features

- **Shell**: Zsh with Oh My Zsh and Starship prompt (Catppuccin Powerline preset)
- **Editor**: Vim with modern plugins via vim-plug
- **Terminal**: Tmux with custom configuration and seamless vim integration
- **Git**: Enhanced Git configuration with delta diff viewer and useful aliases
- **Development**: ESLint, Prettier, and EditorConfig support
- **Cross-platform**: Automatic OS detection and package management
- **Modern tooling**: Delta, Starship, syntax highlighting, and auto-suggestions

## Quick Install

### One-line installation:
```bash
git clone https://github.com/agoconcept/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && chmod +x install.sh && ./install.sh
```

### Step-by-step installation:
```bash
# Clone the repository
git clone https://github.com/agoconcept/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Make the install script executable
chmod +x install.sh

# Run the installation
./install.sh
```

## What Gets Installed

### Automatically Installed Tools:
- **Zsh** with Oh My Zsh framework
- **Starship** prompt with Catppuccin Powerline preset
- **Delta** for enhanced git diffs
- **Vim-plug** for vim plugin management
- **Zsh plugins**: autosuggestions and syntax highlighting
- **All dotfiles** symlinked to appropriate locations

### Package Managers Used:
- **macOS**: Homebrew (auto-installed if missing)
- **Linux**: apt-get, dnf, or pacman (auto-detected)

### Supported Operating Systems:
- macOS (Intel and Apple Silicon)
- Ubuntu/Debian Linux
- Fedora/RHEL Linux
- Arch Linux

## Manual Installation (Alternative)

If you prefer to install components individually or the automatic script fails:

```bash
# Clone the repository
git clone https://github.com/agoconcept/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Use the legacy Makefile (Ubuntu/Debian only)
make

# Or create symlinks manually
ln -sf ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/vim/vimrc ~/.vimrc
# ... etc
```

## Post-Installation

### Required Steps:

1. **Install a Nerd Font** from [Nerd Fonts](https://www.nerdfonts.com/)
   - Recommended: FiraCode Nerd Font, JetBrains Mono Nerd Font, or Sauce Code Pro
   - Required for proper Starship prompt display

2. **Configure Git with your information**:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

3. **Restart your terminal** or source the new configuration:
   ```bash
   source ~/.zshrc
   ```

### Optional Steps:

4. **Configure GitHub token** (for some git operations):
   ```bash
   echo "your_github_token" > ~/.github_token
   ```

5. **Install additional development tools**:
   ```bash
   # FZF (fuzzy finder) - if not auto-installed
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   ~/.fzf/install
   ```

## Configuration Files

| Tool | Config File | Description |
|------|-------------|-------------|
| Zsh | `zsh/zshrc` | Shell configuration with Oh My Zsh and plugins |
| Starship | `starship/starship.toml` | Modern prompt configuration (auto-generated) |
| Git | `git/gitconfig` | Git aliases, settings, and delta integration |
| Git | `git/gitconfig_delta` | Delta-specific configuration for enhanced diffs |
| Tmux | `tmux/tmux.conf` | Terminal multiplexer with vim integration |
| Vim | `vim/vimrc` | Vim editor with modern plugins |
| SSH | `ssh/config` | SSH client configuration |
| EditorConfig | `editorconfig/.editorconfig` | Cross-editor coding style |
| ESLint | `eslint/.eslintrc.js` | JavaScript/TypeScript linting rules |
| Prettier | `prettier/.prettierrc` | Code formatting configuration |

## Key Features & Aliases

### Git Aliases:
- `git d` - Enhanced diff with delta
- `git dt` - Diff tool (vimdiff) for side-by-side editing
- `git ll` - Beautiful log with graph
- `git st` - Short status
- `git fpush` - Force push with lease (safer)

### Shell Features:
- **Starship prompt** with git status, language versions, and more
- **Zsh autosuggestions** based on history
- **Syntax highlighting** for commands
- **Vi mode** for command line editing
- **Tmux integration** with seamless vim navigation

### Vim Features:
- **Modern plugin manager** (vim-plug)
- **Git integration** (fugitive, gitgutter)
- **File navigation** (CtrlP, NERDTree alternatives)
- **Syntax checking** and **code completion**
- **Tmux navigation** integration

## Customization

### Adding New Configurations

1. Create a new directory: `mkdir newtool`
2. Add your config file: `newtool/config`
3. Update `install.sh` to create the symlink
4. Test the installation

### Modifying Existing Configs

All configurations are modular. Edit files in their respective directories and changes are reflected immediately (or after restarting the application).

### Project-Specific Configs

Copy development tool configs to your projects:
```bash
# Copy to a JavaScript project
cp ~/.dotfiles/eslint/.eslintrc.js ~/my-project/
cp ~/.dotfiles/prettier/.prettierrc ~/my-project/
cp ~/.dotfiles/editorconfig/.editorconfig ~/my-project/
```

## Troubleshooting

### Installation Issues

**Homebrew installation fails on macOS:**
```bash
# Install Homebrew manually
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Package manager not supported:**
```bash
# Install packages manually, then run:
./install.sh
```

### Configuration Issues

**Zsh not loading properly:**
```bash
# Reset zsh configuration
rm ~/.zshrc
ln -sf ~/.dotfiles/zsh/zshrc ~/.zshrc
source ~/.zshrc
```

**Vim plugins not working:**
```bash
# Reinstall vim plugins
vim +PlugInstall +qall
```

**Tmux configuration issues:**
```bash
# Reload tmux configuration
tmux source-file ~/.tmux.conf
```

**Git delta not working:**
```bash
# Check if delta is installed
which delta
# If not, install manually:
# macOS: brew install git-delta
# Linux: cargo install git-delta
```

**Starship prompt not showing:**
```bash
# Check if starship is installed
which starship
# Install manually if needed:
curl -sS https://starship.rs/install.sh | sh
```

### Font Issues

**Prompt symbols not displaying correctly:**
1. Install a Nerd Font from [nerdfonts.com](https://www.nerdfonts.com/)
2. Set your terminal to use the Nerd Font
3. Restart your terminal

## Development

### Testing Changes

```bash
# Test zsh config syntax
zsh -n ~/.dotfiles/zsh/zshrc

# Test vim config
vim -c "source ~/.dotfiles/vim/vimrc" -c "q"

# Test git config
git config --list
```

### Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes
4. Test on both macOS and Linux if possible
5. Update documentation if needed
6. Submit a pull request

## License

MIT License - feel free to use and modify as needed.

---

**Note**: This configuration is opinionated and reflects personal preferences. Feel free to fork and customize to your needs!
