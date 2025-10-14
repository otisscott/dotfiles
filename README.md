# Dotfiles

Personal development environment configuration for Zsh, Neovim, and other development tools.

## Features

- **Zsh** with Oh My Zsh, custom plugins, and project aliases
- **Neovim** with Lua configuration, lazy loading, and modern plugins
- **Tmux** for terminal multiplexing with custom keybindings
- **Git** configuration with useful aliases and sensible defaults
- **Ghostty** for macOS (optional)
- **Automated installation** script for macOS and Linux
- **Tool management** for Bun, uv, tmux, and more

## Installation

Run the installation script:

```bash
./install.sh
```

This script will:
- Detect your operating system (macOS/Linux)
- Install base dependencies (git, curl, build tools)
- Install Zsh and Oh My Zsh
- Install Neovim, Bun, uv, and Ghostty
- Create symbolic links for all configurations

## Directory Structure

```
dotfiles/
├── install.sh              # Main installation script
├── .gitignore              # Git ignore rules
├── git/                   # Git configuration
│   └── .gitconfig         # Git configuration with aliases
├── zsh/                   # Zsh configuration
│   ├── .zshrc             # Main Zsh configuration
│   └── custom/           # Custom Oh My Zsh plugins and configs
│       ├── example.zsh    # Example custom configuration
│       └── plugins/      # Custom plugins directory
├── nvim/                  # Neovim configuration
│   ├── init.lua           # Main Neovim entry point
│   └── lua/oscott/        # Neovim Lua configuration modules
│       ├── init.lua       # Core Neovim setup
│       ├── set.lua        # Neovim settings and options
│       └── lazy/          # Lazy-loaded plugin configurations
├── tmux/                  # Tmux configuration
│   └── .tmux.conf         # Tmux configuration with custom keybindings
```

## Configuration Details

### Zsh

- **Theme**: robbyrussell
- **Plugins**: git, zsh-completions, zsh-autosuggestions
- **Environment**: NVM, Bun, Linuxbrew, opencode
- **Aliases**: Quick navigation to project directories

### Neovim

- **Configuration**: Lua-based with lazy loading
- **Plugins**: LSP, Treesitter, Telescope, Color schemes
- **Key Leader**: Space bar
- **Package Manager**: Lazy.nvim

## Customization

### Adding Zsh Aliases

Edit `zsh/.zshrc` to add custom aliases:

```bash
# Add your project-specific aliases here:
alias myproject="cd ~/Projects/my-project"
alias work="cd ~/Projects/work"
```

### Git Configuration

Edit `git/.gitconfig` and update:
- `user.name` and `user.email` with your Git identity
- `github.user` with your GitHub username



### Tmux Configuration

Edit `tmux/.tmux.conf` to customize:
- Keybindings
- Status bar appearance
- Window and pane behavior

### Neovim Configuration

Edit `nvim/lua/oscott/` files to customize:
- Plugin settings
- Key mappings
- Color schemes
- LSP configurations

### Adding Neovim Plugins

Edit `nvim/lua/oscott/lazy/init.lua` to add new plugins:

```lua
require("lazy").setup({
  -- Add your plugins here
  { "plugin-name/plugin-repo" },
})
```

### Adding Custom Zsh Functions

Create files in `zsh/custom/` directory:

```bash
# custom/my-functions.zsh
function myfunc() {
  # Your custom function
}
```

## Requirements

- macOS 10.14+ or Linux (Ubuntu/Debian/Arch/Fedora)
- Git
- curl
- build-essential (Linux) or Xcode Command Line Tools (macOS)

## Tools Installed

- **Zsh**: Modern shell with Oh My Zsh
- **Neovim**: Latest version via AppImage (Linux) or brew (macOS)
- **Tmux**: Terminal multiplexer with custom keybindings
- **Git**: Version control with useful aliases and sensible defaults
- **Bun**: Fast JavaScript runtime and package manager
- **uv**: Python package and project manager
- **Ghostty**: Modern terminal emulator (macOS, optional)
- **Linuxbrew**: Package manager for Linux (if applicable)

## Dynamic Path Handling

The configuration automatically handles different system setups:

- **Homebrew paths**: Detects both Intel (`/home/linuxbrew/.linuxbrew`) and Apple Silicon (`/opt/homebrew`) installations
- **User-specific tools**: Uses `$HOME` for all user directories (`.opencode`, `.bun`, etc.)
- **Cross-platform compatibility**: Works on both macOS and Linux without hardcoded paths
- **Project aliases**: Template-based aliases that can be easily customized for any user

## Post-Installation

1. Restart your terminal or run `zsh`
2. Run `:Lazy sync` in Neovim the first time you open it
3. Configure your Git identity in `git/.gitconfig`:
   ```bash
   # Edit git/.gitconfig with your name and email
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```
4. Start a tmux session:
   ```bash
   tmux
   ```

## Additional Features

### Terminal Multiplexing
- Use `tmux` to create persistent terminal sessions
- Sessions survive reboots and disconnections
- Custom keybindings for efficient navigation

### Enhanced Git Workflow
- Pre-configured aliases for common operations
- Automatic rebase on pull
- Sensible defaults for push and pull behavior

### Cross-Platform Compatibility
- Works on macOS and Linux
- Dynamic path detection for different Homebrew installations
- User-specific paths using `$HOME` variable

### Terminal Support
- **macOS**: Ghostty (optional, installed via brew)
- **WSL2**: Wezterm (recommended, not installed by this script)

## Troubleshooting

### Symbolic Link Issues

If existing configurations are backed up with `.bak` suffix, you can remove them:

```bash
rm ~/.zshrc.bak
rm -rf ~/.oh-my-zsh/custom.bak
```

### Permission Issues

Ensure the installation script has execute permissions:

```bash
chmod +x install.sh
```

## License

MIT License - feel free to use and modify these dotfiles for your own use.