#!/bin/zsh

## zsh history-related configuration

export HISTFILE="${HOME}"/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt append_history
setopt autopushd
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt pushd_ignore_dups
setopt share_history

if [[ -r ${ZDOTLOCAL}/history.zsh ]]; then
    source "${ZDOTLOCAL}"/history.zsh
fi
