# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# vi mode in Bash
set editing-mode vi

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\] \W \[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h: \W \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# basic aliases
# alias ls='ls --classify'
alias cp='cp -i'
alias less='less --quit-if-one-screen --ignore-case --no-init'
alias mv='mv -i'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# load private aliases, if any
if [ -f ~/.bash_priv_aliases ]; then
    . ~/.bash_priv_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Add doom emacs to path
export PATH=$HOME/.emacs.d/bin:$PATH
export PATH=$HOME/.config/emacs/bin:$PATH

# Add cabal to path
export PATH=$PATH:$HOME/.cabal/bin/

# add Amazon Corretto JDK 11 to path
export PATH=$HOME/amazon-corretto-11.0.16.8.1-linux-x64/bin:$PATH

# https://cryptohack.org/faq/#install
alias cryptohack_docker='sudo docker run -p 127.0.0.1:8888:8888 -it hyperreality/cryptohack:latest'

# WIP Todo-Tree Function using ripgrep because ripgrep is faster I think?
# https://github.com/BurntSushi/ripgrep
# How ironic it has it's own todos
# TODO: don't match the word todo in the middle of words or sentences (example "pycryptodome")
# TODO: Make only match commends
# TODO: figure out features to add
# There has to be a better way to match these backslashes
todo() {
    FILES=($(find $(rg -li '[#|\\\\|\\*]+(\s)*(todo|fixme)' ${1:-.} 2>/dev/null) -type f 2>/dev/null))
    for file in "${FILES[@]}"
    do
        rg -iHc '[#|\\\\|\\*]+(\s)*(todo|fixme)' $file | rg -v ':0$'
        rg -iHn '[#|\\\\|\\*]+(\s)*(todo|fixme)' $file
    done
}

# Display possible color options for tmux
# From https://unix.stackexchange.com/questions/60968/tmux-bottom-status-bar-color-change
tmux_colors() {
  for i in {0..255} 
  do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}

# Gurobi shit
export GUROBI_HOME="${HOME}/opt/gurobi950/linux64"
export GRB_LICENSE_FILE="${HOME}/gurobi.lic"
export PATH="${PATH}:${GUROBI_HOME}/bin"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${GUROBI_HOME}/lib"

# golang
export PATH=$PATH:/usr/local/go/bin

# I would like to do math
export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2025/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2025/texmf-dist/doc/info:$INFOPATH

# *space noises*
eval "$(starship init bash)"

. "$HOME/.cargo/env"

# Make GPG play nice
export GPG_TTY=$(tty)

# # Add sage to path
# export SAGE_ROOT="sage/sage-10.4"
# export PATH=$PATH:$SAGE_ROOT/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# uv
export PATH="/home/anakin/.local/bin:$PATH"
