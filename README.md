# Dotfiles

Personal development environment configuration for Zsh, Neovim, and other development tools.

## Features

- **Zsh** with Oh My Zsh, custom plugins, aliases, and welcome message
- **Neovim** with comprehensive Lua configuration, modern plugins, and LSP support
- **AeroSpace** window manager for macOS with vim-style navigation
- **1Password** CLI integration for SSH and credential management
- **Ghostty** terminal emulator with Tokyo Night theme and opacity
- **Zed** editor with Z.ai API integration for AI assistance
- **Git** configuration with useful aliases and sensible defaults
- **Automated installation** script for macOS and Linux
- **Comprehensive tool management** for development productivity

## Installation

Run the installation script:

```bash
./install.sh
```

This script will:
- Detect your operating system (macOS/Linux)
- Install base dependencies (git, curl, build tools)
- Install Zsh and Oh My Zsh with custom plugins
- Install Neovim with comprehensive plugin suite
- Install AeroSpace window manager (macOS)
- Install 1Password with SSH integration
- Install Ghostty terminal emulator
- Install development tools: fzf, GitHub CLI, Docker, Maccy
- Install utility tools: ripgrep, fd, eza, fastfetch
- Create symbolic links for all configurations
- Set up Z.ai API key for Zed (macOS)
- Add useful aliases and welcome message to shell

## Directory Structure

```
dotfiles/
├── install.sh              # Main installation script
├── .gitignore              # Git ignore rules
├── git/                   # Git configuration
│   └── .gitconfig         # Git configuration with aliases
├── zsh/                   # Zsh configuration
│   └── .zshrc             # Main Zsh configuration with aliases
├── nvim/                  # Neovim configuration
│   ├── init.lua           # Main Neovim entry point
│   ├── lazy-lock.json     # Plugin lock file
│   └── lua/oscott/        # Neovim Lua configuration modules
│       ├── init.lua       # Core Neovim setup
│       ├── set.lua        # Neovim settings and options
│       ├── lazy_init.lua  # Lazy.nvim configuration
│       └── lazy/          # Lazy-loaded plugin configurations
│           ├── init.lua   # Plugin list
│           ├── lsp.lua    # LSP configuration
│           ├── telescope.lua # Fuzzy finder
│           ├── treesitter.lua # Syntax highlighting
│           ├── colorscheme.lua # Theme configuration
│           ├── nvim-tree.lua # File explorer
│           ├── bufferline.lua # Buffer management
│           ├── lualine.lua # Status line
│           ├── indent-blankline.lua # Indentation guides
│           ├── which-key.lua # Keybinding helper
│           ├── autopairs.lua # Auto-close brackets
│           ├── comment.lua # Smart commenting
│           ├── gitsigns.lua # Git integration
│           ├── todo-comments.lua # TODO highlighting
│           ├── trouble.lua # LSP diagnostics
│           └── notify.lua # Notifications
├── ghostty/               # Ghostty terminal configuration
│   └── config             # Ghostty config with Tokyo Night theme
├── aerospace/             # AeroSpace window manager config
│   └── .aerospace.toml    # AeroSpace configuration with vim-style navigation
├── zed/                   # Zed editor configuration
│   └── config.json        # Zed config with Z.ai API integration
└── bin/                   # Custom scripts (created during install)
    └── update-all         # Update script for all tools
```

## Configuration Details

### Zsh

- **Theme**: robbyrussell
- **Plugins**: git, zsh-completions, zsh-autosuggestions
- **Aliases**: Navigation (`..`, `...`), Git shortcuts (`gs`, `ga`, `gc`, `gp`, `gl`), System (`reload`, `clear`)
- **Enhanced listings**: `ll` and `la` with eza and git info
- **Welcome message**: Motivational startup message with date
- **1Password SSH integration**: Automatic SSH agent setup

### Neovim

- **Configuration**: Lua-based with lazy loading
- **Theme**: Tokyo Night with transparency
- **Key Leader**: Space bar with which-key integration
- **Package Manager**: Lazy.nvim
- **Core Features**:
  - **LSP**: TypeScript, Python, Lua, JSON with auto-completion
  - **File Explorer**: nvim-tree with git integration
  - **Fuzzy Finding**: Telescope with file search and live grep
  - **Syntax Highlighting**: Treesitter for multiple languages
  - **Buffer Management**: bufferline.nvim with tab-like navigation
  - **Status Line**: lualine.nvim with git status and diagnostics
  - **Git Integration**: gitsigns.nvim with hunk staging
  - **Smart Commenting**: Comment.nvim with toggle functionality
  - **Auto Pairs**: nvim-autopairs for bracket/quote completion
  - **TODO Highlighting**: todo-comments.nvim for task tracking
  - **Diagnostics**: trouble.nvim for LSP error management

### AeroSpace (macOS)

- **Window Management**: Tiling window manager with vim-style navigation
- **Keybindings**: Alt+HJKL for navigation, Alt+1-9,A-Z for workspaces
- **App Rules**: Floating for system apps, tiling for development tools
- **Integration**: Ghostty terminal launcher with Alt+Enter
- **Auto-start**: Configured to start at login

### Ghostty Terminal

- **Theme**: Tokyo Night with 0.9 opacity
- **Font**: Typestar for consistent typography
- **Features**: Clean window styling, shell integration, GPU acceleration

### Zed Editor

- **AI Integration**: Z.ai API support with GLM models
- **Configuration**: Environment variable for API key security
- **Models**: GLM-4.6 and GLM-4.5 Air available

### 1Password

