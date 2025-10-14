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
    info "Installing build tools and utilities..."
    $PACKAGE_MANAGER_INSTALL git curl build-essential
  elif [[ "$OS" == "linux" ]]; then
    info "Updating package lists..."
    $PACKAGE_MANAGER_UPDATE 2>/dev/null || true
    info "Installing build tools and utilities..."
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
}

install_neovim() {
  info "Checking for Neovim..."
  if ! command -v nvim &> /dev/null; then
    info "Installing Neovim..."
    if [[ "$OS" == "macos" ]]; then
      $PACKAGE_MANAGER_INSTALL neovim
    elif [[ "$OS" == "linux" ]]; then
      # Use the AppImage for the latest version on Linux
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

install_ghostty() {
  info "Checking for Ghostty..."
  if ! command -v ghostty &> /dev/null; then
    info "Installing Ghostty..."
    if [[ "$OS" == "macos" ]]; then
      $PACKAGE_MANAGER_INSTALL ghostty
    elif [[ "$OS" == "linux" ]]; then
      info "Ghostty is typically used on macOS. For Linux/WSL2, you can use Wezterm or other terminals."
    fi
  else
    success "Ghostty is already installed."
  fi
}





# --- Symbolic Link Setup ---
setup_symlinks() {
  info "Setting up symbolic links for configurations..."
  # Get the absolute path of the dotfiles directory
  DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

  # Helper for creating symlinks
  link() {
    local src=$1
    local dst=$2
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$dst")"
    # Back up existing file/directory
    if [ -e "$dst" ] || [ -L "$dst" ]; then
      info "Backing up existing config at $dst"
      mv "$dst" "$dst.bak"
    fi
    info "Linking $src to $dst"
    ln -s "$src" "$dst"
  }

  # Neovim
  link "${DOTFILES_DIR}/nvim" "${HOME}/.config/nvim"

  # Zsh and Oh My Zsh
  link "${DOTFILES_DIR}/zsh/.zshrc" "${HOME}/.zshrc"
  link "${DOTFILES_DIR}/zsh/custom" "${HOME}/.oh-my-zsh/custom"

  # Git
  link "${DOTFILES_DIR}/git/.gitconfig" "${HOME}/.gitconfig"

  # Tmux
  link "${DOTFILES_DIR}/tmux/.tmux.conf" "${HOME}/.tmux.conf"

  

  

  success "Symbolic links created."
}

# --- Main Execution ---
main() {
  # Ask for the administrator password upfront
  info "Sudo password may be required for installation."
  sudo -v

  detect_os
  install_dependencies
  install_zsh_and_omz
  install_neovim
  install_bun
  install_uv
  install_tmux
  install_ghostty
  setup_symlinks

  success "Dotfiles setup complete!"
  info "Please restart your terminal or run 'zsh' for changes to take effect."
  info "You may need to run ':Lazy sync' the first time you open Neovim."
  info "Run 'tmux' to start a new tmux session."
}

# Run the main function
main
