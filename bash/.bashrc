# -----------------------------------------------------
#    _               _
#   | |__   __ _ ___| |__  _ __ ___
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__
# (_)_.__/ \__,_|___/_| |_|_|  \___|
#
# -----------------------------------------------------

# ------------------------------
# PATH & environment
# ------------------------------
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.config/.foundry/bin" # foundry
export PATH="$HOME/.opencode/bin:$PATH"        # opencode

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

# ------------------------------
# Version managers & tool init
# ------------------------------
# nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pyenv
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# ------------------------------
# Aliases
# ------------------------------
alias kittyh='kitty --directory "$(pwd)" &'
alias tasks='nvim ~/Desktop/Tasks.txt'
alias running='systemctl list-units --type=service --state=running'
alias enabled='systemctl list-unit-files --type=service --state=enabled'
alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias enable='sudo systemctl enable'
alias disable='sudo systemctl disable'
alias status='systemctl status'

# ------------------------------
# Prompt & startup
# ------------------------------
eval "$(starship init bash)"
fastfetch

# ------------------------------
# Managed / generated — leave as-is
# ------------------------------
# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
. "$HOME/.local/share/../bin/env"