- **CLI Integration**: op command-line tool
- **SSH Agent**: Automatic SSH key management
- **Cross-platform**: Full app on macOS, CLI on Linux

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

### Development Tools
- **Neovim**: Latest version with comprehensive plugin suite
- **Zed**: Modern editor with AI integration
- **GitHub CLI**: gh for enhanced git workflow
- **Docker**: Container management (Desktop on macOS, native on Linux)

### Terminal & Shell
- **Zsh**: Modern shell with Oh My Zsh and custom plugins
- **Ghostty**: Modern terminal emulator with Tokyo Night theme
- **fzf**: Fuzzy finder with shell integration
- **1Password**: Password manager with CLI and SSH integration

### Window Management (macOS)
- **AeroSpace**: Tiling window manager with vim-style navigation
- **Maccy**: Clipboard manager with history

### Utility Tools
- **Git**: Version control with useful aliases
- **ripgrep**: Fast text search (rg)
- **fd**: Fast file finder
- **eza**: Modern ls replacement

- **fastfetch**: System information display
- **Bun**: Fast JavaScript runtime and package manager
- **uv**: Python package and project manager

## Dynamic Path Handling

The configuration automatically handles different system setups:

- **Homebrew paths**: Detects both Intel (`/home/linuxbrew/.linuxbrew`) and Apple Silicon (`/opt/homebrew`) installations
- **User-specific tools**: Uses `$HOME` for all user directories (`.opencode`, `.bun`, etc.)
- **Cross-platform compatibility**: Works on both macOS and Linux without hardcoded paths
- **Project aliases**: Template-based aliases that can be easily customized for any user

## Post-Installation

1. **Restart your terminal** or run `exec zsh` to apply shell changes
2. **Neovim setup**: Run `:Lazy sync` in Neovim the first time you open it
3. **Git configuration**: Update your Git identity in `git/.gitconfig`:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```
4. **1Password setup** (if installed):
   ```bash
   # Sign in to 1Password
   op account add
   # Add SSH keys to 1Password
   # Start SSH agent
   eval $(op ssh agent --)
   ```
5. **GitHub CLI setup** (if installed):
   ```bash
   gh auth login
   ```
6. **Zed AI setup** (macOS): If you entered a Z.ai API key during installation, Zed is ready to use AI features
7. **AeroSpace** (macOS): Log out and back in, or run `aerospace restart` to start using the window manager

## Quick Start Commands

### Shell Aliases
```bash
ll          # Enhanced directory listing
la          # Show all files including hidden
gs          # Git status
ga .        # Add all files
gc          # Git commit
gp          # Git push
reload      # Reload shell configuration
update-all  # Update all installed tools
```

### Neovim Keybindings
```bash
<leader>ff  # Find files
<leader>fg  # Git files
<leader>fl  # Live grep
<leader>e   # Toggle file explorer
<leader>/   # Toggle comment
<Tab>       # Next buffer
<S-Tab>     # Previous buffer
```

### AeroSpace (macOS)
```bash
Alt+h/j/k/l # Navigate windows
Alt+1-9     # Switch workspaces
Alt+Enter   # Open Ghostty terminal
Alt+Shift+; # Enter service mode
```

## Additional Features

### Enhanced Development Workflow
- **AI-powered coding**: Zed with Z.ai integration for intelligent assistance
- **Efficient navigation**: AeroSpace window manager with vim-style controls
- **Smart terminal**: Ghostty with modern features and beautiful theming
- **Fuzzy finding**: fzf integration for quick file and command search
- **Git productivity**: GitHub CLI for enhanced repository management

### Security & Credential Management
- **1Password integration**: Secure password and SSH key management
- **SSH agent**: Automatic key management through 1Password
- **API key security**: Environment variable storage for sensitive keys

### Cross-Platform Compatibility
- Works on macOS and Linux
- Dynamic path detection for different Homebrew installations
- User-specific paths using `$HOME` variable
- Platform-specific optimizations (AeroSpace on macOS, Docker variations)

### Terminal Experience
- **macOS**: Ghostty with Tokyo Night theme and transparency
- **Linux**: Full 1Password CLI integration
- **Universal**: Consistent aliases and tools across platforms

### Productivity Enhancements
- **Welcome message**: Motivational startup with current date
- **Quick updates**: Single command to update all tools
- **Smart aliases**: Navigation, git, and system shortcuts
- **Visual feedback**: Rich notifications and status indicators

## Troubleshooting

### Symbolic Link Issues

The installation script removes existing configurations before creating symlinks. If you need to restore any manually moved files:

```bash
# Check if you have any backed up files
ls -la ~ | grep "\.bak"
```

### Permission Issues

Ensure the installation script has execute permissions:

```bash
chmod +x install.sh
```

### Neovim Issues

If plugins don't load correctly:

```bash
# In Neovim, run:
:Lazy sync
:checkhealth
```

### 1Password SSH Issues

If SSH agent isn't working:

```bash
# Check if agent is running
op ssh agent --status
# Start the agent
eval $(op ssh agent --)
```

### AeroSpace Issues (macOS)

If AeroSpace doesn't start automatically:

```bash
# Enable start at login
aerospace start-at-login enable
# Restart AeroSpace
aerospace restart
```

### Ghostty Configuration

If Ghostty shows configuration errors:

```bash
# Check Ghostty config path
ghostty --config-dir
# Validate configuration
ghostty --config
```

### Docker Issues (Linux)

If Docker requires sudo:

```bash
# Add user to docker group
sudo usermod -aG docker $USER
# Log out and back in to apply changes
```

## License

MIT License - feel free to use and modify these dotfiles for your own use.