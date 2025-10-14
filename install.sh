#!/bin/bash
#
# Dotfiles Install Script

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Helper Functions for Logging ---
info() { echo -e "\033[1;34m[INFO]\033[0m $1"; }
success() { echo -e "\033[1;32m[SUCCESS]\033[0m $1"; }
error() { echo -e "\033[1;31m[ERROR]\033[0m $1"; exit 1; }

# --- OS Detection and Package Manager Setup ---
OS=""
PACKAGE_MANAGER_INSTALL=""
PACKAGE_MANAGER_UPDATE=""

detect_os() {
  info "Detecting operating system..."
  case "$(uname -s)" in
    Darwin)
      OS="macos"
      PACKAGE_MANAGER_INSTALL="brew install"
      PACKAGE_MANAGER_UPDATE="brew update"
      ;;
    Linux)
      OS="linux"
      if [ -f /etc/debian_version ]; then
        PACKAGE_MANAGER_INSTALL="sudo apt-get install -y"
        PACKAGE_MANAGER_UPDATE="sudo apt-get update"
      # Add other linux distros here if needed
      else
        error "Unsupported Linux distribution."
      fi
      ;;
    *) error "Unsupported operating system: $(uname -s)" ;;
  esac
  success "System detected: $OS"
}

# --- Prerequisite Installation ---
install_dependencies() {
  info "Installing base dependencies..."
  if [[ "$OS" == "macos" ]]; then
    if ! command -v brew &> /dev/null; then
      info "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    info "Updating Homebrew..."
    $PACKAGE_MANAGER_UPDATE
    $PACKAGE_MANAGER_INSTALL git curl
  elif [[ "$OS" == "linux" ]]; then
    $PACKAGE_MANAGER_UPDATE 2>/dev/null || true
    $PACKAGE_MANAGER_INSTALL build-essential git curl file procps
  fi
  success "Base dependencies installed."
}

# --- Tool-Specific Installers ---

install_zsh_and_omz() {
  info "Checking for Zsh..."
  if ! command -v zsh &> /dev/null; then $PACKAGE_MANAGER_INSTALL zsh; else success "Zsh is already installed."; fi
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    success "Oh My Zsh is already installed."
  fi
  info "Installing Pure theme..."
  if [[ "$OS" == "macos" ]]; then
    if ! brew list pure &> /dev/null; then
      $PACKAGE_MANAGER_INSTALL pure
      success "Pure theme installed."
    else
      success "Pure theme is already installed."
    fi
  elif [[ "$OS" == "linux" ]]; then
    if [ ! -d "${HOME}/.local/share/zsh/pure" ]; then
      mkdir -p "${HOME}/.local/share/zsh"
      git clone https://github.com/sindresorhus/pure.git "${HOME}/.local/share/zsh/pure"
      success "Pure theme installed."
    else
      success "Pure theme is already installed."
    fi
  fi
  info "Installing custom Zsh plugins..."
  local custom_plugins_dir="${HOME}/dotfiles/zsh/custom/plugins"
  mkdir -p "$custom_plugins_dir"
  if [ ! -d "${custom_plugins_dir}/zsh-autosuggestions" ]; then git clone https://github.com/zsh-users/zsh-autosuggestions "${custom_plugins_dir}/zsh-autosuggestions"; else success "zsh-autosuggestions already installed."; fi
  if [ ! -d "${custom_plugins_dir}/zsh-completions" ]; then git clone https://github.com/zsh-users/zsh-completions "${custom_plugins_dir}/zsh-completions"; else success "zsh-completions already installed."; fi
}

install_neovim() {
  if ! command -v nvim &> /dev/null; then
    info "Installing Neovim..."
    if [[ "$OS" == "macos" ]]; then $PACKAGE_MANAGER_INSTALL neovim;
    elif [[ "$OS" == "linux" ]]; then
      curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
      chmod u+x nvim.appimage && sudo mv nvim.appimage /usr/local/bin/nvim; fi
  else success "Neovim is already installed."; fi
}

