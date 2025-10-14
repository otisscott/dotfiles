export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
	git
	zsh-completions
	zsh-autosuggestions
)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

source $ZSH/oh-my-zsh.sh

# Project Aliases - customize these for your own projects
alias p="cd ~/Projects"
# Add your project-specific aliases here:
# alias myproject="cd ~/Projects/my-project"
# alias work="cd ~/Projects/work"

# Custom Functions
function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export PATH=$PATH:/snap/bin
# Linuxbrew - check if installed and add to path if present
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -d "/opt/homebrew/bin" ]; then
  # Apple Silicon Mac Homebrew
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# opencode - use dynamic path
export PATH="$HOME/.opencode/bin:$PATH"

# bun completions - use dynamic path
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun - use dynamic paths
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
