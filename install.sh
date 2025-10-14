#!/bin/bash
#
# Dotfiles Install Script
#
# This script installs essential development tools and sets up configurations
# from this repository for both macOS and Linux systems.

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Helper Functions for Logging ---
info() {
  # Blue text
  echo -e "\033[1;34m[INFO]\033[0m $1"
}

success() {
  # Green text
  echo -e "\033[1;32m[SUCCESS]\033[0m $1"
}

warn() {
  # Yellow text
  echo -e "\033[1;33m[WARN]\033[0m $1"
}

error() {
  # Red text
  echo -e "\033[1;31m[ERROR]\033[0m $1"
  exit 1
}

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
      elif [ -f /etc/arch-release ]; then
        PACKAGE_MANAGER_INSTALL="sudo pacman -Syu --noconfirm"
      elif [ -f /etc/fedora-release ]; then
        PACKAGE_MANAGER_INSTALL="sudo dnf install -y"
      else
        error "Unsupported Linux distribution. Please install dependencies manually."
      fi
      ;;
    *)
      error "Unsupported operating system: $(uname -s)"
      ;;
  esac
  success "System detected: $OS"
}

# --- Prerequisite Installation ---
install_dependencies() {
  info "Installing base dependencies..."

  if [[ "$OS" == "macos" ]]; then
    if ! command -v brew &> /dev/null; then
      info "Homebrew not found. Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    info "Updating Homebrew..."
    $PACKAGE_MANAGER_UPDATE
    info "Installing utilities for macOS..."
    $PACKAGE_MANAGER_INSTALL git curl
  elif [[ "$OS" == "linux" ]]; then
    info "Updating package lists..."
    $PACKAGE_MANAGER_UPDATE 2>/dev/null || true
    info "Installing build tools and utilities for Linux..."
    $PACKAGE_MANAGER_INSTALL build-essential git curl file procps
  fi
  success "Base dependencies installed."
}

# --- Tool-Specific Installers ---

install_zsh_and_omz() {
  info "Checking for Zsh..."
  if ! command -v zsh &> /dev/null; then
    info "Installing Zsh..."
    $PACKAGE_MANAGER_INSTALL zsh
  else
    success "Zsh is already installed."
  fi

  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    success "Oh My Zsh is already installed."
  fi

  info "Installing custom Zsh plugins..."
  local custom_plugins_dir="${HOME}/dotfiles/zsh/custom/plugins"
  mkdir -p "$custom_plugins_dir"

  if [ ! -d "${custom_plugins_dir}/zsh-autosuggestions" ]; then
    info "Cloning zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "${custom_plugins_dir}/zsh-autosuggestions"
  else
    success "zsh-autosuggestions already installed."
  fi

  if [ ! -d "${custom_plugins_dir}/zsh-completions" ]; then
    info "Cloning zsh-completions..."
    git clone https://github.com/zsh-users/zsh-completions "${custom_plugins_dir}/zsh-completions"
  else
    success "zsh-completions already installed."
  fi
}

install_neovim() {
  info "Checking for Neovim..."
  if ! command -v nvim &> /dev/null; then
    info "Installing Neovim..."
    if [[ "$OS" == "macos" ]]; then
      $PACKAGE_MANAGER_INSTALL neovim
    elif [[ "$OS" == "linux" ]]; then
      curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
      chmod u+x nvim.appimage
      sudo mv nvim.appimage /usr/local/bin/nvim
    fi
  else
    success "Neovim is already installed."
  fi
}

install_bun() {
  info "Checking for Bun..."
  if ! command -v bun &> /dev/null; then
    info "Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
  else
    success "Bun is already installed."
  fi
}

install_uv() {
  info "Checking for uv..."
  if ! command -v uv &> /dev/null; then
    info "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
  else
    success "uv is already installed."
  fi
}

install_tmux() {
  info "Checking for Tmux..."
  if ! command -v tmux &> /dev/null; then
    info "Installing Tmux..."
    $PACKAGE_MANAGER_INSTALL tmux
  else
    success "Tmux is already installed."
  fi
}

# --- NEW FUNCTION ---
install_fastfetch() {
  info "Checking for fastfetch..."
  if ! command -v fastfetch &> /dev/null; then
    info "Installing fastfetch..."
    $PACKAGE_MANAGER_INSTALL fastfetch
  else
    success "fastfetch is already installed."
  fi
}
# --- END NEW FUNCTION ---

install_ghostty() {
  info "Checking for Ghostty..."
  if ! command -v ghostty &> /dev/null; then
    info "Installing Ghostty..."
    if [[ "$OS" == "macos" ]]; then
      $PACKAGE_MANAGER_INSTALL ghostty
    elif [[ "$OS" == "linux" ]]; then
      GHOSTTY_URL=$(curl -s "https://api.github.com/repos/ghostty-org/ghostty/releases/latest" | grep "browser_download_url.*-linux-x86_64.tar.gz" | cut -d : -f 2,3 | tr -d \")
      curl -LO "$GHOSTTY_URL"
      tar -xzf ghostty-linux-x86_64.tar.gz
      sudo mv ghostty /usr/local/bin/
      /usr/local/bin/ghostty --install-desktop-files
      rm ghostty-linux-x86_64.tar.gz
    fi
  else
    success "Ghostty is already installed."
  fi
}

install_zed() {
  info "Checking for Zed..."
  if ! command -v zed &> /dev/null; then
    info "Installing Zed..."
    if [[ "$OS" == "macos" ]]; then
      curl -fsSL https://zed.dev/install.sh | sh
    elif [[ "$OS" == "linux" ]]; then
      info "Zed installation for Linux requires manual setup. Please visit https://zed.dev for instructions."
    fi
  else
    success "Zed is already installed."
  fi
}

# --- Symbolic Link Setup ---
setup_symlinks() {
  info "Setting up symbolic links for configurations..."
  DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

  link() {
    local src=$1
    local dst=$2
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
      info "Backing up existing config at $dst"
      mv "$dst" "$dst.bak" 2>/dev/null || true
    fi
    info "Linking $src to $dst"
    ln -s "$src" "$dst"
  }

  link "${DOTFILES_DIR}/nvim" "${HOME}/.config/nvim"
  link "${DOTFILES_DIR}/zsh/.zshrc" "${HOME}/.zshrc"
  link "${DOTFILES_DIR}/zsh/custom" "${HOME}/.oh-my-zsh/custom"
  link "${DOTFILES_DIR}/git/.gitconfig" "${HOME}/.gitconfig"
  link "${DOTFILES_DIR}/tmux/.tmux.conf" "${HOME}/.tmux.conf"
  link "${DOTFILES_DIR}/ghostty/config" "${HOME}/.config/ghostty/config"
  link "${DOTFILES_DIR}/zed/config.json" "${HOME}/.config/zed/config.json"

  success "Symbolic links created."

  info "Fixing Zsh directory permissions for completion..."
  if command -v zsh &> /dev/null; then
    zsh -c "compaudit | xargs chmod g-w,o-w" || true
    success "Zsh permissions fixed."
  fi
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
  install_tmux
  install_fastfetch # <-- ADDED CALL
  install_ghostty
  install_zed
  setup_symlinks

  success "Dotfiles setup complete!"
  info "Please restart your terminal or run 'zsh' for changes to take effect."
}

# Run the main function
main