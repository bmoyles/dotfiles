setopt autopushd
setopt pushd_ignore_dups

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_ignore_all_dups
setopt inc_append_history
setopt share_history
setopt hist_reduce_blanks
setopt hist_verify

setopt nobeep

unalias run-help
autoload run-help
export HELPDIR=/usr/share/zsh/help

# vim: filetype=zsh:ts=4:sw=4:expandtab
