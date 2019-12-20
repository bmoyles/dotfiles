#!/bin/zsh

## miscellaneous zsh configuration

## Shush
setopt nobeep

## make sure run-help is available
unalias run-help 2>/dev/null
autoload run-help
export HELPDIR=/usr/share/zsh/help

## command-not-found
command_not_found_handler() {
    if [[ -x /usr/lib/command-not-found ]]; then
        /usr/lib/command-not-found -- "$1"
        return $?
    else
        printf '%s: command not found\n' "$1" >&2
        return 127
    fi
}

if [[ -r ${ZDOTLOCAL}/misc.zsh ]]; then
    source "${ZDOTLOCAL}"/misc.zsh
fi
