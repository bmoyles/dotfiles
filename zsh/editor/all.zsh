bindkey -e

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^f' edit-command-line

function rationalize-dot {
    if [[ $LBUFFER = *.. ]] ; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalize-dot
bindkey . rationalize-dot

function insert_sudo {
    zle beginning-of-line
    zle -U 'sudo '
}
zle -N insert-sudo insert_sudo
bindkey '^[s' insert-sudo

# vim: filetype=zsh:ts=4:sw=4:expandtab
