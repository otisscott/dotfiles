# ~/.zshrc

# ------------------------------------------------------------------------------
# SECTION 1: EXPORTS AND ENVIRONMENT
#
# Set essential environment variables and construct the PATH.
# Using 'typeset -U path' is a Zsh-native way to build the PATH
# that automatically removes duplicate entries.
# ------------------------------------------------------------------------------

# Use Zsh's 'typeset' to ensure the PATH array contains only unique values.
# This automatically syncs with the uppercase $PATH environment variable.
# The 'path' array is automatically initialized from the existing $PATH.
typeset -U path

# Prepend custom and high-priority directories to the existing PATH.
# This ensures your custom scripts and tools are found first, without
# losing access to standard system binaries.
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.bun/bin"
  "$HOME/.opencode/bin"
  $path # <-- THIS IS THE CRITICAL FIX: It includes the original system path.
)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# NVM Environment Variable
export NVM_DIR="$HOME/.nvm"


# ------------------------------------------------------------------------------
# SECTION 2: SHELL FRAMEWORKS (Oh My Zsh, Homebrew)
# ------------------------------------------------------------------------------

# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  opentofu
  1password
)

# Pure theme setup
if [[ "$(uname -s)" == "Darwin" ]]; then
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
  autoload -U promptinit && promptinit
  prompt pure
elif [[ -d "$HOME/.local/share/zsh/pure" ]]; then
  fpath+=("$HOME/.local/share/zsh/pure")
  autoload -U promptinit && promptinit
  prompt pure
fi

# Source Oh My Zsh itself
source "$ZSH/oh-my-zsh.sh"

# Homebrew (macOS and Linux)
if [ -d "/opt/homebrew/bin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


# ------------------------------------------------------------------------------
# SECTION 3: TOOL AND VERSION MANAGERS (NVM, Bun Completions)
# ------------------------------------------------------------------------------

# NVM (Node Version Manager)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Bun shell completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"


# ------------------------------------------------------------------------------
# SECTION 4: PERSONAL ALIASES AND FUNCTIONS
# ------------------------------------------------------------------------------

# --- Aliases ---
alias p="cd ~/Projects"

# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'

# eza (modern ls replacement) aliases
alias ls='eza --icons'        # ls
alias ll='eza -l --icons'     # ls -l
alias la='eza -la --icons'    # ls -la
alias ltree='eza --tree --level=2 --icons' # tree view

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# System aliases
alias reload='source ~/.zshrc'
alias c='clear'

# --- Custom Functions ---
function lazygit() {
    if [ -z "$1" ]; then
        echo "Error: Commit message is required."
        return 1
    fi
    git add .
    git commit -a -m "$1"
    git push
}

eval "$(atuin init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Welcome message
echo "👋 Welcome back! $(date '+%A, %B %d, %Y')"
echo "📁 Current directory: $(pwd)"
echo "🌟 Today's focus: Make it happen!"
