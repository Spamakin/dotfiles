# ~/.zprofile: Executed for login shells.

# Not sure what this does
eval "$(/opt/homebrew/bin/brew shellenv)"

# Default paths
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# TODO: Figure out which of these I can remove
# Go, Doom Emacs, Cabal, Corretto Java
export PATH="$PATH:/usr/local/go/bin"
export PATH="$HOME/.emacs.d/bin:$HOME/.config/emacs/bin:$PATH"
export PATH="$PATH:$HOME/.cabal/bin/"
export PATH="$HOME/amazon-corretto-11.0.16.8.1-linux-x64/bin:$PATH"

# Environment Variables
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GPG_TTY=$(tty)

# Sourced environments (Cargo, uv)
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