install_bun() { if ! command -v bun &> /dev/null; then info "Installing Bun..."; curl -fsSL https://bun.sh/install | bash; else success "Bun is already installed."; fi; }
install_uv() { if ! command -v uv &> /dev/null; then info "Installing uv..."; curl -LsSf https://astral.sh/uv/install.sh | sh; else success "uv is already installed."; fi; }
install_fastfetch() { if ! command -v fastfetch &> /dev/null; then info "Installing fastfetch..."; $PACKAGE_MANAGER_INSTALL fastfetch; else success "fastfetch is already installed."; fi; }
install_ripgrep() { if ! command -v rg &> /dev/null; then info "Installing ripgrep..."; $PACKAGE_MANAGER_INSTALL ripgrep; else success "ripgrep is already installed."; fi; }
install_fd() { if ! command -v fd &> /dev/null; then info "Installing fd..."; $PACKAGE_MANAGER_INSTALL fd; else success "fd is already installed."; fi; }
install_eza() { if ! command -v eza &> /dev/null; then info "Installing eza..."; $PACKAGE_MANAGER_INSTALL eza; else success "eza is already installed."; fi; }
install_atuin() { if ! command -v atuin &> /dev/null; then info "Installing atuin..."; $PACKAGE_MANAGER_INSTALL atuin; else success "atuin is already installed."; fi; }

install_ghostty() {
  if ! command -v ghostty &> /dev/null; then
    info "Installing Ghostty..."
    if [[ "$OS" == "macos" ]]; then $PACKAGE_MANAGER_INSTALL ghostty;
    elif [[ "$OS" == "linux" ]]; then
      GHOSTTY_URL=$(curl -s "https://api.github.com/repos/ghostty-org/ghostty/releases/latest" | grep "browser_download_url.*-linux-x86_64.tar.gz" | cut -d : -f 2,3 | tr -d \")
      curl -LO "$GHOSTTY_URL" && tar -xzf ghostty-linux-x86_64.tar.gz && sudo mv ghostty /usr/local/bin/
      /usr/local/bin/ghostty --install-desktop-files && rm ghostty-linux-x86_64.tar.gz; fi
  else success "Ghostty is already installed."; fi
}

install_aerospace() {
  if [[ "$OS" == "macos" ]]; then
    if ! command -v aerospace &> /dev/null; then
      info "Installing AeroSpace..."
      brew install --cask nikitabobko/tap/aerospace
      success "AeroSpace installed."
    else
      success "AeroSpace is already installed."
    fi
  else
    info "AeroSpace is macOS-only, skipping installation."
  fi
}

install_1password() {
  if [[ "$OS" == "macos" ]]; then
    if ! command -v 1password &> /dev/null || [ ! -d "/Applications/1Password.app" ]; then
      info "Installing 1Password..."
      brew install --cask 1password || {
        info "1Password installation failed, but it might already be installed. Continuing..."
      }
      success "1Password installation completed."
    else
      success "1Password is already installed."
    fi
  elif [[ "$OS" == "linux" ]]; then
    if ! command -v op &> /dev/null; then
      info "Installing 1Password CLI for Linux..."
      curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --yes --output /usr/share/keyrings/1password-archive-keyring.gpg
      echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
      sudo mkdir -p /etc/debsig/keyrings/requests
      sudo gpg --dearmor --yes --output /etc/debsig/keyrings/requests.gpg /usr/share/keyrings/1password-archive-keyring.gpg
      echo 'deb [arch=amd64 signed-by=/etc/debsig/keyrings/requests.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
      sudo apt-get update && sudo apt-get install -y 1password-cli
      success "1Password CLI installed."
    else
      success "1Password CLI is already installed."
    fi
  fi
}

install_fzf() {
  if ! command -v fzf &> /dev/null; then
    info "Installing fzf..."
    $PACKAGE_MANAGER_INSTALL fzf
    if [[ "$OS" == "macos" ]]; then
      $(brew --prefix)/opt/fzf/install --all
    fi
    success "fzf installed."
  else
    success "fzf is already installed."
  fi
}

install_gh() {
  if ! command -v gh &> /dev/null; then
    info "Installing GitHub CLI..."
    if [[ "$OS" == "macos" ]]; then
      brew install gh
    elif [[ "$OS" == "linux" ]]; then
      curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
      sudo apt-get update && sudo apt-get install -y gh
    fi
    success "GitHub CLI installed."
  else
    success "GitHub CLI is already installed."
  fi
}

install_docker() {
  if [[ "$OS" == "macos" ]]; then
    if ! command -v docker &> /dev/null; then
      info "Installing Docker Desktop..."
      brew install --cask docker
      success "Docker Desktop installed."
    else
      success "Docker Desktop is already installed."
    fi
  elif [[ "$OS" == "linux" ]]; then
    if ! command -v docker &> /dev/null; then
      info "Installing Docker..."
      curl -fsSL https://get.docker.com -o get-docker.sh
      sudo sh get-docker.sh
      sudo usermod -aG docker $USER
      rm get-docker.sh
      success "Docker installed. You may need to log out and back in to use docker without sudo."
    else
      success "Docker is already installed."
    fi
  fi
}

install_clipboard() {
  if [[ "$OS" == "macos" ]]; then
    if ! command -v maccy &> /dev/null; then
      info "Installing Maccy (clipboard manager)..."
      brew install --cask maccy
      success "Maccy installed."
    else
      success "Maccy is already installed."
    fi
  fi
}

install_raycast() {
  if [[ "$OS" == "macos" ]]; then
    if [ ! -d "/Applications/Raycast.app" ]; then
      info "Installing Raycast..."
      brew install --cask raycast
      success "Raycast installed."
    else
      success "Raycast is already installed."
    fi
  else
    info "Raycast is macOS-only, skipping installation."
  fi
}

# --- OS Specific Configurations ---
configure_macos() {
  if [[ "$OS" == "macos" ]]; then
    info "Applying macOS-specific configurations..."
    # Finder
    defaults write com.apple.finder AppleShowAllFiles -bool true
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder _FXSortFoldersFirst -bool true
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    # Keyboard
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    # Screenshots
    mkdir -p "${HOME}/Screenshots"
    defaults write com.apple.screencapture location -string "${HOME}/Screenshots"
    # Apply changes
    killall Finder
    success "macOS configurations applied."
  fi
}

# --- Symbolic Link Setup ---
setup_symlinks() {
  info "Setting up symbolic links..."
  DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
  link() {
    local src=$1 dst=$2
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] || [ -L "$dst" ]; then 
      rm "$dst" 2>/dev/null || true
    fi
    ln -s "$src" "$dst" || error "Failed to create symlink: $dst -> $src"
  }
  link "${DOTFILES_DIR}/nvim" "${HOME}/.config/nvim"
  link "${DOTFILES_DIR}/zsh/.zshrc" "${HOME}/.zshrc"
  link "${DOTFILES_DIR}/zsh/custom" "${HOME}/.oh-my-zsh/custom"
  link "${DOTFILES_DIR}/git/.gitconfig" "${HOME}/.gitconfig"
  link "${DOTFILES_DIR}/aerospace/.aerospace.toml" "${HOME}/.aerospace.toml"
  success "Symbolic links created."
  info "Fixing Zsh directory permissions..."
  if command -v zsh &> /dev/null; then
    zsh -c "autoload -U compinit && compinit; compaudit | xargs chmod g-w,o-w" || true
    success "Zsh permissions fixed."
  fi
}

# --- Post-install Configuration ---
configure_aerospace() {
  if [[ "$OS" == "macos" ]] && command -v aerospace &> /dev/null; then
    info "Configuring AeroSpace to start at login..."
    aerospace start-at-login
    success "AeroSpace configured to start at login."
  fi
}

configure_zed_api_key() {
  if [[ "$OS" == "macos" ]]; then
    info "Setting up Z.ai API key for Zed..."
    echo ""
    read -p "Enter your Z.ai API key (press Enter to skip): " ZAI_API_KEY
    
    if [[ -n "$ZAI_API_KEY" ]]; then
      # Check if ANTHROPIC_API_KEY is already in .zshrc
      if ! grep -q "ANTHROPIC_API_KEY" "${HOME}/.zshrc" 2>/dev/null; then
        echo "" >> "${HOME}/.zshrc"
        echo "# Z.ai API key for Zed" >> "${HOME}/.zshrc"
        echo "export ANTHROPIC_API_KEY=\"$ZAI_API_KEY\"" >> "${HOME}/.zshrc"
        success "Z.ai API key added to ~/.zshrc"
      else
        # Update existing ANTHROPIC_API_KEY
        sed -i.tmp "s/export ANTHROPIC_API_KEY=.*/export ANTHROPIC_API_KEY=\"$ZAI_API_KEY\"/" "${HOME}/.zshrc"
        rm "${HOME}/.zshrc.tmp" 2>/dev/null || true
        success "Z.ai API key updated in ~/.zshrc"
      fi
      echo "  - Restart your terminal or run 'source ~/.zshrc' to apply"
    else
      info "Skipping Z.ai API key setup"
    fi
  fi
}

configure_zsh_enhancements() {
  info "Adding aliases and enhancements to .zshrc..."
  
  # Add aliases if not already present
  if ! grep -q "# Navigation aliases" "${HOME}/.zshrc" 2>/dev/null; then
    cat >> "${HOME}/.zshrc" << 'EOF'

# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ll='eza -la --git'
alias la='eza -la --git --all'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# System aliases
alias reload='source ~/.zshrc'
alias c='clear'
EOF
    success "Aliases added to ~/.zshrc"
  else
    success "Aliases already exist in ~/.zshrc"
  fi
  
  # Add welcome message if not already present
  if ! grep -q "# Welcome message" "${HOME}/.zshrc" 2>/dev/null; then
    cat >> "${HOME}/.zshrc" << 'EOF'

# Welcome message
echo "👋 Welcome back! $(date '+%A, %B %d, %Y')"
echo "📁 Current directory: $(pwd)"
echo "🌟 Today's focus: Make it happen!"
EOF
    success "Welcome message added to ~/.zshrc"
  else
    success "Welcome message already exists in ~/.zshrc"
  fi
}

create_update_script() {
  info "Creating update script..."
  mkdir -p "${HOME}/bin"
  cat > "${HOME}/bin/update-all" << 'EOF'
#!/bin/bash
echo "🔄 Updating everything..."
if command -v brew &> /dev/null; then
  echo "Updating Homebrew packages..."
  brew update && brew upgrade
fi
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Updating Oh My Zsh..."
  omz update
fi
echo "✅ All updated!"
EOF
  chmod +x "${HOME}/bin/update-all"
  
  # Add bin to PATH if not already there
  if ! grep -q "${HOME}/bin" "${HOME}/.zshrc" 2>/dev/null; then
    echo "" >> "${HOME}/.zshrc"
    echo "# Add local bin to PATH" >> "${HOME}/.zshrc"
    echo "export PATH=\"${HOME}/bin:\$PATH\"" >> "${HOME}/.zshrc"
  fi
  
  success "Update script created at ~/bin/update-all"
}

configure_1password_ssh() {
  if command -v op &> /dev/null; then
    info "Setting up 1Password SSH integration..."
    
    # Create SSH directory if it doesn't exist
    mkdir -p "${HOME}/.ssh"
    
    # Add 1Password SSH agent to SSH config if not already present
    if ! grep -q "IdentityAgent" "${HOME}/.ssh/config" 2>/dev/null; then
      cat >> "${HOME}/.ssh/config" << EOF

# 1Password SSH integration
Host *
  IdentityAgent ~/.1password/agent.sock
EOF
      success "1Password SSH agent configured in ~/.ssh/config"
    fi
    
    # Set up SSH socket symlink for 1Password
    mkdir -p "${HOME}/.1password"
    ln -sf "/var/run/com.apple.security.keychain/1password/agent.sock" "${HOME}/.1password/agent.sock" 2>/dev/null || true
    
    info "To complete 1Password SSH setup:"
    echo "  1. Sign in to 1Password: op account add"
    echo "  2. Add SSH keys to 1Password"
    echo "  3. Start SSH agent: eval \$(op ssh agent --)"
    echo "  4. Add to shell: echo 'eval \$(op ssh agent --)' >> ~/.zshrc"
  fi
}

# --- Cleanup ---
cleanup() {
  info "Cleaning up temporary files..."
  # Remove any downloaded AppImages or archives
  rm -f nvim.appimage ghostty-linux-x86_64.tar.gz 2>/dev/null || true
  success "Cleanup complete."
}

# --- Main Execution ---
main() {
  info "Sudo password may be required for installation."
  sudo -v
  detect_os
  install_dependencies
  install_zsh_and_omz
  install_neovim
  install_bun
  install_uv
  install_fastfetch
  install_ghostty
  install_aerospace
  install_1password
  install_fzf
  install_gh
  install_docker
  install_clipboard
  install_raycast
  install_ripgrep
  install_fd
  install_eza
  install_atuin
  setup_symlinks
  configure_macos
  configure_aerospace
  configure_1password_ssh
  configure_zed_api_key
  configure_zsh_enhancements
  create_update_script
  cleanup
  success "Dotfiles setup complete!"
  info "To apply all changes, please do one of the following:"
  echo "  1. (Recommended) Close and restart your terminal."
  echo "  2. (Quick reload) Run 'exec zsh' to replace your current shell with the new configuration."
  if [[ "$OS" == "macos" ]]; then
    echo ""
    info "AeroSpace is installed! To use it:"
    echo "  - Log out and back in, or run 'aerospace restart'"
    echo "  - Use Alt+HJKL to navigate windows"
    echo "  - Use Alt+1-9,A-Z to switch workspaces"
  fi
  
  if command -v op &> /dev/null; then
    echo ""
    info "1Password is installed! To complete SSH setup:"
    echo "  1. Sign in to 1Password: op account add"
    echo "  2. Add SSH keys to 1Password"
    echo "  3. Start SSH agent: eval \$(op ssh agent --)"
  fi
  
  if command -v fzf &> /dev/null; then
    echo ""
    info "fzf is installed! Use Ctrl+R for history search and Ctrl+T for file selection"
  fi
  
  if command -v gh &> /dev/null; then
    echo ""
    info "GitHub CLI is installed! Run 'gh auth login' to authenticate"
  fi
  
   if [[ "$OS" == "macos" ]] && command -v maccy &> /dev/null; then
     echo ""
     info "Maccy (clipboard manager) is installed! Use Cmd+Shift+C to open"
   fi
   
   if [[ "$OS" == "macos" ]] && [ -d "/Applications/Raycast.app" ]; then
     echo ""
     info "Raycast is installed! Use Cmd+Space to open and create custom commands"
   fi
  
  echo ""
  info "New aliases available:"
  echo "  - ll, la: Enhanced directory listings"
  echo "  - gs, ga, gc, gp, gl: Git shortcuts"
  echo "  - reload: Reload shell configuration"
  echo "  - update-all: Update all tools (run from anywhere)"
  echo ""
  info "Run 'update-all' to keep everything up to date!"
}

main