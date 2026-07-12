# ~/.zshrc: Executed for interactive shells.

# Not sure what this deos
. "$HOME/.local/bin/env"

# =============================================================================
# ZSH OPTIONS & HISTORY
# =============================================================================
# Equivalent to HISTSIZE=1000, HISTFILESIZE=2000, and HISTCONTROL=ignoreboth
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt appendhistory      # shopt -s histappend
setopt histignorealldups  # Ignore duplicate commands
setopt histignorespace    # Ignore commands starting with a space

# Vi mode in Zsh (Replacing `set editing-mode vi`)
bindkey -v

# Zsh Completion System (Replacing the bash-completion block)
autoload -Uz compinit
compinit

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Basic Aliases
alias cp='cp -i'
alias mv='mv -i'
alias less='less --quit-if-one-screen --ignore-case --no-init'
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Long running command alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# NVM bash completion usually works fine in zsh via their wrapper
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# *space noises*
eval "$(starship init zsh)"
