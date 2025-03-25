setopt AUTO_CD

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="yyyy-mm-dd"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"

setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY         # Share history between all sessions.
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
setopt HIST_VERIFY           # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY        # append to history file (Default)
setopt HIST_NO_STORE         # Don't store history commands
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.

# Exports
export LANG=en_US.UTF-8
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND="fd -g"
export SSH_KEY_PATH="~/.ssh/id_rsa"
export NVM_DIR="$HOME/.nvm"
export PATH="$HOME/.local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/ssl/bin:$HOME/.npm-global/bin:$HOME/.composer/vendor/bin:vendor/bin/:$PATH"

# Program inits
eval "$(starship init zsh)" # starship
eval "$(zoxide init zsh)" # zoxide
eval "$(fzf --zsh)" # fzf
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # nvm
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh # zsh-vi-mode
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh # zsh-autosuggestions

# Import non-versioned config
if [ -f ~/.zsh-local ]; then
    source ~/.zsh-local
else
    print "404: ~/.zsh-local not found."
fi

# Aliases
alias ll="lsd -aAlGX --header"
alias c.="code ."
alias zed="nvim ~/.zshrc"
alias ned="nvim ~/.config/nvim/init.lua"
alias sed="nvim ~/.config/starship.toml"
alias src="source ~/.zshrc"
alias p="pnpm"
alias v="nvim"
alias f="fzf --preview \"bat --color=always --style=numbers --line-range=:500 {}\""
alias lg="lazygit"
alias cd="z"
alias y="yazi"

# Git aliases
alias g='git'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout $(git_main_branch)'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gf='git fetch origin'
alias gm='git merge'
alias gl='git pull'
alias gp='git push'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gst='git status'
alias gsta='git stash'
alias gstaa='git stash apply'
alias gstp='git stash pop'
function gbda() {
  git branch --no-color --merged | command grep -vE "^([+*]|\s*(master))\s*$)" | command xargs git branch --delete 2>/dev/null
}

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
