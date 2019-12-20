#!/bin/zsh

## zsh zle/editor-related configuration

bindkey -e

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^f' edit-command-line

function insert_sudo {
    zle beginning-of-line
    zle -U 'sudo '
}
zle -N insert-sudo insert_sudo
bindkey '^[s' insert-sudo

if [[ -r ${ZDOTLOCAL}/editor.zsh ]]; then
    source "${ZDOTLOCAL}"/editor.zsh
fi
