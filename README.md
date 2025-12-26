# Dotfiles

A modern, cross-platform dotfiles configuration for developers that works seamlessly on macOS and Linux.

## Features

- **Shell**: Zsh with Oh My Zsh and Starship prompt (Catppuccin Powerline preset)
- **Editor**: Vim with modern plugins via vim-plug + Neovim configuration
- **Terminal**: Tmux with custom configuration, plugins, and seamless vim integration
- **Git**: Enhanced Git configuration with delta diff viewer and useful aliases
- **Modern CLI Tools**: bat, ripgrep, fd, fzf, eza for enhanced productivity
- **Development**: ESLint, Prettier, EditorConfig, and language-specific configs
- **Cross-platform**: Automatic OS detection and package management
- **Modern tooling**: Delta, Starship, syntax highlighting, and auto-suggestions
- **VS Code**: Settings and recommended extensions
- **Themes**: Consistent Catppuccin theme across all tools

## Quick Install

### One-line installation:
```bash
git clone https://github.com/agoconcept/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./install.sh
```

### Step-by-step installation:
```bash
# Clone the repository
git clone https://github.com/agoconcept/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run the installation
./install.sh
```

## What Gets Installed

### Automatically Installed Tools:
- **Zsh** with Oh My Zsh framework
- **Starship** prompt with Catppuccin Powerline preset
- **Delta** for enhanced git diffs
- **Bat** - modern cat replacement with syntax highlighting
- **Ripgrep** - faster grep alternative
- **Fd** - modern find replacement
- **Fzf** - fuzzy finder for files and commands
- **Eza** - modern ls replacement with git integration
- **Vim-plug** for vim plugin management
- **Tmux Plugin Manager** with curated plugins
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

# Create symlinks manually
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

4. **Install additional development tools**:
   ```bash
   # FZF (fuzzy finder) - if not auto-installed
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   ~/.fzf/install
   ```

## Configuration Files

| Tool | Config File | Description |
|------|-------------|-------------|
| Zsh | `zsh/zshrc` | Shell configuration with Oh My Zsh and plugins |
| Zsh | `zsh/aliases.zsh` | Modern shell aliases and shortcuts |
| Starship | `starship/starship.toml` | Modern prompt configuration (auto-generated) |
| Git | `git/gitconfig` | Git aliases, settings, and delta integration |
| Git | `git/gitconfig_delta` | Delta-specific configuration for enhanced diffs |
| Tmux | `tmux/tmux.conf` | Terminal multiplexer with plugins and themes |
| Vim | `vim/vimrc` | Vim editor with modern plugins |
| Neovim | `nvim/init.lua` | Neovim configuration in Lua |
| SSH | `ssh/config` | SSH client configuration |
| Bat | `bat/config` | Modern cat replacement configuration |
| Ripgrep | `ripgrep/.ripgreprc` | Modern grep configuration |
| FZF | `fzf/.fzf.zsh` | Fuzzy finder configuration and key bindings |
| VS Code | `vscode/settings.json` | VS Code editor settings |
| VS Code | `vscode/extensions.txt` | Recommended VS Code extensions |
| EditorConfig | `editorconfig/.editorconfig` | Cross-editor coding style |
| ESLint | `eslint/.eslintrc.js` | JavaScript/TypeScript linting rules |
| Prettier | `prettier/.prettierrc` | Code formatting configuration |
| Python | `python/.pythonrc` | Enhanced Python REPL configuration |
| Node.js | `node/.npmrc` | NPM configuration and defaults |
| Rust | `rust/config.toml` | Cargo configuration |
| Docker | `docker/.dockerignore` | Docker ignore template |
| Homebrew | `homebrew/Brewfile` | macOS package management |

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

### Modern CLI Tools:
- **bat** - `cat` with syntax highlighting and git integration
- **ripgrep** - `grep` that's faster and more user-friendly
- **fd** - `find` alternative that's simpler and faster
- **fzf** - fuzzy finder for files, commands, and history
- **eza** - `ls` replacement with git status and icons
- **delta** - enhanced git diffs with syntax highlighting

## Advanced Usage

### Homebrew Bundle (macOS)
Install all recommended tools at once:
```bash
brew bundle --file=~/.dotfiles/homebrew/Brewfile
```

### VS Code Setup
Install recommended extensions:
```bash
cat ~/.dotfiles/vscode/extensions.txt | xargs -L 1 code --install-extension
```

### Tmux Plugins
After installation, install tmux plugins:
```bash
# In tmux, press prefix + I (usually Ctrl-a + I)
# Or run:
~/.tmux/plugins/tpm/bin/install_plugins
```

### FZF Key Bindings
- `Ctrl-T` - Find files
- `Ctrl-R` - Search command history
- `Alt-C` - Change directory

### Modern CLI Aliases
The configuration includes smart aliases that use modern tools when available:
- `cat` → `bat` (if installed)
- `grep` → `ripgrep` (if installed)
- `find` → `fd` (if installed)
- `ls` → `eza` (if installed)

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

## Performance & Security

### Shell Performance
- **Lazy loading** of plugins and tools
- **Optimized history** settings for large histories
- **Smart aliases** that only activate when tools are available

### Security Features
- **Safe rm/cp/mv** aliases with confirmation prompts
- **SSH configuration** with security best practices
- **Git configuration** with safe force-push (`--force-with-lease`)
- **Comprehensive .gitignore** to prevent credential leaks

### Privacy
- **Telemetry disabled** in VS Code configuration
- **No tracking** in shell or editor configurations
- **Local-first** approach - all configurations stored locally

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

**Tmux plugins not loading:**
```bash
# Plugins are installed automatically during setup
# If you need to reinstall manually:
rm -rf ~/.tmux/plugins
./install.sh  # This will reinstall tmux plugins
```

**Modern CLI tools not working:**
```bash
# Check which tools are installed
which bat rg fd fzf eza delta
# Install missing tools manually or re-run install script
```

## Uninstalling

To remove all dotfiles symlinks:
```bash
./uninstall.sh
```

This will safely remove all symlinks while preserving your original files (which were backed up during installation).

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
